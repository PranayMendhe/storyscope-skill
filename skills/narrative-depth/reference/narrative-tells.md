# Narrative tells checklist (StoryScope-aligned)

Grounded in Russell et al., *StoryScope: Investigating idiosyncrasies in AI fiction* (arXiv:2604.03136). StoryScope induces 304 discourse-level features across **10 NarraBench-based dimensions** (Agent, Social Network, Event, Plot, Structure, Setting, Time, Revelation, Perspective, Style). A compact set of **30 core features** reaches about **84.8%** macro-F1 on human-vs-AI in their controlled long-fiction setting; full narrative features reach **93.2%** (96.0% with style). Use this file as a **craft checklist**, not a detector.

Below: common **AI-leaning** patterns vs **human-leaning** counterparts, grouped by dimension. Quotes and percentages are from the paper's reported means / prevalences where noted.

## Agent

| AI-leaning tell | Human-leaning counterpart |
|-----------------|---------------------------|
| Emotions mainly via **embodied metaphors** / body sensations (paper: ~81% AI vs ~38% human for embodied as dominant) | Mix of **explicit emotion labels**, behavioral cues, and ambiguity (~29% human vs ~8% AI for explicit labels as dominant) |
| Protagonist introduced via **external description** | Introduced **in action**, dialogue, or others' reports |
| Deep interior access stacked with sensory performance | Interiority that still leaves some opacity |

## Social Network

| AI-leaning tell | Human-leaning counterpart |
|-----------------|---------------------------|
| Narrow cast; dyads that serve a single thematic line | Wider community texture; ensemble friction |
| Reconciliations that resolve cleanly | Partial / ambiguous forgiveness (also a GPT fingerprint when present as gossip-driven social plot) |
| Gossip unused or purely ornamental | Gossip/rumor as real plot mechanism (elevated in GPT in the paper) |

## Event

| AI-leaning tell | Human-leaning counterpart |
|-----------------|---------------------------|
| **Tight continuity** of a single causal chain | Loose ends, broken or braided causality |
| Resolution via **internal understanding / acceptance** (~47% AI vs ~27% human) | External action, unresolved endings, or costly tradeoffs |
| **Flat event escalation** (notable Claude fingerprint) | Escalation that changes what is at stake, not only mood |

## Plot

| AI-leaning tell | Human-leaning counterpart |
|-----------------|---------------------------|
| **No subplots** (~79% AI vs ~57% human) | Subplots that parallel, contrast, or refuse the theme (~42% human vs ~21% AI for thematically parallel subplots) |
| Resolution driven cleanly by **protagonist choice** (~69% AI vs ~46% human) | Mixed agency or external fate that complicates blame |
| **High thematic unity**; everything serves one moral | Flourishes and digressions that do not preach |
| Protagonist framed as **morally clear** | **Ambivalent / mixed** moral polarity (~59% human vs ~38% AI) |

## Structure

| AI-leaning tell | Human-leaning counterpart |
|-----------------|---------------------------|
| Single-track, tidy arc; few loose ends | Messier architecture; competing through-lines |
| Epilogue that seals meaning (Claude often favors epilogues / quiet endings) | Endings that reopen or withhold |
| Schema defaults (quest → lesson) without friction | Schema mixed or subverted |

## Setting

| AI-leaning tell | Human-leaning counterpart |
|-----------------|---------------------------|
| Setting as **psychological mirror** (higher AI mean) | Setting that resists mood-matching |
| High **sensory density**, especially **olfactory** (~82% AI vs ~57% human) | Selective sensory detail; not every room smells like memory |
| Fine spatial granularity and clear opening grounding as default polish | Strategic vagueness; fewer locales or stranger location variety (humans span more locations on average) |

## Time

| AI-leaning tell | Human-leaning counterpart |
|-----------------|---------------------------|
| Mostly **linear** chronology | **Chronological discontinuity**, flashbacks/forwards (**anachrony**) |
| Little use of time jumps to stage reveals | Nonlinear framing for **delayed disclosure** |
| Avoids dream/vision temporal distortion (Claude fingerprint: often no dreams/visions) | Temporal play when it earns reinterpretation |

## Revelation

| AI-leaning tell | Human-leaning counterpart |
|-----------------|---------------------------|
| Reveals land without forcing a re-read | **Deep recontextualization** after surprise |
| Linear march to the reveal | Time structure used to withhold and reframe |
| Pre-threat investment as neat setup | Investment that makes later irony cut |

## Perspective

| AI-leaning tell | Human-leaning counterpart |
|-----------------|---------------------------|
| Dialogue used for **philosophical debate** (~59% AI vs ~34% human) | Dialogue that advances plot, reveals character, or refuses thesis-speech |
| Lower dialogue-to-narration share on average | Higher dialogue proportion when scenes need voices |
| Uniform narrative voice (Claude fingerprint: especially uniform) | Voice shifts, heteroglossia, or strategic distance |

## Style (use lightly in audits)

Style still separates sources in the paper (style-only ~85.8% macro-F1), but this skill prioritizes **structure**. Only flag style when it props up narrative tells (e.g. purple sensory stacks that mirror theme, sermonizing diction).

| AI-leaning texture that often co-occurs | Craft note |
|------------------------------------------|------------|
| Overwrought sensory catalogs | Cut to the one detail that changes a choice |
| Vague allusions instead of named references | Prefer specific titles, places, brands when honest to the world |
| Rare fourth-wall / reader address | Humans break the wall more often in the study—use only if it fits voice |

## Cross-cutting AI narrative profile (paper §4.1)

- **Over-explains themes / morals**; narratorial thematic commentary ~77% AI vs ~52% human.
- **Tidy, single-track, causally neat** plots; fewer subplots.
- **Linear time**; fewer flashbacks and discontinuities.
- Shared **narrow region of narrative space**: five LLMs cluster; humans are more dispersed and rarer in feature space (human mean rarity percentile 0.71 vs 0.49 AI).

## Per-model fingerprints (optional color)

From the paper (not proof of authorship on a new text):

- **Claude:** flat event escalation; restrained/uniform voice; epilogues; fewer dream sequences.
- **GPT:** gossip/rumor as plot mechanism; distant retrospective framing; more expectation-subversion than other AI sources in their data.
- **Gemini:** external character-description defaults (abstract); also tidier endings / extended denouements and bleak settings in their fingerprint notes.
- **DeepSeek / Kimi:** closer to the generic AI cluster; DeepSeek front-loads context; Kimi few distinctive fingerprints.

## Scoring reminder

Dimension score 1–5 = **formulaic narrative pressure**, not P(AI). Short excerpts under-trigger temporal/subplot features; say so when evidence is thin.
