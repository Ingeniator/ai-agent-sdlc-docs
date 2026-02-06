# SDLC: Traditional vs AI Agent

> Both follow the same fundamental cycle. The difference is in **what's inside each stage** and **new substages** required for non-deterministic systems.

## Document Structure

```
sdlc/
├── README.md                    # This file - overview
├── 01-traditional-sdlc.md       # Traditional SDLC stages & tools
├── 02-ai-agent-sdlc.md          # AI Agent SDLC stages & tools
├── 03-comparison.md             # Side-by-side comparison
├── 04-tools-landscape.md        # Tool ecosystem reference
└── 05-dataset-management.md     # Eval dataset management deep dive
```

## Quick Overview

Both SDLCs share the same core cycle:

```mermaid
flowchart TB
    subgraph cycle["Core SDLC Cycle - Both"]
        Planning --> Design --> Development --> Testing --> Deployment --> Operations
        Operations -.->|Continuous Iteration| Planning
    end
```

### Traditional SDLC

```mermaid
flowchart TB
    subgraph Traditional["Traditional SDLC"]
        P1[Planning] --> D1[Design] --> DEV1[Development]
        DEV1 --> T1[Testing] --> DEP1[Deployment] --> O1[Operations]
        O1 -.->|Iteration| P1

        subgraph ops1["Operations"]
            O1a[Monitoring]
            O1b[Maintenance]
            O1c[Improvements]
        end
    end
```

**Artifacts**: Code
**Testing**: Pass/fail assertions
**Monitoring**: Logs, metrics, APM (Application Performance Monitoring: latency, error rates, throughput, distibuted traces, dependencies)

### AI Agent SDLC

```mermaid
flowchart TB
    subgraph AI["AI Agent SDLC"]
        P2[Planning] --> D2[Design] --> DEV2[Development]
        DEV2 --> T2["Testing / Evaluation"] --> DEP2[Deployment] --> O2[Operations]
        O2 -.->|Iteration| P2

        subgraph ops2["Operations - Expanded"]
            O2a[Observability]
            O2b["Quality Control ✱"]
            O2c[Improvements]
        end
    end

    style T2 fill:#fff3e0,stroke:#e65100
    style O2b fill:#e8f5e9,stroke:#2e7d32
```

**Artifacts**: Code + **Prompts** + **Model refs**
**Testing**: Pass/fail + **Fuzzy scoring**
**Monitoring**: Logs, metrics + **Traces** + **Token costs**

✱ = New substage

---

## What's Actually Different?

### Same Stages, Different Content

| Stage | Traditional | AI Agent | What Changes |
|-------|-------------|----------|--------------|
| **Planning** | User stories, specs | + Guardrail specs, eval criteria | Add safety boundaries |
| **Design** | Architecture, APIs | + Prompt design, memory strategy | New design artifacts |
| **Development** | Code, unit tests | + Prompt templates, tracing | New artifact types |
| **Testing** | Pass/fail assertions | + Fuzzy scoring (evals) | Scoring replaces binary |
| **Deployment** | CI/CD, feature flags | + Prompt versioning, A/B models | Version more artifacts |
| **Operations** | Monitoring, maintenance | + Quality control substage | Expanded scope |

### Genuinely New Concepts

| Concept | Why It's New |
|---------|--------------|
| **Fuzzy Evaluation** | Non-deterministic outputs need scoring, not assertions |
| **Reasoning Traces** | Debug *why* the agent decided something |
| **Quality Control** | Detect hallucinations, safety violations in real-time |
| **Prompt Versioning** | Prompts are code-level artifacts now |
| **Token Economics** | Per-request variable costs |
| **Human-in-the-loop** | Continuous feedback drives improvements |

### Key Paradigm Shift

```
Traditional: Same input → Same output (deterministic)
AI Agent:    Same input → Different outputs (probabilistic)
                         ↓
            Requires: Fuzzy evaluation, quality monitoring, traces
```

---

## Side-by-Side Diagram

```mermaid
C4Context
    title SDLC Comparison

    Enterprise_Boundary(trad, "Traditional") {
        System(t1, "Planning", "Requirements, specs")
        System(t2, "Design", "Architecture, APIs")
        System(t3, "Development", "Code")
        System(t4, "Testing", "Pass/fail")
        System(t5, "Deployment", "CI/CD")
        System(t6, "Operations", "Monitor + Maintain")
    }

    Enterprise_Boundary(ai, "AI Agent") {
        System(a1, "Planning", "+ Guardrails, eval criteria")
        System(a2, "Design", "+ Prompts, memory, tools")
        System(a3, "Development", "+ Prompts, traces")
        System(a4, "Evaluation", " + Scoring")
        System(a5, "Deployment", "+ Prompt versions")
        System(a6, "Operations", "+ Quality Control")
    }

    Rel(t1, a1, "Expands")
    Rel(t2, a2, "Expands")
    Rel(t3, a3, "Expands")
    Rel(t4, a4, "Evolves")
    Rel(t5, a5, "Expands")
    Rel(t6, a6, "Expands")

    UpdateLayoutConfig($c4ShapeInRow="3", $c4BoundaryInRow="1")
```

---

## Summary: Evolution, Not Revolution

| Aspect | Change Type | Description |
|--------|-------------|-------------|
| Planning | **Expand** | Add guardrails and evaluation criteria |
| Design | **Expand** | Add prompt engineering and memory design |
| Development | **Expand** | Add prompt templates and tracing |
| Testing | **Evolve** | Binary → Scoring (fundamental shift) |
| Deployment | **Expand** | Version prompts alongside code |
| Operations | **Expand** | Add Quality Control substage |

The AI Agent SDLC is an **evolution** of traditional SDLC, not a replacement. Teams with strong traditional practices have a foundation—they need to **expand** existing stages and **adapt** testing for non-determinism.

---

## Reading Order

1. **[Traditional SDLC](01-traditional-sdlc.md)** - Understand the foundation
2. **[AI Agent SDLC](02-ai-agent-sdlc.md)** - See what expands/evolves
3. **[Comparison](03-comparison.md)** - Detailed stage-by-stage analysis
4. **[Tools Landscape](04-tools-landscape.md)** - Tool reference guide
5. **[Dataset Management](05-dataset-management.md)** - Eval dataset management deep dive
