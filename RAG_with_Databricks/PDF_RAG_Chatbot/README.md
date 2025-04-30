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
       1. Need to create a new schema within the **Catalog** space. You can name it anything you want. Let's say I named it **"LLM_RAG_demos".**
       2. Next, you want to create another specific schema within this a **volume**. You can name it anything you want, let's say I named it "pdf_rag_dbrx".
       3. Upload PDF file(s) to unity catalog volume.
       4. Run notebook 1 --> this will create 2 blank tables in the unity catalog. 
  

2. **Extract --> Chunk --> Load**
   * Data extraction
     * This is done using `PdfPlumber` library.
   * Text splitting/chunking
   * Data storage in delta table
   * To do this run notebook 2a.
  
2b. **Alternative Approach -- Scrape Data from website**
   * Let's say you don't have a PDF file and you want to scrape data from a website.
   * There are numerous approaches to doing this (obviously), but one approach is to use [APIFY](https://apify.com/apify/web-scraper).
   * After scraping the website you can export the data into a CSV file and then upload that into a delta table and use the same process as step 2 where you `extract --> chunk --> load` the chunks and re-insert them into the delta table.
   * To do this run notebook 2b. 

3. **Vector Store Index and Endpoint**
   * There are multiple parts to this which we will list below.
   * The best way to do this is to first create the vector endpoint --> then create the vector embeddings & index
       * Using an open source embedding model from the Databricks catalog.
       * Create a **Vector Search endpoint.**
       * Steps to create a **Vector Store endpoint:**
         * 1. Go to `compute`.
         * 2. Go to `vector search`.
           3. Create endpoint --> name the endpoint --> click create
           4. Verify the endpoint was created in the user interface on databricks.
     * d. Create Vector Embedding Index using Databricks embedding model(s).
         * Steps to create this:
           * 1. Go back to catalog.
             2. Go to `docs_text` table.
             3. Go to "Create" button on upper right corner.
             4. Click "Create Vector Search Index".
             5. Follow steps on GUI to create the Vector Search Index:
                * Name
                * Primary Key (id)
                * Vector Endpoint (what we just created)
                * Compute Embeddings (or use existing embeddings if you pre-created them)
                * Embedding Source Column (e.g. Text)
                * Embedding model of choice: `databricks-gte-large-en`
                * Sync mode --> `Triggered` vs. `Continuous` (Choose triggered depending on your needs)
             6. Create the Vector index/embeddings
        * e. You can then run a test query on the Vector endpoint using the embeddings once it is created.
           1. This will give you a demo of the most similar documents or text chunks that will be retrived based on your similarity metric.
           2. This is NOT the same as what the final chatbot looks like but it is looking "under the hood" of RAG based retrieval using your embeddings. 
                
    
4. **Retriever**
   * RAG retriever created using LangChain API, Prompt Template.

5. **LLM endpoint**
   * LLM used for inference will be the `Databricks-dbrx-instruct` endpoint.
  
6. **Register to Unity Catalog**

7. **Model Serving Endpoint**
   * Create this endpoint for real-time inference.
  
8. **Operationalization**
   * How to keep vector store/index updated and avoid model drift and outdated information in the RAG pipeline. 
