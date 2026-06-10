# Data Modeling

## 1. Overview
###Objective
This project aims to process, transform, and make data available for analytics and consumption by analytical applications through a Lakehouse architecture implemented on Databricks.

The architecture follows a medallion structure approach:
- S3 (Staging)
- Bronze
- Silver
- Gold

Each layer has specific responsibilities to ensure data governance, quality, and traceability throughout the data lifecycle.

## 2 - Architecture
![Architecture Image](assets/architecture.png)

## 3. Project Layers
### 3.1 Staging (Amazon S3)
#### Objective
This layer is responsible for the initial storage of files received from data sources.

#### Characteristics
* Data is stored in its raw format.
* No business transformations are applied.
* Serves as the entry point for incoming data.
* Maintains a historical record of all received files.

#### Responsibilities
* Receive data from source systems.
* Ensure data traceability.
* Serve as a recovery layer in case of processing failures.

### 3.3 Silver Layer
#### Objective

Provide clean, standardized, and business-ready data prepared for analytical modeling and downstream consumption.

#### Characteristics

* Cleansed and transformed data.
* Application of data quality rules.
* Standardized and normalized data structures.

![Silver Image](assets/silver.png)

#### Applied Transformations
##### Data Cleansing

* Removal of invalid records.
* Null value handling.
* Standardization of data formats.

##### Data Quality
* Data type validation.
* Deduplication of records.
* Enforcement of business rules.

### 3.4 Gold Layer
#### Objective

Provide data models optimized for business analytics, reporting, and key performance indicators (KPIs).

#### Characteristics
Consumption-oriented data structures.
Aggregated tables.
Business metrics and KPIs.
Data Modeling

The Gold layer leverages dimensional modeling to optimize analytical queries and support efficient reporting and business intelligence workloads.

![Gold Image](assets/gold.png)