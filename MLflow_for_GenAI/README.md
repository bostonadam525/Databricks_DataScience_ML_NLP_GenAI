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
---
# Custom tracking for Complex Workflows
- Above we mentioned how you can use `mlflow.autolog()` out of the box for tracking. However, in real-world models and Gen AI applications such as RAG and Agents, you will want to implement custom tracing.[
- See mlflow manual tracing docs: https://mlflow.org/docs/latest/genai/tracing/app-instrumentation/manual-tracing/

## Overview of Manual Tracing
- When do we use manual tracing vs. autologging?
- How to use `@mlflow.trace` decorator with arguments
- Create custom spans with proper types
- Add custom attributes to spans
- Trace agentic workflows with tool usage
- Trace RAG pipelines end-to-end
- Advanced debugging techniques
- How to leverage claude code assistant for quick on the fly debugging

## Autologging is great for:
- LLM API calls (OpenAI, Anthropic, Gemini, etc.)
- Integrated framework chains (LangChain, LlamaIndex, LangGraph, etc.)
- Quick prototyping and POCs 
- Standard workflows

## Manual tracing is needed for:
- Custom functions in your pipeline
- Domain-specific operations (parsing, validation, business logic, etc...)
- Custom retrievers or custom data sources
- External API calls that aren't auto-instrumented
- Adding additional context not captured automatically
- Organizing operations into logical groups

### Best practice: combine both!
- Enable `autolog` early in the code
- Enable a custom trace
```
# Use autologging for LLM calls
mlflow.openai.autolog()

# Add manual tracing for custom logic
@mlflow.trace(name="custom_code", span_type=SPAN_TYPE)
def my_custom_function(query):
    # Your custom code
    pass
```
---
Manual Tracing with Span Types

The `@mlflow.trace` decorator turns any function into a traced span. You control the **name** and **type** of each span, which makes traces searchable and visually organized in the MLflow UI.

### Standard Span Types to use for Manual Tracing

| Type | Use for |
|------|---------|
| `CHAIN` | A sequence of operations (parent wrapper) |
| `LLM` | Language model call |
| `CHAT_MODEL` | A query to a chat model — a special case of an LLM interaction |
| `RERANKER` | A re-ranking operation, ordering retrieved contexts by relevance |
| `MEMORY` | A memory operation, such as persisting context in a long-term memory DB |
| `RETRIEVER` | Document retrieval |
| `EMBEDDING` | Text embedding |
| `TOOL` | Tool/function execution -- custom or external API/database |
| `AGENT` | Agent reasoning / planning |
| `PARSER` | Output parsing or business logic -- can also be used to mask PII data |

### Code to implement
- We can see there are 2 arguments to use for this:
1. name
2. `span_type` from list above

```python
# Always provide name and span_type
@mlflow.trace(name="my_retriever", span_type="RETRIEVER")
def my_function(x): ...
```

## When to Add Custom Attributes
- You would usually add attributes for:
   - Configuration (top_k, model_name)
   - Performance metrics (num_results, cache_hit)
   - Data characteristics (query_length, doc_size)
   - Business logic (user_tier, feature_flags)
   - Debugging info (data_source, version)
- These all make traces searchable and analyzable.


## Agent Tracing Benefits
- For agentic workflows, custom tracing reveals:

   - Insight into Decision making: which tool was chosen, and why
   - Tool performance: how long each tool takes
   - Error tracking: which tool failed, why and how
   - Cost analysis: how many LLM calls per agent run
   - Optimization: whether any steps can be skipped
- This is what makes complex agents debuggable.


## Why Hierarchical RAG Tracing Matters
- Within a single RAG trace you can immediately examine every span and answer:

   - Which step is slowest? (compare span durations in the timeline)
   - What did the query parser extract? (inspect parse_query inputs/outputs)
   - Which documents were retrieved? (check vector_search output)
   - How many tokens did the answer cost? (tokens_used attribute on generate_answer)
   - Where did it fail? (the failed span is highlighted, and all attributes logged before the error are preserved)

 ---
 # Performance Analysis
 In the MLflow UI, you can:

1. Timeline View
   - See which operations take the most time
   - Identify serial vs parallel operations
   - Find bottlenecks visually

2. Aggregate Metrics
   - Average latency per span type
   - P50, P95, P99 latencies
   - Success rate per operation

3. Comparison
   - Compare traces before/after optimization
   - A/B test different implementations
   - Track performance over time

4. Optimization Strategies
- If retrieval is slow:

   - Check embedding generation time
   - Optimize vector search
   - Optimize prompt with GEPA
- If LLM calls are slow:

   - Reduce max_tokens
   - Use streaming responses
   - Try smaller models to reduce latency or curb costs

- If overall latency is high:

   - Parallelize independent operations
   - Cache frequent queries
   - Optimize prompt length

5. Metrics to Track
   - End-to-end latency
   - Per-operation latency
   - Token usage and cost
   - Error rate
---
# Prompt Registry
- This is a VERY important part of MLflow for Gen AI use cases.
- These are things that you can do with Prompt Registy:

1. Why the Prompt Registry solves prompt management problems

2. Registering prompts with `mlflow.genai.register_prompt()`

3. Using Jinja2 {{ variable }} templates

4. Versioning prompts with commit messages

5. Using the Registry as a shared team library

6. Aliases (@production, @staging) for safe deployments

7. Searching prompts across your organization

## Why should you manage and register prompts?

### The Problem -- Without proper PROMPT management:

- **Scattered prompts in code:**
  - This is especially common with multiple agents!
  - This is also common with multiple versions of RAG applications and other models.
  - **Being able to have registered version control in the same place that you would do testing, tracing, and observability is paramount to understanding your application end-to-end.**

```
prompt_assistant = "You are a helpful assistant. Answer: {question}"
prompt_repond = "You are helpful. Respond to: {question}"  # Which one works better?
prompt_qa = "Answer {question}"  # Lost track of what works
```
- **Problems with hardcoded, scattered prompts:**

```
❌ Prompts hardcoded in multiple places
❌ No version history
❌ Hard to A/B test different versions
❌ Difficult to collaborate
❌ Can't track which prompt generated which output
```

---
### The Solution: MLflow Prompt Registry -- Centralized, versioned prompts in the Prompt Registry
- With this code block you can do this simply:

```
prompt = mlflow.genai.register_prompt(
    name="my-qa-prompt",
    template="You are a helpful assistant. Answer: {{ question }}",
    commit_message="Initial version"
)
```

- This allows you to do the following:
```
# ✅ Version prompts automatically
# ✅ Load by name, version, or alias
# ✅ Share with team
# ✅ Search across your organization
```
### Benefits of Prompt Registry:
1. **Reproducibility: Know exactly which prompt was used**
2. **Collaboration: Share prompts across team**
3. **Experimentation: Systematic A/B testing**
4. **Version Control: Track prompt evolution with commit messages**
5. **Data Governance: Audit and approval processes via aliases**
