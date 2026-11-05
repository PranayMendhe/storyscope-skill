---
name: narrative-depth
description: Audit and revise fiction for StoryScope-style AI narrative tells (tidy single-track plots, over-explained themes, linear time, flat escalation, thin moral ambiguity). Use when the user wants a craft audit of a story or draft, structural revision suggestions, or a rewrite that deepens plot, time, agency, and theme—not as an AI detector.
---

# Narrative Depth

Craft tool for writers and editors. Grounded in StoryScope (Russell et al., UMD + Google DeepMind): discourse-level narrative features—not style quirks like em-dashes or "delve"—that often separate formulaic AI fiction from messier human storytelling.

**This is not a reliable AI detector.** StoryScope is a controlled preprint on long (~5k-word) parallel fiction. Do not claim authorship, score "AI probability," or frame revisions as detector evasion. Frame work as craft: less formulaic structure, more lived-in narrative choice.

## When to load reference files

- Before AUDIT: read `reference/narrative-tells.md`
- Before REVISE: read `reference/revision-moves.md`
- For install/usage context outside this skill folder, see the repo README

## Modes

Infer mode from the user. If unclear, ask once: **AUDIT**, **REVISE**, or both (audit first, then revise).

### AUDIT

Read the story or excerpt. Report which StoryScope-aligned **AI narrative tells** appear, **dimension by dimension**, with **quoted evidence** (short quotes) and a simple score.

**Process**

1. Skim for plot shape, time order, how theme is stated, how choices resolve, sensory/setting habits, and character intro/agency.
2. Score each of the 10 NarraBench-based dimensions StoryScope uses (Agent, Social Network, Event, Plot, Structure, Setting, Time, Revelation, Perspective, Style) on a 1–5 "formulaic pressure" scale:
   - 1 = human-leaning / messy / ambiguous / discontinuous where useful
   - 3 = mixed
   - 5 = strongly matches common AI narrative defaults from the paper
3. For each dimension that scores ≥3, list specific tells from `reference/narrative-tells.md`, quote evidence, and note the human-leaning counterpart that is missing.
4. Give an overall **formulaic narrative score** (1–5) as the mean of dimension scores (one decimal). State clearly: this measures resemblance to the paper's AI-leaning narrative patterns, **not** authorship.
5. End with 3–7 prioritized craft questions (not a moral of the story).

**AUDIT output template**

```markdown
# Narrative Depth Audit

**Overall formulaic narrative score:** X.X / 5
*(Craft signal only — not an authorship or detector result.)*

## Dimension scores
| Dimension | Score (1–5) | Top tells |
|-----------|-------------|-----------|
| Agent | | |
| Social Network | | |
| Event | | |
| Plot | | |
| Structure | | |
| Setting | | |
| Time | | |
| Revelation | | |
| Perspective | | |
| Style | | |

## Evidence by dimension
### [Dimension]
- **Tell:** …
- **Evidence:** "…"
- **Missing human-leaning move:** …

## Priority craft questions
1. …
```

Keep Style brief: note purple prose / cliché only if it reinforces structural tells; do not center lexical "AI tells."

### REVISE

Offer concrete **structural** revision moves. Only produce a full rewrite if the user asks.

**Default:** bullet revision plan mapped to weak dimensions (from a fresh or prior audit). Each bullet: what to change, where (scene/beat), why (which tell it counters).

**If rewrite requested:** rewrite the passage or story applying moves from `reference/revision-moves.md`. Prefer:

- Moral ambiguity and costly choices (not tidy internal acceptance alone)
- At least one subplot or loose thread that does not sermonize the theme
- Temporal complexity (flashback, fragment, delayed disclosure) when it serves revelation
- Real event escalation (raise stakes; avoid flat intensity)
- Themes shown through consequence and contradiction, not narratorial moralizing
- Interiority and behavioral cues alongside (not only) embodied metaphor stacks
- Specific named cultural/intertextual anchors when natural; avoid vague "ancient prophecy" mush

**Do not** end with an explicit moral, lesson paragraph, or narrator explaining What It All Meant. Trust the reader.

## Honesty constraints (always)

- Credit StoryScope; link paper/code when relevant: https://arxiv.org/html/2604.03136v6 and https://github.com/jenna-russell/storyscope
- Cite headline numbers only if accurate: 61,608 stories; 10,272 prompts; 1 human + 5 LLMs; 304 features; narrative-only 93.2% macro-F1 human-vs-AI (96.0% with style); 30 core features ~84.8%; six-way attribution 68.4% narrative-only. Never invent stats or quotes.
- Per-model fingerprints (illustrative, from the paper): Claude — flat event escalation; GPT — gossip/rumor as plot mechanism; Gemini — external character description default (among other quirks). Use only as optional color in audits of model-labeled drafts, not as proof of source.
- Refuse requests framed as "make this undetectable" / "bypass AI detectors." Offer craft revision instead.

## Quick examples

**User:** "Audit this chapter for AI-ish structure."
→ AUDIT mode, full template.

**User:** "Make the ending less neat; add moral ambiguity."
→ REVISE plan; rewrite only if asked.

**User:** "Is this AI-written?"
→ Decline detection claims. Offer AUDIT as a craft checklist of formulaic narrative patterns, with the disclaimer above.
