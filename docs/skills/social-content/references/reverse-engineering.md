# Reverse Engineering Viral Content

Instead of guessing what works, systematically analyze top-performing content in your niche and extract proven patterns.

## The 6-Step Framework

### 1. NICHE ID  Find Top Creators

Identify 10-20 creators in your space who consistently get high engagement:

**Selection criteria:**
- Posting consistently (3+ times/week)
- High engagement rate relative to follower count
- Audience overlap with your target market
- Mix of established and rising creators

**Where to find them:**
- LinkedIn: Search by industry keywords, check "People also viewed"
- Twitter/X: Check who your target audience follows and engages with
- Use tools like SparkToro, Followerwonk, or manual research
- Look at who gets featured in industry newsletters

### 2. SCRAPE  Collect Posts at Scale

Gather 500-1000+ posts from your identified creators for analysis:

**Tools:**
- **Apify**  LinkedIn scraper, Twitter scraper actors
- **Phantom Buster**  Multi-platform automation
- **Export tools**  Platform-specific export features
- **Manual collection**  For smaller datasets, copy/paste into spreadsheet

**Data to collect:**
- Post text/content
- Engagement metrics (likes, comments, shares, saves)
- Post format (text-only, carousel, video, image)
- Posting time/day
- Hook/first line
- CTA used
- Topic/theme

### 3. ANALYZE  Extract What Actually Works

Sort and analyze the data to find patterns:

**Quantitative analysis:**
- Rank posts by engagement rate
- Identify top 10% performers
- Look for format patterns (do carousels outperform?)
- Check timing patterns (best days/times)
- Compare topic performance

**Qualitative analysis:**
- What hooks do top posts use?
- How long are high-performing posts?
- What emotional triggers appear?
- What formats repeat?
- What topics consistently perform?

**Questions to answer:**
- What's the average length of top posts?
- Which hook types appear most in top 10%?
- What CTAs drive most comments?
- What topics get saved/shared most?

### 4. PLAYBOOK  Codify Patterns

Document repeatable patterns you can use:

**Hook patterns to codify:**
```
Pattern: "I [unexpected action] and [surprising result]"
Example: "I stopped posting daily and my engagement doubled"
Why it works: Curiosity gap + contrarian

Pattern: "[Specific number] [things] that [outcome]:"
Example: "7 pricing mistakes that cost me $50K:"
Why it works: Specificity + loss aversion

Pattern: "[Controversial take]"
Example: "Cold outreach is dead."
Why it works: Pattern interrupt + invites debate
```

**Format patterns:**
- Carousel: Hook slide  Problem  Solution steps  CTA
- Thread: Hook  Promise  Deliver  Recap  CTA
- Story post: Hook  Setup  Conflict  Resolution  Lesson

**CTA patterns:**
- Question: "What would you add?"
- Agreement: "Agree or disagree?"
- Share: "Tag someone who needs this"
- Save: "Save this for later"

### 5. LAYER VOICE  Apply Direct Response Principles

Take proven patterns and make them yours with these voice principles:

**"Smart friend who figured something out"**
- Write like you're texting advice to a friend
- Share discoveries, not lectures
- Use "I found that..." not "You should..."
- Be helpful, not preachy

**Specific > Vague**
```
 "I made good revenue"
 "I made $47,329"

 "It took a while"
 "It took 47 days"

 "A lot of people"
 "2,847 people"
```

**Short. Breathe. Land.**
- One idea per sentence
- Use line breaks liberally
- Let important points stand alone
- Create rhythm: short, short, longer explanation

```
 "I spent three years building my business the wrong way before I finally realized that the key to success was focusing on fewer things and doing them exceptionally well."

 "I built wrong for 3 years.

Then I figured it out.

Focus on less.
Do it exceptionally well.

Everything changed."
```

**Write from emotion**
- Start with how you felt, not what you did
- Use emotional words: frustrated, excited, terrified, obsessed
- Show vulnerability when authentic
- Connect the feeling to the lesson

```
 "Here's what I learned about pricing"

 "I was terrified to raise my prices.

My hands were shaking when I sent the email.

Here's what happened..."
```

### 6. CONVERT  Turn Attention into Action

### 7. Technical Integrity: The Karpathy Principles
Combat AI slop through rigid adherence to the four principles of Andrej Karpathy:

### 8. Corporate Reporting: The Obsidian Loop
Durable memory is mandatory. Every task must result in a persistent artifact:
- **Write Report**: Upon completion, save a summary/artifact to the relevant department in `docs/departments/` (e.g., `Engineering/`, `Growth/`).
- **Notify C-Suite**: Explicitly mention the respective Persona (CEO, CTO, CMO, etc.) that the report is ready for review.
- **Traceability**: Link the report to the corresponding Linear ticket.
1. **Think Before Coding**: Don't guess. **If uncertain, STOP and ASK.** State assumptions explicitly. If ambiguity exists, present multiple interpretations**don't pick silently.** Push back if a simpler approach exists.
2. **Simplicity First**: Implement the minimum code that solves the problem. **No speculative abstractions.** If 200 lines could be 50, **rewrite it.** No "configurability" unless requested.
3. **Surgical Changes**: Touch **ONLY** what you must. Every changed line must trace to the request. Don't "improve" adjacent code or refactor things that aren't broken. Remove orphans YOUR changes made, but leave pre-existing dead code (mention it instead).
4. **Goal-Driven Execution**: Define success criteria via tests-first. **Loop until verified.**
   - Multi-step tasks MUST use this syntax:
     1. [Step]  verify: [check]
     2. [Step]  verify: [check]


## The Formula

```
1. Find what's already working (don't guess)
2. Extract the patterns (hooks, formats, CTAs)
3. Layer your authentic voice on top
4. Test and iterate based on your own data
```

## Reverse Engineering Checklist

- [ ] Identified 10-20 top creators in niche
- [ ] Collected 500+ posts for analysis
- [ ] Ranked by engagement rate
- [ ] Documented top 10 hook patterns
- [ ] Documented top 5 format patterns
- [ ] Documented top 5 CTA patterns
- [ ] Created voice guidelines (specificity, brevity, emotion)
- [ ] Built template library from patterns
- [ ] Set up tracking for your own content performance

 2026 Galyarder Labs. Galyarder Framework.
