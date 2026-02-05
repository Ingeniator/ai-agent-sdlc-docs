# AI Agent Software Development Life Cycle

> A new paradigm for building AI-powered autonomous systems.

## Overview

```mermaid
C4Context
    title AI Agent SDLC - Context Diagram

    Person(team, "Dev Team", "Engineers, ML specialists")
    Person(users, "End Users", "Provide feedback")

    Enterprise_Boundary(sdlc, "AI Agent SDLC") {
        System(plan, "Planning", "Goals, guardrails, metrics")
        System(design, "Design", "Prompts, tools, memory")
        System(dev, "Development", "Code + Prompts + Traces")
        System(eval, "Evaluation", "Evals, red team, human review")
        System(deploy, "Deployment", "Canary, A/B, rollback")
        System(obs, "Observability", "Traces, tokens, costs")
        System(qc, "Quality Control", "Scoring, hallucination, safety")
        System(iter, "Iteration", "Prompt opt, fine-tuning")
    }

    System_Ext(llm, "LLM Provider", "OpenAI, Anthropic, etc.")
    System_Ext(vectordb, "Vector DB", "RAG storage")

    Rel(team, plan, "Defines")
    Rel(users, qc, "Provides feedback")
    Rel(dev, llm, "Calls")
    Rel(dev, vectordb, "Queries")

    Rel(plan, design, "")
    Rel(design, dev, "")
    Rel(dev, eval, "")
    Rel(eval, deploy, "")
    Rel(deploy, obs, "")
    Rel(obs, qc, "")
    Rel(qc, iter, "")
    Rel(iter, plan, "Continuous loop")
```

## What's Different?

| Aspect | Traditional | AI Agent |
|--------|-------------|----------|
| Output | Deterministic | Probabilistic |
| Artifact | Code | Code + Prompts + Model |
| Testing | Pass/fail | Fuzzy scoring |
| Debugging | Stack traces | Reasoning traces |
| Costs | Compute/storage | Per-token pricing |
| Safety | Security | Security + Alignment |

---

## Stage 1: Planning

**Purpose**: Define what the agent should achieve and its boundaries.

```mermaid
C4Container
    title Planning Stage

    Container_Boundary(plan, "Planning") {
        Container(goals, "Agent Goals", "Document", "What problem to solve")
        Container(usecases, "Use Cases", "Specification", "User intents, scenarios")
        Container(metrics, "Success Metrics", "KPIs", "Accuracy, latency, cost targets")
        Container(guardrails, "Guardrail Specs", "Policy", "Safety boundaries")
        Container(evalcriteria, "Eval Criteria", "Rubric", "How to measure quality")
    }

    Rel(goals, usecases, "Drives")
    Rel(usecases, metrics, "Measured by")
    Rel(metrics, guardrails, "Bounded by")
    Rel(guardrails, evalcriteria, "Validated against")
```

### Key Activities
- Define agent's purpose and scope
- Identify user intents and scenarios
- Set measurable success criteria
- Define safety boundaries and policies
- Design evaluation rubrics
- Set cost and latency budgets

### Artifacts
- Agent specification document
- Use case catalog
- Success metrics and KPIs
- Guardrail policy document
- Evaluation criteria rubric

### Key Questions
- What task should the agent accomplish?
- What are acceptable failure modes?
- What content/actions are prohibited?
- What's the token budget per request?
- How do we measure "good enough"?

### Tools
| Category | Tools |
|----------|-------|
| **Project Management** | Jira, Linear, Notion |
| **Prompt Management** | PromptLayer, Humanloop, Agenta |
| **Eval Design** | Braintrust, Scorecard |

---

## Stage 2: Design

**Purpose**: Architect the agent system and design prompts.

```mermaid
C4Container
    title Design Stage

    Container_Boundary(design, "Design") {
        Container(arch, "Agent Architecture", "Pattern", "ReAct, CoT, Multi-agent")
        Container(prompts, "Prompt Engineering", "Templates", "System prompts, few-shot")
        Container(tools, "Tool Design", "Schemas", "Function calling specs")
        Container(memory, "Memory Strategy", "Design", "Context, RAG, long-term")
        Container(safety, "Safety Design", "Guardrails", "Input/output filters")
    }

    Rel(arch, prompts, "Shapes")
    Rel(arch, tools, "Defines")
    Rel(prompts, memory, "Uses")
    Rel(tools, safety, "Constrained by")
```

### Agent Patterns

| Pattern | Description | Use Case |
|---------|-------------|----------|
| **ReAct** | Reason + Act loop | Tool-using agents |
| **Chain-of-Thought** | Step-by-step reasoning | Complex reasoning |
| **Plan-and-Execute** | Plan first, then execute | Multi-step tasks |
| **Multi-Agent** | Multiple specialized agents | Complex workflows |
| **Reflexion** | Self-critique and improve | Iterative refinement |

### Key Activities
- Choose agent architecture pattern
- Design system prompts and templates
- Define tool/function schemas
- Design memory and retrieval strategy
- Plan context window management
- Design safety guardrails

### Artifacts
- Architecture decision records
- Prompt templates (versioned)
- Tool/function schemas (JSON Schema)
- Memory architecture diagram
- Guardrail specifications

### Tools
| Category | Tools |
|----------|-------|
| **Frameworks** | LangChain, LlamaIndex, AutoGen, CrewAI |
| **Prompt IDEs** | PromptLayer, Humanloop, Agenta |
| **RAG/Memory** | Pinecone, Weaviate, Chroma, Qdrant |
| **Diagramming** | Miro, Draw.io, Excalidraw |

---

## Stage 3: Development

**Purpose**: Build the agent system with observability.

```mermaid
C4Container
    title Development Stage

    Container_Boundary(dev, "Development") {
        Container(logic, "Agent Logic", "Code", "Orchestration, routing")
        Container(prompts, "Prompt Templates", "Config", "Versioned YAML/JSON")
        Container(tools, "Tool Implementations", "Code", "Function handlers")
        Container(guards, "Guardrails", "Code", "Input/output validators")
        Container(trace, "Tracing", "SDK", "Instrumentation")
    }

    System_Ext(framework, "Agent Framework", "LangChain, etc.")
    System_Ext(llm, "LLM API", "OpenAI, Anthropic")
    System_Ext(vectordb, "Vector DB", "Pinecone, Chroma")
    System_Ext(obsplatform, "Observability", "LangSmith, LangFuse")

    Rel(logic, framework, "Uses")
    Rel(logic, prompts, "Loads")
    Rel(logic, tools, "Calls")
    Rel(logic, guards, "Validates")
    Rel(framework, llm, "Calls")
    Rel(framework, vectordb, "Queries")
    Rel(trace, obsplatform, "Exports to")
```

### Key Activities
- Implement agent orchestration
- Create versioned prompt templates
- Build tool/function implementations
- Implement guardrail validators
- Instrument with tracing
- Handle context window limits
- Implement error handling and retries

### Artifacts
- Agent code (Python/TypeScript)
- Prompt templates (version controlled)
- Tool implementations
- Guardrail configurations
- Tracing instrumentation

### Code Example: Basic Agent Structure
```python
# Pseudo-code structure
class Agent:
    def __init__(self):
        self.llm = LLM(model="gpt-4")
        self.tools = [search_tool, calculator_tool]
        self.memory = VectorStore()
        self.guardrails = Guardrails()
        self.tracer = Tracer()

    @trace
    def run(self, user_input: str) -> str:
        # Validate input
        self.guardrails.validate_input(user_input)

        # Retrieve context
        context = self.memory.search(user_input)

        # Generate response with tools
        response = self.llm.generate(
            system_prompt=SYSTEM_PROMPT,
            user_message=user_input,
            context=context,
            tools=self.tools
        )

        # Validate output
        self.guardrails.validate_output(response)

        return response
```

### Tools
| Category | Tools |
|----------|-------|
| **Frameworks** | LangChain, LlamaIndex, Haystack, AutoGen |
| **LLM APIs** | OpenAI, Anthropic, Google, Cohere, Mistral |
| **Guardrails** | Guardrails AI, NeMo Guardrails, Rebuff |
| **Tracing** | LangSmith, LangFuse, Arize Phoenix, OpenLLMetry |

---

## Stage 4: Evaluation

**Purpose**: Assess agent quality with fuzzy metrics.

```mermaid
C4Container
    title Evaluation Stage

    Container_Boundary(eval, "Evaluation") {
        Container(unit, "Unit Tests", "Framework", "Deterministic parts")
        Container(behavioral, "Behavioral Evals", "Suite", "Fuzzy scoring")
        Container(benchmark, "Benchmarks", "Datasets", "Standard eval sets")
        Container(redteam, "Red Team", "Adversarial", "Jailbreaks, injection")
        Container(human, "Human Eval", "Annotation", "Expert review")
        Container(regression, "Regression", "CI", "Quality gates")
    }

    ContainerDb(evaldb, "Eval Results", "Database", "Score history")

    Rel(behavioral, evaldb, "Records")
    Rel(benchmark, evaldb, "Records")
    Rel(redteam, evaldb, "Records")
    Rel(human, evaldb, "Records")
    Rel(evaldb, regression, "Tracks")
```

### Evaluation Types

| Type | Description | Automation |
|------|-------------|------------|
| **Unit Tests** | Deterministic component tests | Automated |
| **Behavioral Evals** | Input→Output quality scoring | Automated |
| **Benchmark Evals** | Standard datasets (MMLU, etc.) | Automated |
| **LLM-as-Judge** | Use LLM to evaluate outputs | Automated |
| **Red Teaming** | Adversarial testing | Semi-automated |
| **Human Evaluation** | Expert annotation | Manual |

### Scoring Methods

| Method | Description |
|--------|-------------|
| **Exact Match** | Output == expected |
| **Fuzzy Match** | Similarity score |
| **LLM-as-Judge** | LLM rates quality 1-5 |
| **Rubric Scoring** | Multi-criteria rubric |
| **Human Rating** | Expert annotation |

### Key Metrics
| Metric | Description |
|--------|-------------|
| **Task Accuracy** | % correct completions |
| **Hallucination Rate** | % factually incorrect |
| **Safety Violation Rate** | % policy violations |
| **Refusal Rate** | % inappropriate refusals |
| **Latency P50/P99** | Response time distribution |
| **Token Efficiency** | Output quality per token |

### Tools
| Category | Tools |
|----------|-------|
| **Eval Frameworks** | Promptfoo, RAGAS, DeepEval, Evalplus |
| **Benchmarks** | MMLU, HumanEval, MT-Bench, AlpacaEval |
| **Platforms** | Braintrust, LangSmith Evals, Humanloop |
| **Red Teaming** | Garak, promptfoo adversarial |
| **Human Eval** | Scale AI, Surge AI, Labelbox |

---

## Stage 5: Deployment

**Purpose**: Release with quality gates and rollback capability.

```mermaid
C4Container
    title Deployment Stage

    Container_Boundary(deploy, "Deployment") {
        Container(ci, "CI + Evals", "Pipeline", "Build, test, eval")
        Container(registry, "Artifact Registry", "Storage", "Code + Prompts + Model refs")
        Container(staging, "Staging", "Environment", "Pre-prod validation")
        Container(canary, "Canary", "Strategy", "Limited traffic")
        Container(prod, "Production", "Environment", "Full deployment")
        Container(rollback, "Auto-Rollback", "Automation", "Quality-triggered")
    }

    Rel(ci, registry, "Publishes")
    Rel(registry, staging, "Deploys")
    Rel(staging, canary, "Promotes")
    Rel(canary, prod, "Graduates")
    Rel(prod, rollback, "Triggers if needed")
```

### Deployment Differences

| Aspect | Traditional | AI Agent |
|--------|-------------|----------|
| **Artifacts** | Code/containers | + Prompts + Model refs |
| **Quality Gate** | Tests pass | + Eval scores above threshold |
| **Rollback Trigger** | Errors, latency | + Quality degradation |
| **A/B Testing** | Feature comparison | Model/prompt comparison |

### Key Activities
- Version prompts alongside code
- Set eval score thresholds for deployment
- Configure canary deployment
- Set up A/B testing for model variants
- Implement quality-triggered rollback
- Monitor token costs during rollout

### Tools
| Category | Tools |
|----------|-------|
| **LLM Hosting** | AWS Bedrock, Azure OpenAI, Vertex AI |
| **Agent Hosting** | Modal, Replicate, Baseten, Anyscale |
| **Experiment Tracking** | Weights & Biases, MLflow, Comet |
| **Feature Management** | LaunchDarkly, Statsig |

---

## Stage 6: Observability

**Purpose**: Monitor reasoning, costs, and quality in real-time.

```mermaid
C4Container
    title Observability Stage

    Container_Boundary(obs, "Observability") {
        Container(traces, "Trace Collection", "Service", "Reasoning chains")
        Container(metrics, "Metrics", "Service", "Latency, throughput")
        Container(tokens, "Token Tracking", "Service", "Usage, costs")
        Container(costs, "Cost Analytics", "Dashboard", "Per-request costs")
        Container(alerts, "Alerting", "Service", "Anomaly detection")
    }

    ContainerDb(tracedb, "Trace Storage", "Database", "LangSmith, Phoenix")
    ContainerDb(metricsdb, "Metrics DB", "Time Series", "Prometheus")

    Rel(traces, tracedb, "Stores")
    Rel(metrics, metricsdb, "Stores")
    Rel(tokens, metricsdb, "Stores")
    Rel(metricsdb, alerts, "Triggers")
```

### What to Monitor

| Category | Metrics |
|----------|---------|
| **Performance** | Latency (P50, P99), throughput |
| **Tokens** | Input/output counts, cost per request |
| **Quality** | Online eval scores, user ratings |
| **Errors** | LLM errors, tool failures, guardrail blocks |
| **Business** | Task completion rate, user satisfaction |

### Trace Anatomy
```
Request → Input Guardrail → LLM Call 1 → Tool Call → LLM Call 2 → Output Guardrail → Response
   │            │               │            │            │              │              │
   └────────────┴───────────────┴────────────┴────────────┴──────────────┴──────────────┘
                                    Full Trace Span
```

### Tools
| Category | Tools |
|----------|-------|
| **LLM Observability** | LangSmith, LangFuse, Arize Phoenix, Helicone |
| **Cost Tracking** | OpenMeter, Helicone |
| **General APM** | Datadog, New Relic (with LLM integrations) |
| **Dashboards** | Grafana, custom |

---

## Stage 7: Quality Control

**Purpose**: Detect and respond to quality issues.

```mermaid
C4Container
    title Quality Control Stage

    Container_Boundary(qc, "Quality Control") {
        Container(scoring, "Output Scoring", "Service", "Automated quality")
        Container(hallucination, "Hallucination Detection", "Service", "Fact verification")
        Container(safety, "Safety Monitor", "Service", "Policy violations")
        Container(feedback, "Feedback Collection", "Service", "User ratings")
        Container(drift, "Drift Detection", "Analytics", "Quality over time")
    }

    ContainerDb(qualitydb, "Quality DB", "Database", "Historical scores")
    Person(reviewers, "Human Reviewers", "Expert annotators")

    Rel(scoring, qualitydb, "Records")
    Rel(hallucination, qualitydb, "Records")
    Rel(reviewers, feedback, "Provides")
    Rel(qualitydb, drift, "Analyzes")
```

### Quality Signals

| Signal | Description | Response |
|--------|-------------|----------|
| **Low Quality Score** | Output below threshold | Alert, investigate |
| **Hallucination** | Factually incorrect | Flag, potentially block |
| **Safety Violation** | Policy breach | Block, alert |
| **User Thumbs Down** | Negative feedback | Log, analyze patterns |
| **Quality Drift** | Score degradation over time | Trigger iteration |

### Key Activities
- Real-time output quality scoring
- Hallucination detection and grounding
- Safety violation monitoring
- User feedback collection
- Quality drift detection
- Human review of flagged outputs

### Tools
| Category | Tools |
|----------|-------|
| **Quality Scoring** | Braintrust, RAGAS, custom LLM-as-judge |
| **Hallucination** | Vectara, Chainpoll, grounding checks |
| **Safety** | Guardrails AI, Azure Content Safety, Perspective |
| **Feedback** | Custom UI, Retool |

---

## Stage 8: Iteration

**Purpose**: Continuously improve from feedback and failures.

```mermaid
C4Container
    title Iteration Stage

    Container_Boundary(iter, "Iteration") {
        Container(analysis, "Trace Analysis", "Tool", "Failure patterns")
        Container(promptopt, "Prompt Optimization", "Process", "Refine templates")
        Container(dataset, "Dataset Curation", "Process", "Training data")
        Container(finetune, "Fine-tuning", "Pipeline", "Custom models")
        Container(rlhf, "RLHF/DPO", "Pipeline", "Preference learning")
    }

    System_Ext(mlplatform, "ML Platform", "Training infra")

    Rel(analysis, promptopt, "Informs")
    Rel(analysis, dataset, "Creates")
    Rel(promptopt, finetune, "If insufficient")
    Rel(dataset, finetune, "Trains")
    Rel(dataset, rlhf, "Trains")
    Rel(finetune, mlplatform, "Runs on")
    Rel(rlhf, mlplatform, "Runs on")
```

### Improvement Hierarchy

```
1. Prompt Optimization (fast, cheap)
         ↓ if insufficient
2. Few-shot Examples (medium)
         ↓ if insufficient
3. RAG/Retrieval Improvements (medium)
         ↓ if insufficient
4. Fine-tuning (slow, expensive)
         ↓ if insufficient
5. RLHF/DPO (slowest, most expensive)
```

### Key Activities
- Analyze failure patterns from traces
- Optimize prompts based on failures
- Curate datasets from production data
- Fine-tune models if needed
- Implement RLHF from human feedback
- Evaluate new model versions

### Tools
| Category | Tools |
|----------|-------|
| **Prompt Optimization** | DSPy, TextGrad, OPRO |
| **Fine-tuning** | OpenAI fine-tuning, Together AI, Fireworks |
| **RLHF/DPO** | Hugging Face TRL, OpenRLHF |
| **Dataset Management** | Argilla, Label Studio, Lilac |
| **Experiment Tracking** | Weights & Biases, MLflow |

---

## Summary: AI Agent SDLC Characteristics

| Characteristic | Description |
|----------------|-------------|
| **Probabilistic** | Same input can produce different outputs |
| **Fuzzy Testing** | Quality scores instead of pass/fail |
| **Triple Versioning** | Code + Prompts + Model references |
| **Trace Debugging** | Full reasoning chain visibility |
| **Token Economics** | Per-token cost optimization |
| **Safety + Alignment** | Beyond security to ethical behavior |
| **Continuous Learning** | Human feedback drives improvement |

---

**Next**: [Side-by-Side Comparison →](03-comparison.md)
