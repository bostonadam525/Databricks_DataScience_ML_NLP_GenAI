# MLflow for AI Agent Observability


---
# When to use Custom LLM Judges/Scorers?
- Lets start by comparing Built-in LLM judges/scorers vs. Custom Judges/Scorers

## Built-in Judges + Scorers
- Most of the time these work out of the box for most use cases that don't need customization.
- See docs: https://mlflow.org/docs/latest/genai/eval-monitor/scorers/llm-judge/predefined/#available-judges
- Most common use cases:

1. Agents
   - Tool calling efficiency
   - Tool calling correctness 

2. RAG
   - Context Retrieval Relevance, precision, recall

3. Grounded/Answer Relevance
   - Is the final answer grounded by what the model retrieved?

## Custom LLM Judges/Scorers
- However, custom LLM judges/scorers are MOST useful when you have domain + business specific criteria, data and uses cases.
  - You may have very specific natural language defined evaluation structure and priorities which is why you would go with a custom judge. 
- See docs: https://mlflow.org/docs/latest/genai/eval-monitor/scorers/llm-judge/custom-judges/
- There are also **Guideline Judges** see here: https://mlflow.org/docs/latest/genai/eval-monitor/scorers/llm-judge/guidelines/ 

1. Custom Rubrics + Templates
   - You can use a custom scoring rubric or template that aligns with your use case more easily using this approach.

2. Natural language
   - If you have specific natural language rules you need to use, you can create a custom function and build into a custom judge.

3. Custom code
   - Again, if you have custom code you need to use you can build it into a custom function and use it here. 
