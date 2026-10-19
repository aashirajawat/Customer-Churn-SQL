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
- **Tenure Analysis:** Customers with 0–12 months of tenure had the highest churn rate at 47.44%, compared with 28.71% for 13–24 months, 20.39% for 25–48 months, and 9.51% for 49–72 months.
- **Retention Opportunity:** Investigate early-tenure customer experiences and onboarding to identify opportunities to reduce first-year churn.
### Revenue Analysis by Churn Status
- Churned customers have a higher average monthly charge of 74.44 compared with 61.27 for retained customers.
- The total monthly charges associated with churned customers are 139,130.85, while retained customers account for 316,985.75.
- Retained customers have total lifetime charges of 13,193,241.80, compared with 2,862,926.90 for churned customers.
- These findings suggest that customer churn is relevant to revenue analysis. Further investigation is needed to understand the reasons behind higher average charges among churned customers.
  
**Business Recommendation:** Analyze pricing plans, contract types, and customer tenure to identify patterns associated with churn and develop suitable retention strategies.

## Churn Analysis by Payment Method

| Payment Method | Total Customers | Churned Customers | Churn Rate |
|---|---:|---:|---:|
| Electronic check | 2,365 | 1,071 | 45.29% |
| Mailed check | 1,612 | 308 | 19.11% |
| Bank transfer (automatic) | 1,544 | 258 | 16.71% |
| Credit card (automatic) | 1,522 | 232 | 15.24% |

**Key Finding:** Electronic check customers have the highest churn rate at 45.29%, while automatic credit card customers have the lowest at 15.24%.

**Business Recommendation:** Investigate billing experience, payment preferences, and customer characteristics to understand this pattern. Consider testing convenient payment options as part of customer retention strategies.

## Churn Analysis by Internet Service

| Internet Service | Total Customers | Churned Customers | Churn Rate |
|---|---:|---:|---:|
| Fiber optic | 3,096 | 1,297 | 41.89% |
| DSL | 2,421 | 459 | 18.96% |
| No internet service | 1,526 | 113 | 7.40% |

**Key Finding:** Fiber optic customers have the highest churn rate at 41.89%, followed by DSL customers at 18.96%. Customers without internet service have the lowest churn rate at 7.40%.

**Business Recommendation:** Investigate customer satisfaction, pricing, service quality, and support experiences among fiber optic customers to understand the higher churn rate. These results show an association and do not establish the cause of churn.

## Churn Analysis by Senior Citizen Status

| Senior Citizen Status | Total Customers | Churned Customers | Churn Rate |
|---|---:|---:|---:|
| No | 5,901 | 1,393 | 23.61% |
| Yes | 1,142 | 476 | 41.68% |

**Key Finding:** Senior citizens have a churn rate of 41.68%, compared with 23.61% for non-senior customers. This is a difference of 18.07 percentage points.

**Business Recommendation:** Investigate whether customer support needs, service preferences, pricing, or other customer characteristics are associated with the higher churn rate among senior citizens. Use these findings to explore appropriate retention strategies without assuming age is the cause of churn.

## Churn Analysis by Tech Support

| Tech Support | Total Customers | Churned Customers | Churn Rate |
|---|---:|---:|---:|
| No | 3,473 | 1,446 | 41.64% |
| Yes | 2,044 | 310 | 15.17% |
| No internet service | 1,526 | 113 | 7.40% |

**Key Finding:** Customers without tech support have a churn rate of 41.64%, compared with 15.17% among customers with tech support.

**Business Recommendation:** Investigate support accessibility, response times, and customer satisfaction to understand this difference. Consider evaluating support improvements as a possible retention strategy; this analysis shows an association, not proof of causation.