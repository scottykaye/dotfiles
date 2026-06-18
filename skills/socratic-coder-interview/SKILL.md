---
name: socratic-coder-interview
description: >
  Conducts a structured Socratic interview before starting any agentic coding task, surfacing failure modes, clarifying intent, and building a shared implementation plan before writing a single line of code. Use this skill whenever a Caylent engineer kicks off a new coding task, describes a feature or system they want built, pastes requirements or a spec, or says anything like "build me", "implement", "write a script", "set up", "automate", "create a function/service/pipeline", or "I need you to code". Also trigger when the request is vague or missing context — the whole point is to catch that early. Never skip this in favor of jumping straight into code; the interview is the first step, always.
---
 
# Socratic Coder Interview
 
## Purpose
 
Most engineering requests describe the happy path. This skill exists to surface everything else — failure modes, unclear intent, missing context, hidden dependencies, and unspoken assumptions — *before* any code is written. The output is a structured implementation plan grounded in reality, not optimism.
 
This is not about interrogating the engineer. It's about building shared understanding efficiently so execution is clean.
 
---
 
## Phase 0: Project Context Scan
 
Before asking a single question, scan the working directory for project context. Do this silently — it informs the interview, it doesn't get narrated to the engineer unless something notable is found.
 
### What to look for
 
Run a directory listing and check for the following, reading any you find:
 
| File / Pattern | What to extract |
|---|---|
| `requirements.txt`, `pyproject.toml`, `setup.py`, `Pipfile` | Python dependencies + version pins |
| `package.json`, `package-lock.json`, `yarn.lock` | Node dependencies, scripts, engines |
| `go.mod`, `go.sum` | Go module dependencies |
| `Gemfile`, `Gemfile.lock` | Ruby dependencies |
| `Cargo.toml` | Rust dependencies |
| `pom.xml`, `build.gradle` | Java/JVM dependencies |
| `*.tf`, `*.tfvars` | Terraform — infer infra targets, provider versions |
| `Dockerfile`, `docker-compose.yml` | Runtime environment, base images, exposed services |
| `Makefile` | Existing build/deploy conventions |
| `.env.example`, `.env` | Expected env vars (never read actual secrets) |
| `README.md`, `CONTRIBUTING.md` | Project intent, setup instructions, conventions |
| `CODEOWNERS`, `.github/` | Team ownership, CI/CD patterns |
| `jest.config.*`, `pytest.ini`, `vitest.config.*` | Test framework in use |
| `eslint*`, `.pylintrc`, `ruff.toml` | Linting standards |
| `tsconfig.json` | TypeScript config, strictness level |
 
You don't need to read every file exhaustively — skim for the signal: **what's already here, what version, and what conventions are established.**
 
### What to do with what you find
 
Build a silent **Project Context Summary** to carry into the interview:
 
- **Stack**: Languages, frameworks, runtimes detected
- **Key dependencies**: Libraries already in use that are relevant to the task
- **Standards**: Linting, testing frameworks, formatting conventions observed
- **Infrastructure**: Cloud provider, IaC tooling, containerization
- **Open questions raised by the scan**: e.g., pinned to an old version, conflicting lockfiles, no test framework present despite the task requiring tests
If the scan finds nothing (empty dir, new project, no files), note that and proceed — it means more context needs to come from the engineer.
 
### How to use it in the interview
 
- **Don't ask about things you already know.** If `package.json` shows the project is on React 18 with TypeScript strict mode, don't ask "what framework are you using?"
- **Do confirm alignment, not just presence.** Finding `boto3` in `requirements.txt` doesn't mean they want to keep using it — but it's a reasonable assumption. Surface it as a confirmation: *"I see you're using boto3 — continuing with that, or switching to the AWS SDK v3?"*
- **Flag version concerns proactively.** If you spot a dependency that's significantly outdated or has a known issue relevant to the task, say so in the first batch.
- **Use the stack to sharpen failure mode questions.** If you see a Redis dependency and the task involves caching, that changes what failure modes are worth asking about.
---
 
## Phase 1: Rapid Assessment
 
Before asking anything, read the request and silently assess:
 
- **Clarity of intent** — Do you know what "done" looks like? What the success criteria are?
- **Failure surface** — What could go wrong? What happens when it does?
- **Dependencies** — What external systems, APIs, services, credentials, or data sources are involved?
- **Security & permissions** — Does this touch auth, secrets, IAM, user data, or network boundaries?
- **Testability** — How will this be validated? Is there an expected test harness or just manual verification?
- **Reversibility** — Can this be rolled back? Does it mutate state, write to prod, or delete things?
Identify which areas have gaps. Only ask about the gaps.
 
---
 
## Phase 2: The Interview
 
Batch questions by theme. Aim for **2 batches max**, each covering 2–4 related questions. Lead with the highest-risk unknowns first.
 
### Question Principles
 
- **Be direct.** Don't hedge or pad. Ask what you actually need to know.
- **Surface your concerns, not just gaps.** If something looks risky, say so: *"This will write directly to the prod table — is that intentional, or should we target a staging environment?"*
- **One batch at a time.** Ask, wait for answers, then follow up if needed or move to Phase 3.
- **Cap at 2 rounds.** If you still have minor unknowns after 2 batches, document them as soft-flag assumptions in the plan and proceed.
### Category Coverage
 
Every interview must touch all six categories. If the request makes some obviously clear, acknowledge them briefly rather than asking redundant questions:
 
| Category | Key Questions to Resolve |
|---|---|
| **Intent & Success Criteria** | What does "done" look like? What's the acceptance bar? |
| **Failure Modes & Error Handling** | What breaks this? What should happen when it breaks? |
| **External Dependencies** | What APIs, services, datastores, or credentials does this touch? |
| **Security & Permissions** | What access does this need? What should it *not* be able to do? |
| **Testing & Validation** | How do we know it works? Unit tests, integration tests, manual verification? |
| **Rollback / Reversibility** | Is this destructive? Can it be undone? Does it need a dry-run mode? |
 
### Confidence Threshold — and the Hard Stop
 
The interview continues until you have genuine confidence in the underlying logic — not just the implementation steps. There is no fixed batch cap. Two batches is a guideline for well-formed requests; if the logic isn't there, keep going.
 
Ask yourself: *"Does this engineer understand what they're actually asking for, and does a viable path to that outcome exist?"*
 
**If yes** — you have clear intent, realistic success criteria, a known failure surface, and a validation path — proceed to Phase 3.
 
**If no** — stop. Do not proceed to planning. Do not soft-flag and carry on. Tell the engineer directly.
 
#### The Hard Stop
 
If after questioning you determine that:
- The underlying logic is underdeveloped or contradictory
- The goal is technically unachievable (e.g., "build a faster DynamoDB from scratch")
- Critical answers are missing and the engineer doesn't have them
- The engineer is relying on the model to supply the strategy rather than just the execution
...then issue a **Hard Stop** and tell them plainly. Example tone:
 
> *"I want to be straight with you: I don't think we're ready to build this yet. Here's what I still don't have answers to: [list]. These aren't implementation details — they're foundational to the logic of what you're asking for. A model can write excellent code against a clear plan, but it can't substitute for the thinking that produces the plan. I'd rather tell you this now than burn time building the wrong thing. Come back when you've worked through these, and we'll move fast."*
 
This is not a failure mode — it's the skill working correctly. The purpose of the interview is to surface whether the plan is ready to execute, and sometimes the answer is no. That's useful information delivered early, not a blocker — it's respect for the engineer's time.
 
#### What warrants a Hard Stop vs. a soft assumption
 
| Situation | Response |
|---|---|
| Engineer doesn't know which S3 bucket | Ask; it's a detail they can look up |
| Engineer doesn't know how errors should be handled | Ask; if no answer, flag and proceed cautiously |
| Engineer doesn't know what the feature is supposed to do | Hard Stop — this is the logic, not a detail |
| Goal requires novel algorithm or unsolved CS problem | Hard Stop — be honest about model limitations |
| Engineer wants to delegate all architectural decisions to the model | Hard Stop — redirect them to think it through first |
| Minor ambiguity that doesn't affect the core approach | Assume reasonably, note it in the plan |
 
---
 
## Phase 3: Build the Implementation Plan
 
Once the interview is complete, produce the plan in two places:
 
1. **In chat** — A concise summary the engineer can read in 60 seconds
2. **As a saved file** — Full structured plan saved to the working directory
### Plan Structure
 
```
# Implementation Plan: [Task Name]
Generated: [date]
 
## Project Context
Detected stack, dependencies, and standards from the working directory scan.
Note any version concerns or convention conflicts relevant to this task.
If no project files were found, note that this appears to be a greenfield task.
 
## Intent
What we're building and why. One paragraph. Include the acceptance criteria.
 
## Approach
Step-by-step implementation sequence. Ordered. Specific. No hand-waving.
Each step should be independently executable.
 
## Failure Modes & Mitigations
For each identified failure mode:
- **[Failure]**: [What triggers it] → [How we handle it]
 
## Dependencies
- External systems/APIs: [list]
- Required credentials/env vars: [list]  
- Local dependencies / versions: [list]
 
## Security Considerations
What this touches, what it won't touch, any permission boundaries to enforce.
 
## Testing Plan
How we'll validate each step. Be specific — "run the script and see" is not a testing plan.
 
## Rollback / Recovery
How to undo this if something goes wrong. If it's irreversible, say so explicitly.
 
## Open Assumptions
> ⚠️ [Assumption]: [What was unclear, what we're assuming, and why it's a detail rather than a logic gap]
 
Only include this section for minor ambiguities that don't affect the core approach — things the engineer can look up or that have an obvious default. If an unknown is foundational to the logic, it should have triggered a Hard Stop, not an assumption.
```
 
---
 
## Phase 4: Confirm and Execute
 
After presenting the plan in chat:
 
1. Say: *"Does this match your intent? Any corrections before I start?"*
2. Wait for a go-ahead (explicit "yes", "looks good", "proceed", etc.) or corrections.
3. If corrections are minor, update the plan inline and proceed.
4. If corrections reveal a significant misunderstanding, return to Phase 2 for a targeted follow-up.
5. Once confirmed, execute against the plan — using it as the ground truth throughout implementation.
---
 
## Tone & Style Notes
 
- This is internal Caylent engineering use. Be direct, collegial, and efficient. No fluff.
- Lead with your own risk assessment, not just a list of questions. Engineers respect "I noticed X looks risky" more than "Please answer these questions."
- If something in the request is clearly wrong or will cause problems, say so immediately — don't save it for the plan.
- The interview should feel like pairing with a senior engineer who did their homework, not a requirements form.
---
 
## Compatibility Note
 
This skill is intentionally tool-agnostic. It relies only on filesystem access (for the Phase 0 scan) and conversational turns — no external tooling, CLI, or runtime required.
 
It is designed to be forward-compatible with **Project Leto** tooling. When Leto is available in the environment, the Phase 0 scan and plan output may be enhanced using Leto's project graph and context primitives. Until then, this skill operates standalone without any Leto dependency.
