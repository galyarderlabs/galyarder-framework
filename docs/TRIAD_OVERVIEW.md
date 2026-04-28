# The Galyarder Triad: Complete Ecosystem Overview

To build a high-scale Digital Company, you need three layers working in perfect symmetry: **Intelligence**, **Governance**, and **Presence**.

---

## 1. Galyarder Framework (Intelligence Layer)
*The Brain and the Workforce.*

- **Repository**: [galyarder-framework](https://github.com/galyarderlabs/galyarder-framework)
- **Role**: Provides the 40 specialized agents and 132 skills (SOPs) that execute missions with mathematical precision (Humans 3.0).
- **Function**: It is the logic engine. It defines *how* work is done (TDD, SEO, Security, etc.).
- **Usage**: Runs inside your AI assistants (Claude, Gemini, Cursor) to give them institutional-grade capabilities.

---

## 2. Galyarder HQ (Governance Layer)
*The Control Plane and the Office.*

- **Repository**: [galyarder-hq](https://github.com/galyarderlabs/galyarder-hq)
- **Role**: A master governance dashboard for solo founders managing multiple projects.
- **Function**: It provides the Web UI to monitor task queues, review Obsidian reports, and govern agent activity across the entire empire.
- **Usage**: A self-hosted web app that "listens" to your file system and integrates with Linear.

---

## 3. Galyarder Agent (Presence Layer)
*The Entity and the Runtime.*

- **Repository**: [galyarder-agent](https://github.com/galyarderlabs/galyarder-agent)
- **Role**: A self-evolving assistant runtime that lives where you live (Telegram, WhatsApp, CLI).
- **Function**: It provides persistent long-term memory, stable identity (faces/selfies), and multi-channel communication. It connects to your Google Workspace and handles proactive tasks.
- **Usage**: A Python-based runtime that you run 24/7 (via systemd) to stay connected to your company.

---

## How They Work Together

```text
[ YOU ] 
   |
   | (Intent via WhatsApp/Telegram)
   v
[ GALYARDER AGENT ] <--- (Powered by) ---> [ GALYARDER FRAMEWORK ]
   (The Entity)                               (The Intelligence)
         |                                           |
         | (Saves Reports & Progress)                |
         v                                           v
                 [ DIGITAL HEADQUARTERS ]
                    (Linear / Obsidian)
                           |
                           | (Visualized & Governed by)
                           v
                    [ GALYARDER HQ ]
                     (Control Plane)
```

1.  **Framework** makes your agents smart.
2.  **Agent** gives your smart logic a "body" and a way to talk to you.
3.  **HQ** gives you a "dashboard" to make sure everything is scaling correctly.

**The Galyarder Triad is the ultimate 1-Man Army stack.** You provide the Vision; the Triad provides the Execution.

---
