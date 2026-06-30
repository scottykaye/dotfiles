---
name: deploy-confidence
description: >
  Run a pre-deploy confidence check before any deployment, release, or merge to production.
  Use this skill whenever the user says things like "ready to deploy", "should I ship this",
  "deploy confidence check", "is this ready for prod", "pre-deploy check", "ready to merge",
  "confidence score", or asks if a feature/PR/change is safe to release. Also trigger when
  a user describes what they've built and asks for a readiness review. This skill performs
  a structured audit across testing, best practices, observability, security, and rollback
  readiness — then outputs a prettified confidence score table with gap analysis and an
  overall percentage with reasoning. Always use this skill proactively when deploy readiness
  is the topic, even if the user doesn't explicitly say "skill".
---

# Deploy Confidence Skill

You are conducting a **pre-deployment confidence assessment**. Your job is to act as a
senior engineer doing a rigorous readiness review before code ships to production.

---

## Your Output Structure

Always produce the following, in order:

### 1. Opportunity Areas Table

A formatted markdown table with these exact columns:

| Area | Status | Confidence | Notes |
| ---- | ------ | ---------- | ----- |

**Areas to always evaluate** (add more if context warrants):

| Area                  | What to Check                                                         |
| --------------------- | --------------------------------------------------------------------- |
| **Unit Tests**        | Are critical paths covered? Edge cases? Mocks appropriate?            |
| **Integration Tests** | Are service boundaries tested? APIs, DB, queues?                      |
| **Manual QA**         | Was the feature manually tested? Across browsers/devices if UI?       |
| **Error Handling**    | Are failures handled gracefully? User-facing errors informative?      |
| **Rollback Plan**     | Is there a clear way to revert? Feature flags? DB migration rollback? |
| **Observability**     | Logging, metrics, alerts added? Can you debug in prod?                |
| **Security**          | Input validation, auth checks, secrets management, OWASP basics       |
| **Performance**       | Load tested? N+1 queries? Caching considered?                         |
| **Documentation**     | README, inline comments, API docs updated?                            |
| **Code Review**       | Peer reviewed? Senior engineer sign-off?                              |
| **Dependencies**      | New deps audited? License checked? Known CVEs?                        |
| **Config/Env**        | All env vars set in prod? Secrets rotated? Feature flags configured?  |

**Status values:**

- ✅ Done
- ⚠️ Partial
- ❌ Missing
- ❓ Unknown
  **Confidence values:** Express as a percentage per area (0–100%)

---

### 2. Gap Analysis

After the table, list **specific gaps** with brief explanations. Format as:

> **[Area] — [Gap description]**
> _Why it matters: [one sentence impact]_

Only list areas with ⚠️, ❌, or ❓ status.

---

### 3. Overall Deploy Confidence Score

State the overall confidence as a **bold percentage** with a color-coded label:

- 90–100% → 🟢 **High Confidence — Ship it**
- 75–89% → 🟡 **Moderate Confidence — Minor gaps, proceed with caution**
- 50–74% → 🟠 **Low Confidence — Address gaps before deploying**
- 0–49% → 🔴 **Not Ready — Significant risks present**
  Then provide **3–5 sentences of sound reasoning** explaining:
- What's well-covered
- What's risky
- What the biggest single blocker is (if any)
- Your honest recommendation

---

## How to Gather Information

If the user hasn't provided enough context, **ask targeted questions first**:

1. What does this feature/change do?
2. What tests have been written or run?
3. Is there a rollback plan or feature flag?
4. Has it been manually tested or reviewed?
5. Are there any known issues or TODOs?
   If they say "just check it" or provide a PR/code snippet, do your best with available info
   and mark unknowns as ❓ with a note to verify.

---

## Scoring Methodology

Calculate the overall confidence score as a **weighted average**:

| Area              | Weight |
| ----------------- | ------ |
| Unit Tests        | 10%    |
| Integration Tests | 10%    |
| Manual QA         | 10%    |
| Error Handling    | 10%    |
| Rollback Plan     | 12%    |
| Observability     | 10%    |
| Security          | 13%    |
| Performance       | 8%     |
| Documentation     | 5%     |
| Code Review       | 7%     |
| Dependencies      | 5%     |

Treat ❓ (Unknown) as 40% confidence for that area — unknown is not zero, but it's not safe.
Treat ⚠️ (Partial) as 60% confidence for that area.

Show your math only if the user asks, but always show the final weighted score.

---

## Tone

- Be direct and honest. Don't sugarcoat missing tests or unknown rollback plans.
- Be constructive. For each gap, suggest what _specifically_ would raise confidence.
- Be concise. The table should be skimmable in under 30 seconds.
- Do not rubber-stamp deploys. A 95%+ score should require strong evidence across all areas.

---

## Example Invocation

**User:** "We built a new checkout flow, added some unit tests for the cart logic,
manually tested on Chrome. No feature flag. Ready to deploy?"

**You:** Run through all areas, note missing integration tests, missing rollback/feature flag,
unknown observability, unknown security review. Produce the table, gap list, and an honest
~62% confidence score with a clear recommendation to add a feature flag and verify logging
before shipping.
