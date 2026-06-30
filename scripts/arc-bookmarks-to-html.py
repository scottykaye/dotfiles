#!/usr/bin/env python3
"""
arc-bookmarks-to-html.py — Export Arc bookmarks/pinned tabs to a Netscape
bookmarks HTML file that Chrome (and any browser) can import directly.

Arc has no built-in bookmark export. It stores its sidebar (pinned tabs,
folders, spaces) in:
    ~/Library/Application Support/Arc/StorableSidebar.json

This walks that tree, preserves the folder hierarchy under each Space, and
writes standard bookmarks HTML.

Usage:
    arc-bookmarks-to-html.py [OUTPUT.html]
        OUTPUT defaults to ~/Desktop/arc-bookmarks.html

Then in Chrome:
    ⋮ → Bookmarks and lists → Import bookmarks and settings
    → Bookmarks HTML File → pick the generated file.
"""
import json, os, sys, html, time

ARC = os.path.expanduser("~/Library/Application Support/Arc/StorableSidebar.json")
OUT = os.path.expanduser(sys.argv[1] if len(sys.argv) > 1 else "~/Desktop/arc-bookmarks.html")


def load_items():
    d = json.load(open(ARC))
    c = d["sidebar"]["containers"][1]
    items = [x for x in c["items"] if isinstance(x, dict)]
    spaces = [x for x in c.get("spaces", []) if isinstance(x, dict)]
    by_id = {x["id"]: x for x in items}
    return items, spaces, by_id


def node_url(node):
    data = node.get("data", {})
    tab = data.get("tab")
    if tab and tab.get("savedURL"):
        return tab.get("savedURL")
    return None


def node_title(node):
    data = node.get("data", {})
    tab = data.get("tab") or {}
    return node.get("title") or tab.get("savedTitle") or tab.get("savedURL") or "(untitled)"


def render(node, by_id, indent, lines):
    """Recursively render a node and its children as HTML <DT> entries."""
    url = node_url(node)
    children = node.get("childrenIds") or []
    pad = "    " * indent
    if url:
        lines.append(f'{pad}<DT><A HREF="{html.escape(url, quote=True)}">{html.escape(node_title(node))}</A>')
    elif children:
        # a folder
        title = node.get("title") or "Folder"
        lines.append(f'{pad}<DT><H3>{html.escape(title)}</H3>')
        lines.append(f'{pad}<DL><p>')
        for cid in children:
            child = by_id.get(cid)
            if child:
                render(child, by_id, indent + 1, lines)
        lines.append(f'{pad}</DL><p>')


def main():
    items, spaces, by_id = load_items()

    # Build set of all child IDs so we can find top-level roots per space.
    child_ids = set()
    for it in items:
        for cid in (it.get("childrenIds") or []):
            child_ids.add(cid)

    lines = []
    lines.append("<!DOCTYPE NETSCAPE-Bookmark-file-1>")
    lines.append('<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">')
    lines.append("<TITLE>Bookmarks</TITLE>")
    lines.append("<H1>Bookmarks</H1>")
    lines.append("<DL><p>")

    total = [0]

    def count(node):
        if node_url(node):
            total[0] += 1
        for cid in (node.get("childrenIds") or []):
            ch = by_id.get(cid)
            if ch:
                count(ch)

    # Group under each Space as a top-level folder.
    # Each space lists its root container ids in `containerIDs` as a flat
    # list like ["unpinned", <id>, "pinned", <id>, ...]. Items hang off those
    # containers via parentID. We render every item whose parentID is one of
    # the space's container ids (or a descendant thereof, handled recursively).
    rendered_ids = set()

    def collect_under(container_id):
        """Direct children (items) whose parentID == container_id."""
        return [it for it in items if it.get("parentID") == container_id]

    for sp in spaces:
        sp_title = sp.get("title") or "Space"
        cids = sp.get("containerIDs") or []
        # keep only the actual id strings (skip the "pinned"/"unpinned" labels)
        container_ids = [x for x in cids if isinstance(x, str)
                         and x not in ("pinned", "unpinned")]
        roots = []
        for c_id in container_ids:
            roots.extend(collect_under(c_id))
        if not roots:
            continue
        lines.append(f'    <DT><H3>{html.escape(sp_title)}</H3>')
        lines.append("    <DL><p>")
        for r in roots:
            count(r)
            render(r, by_id, 2, lines)
            rendered_ids.add(r["id"])
        lines.append("    </DL><p>")

    # Catch-all: any URL item we didn't place under a space.
    leftovers = [it for it in items
                 if node_url(it) and it["id"] not in child_ids
                 and it["id"] not in rendered_ids]
    if leftovers:
        lines.append('    <DT><H3>Other Arc Bookmarks</H3>')
        lines.append("    <DL><p>")
        for it in leftovers:
            count(it)
            render(it, by_id, 2, lines)
        lines.append("    </DL><p>")

    lines.append("</DL><p>")

    with open(OUT, "w") as fh:
        fh.write("\n".join(lines) + "\n")

    print(f"Wrote {total[0]} bookmarks to {OUT}")
    print("Import in Chrome:  ⋮ → Bookmarks and lists → Import bookmarks and settings → Bookmarks HTML File")


if __name__ == "__main__":
    main()
