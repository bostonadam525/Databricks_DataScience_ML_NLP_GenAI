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
