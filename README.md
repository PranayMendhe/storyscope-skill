# storyscope-skill

A Claude **Agent Skill** (`narrative-depth`) that helps writers and editors **audit and revise fiction** for formulaic narrative patterns documented in the StoryScope research paper—tidy single-track plots, over-explained themes, linear time, flat escalation, thin moral ambiguity—not surface style quirks like em-dashes or "delve."

**This is a craft tool. It is not a reliable AI detector.**

## Research credit

This skill is an independent craft wrapper inspired by:

> Jenna Russell, Rishanth Rajendhran, Chau Minh Pham, Mohit Iyyer (University of Maryland), and John Wieting (Google DeepMind). *StoryScope: Investigating idiosyncrasies in AI fiction.* arXiv:2604.03136.

- Paper (HTML): https://arxiv.org/html/2604.03136v6
- Code and data: https://github.com/jenna-russell/storyscope

StoryScope builds a parallel corpus of **10,272** writing prompts, each answered by a human author and five LLMs (Claude, DeepSeek, Gemini, GPT, Kimi), yielding **61,608** stories of roughly **~5,000** words (corpus mean **4,753**) and **304** discourse-level narrative features across **10** NarraBench-based dimensions. In their experiments, narrative features alone reach **93.2%** macro-F1 for human-vs-AI (**96.0%** with style); a compact set of **30** core features reaches about **84.8%**; six-way authorship attribution reaches **68.4%** macro-F1 with narrative features alone. AI stories in the study tend to over-explain themes and favor causally neat, single-track, temporally linear plots; human stories show more moral ambiguity, subplots, and nonlinear time. The five AI models cluster in a narrower shared region of narrative space than humans.

All headline numbers above are taken from the paper. This repository is **not** affiliated with the authors. Please cite their work if you use these ideas in research.

## What's in the box

```
skills/narrative-depth/
  SKILL.md
  reference/narrative-tells.md
  reference/revision-moves.md
examples/
  sample-story.md          # illustrative original short
  sample-audit.md          # illustrative audit write-up
article/medium-article.md  # draft Medium essay
scripts/package.sh         # builds dist/narrative-depth.zip
Makefile
```

## Modes

1. **AUDIT** — Read a story/draft; report StoryScope-aligned AI narrative tells **dimension by dimension**, with quoted evidence and a simple 1–5 formulaic-narrative score (craft signal only).
2. **REVISE** — Concrete structural revision suggestions, or a rewrite on request (moral ambiguity, subplots, temporal complexity, real escalation, implicit themes, interiority, etc.).

The skill refuses "bypass the detector" framing and will not claim to determine authorship.

## Install

### Claude Code

Personal (all local projects):

```bash
mkdir -p ~/.claude/skills
cp -R skills/narrative-depth ~/.claude/skills/
```

Or project-scoped:

```bash
mkdir -p .claude/skills
cp -R skills/narrative-depth .claude/skills/
```

Start `claude` and ask for a narrative audit, or invoke `/narrative-depth` if your build lists skills as slash commands.

### claude.ai

1. Build the zip: `make zip` (or `./scripts/package.sh`).
2. In Claude, open **Settings → Features** (Anthropic's current custom-skills upload path; requires a plan with code execution enabled).
3. Upload `dist/narrative-depth.zip`.
4. Custom skills on claude.ai are per-user; they do not sync automatically to the API or Claude Code.

### Claude API

Upload the skill directory via the Skills API (`/v1/skills`), then pass the returned `skill_id` in the Messages API `container` alongside the code execution tool. See Anthropic's [Agent Skills overview](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview) and [Skills with the API](https://platform.claude.com/docs/en/build-with-claude/skills-guide). Skills uploaded to the API are not automatically available on claude.ai.

## Usage examples

```text
Audit this chapter for formulaic narrative structure using narrative-depth.
Do not guess if it was written by AI—just score the craft patterns.
```

```text
Using narrative-depth, revise this ending: add moral ambiguity and cut the
narrator explaining the theme. Suggest structural moves first.
```

```text
Rewrite the middle section with one contrasting subplot and a flashback
that recontextualizes the opening. Keep my voice.
```

See `examples/sample-story.md` and `examples/sample-audit.md` for a labeled illustrative pair.

## Package the upload zip

```bash
make zip
# → dist/narrative-depth.zip  (SKILL.md at the zip root folder)
```

`dist/` is gitignored.

## Limitations

- StoryScope studied **long** fiction under a specific parallel-prompt design. Short social posts or business email will not match that regime.
- Feature extraction in the paper used dedicated LLM pipelines and classifiers; this skill is a **checklist + editorial procedure**, not a reproduction of their XGBoost/SHAP stack.
- Models change. Surface style shifts quickly; narrative defaults may shift too.
- Do not use this skill to make unverifiable authorship accusations.

## License

MIT © Pranay Mendhe. See [LICENSE](LICENSE).

StoryScope paper and official code remain under their authors' terms; this repo only reuses publicly described findings with citation.
