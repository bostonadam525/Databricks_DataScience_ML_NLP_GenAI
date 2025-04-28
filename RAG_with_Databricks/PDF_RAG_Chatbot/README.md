# PDF RAG Chatbot 
* This is an example of how to build a chatbot with PDF files on Databricks.
* This was adopted with some changes from a Databricks webinar streamed on the Databricks YouTube channel in June 2024.


## Architecture
* The architeture of this application is seen below, source: [Databricks](https://www.youtube.com/watch?v=p4qpIgj5Zjg)

![Screenshot (8)](https://github.com/user-attachments/assets/c31e72c1-3f88-4210-958a-fc3e12558f90)



* Here are the basic steps:

1. **Data ingestion**
   * The PDF files are being placed in a Unity Catalog volume.
   * The Unity Catalog (UC) volume is a way to manage and govern non-tabular data, such as images, audio, or PDF files, within the Unity Catalog.
   * [Unity Catalog Volumes](https://docs.databricks.com/aws/en/volumes)
   * Steps to recreate:
     a. Need to create a new schema within the **Catalog** space. You can name it anything you want. Let's say I named it **"LLM_RAG_demos".**
     b. Next, you want to create another specific schema within this a **volume**. You can name it anything you want, let's say I named it "pdf_rag_dbrx".
     c. Upload PDF file(s) to unity catalog volume.
     d. Run notebook 1 --> this will create 2 blank tables in the unity catalog. 
  

2. **Extract --> Chunk --> Load**
   * Data extraction
     * This is done using `PdfPlumber` library.
   * Text splitting/chunking
   * Data storage in delta table

3. **Vector Store Index**
   * There are multiple parts to this including:
     * a. Using an open source embedding model from the Databricks catalog.
     * b. Create a Vector Search endpoint.
    
4. **Retriever**
   * RAG retriever created using LangChain API, Prompt Template.

5. **LLM endpoint**
   * LLM used for inference will be the `Databricks-dbrx-instruct` endpoint.
  
6. **Register to Unity Catalog**

7. **Model Serving Endpoint**
   * Create this endpoint for real-time inference.
  
8. **Operationalization**
   * How to keep vector store/index updated and avoid model drift and outdated information in the RAG pipeline. 
