# Copilot / AI Agent Instructions for this repository

This file is a concise, actionable guide for automated coding agents (Copilot, Code-writing agents, CLAUDE-style agents) to be immediately productive in this repository.

NOTE: At the time this file was created there were no project source files discovered in the repository root. The guidance below therefore focuses on a quick reconnaissance checklist and conservative, minimally-invasive actions an agent should take when beginning work. Update this file when the repository contains actual language-specific files (package.json, pyproject.toml, src/, etc.).

Quick objectives for the agent
- Run a repository scan to locate the code, test, and CI entry points (README.md, package.json, pyproject.toml, Dockerfile, .github/workflows/**, src/, tests/).
- If no code is present, open a short PR that adds this file and a short README note describing repo's expected contents; don't add speculative implementation.
- When implementing changes, follow existing patterns in the codebase; prefer small, test-covered commits.

Reconnaissance checklist (first actions)
1. Look for these files in the repo root (strict priority order):
   - `README.md`, `LICENSE`, `CHANGELOG.md`, `CONTRIBUTING.md`
   - `package.json` (Node.js), `pyproject.toml` / `requirements.txt` (Python), `go.mod` (Go), `pom.xml` (Java)
   - `src/`, `lib/`, `app/` or language-specific layout
   - `tests/`, `spec/`, or `__tests__/`
   - `Dockerfile`, `Makefile`, `scripts/`
   - `.github/workflows/*` (CI), `.eslintrc`, `flake8`, `prettierrc` (linters/formatters)
2. If `README.md` exists, read it first for project-specific build/test commands.
3. If any of the language manifests are present, run the language-appropriate dependency and test commands locally (see Build & test commands below) in a safe, read-only mode first.

Build & test commands (what to try, detect first)
- Node.js (if `package.json` present):
  - Inspect `scripts` in `package.json`.
  - Prefer `npm ci` (CI) or `npm install` then `npm test` for running tests. If `yarn.lock` exists, prefer `yarn install && yarn test`.
  - If `build` script exists, run `npm run build` in CI-only tasks.

- Python (if `pyproject.toml` / `requirements.txt` present):
  - Create an isolated venv, then `pip install -r requirements.txt` or `pip install -e .` for editable installs.
  - Run `pytest -q` if `pytest.ini` or `tests/` exists.

- Docker (if `Dockerfile` present):
  - Use `docker build . -t repo-temp` to reproduce container builds; prefer not to push images unless authorized.

- CI checks: examine `.github/workflows/**` to learn what tests/lints run in CI and mirror locally when possible.

Repository conventions to look for
- File layout: expect code under `src/` or `lib/`, tests under `tests/` or `spec/`.
- Test naming: look for `test_*.py` (pytest) or `*.spec.js` / `*.test.js` (JS) to follow existing patterns.
- Linting & formatting: check for `.eslintrc`, `prettierrc`, `pyproject.toml` tool sections—follow project-specific rules.
- Commit & PR style: prefer small, descriptive commits; open PRs against `main` or the branch referenced by the repo's contributing docs. If `package.json` contains a `version` and `release` script, expect semantic releases.

How to propose changes
- Make minimal, focused commits with a clear subject line and short body describing the why.
- Include or update tests for any functional change; run the project's tests locally before opening a PR.
- If the repository contains a `CHANGELOG.md` or release tooling, update it only when changing public behavior.

Safety & permissions
- Do not add or exfiltrate secrets. If the repo contains `.env.example`, only use it for local dev; do not attempt to load real secrets.
- Avoid pushing changes to protected branches. Open PRs from a feature branch named like `ai/short-description`.

Examples / heuristics (how to find examples in this repo)
- If you find `package.json` with a `scripts` entry `{ "test": "jest" }`, run `npm ci && npm test` and add new tests to `tests/` or `__tests__/` following the project's jest config.
- If `pyproject.toml` lists `pytest` under `[tool.poetry.dev-dependencies]`, run `pytest` and place new tests under `tests/` with `test_` prefix.
- If `.github/workflows/ci.yml` contains a matrix for Node versions, follow the same matrix when writing compatibility tests.

When this file should be updated
- Add concrete commands and file paths after the first real code is checked into the repo.
- If the repo uses a monorepo layout, add a short section describing the workspace manager (pnpm/workspaces, lerna, poetry, etc.) and how to target packages.

Questions for the repository owner (please answer in the PR description)
- What is the primary language / runtime for this repo? (Node.js / Python / Go / other)
- Preferred CI command to run locally (if different from defaults above).
- Branch protection rules and release process (semantic release, manual tagging, etc.).

If unsure: be conservative
- When in doubt, create a small, documented PR that only adds tests or docs. Don't implement large features without explicit confirmation.

---
Please review this initial guidance and tell me any repo-specific rules or build commands to add. I can iterate and merge them into this file.