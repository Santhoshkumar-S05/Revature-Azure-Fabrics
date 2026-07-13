# Real-Time Social Media Sentiment Analysis Pipeline

## Project Overview

This project is a cloud-based real-time data engineering solution designed to ingest, process, transform, and analyze social media data using the Medallion Architecture (Bronze, Silver, Gold).

The pipeline collects social media events in real time, processes them through Azure Event Hub and Databricks, performs sentiment analysis and trend analytics, stores curated data in Delta Lake tables, and visualizes insights using Power BI.

---

## Business Objective

Organizations need real-time insights from social media platforms to understand:

- Customer sentiment
- Trending topics
- User engagement patterns
- Influencer activity
- Business impact of social media discussions

This project provides an automated analytics platform that transforms raw social media streams into actionable business insights.

---

# Architecture

Producer Scripts
↓
Azure Event Hub
↓
Databricks Structured Streaming
↓
Bronze Layer (Raw Data)
↓
Silver Layer (Cleaned & Validated Data)
↓
Gold Layer (Business Aggregates)
↓
Power BI Dashboard

---

# Technology Stack

| Category | Technology |
|-----------|------------|
| Programming | Python |
| Streaming | Azure Event Hub |
| Processing | Apache Spark / PySpark |
| Data Platform | Azure Databricks |
| Storage | Delta Lake |
| Data Modeling | dbt |
| Orchestration | Apache Airflow |
| Testing | Pytest |
| Visualization | Power BI |
| Cloud | Microsoft Azure |
| Version Control | Git & GitHub |

---

# Dataset Components

The project processes the following social media datasets:

### Tweets
Contains social media posts.

### Sentiment
Contains sentiment scores and classifications.

### Trends
Contains trending hashtags and topics.

### User Metadata
Contains user profile information.

### Valid Tweets
Stores validated tweet records.

---

# Medallion Architecture

## Bronze Layer

### Purpose
Store raw incoming data exactly as received from Event Hub.

### Activities Performed

- Read data from Azure Event Hub
- Store raw JSON records
- Add ingestion timestamp
- Add source metadata
- Maintain original schema

### Output Tables

- bronze_tweets
- bronze_sentiment
- bronze_trends
- bronze_user_metadata
- bronze_valid_tweets

---

## Silver Layer

### Purpose
Clean and standardize data for analytics.

### Activities Performed

- Remove duplicates
- Handle null values
- Apply business validations
- Data type conversions
- Standardize schema
- Data quality checks

### Output Tables

- silver_tweets
- silver_sentiment
- silver_trends
- silver_user_metadata
- silver_valid_tweets

---

## Gold Layer

### Purpose
Create analytics-ready business datasets.

### Activities Performed

- Build star schema
- Create dimension tables
- Create fact tables
- Aggregate metrics
- Business KPI generation

### Dimension Tables

- dim_user
- dim_date
- dim_topic
- dim_sentiment

### Fact Table

- fact_socialmedia

### Aggregated Tables

- gold_sentiment_summary
- gold_trending_topics
- gold_user_engagement
- gold_geographic_analysis

---

# Data Pipeline Workflow

## Step 1

Producer scripts generate social media events.

Files:

- tweets-hub.py
- sentiment-hub.py
- trends-hub.py
- user-metadata-hub.py
- valid-tweets-hub.py

---

## Step 2

Events are published into Azure Event Hub.

---

## Step 3

Databricks Structured Streaming reads Event Hub data continuously.

---

## Step 4

Bronze pipelines store raw records into Delta tables.

---

## Step 5

Silver pipelines clean and validate data.

---

## Step 6

Gold pipelines create business-ready analytical datasets.

---

## Step 7

Airflow triggers Databricks jobs automatically.

---

## Step 8

Power BI dashboards display insights and KPIs.

---

# Apache Airflow Integration

Airflow is used for workflow orchestration.

### Responsibilities

- Trigger Databricks Jobs
- Schedule Pipeline Runs
- Monitor Pipeline Status
- Retry Failed Jobs
- Centralized Pipeline Management

### DAG

```python
social_media_pipeline
```

### Operator Used

```python
DatabricksRunNowOperator
```

---

# Data Quality Checks

Implemented using Pytest.

### Validation Rules

- Null checks
- Duplicate checks
- Schema validation
- Row count validation
- Data type validation
- Primary key validation
- Foreign key validation

---

# Power BI Dashboard Metrics

### Sentiment Analysis

- Positive Tweets
- Negative Tweets
- Neutral Tweets

### Trending Analysis

- Top Hashtags
- Trending Topics

### User Analytics

- Most Active Users
- User Engagement

### Geographic Analysis

- Location-wise Sentiment
- Regional Trend Analysis

---

# Roles & Responsibilities

### Data Ingestion

- Developed Event Hub producer scripts.
- Configured real-time data streaming.

### Bronze Layer

- Created raw Delta tables.
- Implemented streaming ingestion.

### Silver Layer

- Developed cleansing and validation logic.
- Implemented business rules.

### Gold Layer

- Designed star schema model.
- Created fact and dimension tables.

### Airflow

- Developed orchestration DAG.
- Configured Databricks integration.

### Testing

- Implemented automated data quality tests.

### Dashboard

- Prepared curated datasets for reporting.

---

# Key Achievements

- Built an end-to-end real-time data pipeline.
- Implemented Medallion Architecture.
- Automated workflows using Airflow.
- Delivered near real-time sentiment analytics.
- Created business-ready reporting datasets.
- Improved data quality through automated validation.

---

# Future Enhancements

- Real Twitter API integration
- Real-time alerting system
- Machine Learning sentiment prediction
- AI-based trend forecasting
- Advanced social media recommendation engine

---

# Project Outcome

Successfully designed and implemented a scalable real-time social media sentiment analysis platform using Azure Databricks, Event Hub, Airflow, Delta Lake, dbt, and Power BI, enabling organizations to derive actionable business insights from social media data in near real time.
