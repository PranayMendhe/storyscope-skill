# AI fiction gives itself away in how the story is built

**Subtitle:** A new study of 61,608 parallel human and AI stories finds that narrative choices alone (plot, time, theme, resolution) separate human from AI fiction at 93.2% macro-F1, with no word lists involved. I turned its findings into an open Claude skill for writers.

**Suggested Medium tags:** Writing, Artificial Intelligence, Fiction, Claude AI, Creative Writing

---

Most of us carry a mental list of AI writing tells by now. Em-dashes everywhere, and the word *delve*. I have that list too, and I still catch myself scanning for it.

A recent paper convinced me that list is looking at the wrong layer. Word habits are easy to edit out. What stays is the structure: how cause and effect get laid down, whether time ever breaks, whether a character's choice actually costs them anything, and whether the narrator trusts you to find the theme yourself.

So I read it properly, and then built a small tool I'd actually use on drafts.

## The paper

*StoryScope: Investigating idiosyncrasies in AI fiction* is a preprint by Jenna Russell, Rishanth Rajendhran, Chau Minh Pham and Mohit Iyyer at the University of Maryland, with John Wieting at Google DeepMind. The [arXiv HTML version](https://arxiv.org/html/2604.03136v6) is very readable, and the code and data are at [github.com/jenna-russell/storyscope](https://github.com/jenna-russell/storyscope).

The setup is careful. They reverse-engineered 10,272 writing prompts from human short fiction. Each prompt has the original human story plus a version from each of five LLMs: Claude, DeepSeek, Gemini, GPT and Kimi. That comes to 61,608 stories of roughly 5,000 words each (the corpus mean is 4,753). From these they built 304 discourse-level features across 10 dimensions taken from the NarraBench taxonomy, namely agent, social network, event, plot, structure, setting, time, revelation, perspective and style. The narrative-only model leaves the style features out and works with 257.

The numbers that stuck with me:

- Narrative features alone: 93.2% macro-F1 at telling human from AI.
- Narrative plus style: 96.0%.
- Only 30 core narrative features: 84.8%.
- Six-way attribution (which of the six sources wrote it): 68.4% with narrative features, 77.3% once style is added.

The editing test convinced me most. They took 278 Gemini stories and had them rewritten with LAMP, a method that goes after AI prose artifacts like cliché and purple prose. The narrative model still caught the edited stories at 93.9% macro-F1, compared with 95.5% on the originals. A drop of 1.6 points. Cleaning up the sentences barely touched the skeleton underneath.

I'm an engineering manager in Bengaluru, not a narratologist. I didn't want to rebuild their classifier. I wanted a checklist for drafts, my own or ones that teammates and friends send me.

## What the tells look like on the page

Section 4.1 is the part writers should read slowly. It's almost a set of revision notes.

AI stories over-explain their themes. The narrator explicitly states the theme 77% of the time, against 52% for human stories. Dialogue drifts into philosophical debate more often (59% vs 34%). Endings tend to settle on internal understanding or acceptance (47% vs 27%). Plots run on one causal track, and 79% of AI stories have no subplots at all, compared with 57% of human ones. Emotion comes through the body as physical sensations and bodily metaphors (81% vs 38%), and there's a surprising amount of smell (82% vs 57%). Where a person might just write that someone felt afraid, the model gives you a tight chest and a cold sweat. Humans use plain emotion labels 29% of the time. AI does it 8% of the time.

Human stories are messier, mostly in useful ways. Their protagonists are morally ambivalent more often (59% vs 38%). Subplots that tie back into the main theme show up twice as often (42% vs 21%). People use more flashbacks and time jumps, and seem more comfortable leaving an ending ambiguous. They name real texts and authors more (47% vs 24%), and they speak directly to the reader far more often (28% vs 7%).

The models also look a lot like each other. When every story is turned into a vector of narrative features, the five AI models sit in one tight cluster and the human stories occupy their own region. Human stories are rarer in that space on average (mean rarity percentile 0.71, against 0.49 for AI). That's a finding about a corpus of long stories, and I wouldn't apply it to anyone's weekend draft. It does explain why so much generated fiction feels like it came out of the same workshop.

There are per-model fingerprints too, and some are fun. Claude's escalation is the flattest of the lot, and it likes quiet endings. GPT leans on gossip and rumour as a plot device. Gemini goes for the tidiest endings, with long denouements. DeepSeek puts important context up front where the others hold it back, while Kimi sits at the generic centre of the AI distribution. I'd treat this as colour from their corpus, not evidence about one paragraph you pasted into a chat window.

Word-level tells keep moving, which is why I care more about structure. Style features alone still reach 85.8% macro-F1 in the paper, but the authors note that style-based detectors are known to be brittle under paraphrasing and light editing. Narrative features may last longer as models change, they suggest, because changing them means replotting the story.

For a writer this is ordinary revision work. Find where the story preaches its theme, and check whether there's a second thread at all. Could the timeline break once, so a reveal changes how earlier scenes read? Escalation with no lasting cost is another thing to catch, and so is a protagonist whose choice comes too easily. It doesn't matter whether a person or a model wrote the first draft, and I have no interest in helping anyone beat a detector. I'd just like to read fewer stories that end with the narrator explaining the lesson while the weather nods along.

## The skill: narrative-depth

I packaged all of this as an open Claude Agent Skill called `narrative-depth`. It's at [github.com/PranayMendhe/storyscope-skill](https://github.com/PranayMendhe/storyscope-skill).

It has two modes. In AUDIT you paste a story or chapter, and it scores each of the ten dimensions on a 1–5 "formulaic narrative pressure" scale and quotes the passages behind each score, so you can see which AI-leaning tells it picked up. The overall score is meant as a craft signal. It says nothing about who wrote the text, and if the excerpt is too short to judge, the skill is supposed to say so.

REVISE suggests structural moves first and rewrites only if asked. Typical ones: adding a moral cost, adding a subplot that pulls against the main one, breaking chronology once on purpose, escalating consequences instead of adjectives, and cutting the closing paragraph that explains what it all meant.

Two reference files, `narrative-tells.md` and `revision-moves.md`, keep the model anchored to the paper instead of its own theory of fiction. It should refuse "make this undetectable" requests. If you ask it "is this AI?", it should decline to give a verdict and offer the craft audit instead.

The repo also has a short original sample story, written to be preachy on purpose, with an example audit. Both are labelled as examples. Neither is StoryScope data.

On that sample the flags should pile up: a narrator stating the moral, weather standing in for mood, dialogue used as a thesis, an ending built on quiet acceptance, and no subplot. Time might look barely formulaic, simply because a piece under 300 words has no room for a flashback. That gap matters. StoryScope's features came from long stories, and short pieces under-trigger things like time and social network. I'd rather the tool say "not enough evidence" than make up a score.

To install it:

- **Claude Code:** copy `skills/narrative-depth` into `~/.claude/skills/` (personal) or `.claude/skills/` (project), then start Claude and ask for a narrative-structure audit.
- **claude.ai:** run `make zip` in the repo and upload `dist/narrative-depth.zip` under Settings → Features. You need a plan with code execution enabled, and custom skills there are per-user.

For the Claude API, upload it through Anthropic's Skills API and pass the `skill_id` in the Messages `container` along with the code execution tool. API skills don't sync to claude.ai on their own.

The format itself is simple: a folder with a `SKILL.md` whose YAML frontmatter has a `name` and a `description`, plus optional reference files. The description must say what the skill does and when to use it, since Claude reads it to decide whether to load the skill.

## Limitations

This isn't StoryScope's classifier. It's an editorial procedure based on the feature themes they published. Short posts and marketing copy are well outside what the paper studied. Models change too, and narrative defaults may drift the way word-level tells already have. A macro-F1 score on a parallel corpus is not a verdict on a person, so please don't use this to accuse anyone. I'm also not affiliated with the authors. Cite them for the research. The rough edges in the skill are mine.

I still notice em-dashes, and I still wince a little at *delve*. These days I also check whether a draft's timeline runs too straight, and whether the narrator is doing the reader's job for them.

**Repo:** https://github.com/PranayMendhe/storyscope-skill  
**Paper:** https://arxiv.org/html/2604.03136v6 (official code and data: https://github.com/jenna-russell/storyscope)
