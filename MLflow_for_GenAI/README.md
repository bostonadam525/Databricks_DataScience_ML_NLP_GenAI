# MLflow for GenAI Observability




---
# Why use MLflow for GenAI?
- Open source and vendor-neutral: no lock-in to a specific cloud provider or LLM vendor
- OpenTelemetry compatible: standard observability that fits your existing stack
- One platform: tracking, tracing, evaluation, continuous monitoring, and deployment in one place
- 30+ framework integrations: OpenAI, LangChain, LlamaIndex, DSPy, AutoGen, and more
- [source](https://github.com/dmatrix/mlflow-genai-tutorials/blob/main/01_setup_and_introduction.ipynb)


<img width="2500" height="1406" alt="image" src="https://github.com/user-attachments/assets/1fce5687-a868-488e-9367-06ca28d48dab" />


- Pillars of MLflow Observability Above

1. **Tracing**
   - Allows you to trace all inputs and outputs to your system and find bottlenecks and issues.

2. **Evaluation**
   - Human in the loop feedback
   - [LLM as a judge multiple configurations:](https://docs.databricks.com/aws/en/mlflow3/genai/eval-monitor/concepts/scorers)
     - Built in judges
     - Custom judges
     - Code-based scorers
     - 3rd party scorers
    

3. **Prompt Registry**
   - Track prompts + optimize them with version control.
   - Track agent parameters
   - See docs: https://docs.databricks.com/aws/en/mlflow3/genai/prompt-version-mgmt/prompt-registry/

4. **Gateway**
   - Allows you to control + audit LLM and agentic access to your system.
   - See docs: https://mlflow.org/docs/latest/genai/governance/ai-gateway/

---
# LLM Experiment Tracking
- MLflow can be used to track multiple LLM experiments at the same time. This includes but is not limited to:

1. LLM params and metrics
2. Model configurations comparison
3. Cost tracking/analysis
4. Organizing experiments in parallel
5. Parent-child runs
   - hierarchical runs

## Key techniques to use:
- `mlflow.openai.autolog()` is able to capture model parameters, tokens, latency, and input/output automatically
- `mlflow.log_*` explicit calls should still be used for things such as: tags, custom artifacts
- Comparing different LLM configurations
- Experiment organization techniques and practices

---
# Tracing
- See docs: https://mlflow.org/docs/latest/genai/concepts/trace/

## Important Distinction about Tracing:
- Could be 1 request
- Could be end to end workflow
- Most traces are composed of 1 or more "spans" and usually start with a root span. 

## Problem
- Traditional experiment tracking and logging isn't enough for LLM applications:
```
# Traditional logging - hard to debug
print("Calling LLM...")
response = llm.generate(prompt)
print(f"Response: {response}")
# What happened inside? How long did it take? What was sent or received?
```

## Solution: Use Distributed Tracing
- Tracing captures the complete execution flow of your application as we see below.
- There may be 3 separate spans or actions in a RAG application that we can trace each unit of operation. 

```
Trace: RAG Application
├── Span 1: Embed Query [0ms - 200ms]
│   Input: "What is MLflow for GenAI?"
│   Output: [0.123, 0.456, ...]
│   
├── Span 2: Retrieve Documents [200ms - 350ms]
│   Input: [0.123, 0.456, ...]
│   Output: ["MLflow is...", "The platform..."]
│   
└── Span 3: Generate Response [350ms - 1500ms]
    Input: {query, documents}
    Output: "MLflow is an open source ML and GenAI platform..."
    LLM: gpt-5-mini
    Tokens: 150
```

## Key Benefits
1. Visibility: see every step in your LLM workflow
2. Performance: identify bottlenecks and latency issues
3. Debugging: trace errors to their exact source
4. Cost: track token usage per operation
5. Quality: inspect inputs/outputs at each step


## Trace Data Model

### Trace: A complete execution of an operation
- Represents one request or workflow
- Contains one or more spans
- **Has a root span**

### Span: A single operation within a trace
- Has a start and end time
- Contains inputs and outputs
- Has metadata (model, tokens, latency, etc.)
- Can have parent-child relationships

## Span Attributes: Additional metadata
- Model name
- Token counts
- Temperature
- Custom attributes

### Span Types
- MLflow defines standard span types:

```
CHAIN: A sequence of operations
LLM: Language model call
RETRIEVER: Document retrieval
EMBEDDING: Text embedding
TOOL: Tool/function execution
AGENT: Agent reasoning
PARSER: Output parsing or generic intermediate parsing of a result
```

### Span Hierarchy Example 
- chained or sequential operations....

```
TRACE (root)
│
└─ SPAN: Agent Executor (AGENT)
   │
   ├─ SPAN: Planning Step (LLM)
   │  └─ attributes: {model: gpt-5, tokens: 50}
   │
   ├─ SPAN: Tool Execution (TOOL)
   │  └─ attributes: {tool: search, query: "..."}
   │
   └─ SPAN: Final Response (LLM)
      └─ attributes: {model: gpt-5, tokens: 150}

```
