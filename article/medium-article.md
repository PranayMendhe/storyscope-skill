# AI fiction doesn’t give itself away with “delve.” It gives itself away with how the story is built.

**Subtitle:** A new study of 61,608 parallel human and AI stories finds that narrative choices alone (plot, time, theme, resolution) separate human from AI fiction at 93.2% macro-F1, no word lists needed. I turned its findings into an open Claude skill for writers.

**Suggested Medium tags:** Writing, Artificial Intelligence, Fiction, Claude AI, Creative Writing

---

I read a paper that put numbers on something I had been half-suspecting for months: the obvious “AI writing” tells—em-dashes, *delve*, tapestry metaphors—are not the deepest giveaway. Surface habits are easy to edit away. What sticks is **story structure**. How causality is laid down. Whether time ever breaks. Whether a character’s choice is actually uncomfortable. Whether the narrator trusts you enough to leave the theme unstated.

So I did the boring thing. I read the paper closely, took notes, and, inspired by it, built a small tool I would actually use.

## What StoryScope measured

*StoryScope: Investigating idiosyncrasies in AI fiction* is a preprint by Jenna Russell, Rishanth Rajendhran, Chau Minh Pham, and Mohit Iyyer at the University of Maryland, with John Wieting at Google DeepMind. You can read it here: [arXiv HTML](https://arxiv.org/html/2604.03136v6). Code and data live at [github.com/jenna-russell/storyscope](https://github.com/jenna-russell/storyscope).

Their setup is unusually careful for this topic. They reverse-engineered **10,272** writing prompts from human short fiction, then had each prompt answered by a human author and by five LLMs—Claude, DeepSeek, Gemini, GPT, and Kimi. That yields **61,608** stories, each on the order of **~5,000** words (corpus mean **4,753**). Instead of hunting vocabulary, they induce **304** discourse-level features across **10** dimensions grounded in NarraBench (the narrative-only model withholds the style features and uses **257** of them): agent, social network, event, plot, structure, setting, time, revelation, perspective, and style.

The headline results, taken straight from the paper:

- Narrative features alone: **93.2%** macro-F1 for human vs. AI.
- Narrative + style: **96.0%**.
- A compact set of **30** core narrative features: about **84.8%**.
- Six-way authorship attribution with narrative features: **68.4%** macro-F1 (**77.3%** when style is included).

They also show that surface editing aimed at AI prose artifacts barely moves narrative detection. In their LAMP experiment, 278 Gemini stories were rewritten to remove artifacts like cliché and purple prose, and the narrative model still detects them at **93.9%** macro-F1, versus **95.5%** on the unedited originals: a drop of only 1.6 points. You can sand the diction and still leave the scaffolding.

I am an engineering manager in Bengaluru, not a narratologist. What I wanted was practical: a checklist I could run on drafts—mine, a teammate’s narrative case study, a friend’s chapter—without pretending I had rebuilt their XGBoost stack.

## What “AI narrative tells” look like on the page

Section 4.1 of the paper is the part writers should steal from.

AI stories in the study **over-explain themes**. Narrators explicitly explain the story’s theme far more often (~77% vs ~52% for humans). Dialogue slides into philosophical debate (~59% vs ~34%). Endings resolve into internal understanding or acceptance (~47% vs ~27%). Plots stay on a **single causal track** with fewer subplots (~79% “no subplots” for AI vs ~57% human). Time stays mostly linear. Settings mirror inner weather. Emotion arrives as a stack of physical sensations and bodily metaphors (~81% vs ~38%), with more smell-based imagery (~82% vs ~57%).

Human stories in the same parallel design are messier in useful ways: more **morally ambivalent** protagonists (~59% vs ~38%), more subplots integrated into the overarching theme (~42% vs ~21%), more flashbacks and chronological discontinuity, more willingness to leave meaning inferred, more specific named references to the outside world (~47% vs ~24% for specific texts and authors), more direct address to the reader (~28% vs ~7%).

The five AI models also **cluster**. In their projection of narrative feature space, humans occupy a distinct region while Claude, GPT, Gemini, DeepSeek, and Kimi sit closer to one another. Human stories are rarer on average in that space (mean rarity percentile **0.71** vs **0.49** for AI). That is a research finding about a corpus, not a personality test for your weekend draft—but it explains why so much generated fiction feels like it was built in the same workshop.

The paper reports per-model fingerprints too. Claude’s event escalation is notably flat; its narrative voice is the most uniform and it favors quiet endings. GPT leans on gossip and rumor as a plot mechanism. Gemini defaults to external character description and produces the tidiest endings and extended denouements. DeepSeek front-loads crucial context, and Kimi sits at the generic center of the AI distribution. Treat fingerprints as color from their corpus, not courtroom evidence about a paragraph you pasted into chat.

## Why structure is the craft problem I care about

Lexical tells are a moving target. The StoryScope authors find style cues are strong (style features alone reach **85.8%** macro-F1), but they note that style-based detectors are known to be brittle to paraphrasing and light editing, and that narrative features, because they reflect structural decisions, may prove more durable as models evolve. Narrative choices are slower to fake because changing them means replotting, not synonym-swapping.

For writers, that maps to ordinary revision questions:

1. Where is the theme being sermonized?
2. Where did the subplot go?
3. Where could time break so a reveal rewrites earlier scenes?
4. Where is escalation flat—intensity without irreversible cost?
5. Where is the protagonist’s choice too clean?

Those questions help whether the draft began as human, AI-assisted, or a mix. I am not interested in helping anyone “beat a detector.” I am interested in fewer stories that end with the narrator explaining the lesson while the weather nods in agreement.

## What I built: `narrative-depth`

I packaged the above as an open Claude Agent Skill named **`narrative-depth`**:

**Repo:** [github.com/PranayMendhe/storyscope-skill](https://github.com/PranayMendhe/storyscope-skill)

Two modes.

**AUDIT.** Paste a story or chapter. The skill scores each of the ten dimensions on a simple 1–5 “formulaic narrative pressure” scale, quotes evidence, and lists which AI-leaning tells appear. The overall score is labeled as a **craft signal**, not authorship. If evidence is thin—because the excerpt is short—it should say so.

**REVISE.** Concrete structural moves first. A full rewrite only if you ask. Typical moves: add moral cost; add a contrasting subplot; break chronology once on purpose; escalate consequences rather than adjectives; cut the closing paragraph that explains What It All Meant; mix explicit emotion and behavior instead of only bodily metaphor stacks.

The skill ships with reference files (`narrative-tells.md`, `revision-moves.md`) so the model is anchored to the paper’s themes instead of inventing a private theory of fiction. It should refuse “make this undetectable” framing. If you ask “is this AI?”, it should decline the verdict and offer the craft audit instead.

There is a tiny original sample story in the repo, written on purpose to be tidy and preachy, plus an illustrative audit. They are labeled as examples, not as StoryScope data.

### Install (the version I actually documented)

- **Claude Code:** copy `skills/narrative-depth` into `~/.claude/skills/` (personal) or `.claude/skills/` (project). Start Claude and ask for a narrative-structure audit.
- **claude.ai:** run `make zip` in the repo, then upload `dist/narrative-depth.zip` under **Settings → Features**. This needs a plan with code execution enabled. Custom skills there are per-user.
- **Claude API:** upload through Anthropic’s Skills API, then pass the `skill_id` in the Messages `container` with the code execution tool. API skills do not auto-sync to claude.ai.

Anthropic’s Agent Skills format is a folder with `SKILL.md` YAML frontmatter (`name`, `description`) plus optional reference files. The description has to say **what** the skill does and **when** to use it; that is how Claude decides to load it.

## A quick sense of an audit

On a preachy sample, the skill should light up **Plot**, **Setting**, and **Perspective**: narratorial morals, weather-as-mood, dialogue-as-thesis, internal-acceptance ending, no subplot. Time might score low-formulaic simply because a 400-word sample cannot show flashbacks. That asymmetry matters. StoryScope’s features were extracted on long stories; a tweet-length vignette will under-trigger temporal and network features. Honest tooling says “insufficient evidence” instead of inventing a score.

## Limitations I want on the record

- This skill is **not** StoryScope’s classifier. It is editorial procedure guided by their published feature themes.
- Short posts, emails, and marketing copy are outside the paper’s regime.
- Models change. Yesterday’s lexical tells fade; narrative defaults may drift too.
- Parallel-corpus macro-F1 is not a personal verdict. Do not use this to accuse a stranger of authorship fraud.
- I am not affiliated with the StoryScope authors. Cite them for the science; blame me for the skill’s rough edges.

## Without a moral

I still notice em-dashes. I still flinch at *delve*. After reading StoryScope, I spend more time asking whether a draft’s time is too straight, whether its ending forgives too easily, and whether the narrator is doing the reader’s job.

That is the whole project: a paper worth reading, a small open skill, and a preference for structural honesty over vibes.

**Repo:** https://github.com/PranayMendhe/storyscope-skill  
**Paper:** https://arxiv.org/html/2604.03136v6  
**Official code/data:** https://github.com/jenna-russell/storyscope
