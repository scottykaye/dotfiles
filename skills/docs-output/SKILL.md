# Docs Output

When creating any documentation file, always save it to the `docs/` directory.

## Rules

- All `.md`, `.mdx`, `.txt` documentation files go in `docs/`
- If the user specifies a filename without a path (e.g. "create a README"), save it as `docs/README.md`
- If the user specifies a nested path, preserve it under `docs/` (e.g. `docs/api/overview.md`)
- Never save docs to the root directory or other locations unless the user explicitly overrides this

## Example mappings

| User says                | Save to             |
| ------------------------ | ------------------- |
| "write a README"         | `docs/README.md`    |
| "create an API guide"    | `docs/api-guide.md` |
| "document the auth flow" | `docs/auth-flow.md` |
| "write docs/setup.md"    | `docs/setup.md`     |
