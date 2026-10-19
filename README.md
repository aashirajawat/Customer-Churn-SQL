# Customer Churn Analysis Using PostgreSQL

## Project Overview

This project analyzes customer churn using PostgreSQL to identify customer retention patterns, understand churn behavior, and explore revenue-related trends.

## Dataset

- **Dataset Name:** Telco Customer Churn
- **Source:** Kaggle
- **Dataset Link:** https://www.kaggle.com/datasets/blastchar/telco-customer-churn
- **Total Records:** 7,043 customers
- **Total Columns:** 21

The dataset contains customer demographics, subscribed services, contract details, billing information, and churn status.

## Tools Used

- PostgreSQL
- pgAdmin
- SQL

## Analysis

- Customer churn rate
- Churn by contract type and internet service
- Churn by payment method and customer services
- Tenure and monthly charge analysis
- Revenue analysis
- Common Table Expressions (CTEs)
- Window functions and customer ranking

## Project Structure

```text
Customer-Churn-SQL/
├── sql/
│   └── customer_churn_analysis.sql
└── README.md
```

## How to Use

1. Download the dataset from Kaggle.
2. Create a PostgreSQL database named `customer_churn_db`.
3. Create the `customer_churn` table and import the dataset.
4. Open the SQL script in pgAdmin and execute the analysis queries.

## Key Findings

- **Customer Churn:** Out of 7,043 customers, 1,869 churned, resulting in an overall churn rate of 26.54%.
- **Customer Retention:** 5,174 customers remained, representing approximately 73.46% of the customer base.
- **Tenure Pattern:** Churned customers had an average tenure of 17.98 months, compared with 37.57 months for retained customers.
- **Monthly Charges:** Churned customers had higher average monthly charges (74.44) than retained customers (61.27).
- **Business Recommendation:** Investigate early-tenure customer experiences and whether higher monthly charges are associated with churn. Consider targeted onboarding and retention offers, then measure their impact.

- **Contract Analysis:** Month-to-month customers had the highest churn rate at 42.71%, compared with 11.27% for one-year contracts and 2.83% for two-year contracts.
- **Retention Opportunity:** Explore targeted retention offers and improved onboarding for month-to-month customers, and measure whether these initiatives reduce churn.