# Data Modeling

## 1. Overview
### Objective
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

### 3.2 Bronze Layer

#### Objective

Persist data exactly as it is received from the Staging layer, preserving the original structure and content of the source data.

#### Characteristics

* Data stored in Delta Lake format.
* Schema closely aligned with the source systems.
* Minimal or no business transformations applied.
* Inclusion of technical and audit-related columns.

#### Applied Transformations

* Conversion of source files into Delta format.
* Addition of metadata fields, including:

  * `_source_file`
  * `_ingestion_date`
  * `created_at`
  * `updated_at`

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

## 4. Data Modeling Decisions

### Gold Layer Modeling Strategy

The Gold layer was designed using a dimensional modeling approach (Star Schema) to optimize analytical workloads and reporting performance.

The central fact table, `flights`, contains operational flight events and references multiple dimensions:

* Airports
* Airlines
* Route Types
* Authorization Types

This design provides a balance between query performance, usability, and maintainability.

---

## Advantages

### 1. Improved Query Performance

Dimension tables reduce data redundancy and enable efficient joins during analytical queries.

Benefits include:

* Faster aggregations.
* Reduced storage consumption.
* Better performance for BI tools.

---

### 2. Simplified Business Analytics

Business users can easily understand the model because it follows a standard dimensional design.

Examples:

* Analyze delays by airline.
* Analyze flight volume by airport.
* Analyze operational performance by route type.
* Track authorization status trends.

---

### 3. Better Data Governance

Reference data such as airlines, airports, route types, and authorization types are managed independently from operational flight records.

Benefits:

* Easier maintenance.
* Consistent business definitions.
* Reduced risk of duplicated information.

---

### 4. Scalability

New dimensions can be introduced without impacting existing analytical workloads.

Examples:

* Aircraft Dimension
* Weather Dimension
* Calendar Dimension
* Region Dimension

---

## Trade-offs and Limitations

### 1. Additional Joins Required

Analytical queries require joins between the fact table and dimensions.

Example:

```sql
SELECT
    a.name,
    COUNT(*)
FROM gold.flights f
JOIN gold.airlines a
    ON f.airline_id = a.airline_id
GROUP BY a.name;
```

While Databricks handles these joins efficiently, query complexity increases compared to a fully denormalized model.

---

### 2. ETL Complexity

The Gold layer requires surrogate key resolution and data enrichment from the Silver layer.

Examples:

* Mapping airline ICAO codes to airline IDs.
* Mapping airport ICAO codes to airport IDs.
* Mapping route codes to route type dimensions.

This increases transformation complexity but improves data consistency.

---

### 3. Historical Tracking Not Implemented

The current model stores only the latest version of dimension records.

For example:

* Airline status changes overwrite previous values.
* Airport metadata changes are not historically preserved.

If historical analysis becomes necessary, Slowly Changing Dimensions (SCD Type 2) should be implemented.

---

## Design Rationale

The chosen model prioritizes:

1. Analytical performance.
2. Data consistency.
3. Ease of use for reporting tools.
4. Future scalability.