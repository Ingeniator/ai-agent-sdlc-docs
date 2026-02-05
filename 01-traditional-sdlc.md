# Traditional Software Development Life Cycle

> The established framework for building software systems, refined over decades.

## Overview

```mermaid
C4Context
    title Traditional SDLC - Context Diagram

    Person(stakeholder, "Stakeholders", "Product owners, users")
    Person(team, "Dev Team", "Engineers, QA, DevOps")

    Enterprise_Boundary(sdlc, "Traditional SDLC") {
        System(req, "Requirements", "Gather and document needs")
        System(design, "Design", "Architecture and specifications")
        System(dev, "Development", "Write and review code")
        System(test, "Testing", "Verify functionality")
        System(deploy, "Deployment", "Release to production")
        System(maint, "Maintenance", "Bug fixes and updates")
    }

    Rel(stakeholder, req, "Provides needs")
    Rel(team, design, "Creates")
    Rel(team, dev, "Implements")
    Rel(team, test, "Validates")
    Rel(team, deploy, "Releases")
    Rel(stakeholder, maint, "Reports issues")

    Rel(req, design, "")
    Rel(design, dev, "")
    Rel(dev, test, "")
    Rel(test, deploy, "")
    Rel(deploy, maint, "")
    Rel(maint, req, "Feedback loop")
```

## Stage 1: Requirements

**Purpose**: Understand what to build and why.

```mermaid
C4Container
    title Requirements Stage

    Container_Boundary(req, "Requirements") {
        Container(stories, "User Stories", "Document", "As a user, I want...")
        Container(specs, "Functional Specs", "Document", "System shall...")
        Container(nfr, "Non-Functional Reqs", "Document", "Performance, security")
        Container(acceptance, "Acceptance Criteria", "Checklist", "Definition of done")
    }

    Person(po, "Product Owner", "Defines priorities")
    Person(users, "Users", "Provide feedback")

    Rel(users, stories, "Informs")
    Rel(po, stories, "Writes")
    Rel(stories, specs, "Detailed in")
    Rel(specs, nfr, "Complemented by")
    Rel(specs, acceptance, "Validated against")
```

### Key Activities
- Stakeholder interviews
- User research
- Competitive analysis
- Requirements documentation
- Prioritization (MoSCoW, RICE)

### Artifacts
- Product Requirements Document (PRD)
- User stories with acceptance criteria
- Use case diagrams
- Non-functional requirements

### Tools
| Category | Tools |
|----------|-------|
| **Project Management** | Jira, Linear, Asana, Azure DevOps |
| **Documentation** | Confluence, Notion, Google Docs |
| **Diagramming** | Miro, FigJam, Lucidchart |
| **Research** | UserTesting, Hotjar, Mixpanel |

---

## Stage 2: Design

**Purpose**: Define how the system will be built.

```mermaid
C4Container
    title Design Stage

    Container_Boundary(design, "Design") {
        Container(arch, "System Architecture", "Diagram", "Components, services, infra")
        Container(db, "Database Design", "ERD", "Tables, relationships, indexes")
        Container(api, "API Design", "OpenAPI", "Endpoints, contracts")
        Container(ui, "UI/UX Design", "Mockups", "Wireframes, prototypes")
        Container(security, "Security Design", "Document", "Auth, encryption, access")
    }

    Rel(arch, db, "Includes")
    Rel(arch, api, "Defines")
    Rel(api, ui, "Consumed by")
    Rel(arch, security, "Secured by")
```

### Key Activities
- Architecture decision records (ADRs)
- Database schema design
- API contract definition
- UI/UX prototyping
- Security threat modeling
- Technical spike/PoC

### Artifacts
- Architecture diagrams (C4, UML)
- Entity-Relationship Diagrams
- OpenAPI/Swagger specifications
- Wireframes and mockups
- Security design document

### Tools
| Category | Tools |
|----------|-------|
| **Architecture** | Draw.io, Lucidchart, PlantUML, Structurizr |
| **Database** | dbdiagram.io, MySQL Workbench, pgAdmin |
| **API Design** | Swagger/OpenAPI, Postman, Stoplight |
| **UI/UX** | Figma, Sketch, Adobe XD |
| **Security** | OWASP Threat Dragon, Microsoft TMT |

---

## Stage 3: Development

**Purpose**: Build the software according to design.

```mermaid
C4Container
    title Development Stage

    Container_Boundary(dev, "Development") {
        Container(code, "Application Code", "IDE", "Business logic implementation")
        Container(tests, "Unit Tests", "Framework", "Code-level verification")
        Container(review, "Code Review", "PR", "Peer review process")
        Container(docs, "Documentation", "Markdown", "Code docs, README")
    }

    System_Ext(vcs, "Version Control", "Git repository")
    System_Ext(ci, "CI Pipeline", "Build automation")
    System_Ext(registry, "Artifact Registry", "Package/container storage")

    Rel(code, vcs, "Committed to")
    Rel(code, tests, "Covered by")
    Rel(vcs, review, "Triggers")
    Rel(review, ci, "Triggers")
    Rel(ci, registry, "Publishes to")
```

### Key Activities
- Feature implementation
- Unit test writing
- Code review
- Documentation
- Dependency management
- Local testing

### Artifacts
- Source code
- Unit tests
- Code documentation
- Build configurations
- Container images

### Tools
| Category | Tools |
|----------|-------|
| **IDE** | VS Code, IntelliJ, WebStorm |
| **Version Control** | Git, GitHub, GitLab, Bitbucket |
| **Languages** | TypeScript, Python, Java, Go, Rust |
| **Frameworks** | React, Next.js, Django, Spring, Express |
| **Testing** | Jest, pytest, JUnit, Go testing |
| **Containers** | Docker, Podman |

---

## Stage 4: Testing

**Purpose**: Verify the software works correctly.

```mermaid
C4Container
    title Testing Stage

    Container_Boundary(test, "Testing") {
        Container(unit, "Unit Tests", "Automated", "Function/method level")
        Container(integration, "Integration Tests", "Automated", "Component interaction")
        Container(e2e, "E2E Tests", "Automated", "Full user flows")
        Container(perf, "Performance Tests", "Automated", "Load, stress testing")
        Container(security, "Security Tests", "Automated", "SAST, DAST, pen testing")
        Container(manual, "Manual QA", "Human", "Exploratory testing")
    }

    ContainerDb(results, "Test Results", "Database", "Pass/fail history")

    Rel(unit, results, "Reports to")
    Rel(integration, results, "Reports to")
    Rel(e2e, results, "Reports to")
    Rel(perf, results, "Reports to")
    Rel(security, results, "Reports to")
    Rel(manual, results, "Reports to")
```

### Key Activities
- Test planning
- Test case development
- Automated test execution
- Manual exploratory testing
- Performance benchmarking
- Security scanning
- Bug reporting and tracking

### Artifacts
- Test plans
- Test cases
- Test reports
- Bug reports
- Coverage reports

### Key Metrics
| Metric | Description |
|--------|-------------|
| **Code Coverage** | % of code executed by tests |
| **Pass Rate** | % of tests passing |
| **Defect Density** | Bugs per KLOC |
| **MTTR** | Mean time to resolve bugs |

### Tools
| Category | Tools |
|----------|-------|
| **Unit Testing** | Jest, pytest, JUnit, Go testing |
| **Integration** | Testcontainers, WireMock |
| **E2E** | Cypress, Playwright, Selenium |
| **Performance** | k6, JMeter, Gatling, Locust |
| **Security** | SonarQube, Snyk, OWASP ZAP, Burp Suite |
| **Bug Tracking** | Jira, Linear, GitHub Issues |

---

## Stage 5: Deployment

**Purpose**: Release software to production.

```mermaid
C4Container
    title Deployment Stage

    Container_Boundary(deploy, "Deployment") {
        Container(ci, "CI Pipeline", "Automation", "Build, test, package")
        Container(cd, "CD Pipeline", "Automation", "Deploy to environments")
        Container(staging, "Staging", "Environment", "Pre-production validation")
        Container(prod, "Production", "Environment", "Live system")
        Container(flags, "Feature Flags", "Service", "Gradual rollout control")
    }

    System_Ext(registry, "Artifact Registry", "Images, packages")
    System_Ext(infra, "Infrastructure", "Kubernetes, cloud")

    Rel(ci, registry, "Pushes to")
    Rel(cd, staging, "Deploys to")
    Rel(staging, prod, "Promotes to")
    Rel(flags, prod, "Controls features in")
    Rel(cd, infra, "Provisions")
```

### Key Activities
- Build automation
- Environment configuration
- Release management
- Deployment execution
- Smoke testing
- Rollback procedures

### Deployment Strategies
| Strategy | Description | Use Case |
|----------|-------------|----------|
| **Blue-Green** | Two identical environments | Zero-downtime |
| **Canary** | Gradual traffic shift | Risk mitigation |
| **Rolling** | Incremental instance update | Resource efficient |
| **Feature Flags** | Code deployed, feature toggled | Decouple deploy from release |

### Tools
| Category | Tools |
|----------|-------|
| **CI/CD** | GitHub Actions, GitLab CI, Jenkins, CircleCI |
| **Infrastructure** | Terraform, Pulumi, CloudFormation |
| **Orchestration** | Kubernetes, Docker Swarm, ECS |
| **Feature Flags** | LaunchDarkly, Statsig, Unleash |
| **Secrets** | Vault, AWS Secrets Manager |

---

## Stage 6: Maintenance

**Purpose**: Keep the system running and evolving.

```mermaid
C4Container
    title Maintenance Stage

    Container_Boundary(maint, "Maintenance") {
        Container(monitor, "Monitoring", "Service", "Health, metrics, alerts")
        Container(logs, "Logging", "Service", "Centralized log aggregation")
        Container(incidents, "Incident Management", "Process", "Detection, response")
        Container(bugs, "Bug Fixes", "Code", "Defect resolution")
        Container(updates, "Updates", "Code", "Dependencies, security patches")
    }

    Person(oncall, "On-call Engineer", "Responds to incidents")
    Person(users, "Users", "Report issues")

    Rel(monitor, incidents, "Triggers")
    Rel(users, bugs, "Reports")
    Rel(oncall, incidents, "Responds to")
    Rel(incidents, bugs, "Creates")
```

### Key Activities
- Production monitoring
- Incident response
- Bug fixing
- Security patching
- Dependency updates
- Performance optimization
- Technical debt reduction

### Key Metrics
| Metric | Description |
|--------|-------------|
| **Uptime** | System availability % |
| **MTTR** | Mean time to recovery |
| **MTTD** | Mean time to detect |
| **Error Rate** | Errors per request |
| **P99 Latency** | 99th percentile response time |

### Tools
| Category | Tools |
|----------|-------|
| **APM** | Datadog, New Relic, Dynatrace |
| **Logging** | ELK Stack, Splunk, Grafana Loki |
| **Metrics** | Prometheus, Grafana, CloudWatch |
| **Alerting** | PagerDuty, Opsgenie, VictorOps |
| **Incident** | Incident.io, FireHydrant, Rootly |

---

## SDLC Models

### Waterfall
```
Requirements → Design → Development → Testing → Deployment → Maintenance
```
- Sequential, phase-gate approach
- Good for: Well-defined, stable requirements
- Risk: Late feedback, costly changes

### Agile/Scrum
```
Sprint Planning → Development → Testing → Review → Retrospective
                        ↑__________________________|
```
- Iterative, incremental delivery
- Good for: Evolving requirements, fast feedback
- Risk: Scope creep, documentation gaps

### DevOps/CI-CD
```
Code → Build → Test → Release → Deploy → Operate → Monitor
  ↑______________________________________________|
```
- Continuous integration and delivery
- Good for: Rapid releases, automation
- Risk: Complexity, tooling overhead

---

## Summary: Traditional SDLC Characteristics

| Characteristic | Description |
|----------------|-------------|
| **Deterministic** | Same code produces same output |
| **Pass/Fail Testing** | Tests either pass or fail |
| **Code as Artifact** | Source code is the primary deliverable |
| **Stack Trace Debugging** | Errors have clear traces |
| **Infrastructure Costs** | Pay for compute/storage |
| **Security Focus** | Prevent unauthorized access |
| **Bug-Driven Feedback** | Users report issues |

---

**Next**: [AI Agent SDLC →](02-ai-agent-sdlc.md)
