# GCP BigQuery
- Even though BigQuery is part of GCP, we will go over some basics here.


---
# Overview
- Purpose: **serverless**, fully managed **data warehouse** for analytics and business intelligence.
  - no limit on how much data you can dump in here (hence serverless)
  - data warehouse

- **Key features:**
  - Petabytes of data without issue.
  - ANSI SQL and GCP services integration (ELT + ETL pipelines)
  - Scalable
  - Real-time data analytics capabilities
  - Pricing (pay as you go -- based on num of queries and storage used)
 
- **Use Cases:**
  - Business intelligence + reporting
  - Data lake analysis
  - Marketing analytics, customer insights
  - Multiple companies use BigQuery
 
---
# Architecture of BigQuery
- Separate storage vs. Compute cluster! 
  - Data stored separate
  - Query --> fetches via memory shuffle to distributed storage

## Columnar Storage
- BigQuery uses COLUMNAR storage rather than row storage. [See these docs](https://cloud.google.com/blog/topics/developers-practitioners/bigquery-explained-storage-overview)
- COLUMNAR storage is similar to what is used in Databricks delta tables, and in Snowflake.

- Traditional storage is row by row which is not efficient
- Columnar storage is column by column --> scans column by column which is more efficient than row by row.


---
# BigQuery Partitioning
- Divides a large table into **smaller more manageable table based on a column**.
- This helps improve query performance and reduce costs.

## Types of Partitions
1. **Time-based:** uses DATE, TIMESTAMP, or DATETIME columns
2. **Integer Range:** divides data based on integer column range
3. **Ingestion-time:** Automatically partitions data based on arrival time

## Why Partition?
- FASTER queries -- will only scan relevant partitions
- LOWER costs -- reduces data processed per query
- EFFICIENT DATA MANAGEMENT -- simplifies handling of larger datasets
- **KEY concept: Always make sure to filter by partition column to optimize BIG QUERY performance**

---
# BigQuery Clustering
- Organizes your data **within partitions based on specific columns** thus improving query performance and reducing costs.
- Hence the term cluster --> groups or clusters columns together

## How does clustering work?
- Data is **automatically sorted** within each partition based on the clustered columns.
- Queries that **filter, groupby, or aggregate** clustered columns run faster since BigQuery scans fewer blocks.

## What is the best use case for BigQuery Clustering?
- Best used when queries frequently use: **filter, group, or order by** certain columns.

## Benefits of BigQuery Clustering?
- FASTER Queries -- only scans relevant data blocks
- LOWER costs -- reduces amount of data to read
- BETTER performance -- optimized for repeated query patterns
- BEST PRACTICE --> combine BOTH PARTITIONS + CLUSTERING for max efficiency

