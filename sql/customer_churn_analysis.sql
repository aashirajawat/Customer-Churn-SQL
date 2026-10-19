-- Customer Churn Analysis | PostgreSQL
-- Table setup
CREATE TABLE IF NOT EXISTS customer_churn (
    customer_id VARCHAR(20) PRIMARY KEY,
    gender VARCHAR(10),
    senior_citizen INT,
    partner VARCHAR(5),
    dependents VARCHAR(5),
    tenure INT,
    phone_service VARCHAR(5),
    multiple_lines VARCHAR(30),
    internet_service VARCHAR(30),
    online_security VARCHAR(30),
    online_backup VARCHAR(30),
    device_protection VARCHAR(30),
    tech_support VARCHAR(30),
    streaming_tv VARCHAR(30),
    streaming_movies VARCHAR(30),
    contract VARCHAR(30),
    paperless_billing VARCHAR(5),
    payment_method VARCHAR(50),
    monthly_charges NUMERIC(10,2),
    total_charges NUMERIC(10,2),
    churn VARCHAR(5)
);

-- Customer Churn Analysis
-- Dataset overview

-- Check total number of customers
SELECT COUNT(*) AS total_customers
FROM customer_churn;

-- Preview customer records
SELECT *
FROM customer_churn
LIMIT 10;

-- Check table structure and column data types
SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'customer_churn'
  AND table_schema = 'public'
ORDER BY ordinal_position;

-- Check for duplicate customer IDs
SELECT
    customer_id,
    COUNT(*) AS record_count
FROM customer_churn
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Check missing values in important columns
SELECT
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS missing_customer_ids,
    COUNT(*) FILTER (WHERE tenure IS NULL) AS missing_tenure,
    COUNT(*) FILTER (WHERE monthly_charges IS NULL) AS missing_monthly_charges,
    COUNT(*) FILTER (WHERE total_charges IS NULL) AS missing_total_charges,
    COUNT(*) FILTER (WHERE churn IS NULL) AS missing_churn_values
FROM customer_churn;

-- Customer distribution by churn status
SELECT
    churn,
    COUNT(*) AS total_customers
FROM customer_churn
GROUP BY churn
ORDER BY total_customers DESC;

-- Overall customer churn rate
SELECT
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE churn = 'Yes')
        / NULLIF(COUNT(*), 0),
        2
    ) AS churn_rate_percentage
FROM customer_churn;

-- Customer distribution by gender
SELECT
    gender,
    COUNT(*) AS total_customers
FROM customer_churn
GROUP BY gender
ORDER BY total_customers DESC;

-- Customer distribution by contract type
SELECT
    contract,
    COUNT(*) AS total_customers
FROM customer_churn
GROUP BY contract
ORDER BY total_customers DESC;

-- Churn rate by contract type
SELECT
    contract,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE churn = 'Yes')
        / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM customer_churn
GROUP BY contract
ORDER BY churn_rate_percentage DESC;

-- Churn rate by internet service
SELECT
    internet_service,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE churn = 'Yes')
        / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM customer_churn
GROUP BY internet_service
ORDER BY churn_rate_percentage DESC;

-- Churn rate by customer tenure group
SELECT
    CASE
        WHEN tenure <= 12 THEN '0-12 Months'
        WHEN tenure <= 24 THEN '13-24 Months'
        WHEN tenure <= 48 THEN '25-48 Months'
        ELSE '49-72 Months'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE churn = 'Yes')
        / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM customer_churn
GROUP BY tenure_group
ORDER BY MIN(tenure);

-- Average monthly charges by churn status
SELECT
    churn,
    ROUND(AVG(monthly_charges), 2) AS avg_monthly_charges
FROM customer_churn
GROUP BY churn
ORDER BY churn;

-- Churn rate by payment method
SELECT
    payment_method,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE churn = 'Yes')
        / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM customer_churn
GROUP BY payment_method
ORDER BY churn_rate_percentage DESC;

-- Churn rate by paperless billing
SELECT
    paperless_billing,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE churn = 'Yes')
        / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM customer_churn
GROUP BY paperless_billing
ORDER BY churn_rate_percentage DESC;

-- Churn rate by online security service
SELECT
    online_security,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE churn = 'Yes')
        / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM customer_churn
GROUP BY online_security
ORDER BY churn_rate_percentage DESC;

-- Churn rate by technical support service
SELECT
    tech_support,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE churn = 'Yes')
        / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM customer_churn
GROUP BY tech_support
ORDER BY churn_rate_percentage DESC;

-- Churn rate by customer dependents
SELECT
    dependents,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE churn = 'Yes')
        / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM customer_churn
GROUP BY dependents
ORDER BY churn_rate_percentage DESC;

-- Total revenue from monthly customer charges
SELECT
    ROUND(SUM(monthly_charges), 2) AS total_monthly_revenue
FROM customer_churn;

-- Monthly revenue by churn status
SELECT
    churn,
    COUNT(*) AS total_customers,
    ROUND(SUM(monthly_charges), 2) AS monthly_revenue,
    ROUND(AVG(monthly_charges), 2) AS avg_monthly_charges
FROM customer_churn
GROUP BY churn
ORDER BY monthly_revenue DESC;

-- Total charges by churn status
SELECT
    churn,
    ROUND(SUM(total_charges), 2) AS total_customer_charges,
    ROUND(AVG(total_charges), 2) AS avg_customer_charges
FROM customer_churn
GROUP BY churn
ORDER BY total_customer_charges DESC;

-- Customer segments by monthly charges
WITH customer_segments AS (
    SELECT
        CASE
            WHEN monthly_charges < 35 THEN 'Low Charges'
            WHEN monthly_charges < 70 THEN 'Medium Charges'
            ELSE 'High Charges'
        END AS charge_segment,
        churn
    FROM customer_churn
)
SELECT
    charge_segment,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE churn = 'Yes')
        / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM customer_segments
GROUP BY charge_segment
ORDER BY
    CASE charge_segment
        WHEN 'Low Charges' THEN 1
        WHEN 'Medium Charges' THEN 2
        ELSE 3
    END;

-- Top 10 customers by total charges
SELECT
    customer_id,
    tenure,
    monthly_charges,
    total_charges,
    contract,
    churn
FROM customer_churn
ORDER BY total_charges DESC
LIMIT 10;

-- Rank contract types by churn rate
WITH contract_analysis AS (
    SELECT
        contract,
        COUNT(*) AS total_customers,
        COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
        ROUND(
            100.0 * COUNT(*) FILTER (WHERE churn = 'Yes')
            / COUNT(*),
            2
        ) AS churn_rate_percentage
    FROM customer_churn
    GROUP BY contract
)
SELECT
    *,
    RANK() OVER (
        ORDER BY churn_rate_percentage DESC
    ) AS churn_rate_rank
FROM contract_analysis;

-- Compare average monthly charges across churn groups
WITH churn_analysis AS (
    SELECT
        churn,
        COUNT(*) AS total_customers,
        ROUND(AVG(monthly_charges), 2) AS avg_monthly_charges
    FROM customer_churn
    GROUP BY churn
)
SELECT
    churn,
    total_customers,
    avg_monthly_charges,
    ROUND(
        avg_monthly_charges
        - AVG(avg_monthly_charges) OVER (),
        2
    ) AS difference_from_group_average
FROM churn_analysis;

-- Identify high-value customers who churned
WITH customer_value AS (
    SELECT
        customer_id,
        tenure,
        contract,
        monthly_charges,
        total_charges,
        churn,
        NTILE(4) OVER (
            ORDER BY total_charges DESC
        ) AS value_quartile
    FROM customer_churn
)
SELECT
    customer_id,
    tenure,
    contract,
    monthly_charges,
    total_charges,
    value_quartile
FROM customer_value
WHERE churn = 'Yes'
  AND value_quartile = 1
ORDER BY total_charges DESC
LIMIT 20;

-- Calculate cumulative customer count by tenure
WITH tenure_summary AS (
    SELECT
        tenure,
        COUNT(*) AS customers_at_tenure
    FROM customer_churn
    GROUP BY tenure
)
SELECT
    tenure,
    customers_at_tenure,
    SUM(customers_at_tenure) OVER (
        ORDER BY tenure
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_customers
FROM tenure_summary
ORDER BY tenure;

-- Overall customer churn and revenue summary
SELECT
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (
        WHERE churn = 'Yes'
    ) AS churned_customers,
    COUNT(*) FILTER (
        WHERE churn = 'No'
    ) AS retained_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE churn = 'Yes'
        ) / COUNT(*),
        2
    ) AS churn_rate_percentage,
    ROUND(
        SUM(monthly_charges) FILTER (
            WHERE churn = 'Yes'
        ),
        2
    ) AS monthly_revenue_from_churned_customers,
    ROUND(
        AVG(tenure) FILTER (
            WHERE churn = 'Yes'
        ),
        2
    ) AS avg_tenure_of_churned_customers,
    ROUND(
        AVG(monthly_charges) FILTER (
            WHERE churn = 'Yes'
        ),
        2
    ) AS avg_monthly_charges_of_churned_customers
FROM customer_churn;

-- Overall customer churn summary
SELECT
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (
        WHERE churn = 'Yes'
    ) AS churned_customers,
    COUNT(*) FILTER (
        WHERE churn = 'No'
    ) AS retained_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE churn = 'Yes'
        ) / COUNT(*),
        2
    ) AS churn_rate_percentage,
    ROUND(
        AVG(tenure) FILTER (
            WHERE churn = 'Yes'
        ),
        2
    ) AS avg_tenure_churned,
    ROUND(
        AVG(tenure) FILTER (
            WHERE churn = 'No'
        ),
        2
    ) AS avg_tenure_retained,
    ROUND(
        AVG(monthly_charges) FILTER (
            WHERE churn = 'Yes'
        ),
        2
    ) AS avg_monthly_charges_churned,
    ROUND(
        AVG(monthly_charges) FILTER (
            WHERE churn = 'No'
        ),
        2
    ) AS avg_monthly_charges_retained
FROM customer_churn;

-- Churn analysis by contract type
SELECT
    contract,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (
        WHERE churn = 'Yes'
    ) AS churned_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE churn = 'Yes'
        ) / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM customer_churn
GROUP BY contract
ORDER BY churn_rate_percentage DESC;

-- Churn analysis by customer tenure
SELECT
    CASE
        WHEN tenure <= 12 THEN '0-12 Months'
        WHEN tenure <= 24 THEN '13-24 Months'
        WHEN tenure <= 48 THEN '25-48 Months'
        ELSE '49-72 Months'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (
        WHERE churn = 'Yes'
    ) AS churned_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE churn = 'Yes'
        ) / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM customer_churn
GROUP BY
    CASE
        WHEN tenure <= 12 THEN '0-12 Months'
        WHEN tenure <= 24 THEN '13-24 Months'
        WHEN tenure <= 48 THEN '25-48 Months'
        ELSE '49-72 Months'
    END
ORDER BY
    MIN(tenure);

-- Revenue analysis by churn status
SELECT
    churn,
    COUNT(*) AS total_customers,
    ROUND(SUM(monthly_charges), 2) AS total_monthly_charges,
    ROUND(AVG(monthly_charges), 2) AS avg_monthly_charges,
    ROUND(SUM(total_charges), 2) AS total_lifetime_charges
FROM customer_churn
GROUP BY churn
ORDER BY churn;

-- Churn analysis by payment method
SELECT
    payment_method,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM customer_churn
GROUP BY payment_method
ORDER BY churn_rate_percentage DESC;

-- Churn analysis by internet service
SELECT
    internet_service,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM customer_churn
GROUP BY internet_service
ORDER BY churn_rate_percentage DESC;
