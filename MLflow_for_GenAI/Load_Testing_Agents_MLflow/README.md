# Load Testing Agents with MLflow
- This is very often an overlooked topic with Agentic design and implementation.
- Load testing AI agent approaches requires shifting from traditional request-response metrics to systemic, multi-step lifecycle profiling.
- Because AI agents don't just call a single API endpoint—they query vector databases, call multiple external tools, leverage orchestration frameworks, and maintain memory layers—any single part of the system can introduce a compounding bottleneck
- Modern approaches to load testing AI agents fall into two major paradigms:
  - **Testing the AI Agent (The Subject)** and
  - **Testing with AI Agents (The Tool)**

---
## 1. Challenges

### Standard Software Load Testing
- In Software, we generally test a singular point of contact we are load testing. This might be a 3rd party API or Database call.
- Metrics commonly testing in standard software load testing:
  - **TPS (Transactions Per Second)**
  - **SLA (Latency)**

### LLM Load testing
- This evolves because with LLMs we are measuring tokens.
- Metrics evolved:
  - **Tokens**
  - **Time to first token**
  - **Token Throughput per second**
 
### Agents load testing
- This evolves to have more complicated infrastructure than above.
- Agents are more of a **System** problem than a model problem due to architectural infrastructure. 
- With agents we have to measure more things such as:
  - Tool calls
  - RAG (e.g. knowledge bases, databases)
  - **Key point: Lots of points of contact that can be a bottleneck or rate limiting issue in your system!!**
---
# Locust
- Locust is a Python oss tool for load testing: https://github.com/locustio/locust
- Allows you to:
  - Plug in `@task` decorator
  - API call(s) you need to test or invoke
  - Test agent served via MLflow --> `stream`

 # MLflow
 - Captures:
   - Tracing (async)
   - Spans --> latency and tokens of each step in the agentic loop
  
  # Combined Tracking: Locust + MLflow
  - Locust will give: TPS (transactions per second), end to end latency
  - MLflow derived: tool call latency, tokens per span, time to first token, total tokens, etc..
  - Holistic metric evaluation

---
# Resources
- [Benchmarking + Load Testing Agents](https://github.com/RamVegiraju/benchmark-agents)
- [How to Load Test AI Agents Before Going to Production](https://www.agentcenter.cloud/blogs/how-to-load-test-ai-agents)
- 
