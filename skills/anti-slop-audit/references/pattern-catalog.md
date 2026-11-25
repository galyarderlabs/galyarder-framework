# Pattern Catalog

The auditable source of truth for `anti-slop-audit`. Every finding cites an entry ID. The catalog is the single copy: docs and CI checks quote its counts from here, never from memory.

## Vocabulary Tiers

Tier 1, always flag. These words are the strongest single-word tells when used as filler. A legitimate technical use is an exception, judged by context, not by the word alone.

| ID | Words |
|---|---|
| P-VOCAB-01 | delve, delves, delving |
| P-VOCAB-02 | leverage (as a verb), utilize, commence, facilitate, encompass |
| P-VOCAB-03 | tapestry, landscape (figurative), testament, vibrant, pivotal, crucial |
| P-VOCAB-04 | intricate, meticulous, bolster, garner, underscore, interplay, multifaceted |
| P-VOCAB-05 | nuanced (as filler), foster, paramount, groundbreaking, cutting-edge |
| P-VOCAB-06 | game-changing, transformative, revolutionize, seamless, robust (outside engineering) |
| P-VOCAB-07 | comprehensive (describing own output), endeavour, harnessing, spearheading |
| P-VOCAB-08 | navigating (figurative), showcasing, highlighting, emphasizing, enhancing |
| P-VOCAB-09 | unprecedented, remarkable, stunning, profound, epic (non-literal) |
| P-VOCAB-10 | synergy, pain points, value proposition (in casual contexts), thought leadership |

Tier 2, flag in clusters. One occurrence is a weak match and is reported only as context in the assessment, never as a standalone finding. Two or more occurrences in the same paragraph is a finding.

| ID | Words |
|---|---|
| P-VOCAB-11 | additionally, moreover, furthermore, notably, importantly, indeed |
| P-VOCAB-12 | in essence, at its core, in the realm of, when it comes to |
| P-VOCAB-13 | moving forward, touch base, circle back, rest assured, it goes without saying |

Tier 3, flag at high density. Fine in isolation, suspect in stacks: three or more distinct boilerplate phrases in one piece is a P1 finding; one phrase repeated twice or more is a P2 finding.

| ID | Phrases |
|---|---|
| P-VOCAB-14 | "In today's [adjective] [noun]...", "It is worth noting that...", "It is important to note that..." |
| P-VOCAB-15 | "Let us dive in", "Let us delve into", "A testament to...", "Not just X, but Y" |
| P-VOCAB-16 | "This is where X comes in", "Whether you are a [X] or a [Y]...", "From X to Y" (range opener) |
| P-VOCAB-17 | "At the end of the day...", "The bottom line is...", "Here is the thing...", "Here is the deal..." |
| P-VOCAB-18 | "Without further ado...", "In a nutshell...", "Buckle up", "Take it to the next level" |
| P-VOCAB-19 | "Unlock the power of...", "Empower", "Elevate your...", "Streamline your...", "Supercharge your..." |
| P-VOCAB-20 | "Bridge the gap", "Move the needle", "In conclusion", "Overall," (paragraph starter) |
| P-VOCAB-21 | "Firstly... Secondly... Thirdly...", "I hope this helps", "I hope this finds you well" |

## Content Patterns

| ID | Pattern | Pass condition |
|---|---|---|
| P-CONTENT-01 | Cutoff disclaimers ("As of my last update") | Always a finding (P0) |
| P-CONTENT-02 | Chatbot artifacts ("I hope this helps!", "Great question!") | Always a finding (P0) |
| P-CONTENT-03 | Vague attribution without a source ("Experts believe") | Always a finding (P0) |
| P-CONTENT-04 | Significance inflation on routine events | Always a finding (P0) |
| P-CONTENT-05 | Hashtag stuffing on LinkedIn and investor-email posts | Always a finding (P0 on those profiles, P2 on blogs) |
| P-CONTENT-06 | Fabricated speaker perspective or experience | Always a finding; report as a gap, never fix by inventing |
| P-CONTENT-07 | Manufactured stakes ("now more than ever") | Always a finding |
| P-CONTENT-08 | Forced contrarianism without a source argument | Finding unless the source actually argued it |

## Language Patterns

| ID | Pattern | Severity |
|---|---|---|
| P-LANG-01 | Template phrases and slot-fill constructions | P1 |
| P-LANG-02 | "Let us" transition openers | P1 |
| P-LANG-03 | Synonym cycling inside one paragraph | P1 |
| P-LANG-04 | Formulaic openings ("In the rapidly evolving world of...") | P1 |
| P-LANG-05 | Bold overuse (bolding the setup instead of the insight) | P1 |
| P-LANG-06 | Generic future-narrative closers | P1 |
| P-LANG-07 | Social endorsement closers ("This one is worth your time", "thank me later") | P1 |
| P-LANG-08 | Hedge-stacked predictions ("could potentially", "may eventually") | P1 |
| P-LANG-09 | Real/actual adjective inflation | P1 |
| P-LANG-10 | Moral-adjective category errors ("honest shape") | P1 |
| P-LANG-11 | Narrated candor ("I would rather flag this than let you discover it later") | P1 |
| P-LANG-12 | Lingering-attention claims ("the line I keep coming back to") | P1 |
| P-LANG-13 | Transition phrases (Moreover, Furthermore, Additionally) | P2 |
| P-LANG-14 | Generic conclusions ("The future looks bright") | P2 |

## Structure Patterns

| ID | Pattern | Severity |
|---|---|---|
| P-STRUCT-01 | Compulsive rule of three (defaulting to three items, three points, three reasons) | P2 |
| P-STRUCT-02 | Uniform paragraph length across a whole piece | P2 |
| P-STRUCT-03 | Uniform sentence length (three or more consecutive sentences of the same length) | P2 |
| P-STRUCT-04 | Parataxis chains (three or more short declarative sentences in a row) | P2 |
| P-STRUCT-05 | Bullet lists of five or more bare noun phrases with no verbs | P1 |
| P-STRUCT-06 | Identical paragraph structure repeated (topic sentence, explanation, example, transition) | P2 |
| P-STRUCT-07 | Em dash frequency above 1 per 1,000 words | P2, writing quality only, never an authorship signal |
| P-STRUCT-08 | Copula avoidance (serves as, features, boasts) | P2 |
| P-STRUCT-09 | Repeated setup/reversal punchlines replacing concrete claims | P2 |

## Communication Patterns

| ID | Pattern | Severity |
|---|---|---|
| P-COMM-01 | Invented contrast-pair mirroring ("false precision rather than genuine accuracy") | P1 |
| P-COMM-02 | False agency (attributing agency to a tool or abstraction) | P2, judgment only |
| P-COMM-03 | Transformation crutch (claims of transformation with no mechanism) | P2, judgment only |
| P-COMM-04 | Ambiguous domain terminology used without definition | P2, judgment only |
| P-COMM-05 | Consequence-free explanations (a claim with no stated consequence) | P2, judgment only |
| P-COMM-06 | Repeated empty concessions (conceding a point, then ignoring it) | P2, judgment only |
| P-COMM-07 | Unnecessary hyphenation of curated open, closed, and position-dependent compounds | P2 |

## Context Profiles

Strictness varies by profile. A profile's "skip" is an applicability decision, not a lower setting another profile can overrule.

| Profile | Notes |
|---|---|
| linkedin | Hashtag stuffing is P0. Bold overuse is P1. Short punchy lines are normal, not parataxis. |
| blog | Hashtag stuffing is P2. Longer paragraphs are normal. |
| technical-blog | "robust" and "ecosystem" are legitimate technical uses. Word table exceptions apply. |
| investor-email | Hashtag stuffing is P0. Formal register is normal, not stiffness. |
| docs | Neutral and plain may be the intended voice. Do not force personality. |
| casual | Fragments and short messages are normal. Do not force full sentences. |

## Scoring

Findings per 1,000 words, reported by tier, before and after a rewrite:

- P0 count, P1 count, P2 count, and total.
- Residuals listed by catalog ID with the reason each was left (intentional, protected, source-blocked, pass-limit).
- A "matches voice" claim is never made without this score attached.
