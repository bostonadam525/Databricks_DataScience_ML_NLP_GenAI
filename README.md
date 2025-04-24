# Databricks_DataScience_ML_NLP_GenAI
A repo devoted to all things for data science, ML, NLP and Gen AI on databricks



---
## Databricks Infrastructure & Platform
* Diagram below outlines the architecture of Databricks (image source: Databricks)
* There are 3 basic components:
1. User Plane
2. Control Plane
3. Data Plane

![Screenshot (2)](https://github.com/user-attachments/assets/80eb91a5-32a8-4f09-b7a0-ef89a3982576)

---
## Databricks Compute
### Runtimes
* Two types are:
1. Standard
   * Apache Spark and other components optimized for big data.

2. Machine Learning
   * ML libraries such as: TensorFlow, Keras, PyTorch, XGBoost, etc.

### SQL Warehouses
* These are designed to optimize SQL BI workloads.

### Serverless
* This is also available in Databricks
* Allows for:
1. Higher user productivity
   * Queries begin instantly witout waiting for cluster to start.
   * Concurrent users allowed with instant scaling. 
2. Zero management
   * No configuration needed
   * No performance tuning
   * No capacity management needed
   * Automatic patching and upgrades
3. Lower cost
   * Only pay for what you consume --> prevents idle cluster time adding charges.
   * Resources are not overused.
   * After 10 minutes idle capacity is removed after the last query.
  
---
## Databricks Data Intelligence Platform
* Built upon the Lakehouse paradigm (data lake + data warehouse).
* The architecture of the full platform (source: Databricks) as seen below. 

![Screenshot (3)](https://github.com/user-attachments/assets/d3a345bd-bfdd-4666-9085-f77e2bf13e0c)


### Data storage and governance
1. Cloud Storage
   * All 3 major clouds (e.g. AWS, Azure, GCP) are supported by:
     a. Delta Lake
     b. Unity Catalog

2. Delta Sharing
   * Marketplace
   * Clean Rooms
  

### Unity Catalog
* Unifies data and AI governance across the platform.
* Allows data sharing between:
  1. Data Storage and Engineering
  2. Data Analytics
  3. AI and Machine Learning
* Image below from Databricks.

![Screenshot (4)](https://github.com/user-attachments/assets/6ae536a4-a325-45f8-8aed-622bedb2dc21)

### Data Intelligence
* Databricks IQ is the main intelligence engine.

---
## Data Science, Machine Learning, and Generative AI
* Mosaic AI joined DB and now offers a full suite of end-to-end dev tools including:
1. MLFlow
2. AutoML
3. Feature Store
4. Model Serving
5. Vector Search
6. AI Playground
7. Agent Framework
8. Model Training
9. ...the list goes on...!!!

---
## Data Orchestration and ETL
1. **Databricks Workflows**
   * Control flow --> you can orchestrate anything including DLT pipelines.
   * Monitoring and Observability capabilities
2. **Delta Live Tables**
   * Data Flow --> Automated data pipelines for Delta Lakes.
   * Data transformations using SQL or Python.
   * DLT has built-in quality control and error handling.
  
---
## Data Warehousing and BI
* There are 3 main components of this:
1. Databricks SQL
   * Data warehousing and analytics.
   * ANSI SQL is still used but with underlying optimizations. 
2. AI/BI Dashboards
   * All-in-one data visualization and presentation.
3. AI/BI Genie
   * Natural language queries of data.

---
## Databricks Workspace
* Centralized workspace for all data science, data engineering, machine learning and AI workflows.



---
# Unity Catalog
1. **Metastore**
   * **Metadata storage container or layer**
   * This is a main container for storing data and AI assets organized as a hierarchy with these objects being contained in the Metastore. 
     * External storage access
     * **Catalog** -- Metastore can have 1 or more catalog containers.
       * Each catalog can contain 1 more Schemas.
       * Schemas can contain other objects such as:
         * Tables
         * Views
         * Volumes
         * Functions
         * Models
     * Query Federation
     * Delta sharing
* Diagram of a Metastore from Databricks:

![Screenshot (5)](https://github.com/user-attachments/assets/3d7c4bf8-1169-4360-9790-0cfd6784e00f)


2. Metastore assignment
   * Multiple metastores can be assigned to multiple workspaces in the Databricks environment.
   * This gives the architectural breakdown of catalog --> schema --> table access based on a Metastore (source: Databricks)

![Screenshot (6)](https://github.com/user-attachments/assets/4cc28616-595f-4058-89c0-8e6b6f22c2f3)

