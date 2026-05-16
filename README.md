# husky-hook

Small Node.js repo used to experiment with **[Husky](https://typicode.github.io/husky/)**—local **Git hooks** that run automated checks (or demos) during `commit`, `push`, checkout, merges, etc. Hooks live under **`.husky/`**.

## Prerequisites

- **Git**
- **Node.js** + **npm** (for Husky **v9**)

## Setup

Clone the repo, then:

```bash
npm install
```

Running **`npm install`** runs **`prepare` → `husky`**, which wires `core.hooksPath` so Git invokes the scripts Husky installs.

---

## NPM scripts

| Script        | Purpose |
|---------------|---------|
| `prepare`     | Registers Husky (runs after `npm install`). |
| `test`        | Demo “tests” used by **`pre-commit`** (`exit 0` on success). |
| `lint:demo`   | Placeholder for ESLint / Prettier-style checks. |
| `check:push`  | Pre-push checklist used by **`pre-push`** (`npm test` today). |

Change **`package.json`** to point hooks at real tools (ESLint, Jest, `tsc`, etc.).

---

## Hooks in this repository

Hooks that **enforce** behaviour:

| Hook          | File                 | Behaviour |
|---------------|----------------------|-----------|
| **pre-commit** | `.husky/pre-commit` | Runs **`npm test`** before a commit finishes. Fail → commit blocked. |
| **commit-msg** | `.husky/commit-msg` | Validates the first non-comment subject line (**[Conventional Commits](https://www.conventionalcommits.org/)**). Exceptions: **`Merge …`**, **`Revert …`**. Fail → commit blocked. |
| **pre-push**   | `.husky/pre-push`   | Runs **`npm run check:push`** before sending objects to the remote. Fail → push blocked. |

**Demo hooks** (print `[husky demo] …`; safe to delete or slim down):

| Hook                 | File |
|----------------------|------|
| **prepare-commit-msg** | `.husky/prepare-commit-msg` |
| **post-commit**        | `.husky/post-commit` |
| **pre-rebase**         | `.husky/pre-rebase` |
| **post-checkout**      | `.husky/post-checkout` |
| **post-merge**         | `.husky/post-merge` |
| **post-rewrite**       | `.husky/post-rewrite` |
| **pre-merge-commit**   | `.husky/pre-merge-commit` |
| **pre-auto-gc**        | `.husky/pre-auto-gc` |
| **pre-applypatch**     | `.husky/pre-applypatch` |
| **applypatch-msg**     | `.husky/applypatch-msg` |
| **post-applypatch**    | `.husky/post-applypatch` |

Shared logging helper: **`scripts/log-hook.sh`**.

> **Noise:** Hooks like **`post-checkout`** fire often. Keep only hooks you genuinely need in shared projects.

---

## Commit messages (quick reference)

Validated by **`.husky/commit-msg`**:

```
<type>[(optional-scope)][!]: <subject>
```

Examples:

- `feat: add logout button`
- `fix(auth): retry on 401`

Common types include: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`.

---

## Try it locally

**Good commit:**

```bash
git add .
git commit -m "feat: illustrate husky"
```

**Rejected subject:**

```bash
git commit -m "updated stuff"
```

**Run a hook without Git** (manual smoke test):

```bash
sh .husky/pre-commit
sh .husky/pre-push origin
tf=$(mktemp) && printf 'feat: ok\n\n' > "$tf" && sh .husky/commit-msg "$tf" && rm "$tf"
```

---

## Briefly disabling hooks (emergency / debugging)

Prefer fixing failing scripts. Husky honours **`HUSKY=0`**, which skips hook scripts—for example:

```bash
HUSKY=0 git push
```

Do not rely on this for routine workflow on a shared codebase.

---

## Learn more

- [Husky documentation](https://typicode.github.io/husky/)
- [Git hooks reference](https://git-scm.com/docs/githooks)

## License

**ISC** (see **`package.json`**).
