# Databricks_DataScience_ML_NLP_GenAI
A repo devoted to all things for data science, ML, NLP and Gen AI on databricks




## Databricks Infrastructure & Platform
* Diagram below outlines the architecture of Databricks (image source: Databricks)
* There are 3 basic components:
1. User Plane
2. Control Plane
3. Data Plane

![Screenshot (2)](https://github.com/user-attachments/assets/80eb91a5-32a8-4f09-b7a0-ef89a3982576)


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
* Image below from Databricks.

![Screenshot (4)](https://github.com/user-attachments/assets/6ae536a4-a325-45f8-8aed-622bedb2dc21)

