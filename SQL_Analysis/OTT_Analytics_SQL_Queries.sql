/*
===============================================================================
PROJECT: OTT PLATFORM INTELLIGENCE
TITLE: Content Performance, Viewer Engagement & Customer Churn Analytics
DATABASE: Oracle SQL

PURPOSE
-------
Creates the project tables, validates imported data, and runs business
analysis queries covering customer churn, viewing engagement, subscription
behaviour, and content performance.

TABLES
------
1. CUSTOMERS
2. CONTENT_CATALOGUE
3. VIEWING_SESSIONS

EXECUTION NOTES
---------------
1. Run SECTION 1 only once in a new/empty project schema.
   The tables already exist in your project database, so skip SECTION 1
   when rerunning this script in that existing schema.
2. Run the remaining sections after the three tables have been populated.
3. This script does not DROP tables or delete project data.
4. Engagement segmentation uses customers with at least one viewing session
   because the analysis uses INNER JOIN.
5. Churn rates describe proportions in this synthetic dataset; they do not
   establish causation.
===============================================================================
*/


/* ============================================================================
   SECTION 1: DATABASE TABLE CREATION
   Run this section once, only if the tables do not already exist.
   ============================================================================ */

-- 1.1 Create CUSTOMERS to store customer profile, subscription,
--     acquisition, location, device preference, and churn information.

CREATE TABLE CUSTOMERS (
    customer_id VARCHAR2(30) PRIMARY KEY,
    signup_date DATE,
    subscription_plan VARCHAR2(20),
    monthly_fee_inr NUMBER(10,2),
    acquisition_channel VARCHAR2(30),
    region VARCHAR2(20),
    city VARCHAR2(50),
    preferred_device VARCHAR2(20),
    customer_age NUMBER(3),
    tenure_months NUMBER(3),
    churn_status VARCHAR2(10),
    cancellation_date DATE,
    last_active_date DATE,
    auto_renewal VARCHAR2(3)
);

-- 1.2 Create CONTENT_CATALOGUE to store content metadata,
--     genre, language, runtime, ratings, and cost information.

CREATE TABLE CONTENT_CATALOGUE (
    content_id VARCHAR2(30) PRIMARY KEY,
    content_title VARCHAR2(150),
    content_type VARCHAR2(20),
    genre VARCHAR2(50),
    language VARCHAR2(30),
    release_year NUMBER(4),
    runtime_minutes NUMBER(5),
    content_rating VARCHAR2(10),
    production_cost_lakh NUMBER(12,2),
    marketing_cost_lakh NUMBER(12,2),
    season_count NUMBER(3),
    availability_status VARCHAR2(20)
);

-- 1.3 Create VIEWING_SESSIONS to store viewing activity.
--     Foreign keys link each session to a valid customer and content item.

CREATE TABLE VIEWING_SESSIONS (
    session_id VARCHAR2(30) PRIMARY KEY,
    customer_id VARCHAR2(30),
    content_id VARCHAR2(30),
    session_date DATE,
    watch_minutes NUMBER(8,2),
    completion_pct NUMBER(5,2),
    device_type VARCHAR2(20),
    session_start_hour NUMBER(2),
    session_type VARCHAR2(20),
    buffer_events NUMBER(3),
    viewer_rating NUMBER(3,1),

    CONSTRAINT fk_vs_customer
        FOREIGN KEY (customer_id)
        REFERENCES CUSTOMERS(customer_id),

    CONSTRAINT fk_vs_content
        FOREIGN KEY (content_id)
        REFERENCES CONTENT_CATALOGUE(content_id)
);


/* ============================================================================
   SECTION 2: DATABASE STRUCTURE AND DATA VALIDATION
   Run after the tables have been created and populated.
   ============================================================================ */

-- 2.1 Inspect data types of the key identifier columns.
-- USER_TAB_COLUMNS contains column metadata for the current schema.

SELECT
    table_name,
    column_name,
    data_type
FROM user_tab_columns
WHERE table_name IN (
    'CUSTOMERS',
    'CONTENT_CATALOGUE',
    'VIEWING_SESSIONS'
)
AND column_name IN (
    'CUSTOMER_ID',
    'CONTENT_ID',
    'SESSION_ID'
)
ORDER BY table_name, column_name;

-- 2.2 Count the total number of customer records.

SELECT COUNT(*) AS total_customers
FROM CUSTOMERS;

-- 2.3 Count the total number of content records.

SELECT COUNT(*) AS total_content
FROM CONTENT_CATALOGUE;

-- 2.4 Count the total number of viewing session records.

SELECT COUNT(*) AS total_sessions
FROM VIEWING_SESSIONS;

-- 2.5 Count unique customer IDs in the CUSTOMERS table.

SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM CUSTOMERS;

-- 2.6 Check for viewing sessions whose customer_id has no
-- matching record in CUSTOMERS. A result of zero means no unmatched IDs.

SELECT COUNT(*) AS unmatched_customer_ids
FROM VIEWING_SESSIONS v
WHERE NOT EXISTS (
    SELECT 1
    FROM CUSTOMERS c
    WHERE c.customer_id = v.customer_id
);

-- 2.7 Check for viewing sessions whose content_id has no
-- matching record in CONTENT_CATALOGUE. A result of zero means no unmatched IDs.

SELECT COUNT(*) AS unmatched_content_ids
FROM VIEWING_SESSIONS v
WHERE NOT EXISTS (
    SELECT 1
    FROM CONTENT_CATALOGUE c
    WHERE c.content_id = v.content_id
);


/* ============================================================================
   SECTION 3: TABLE JOINS AND RELATIONSHIP ANALYSIS
   ============================================================================ */

-- 3.1 Join customer details with viewing-session details.
-- INNER JOIN returns sessions with a matching customer record.
-- ROWNUM limits the output to a sample of 10 rows.

SELECT
    c.customer_id,
    c.subscription_plan,
    c.region,
    c.churn_status,
    v.session_id,
    v.watch_minutes,
    v.completion_pct
FROM CUSTOMERS c
INNER JOIN VIEWING_SESSIONS v
    ON c.customer_id = v.customer_id
WHERE ROWNUM <= 10;


/* ============================================================================
   SECTION 4: CUSTOMER CHURN ANALYSIS
   ============================================================================ */

-- 4.1 Calculate customer count, churned customer count, and churn rate
-- for each subscription plan. Sort from highest churn rate to lowest.

SELECT
    subscription_plan,
    COUNT(*) AS total_customers,
    SUM(
        CASE
            WHEN churn_status = 'Churned' THEN 1
            ELSE 0
        END
    ) AS churned_customers,
    ROUND(
        SUM(
            CASE
                WHEN churn_status = 'Churned' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM CUSTOMERS
GROUP BY subscription_plan
ORDER BY churn_rate DESC;

-- 4.2 Calculate customer count, churned customer count, and churn rate
-- for each geographical region.

SELECT
    region,
    COUNT(*) AS total_customers,
    SUM(
        CASE
            WHEN churn_status = 'Churned' THEN 1
            ELSE 0
        END
    ) AS churned_customers,
    ROUND(
        SUM(
            CASE
                WHEN churn_status = 'Churned' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM CUSTOMERS
GROUP BY region
ORDER BY churn_rate DESC;

-- 4.3 Compare session-level average watch time and completion
-- for sessions belonging to active and churned customers.
-- Each viewing session contributes one observation to these averages.

SELECT
    ct.churn_status,
    COUNT(*) AS total_sessions,
    ROUND(AVG(v.watch_minutes), 2) AS avg_watch_minutes,
    ROUND(AVG(v.completion_pct), 2) AS avg_completion
FROM VIEWING_SESSIONS v
INNER JOIN CUSTOMERS ct
    ON v.customer_id = ct.customer_id
GROUP BY ct.churn_status
ORDER BY avg_watch_minutes DESC;


/* ============================================================================
   SECTION 5: CUSTOMER-LEVEL VIEWING AND ENGAGEMENT ANALYSIS
   ============================================================================ */

-- 5.1 Calculate each customer's average watch time, then compare
-- the average of those customer-level averages by churn status.
-- Each customer receives equal weight, regardless of session count.
-- Customers without viewing sessions are excluded by the INNER JOIN.

SELECT
    churn_status,
    COUNT(*) AS total_customers,
    ROUND(AVG(customer_avg_watch), 2) AS avg_watch_minutes
FROM (
    SELECT
        c.customer_id,
        c.churn_status,
        AVG(v.watch_minutes) AS customer_avg_watch
    FROM CUSTOMERS c
    INNER JOIN VIEWING_SESSIONS v
        ON c.customer_id = v.customer_id
    GROUP BY
        c.customer_id,
        c.churn_status
)
GROUP BY churn_status;

-- 5.2 Calculate average watch minutes for each customer.
-- Returns one row per customer with at least one viewing session.

SELECT
    c.customer_id,
    AVG(v.watch_minutes) AS avg_watch_minutes
FROM CUSTOMERS c
INNER JOIN VIEWING_SESSIONS v
    ON c.customer_id = v.customer_id
GROUP BY c.customer_id;

-- 5.3 Show each customer's average watch time together with churn status.

SELECT
    c.customer_id,
    c.churn_status,
    AVG(v.watch_minutes) AS avg_watch_minutes
FROM CUSTOMERS c
INNER JOIN VIEWING_SESSIONS v
    ON c.customer_id = v.customer_id
GROUP BY
    c.customer_id,
    c.churn_status;

-- 5.4 Segment customers by average session watch time:
-- High = 80 minutes or more.
-- Medium = 50 minutes or more, but less than 80 minutes.
-- Low = less than 50 minutes.
-- Compare active and churned customer counts in each segment.
-- Customers without viewing sessions are excluded by the INNER JOIN.

SELECT
    churn_status,
    engagement_level,
    COUNT(*) AS total_customers
FROM (
    SELECT
        customer_id,
        churn_status,
        avg_watch_minutes,
        CASE
            WHEN avg_watch_minutes >= 80 THEN 'High'
            WHEN avg_watch_minutes >= 50
                 AND avg_watch_minutes < 80 THEN 'Medium'
            ELSE 'Low'
        END AS engagement_level
    FROM (
        SELECT
            c.customer_id,
            c.churn_status,
            AVG(v.watch_minutes) AS avg_watch_minutes
        FROM CUSTOMERS c
        INNER JOIN VIEWING_SESSIONS v
            ON c.customer_id = v.customer_id
        GROUP BY
            c.customer_id,
            c.churn_status
    )
)
GROUP BY
    churn_status,
    engagement_level
ORDER BY
    churn_status,
    total_customers DESC;

-- 5.5 Calculate the churn rate within each engagement segment.
-- The denominator is all customers in that segment.
-- This is the percentage of customers in each segment who churned.
-- Customers without viewing sessions are excluded.

SELECT
    engagement_level,
    COUNT(*) AS total_customers,
    SUM(
        CASE
            WHEN churn_status = 'Churned' THEN 1
            ELSE 0
        END
    ) AS churned_customers,
    ROUND(
        SUM(
            CASE
                WHEN churn_status = 'Churned' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM (
    SELECT
        c.customer_id,
        c.churn_status,
        CASE
            WHEN AVG(v.watch_minutes) >= 80 THEN 'High'
            WHEN AVG(v.watch_minutes) >= 50 THEN 'Medium'
            ELSE 'Low'
        END AS engagement_level
    FROM CUSTOMERS c
    INNER JOIN VIEWING_SESSIONS v
        ON c.customer_id = v.customer_id
    GROUP BY
        c.customer_id,
        c.churn_status
)
GROUP BY engagement_level
ORDER BY churn_rate DESC;


/* ============================================================================
   SECTION 6: SUBSCRIPTION AND RETENTION ANALYSIS
   ============================================================================ */

-- 6.1 Compare customer counts and churn rates by auto-renewal setting.
-- This shows an association; it does not prove that auto-renewal status
-- caused churn. The timing of cancellation and renewal changes matters.

SELECT
    auto_renewal AS aut,
    COUNT(*) AS total_customers,
    SUM(
        CASE
            WHEN churn_status = 'Churned' THEN 1
            ELSE 0
        END
    ) AS churned_customers,
    ROUND(
        SUM(
            CASE
                WHEN churn_status = 'Churned' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM CUSTOMERS
GROUP BY auto_renewal
ORDER BY churn_rate DESC;


/* ============================================================================
   SECTION 7: CONTENT PERFORMANCE ANALYSIS
   ============================================================================ */

-- 7.1 Identify the top 10 content titles by total watch minutes.
-- Calculate session count, total watch minutes, and average completion
-- percentage for each title. The outer query returns the first 10 rows
-- from the result ordered by total watch minutes.

SELECT *
FROM (
    SELECT
        c.content_title,
        c.genre,
        COUNT(v.session_id) AS total_sessions,
        ROUND(SUM(v.watch_minutes), 2) AS total_watch_minutes,
        ROUND(AVG(v.completion_pct), 2) AS avg_completion
    FROM CONTENT_CATALOGUE c
    INNER JOIN VIEWING_SESSIONS v
        ON c.content_id = v.content_id
    GROUP BY
        c.content_title,
        c.genre
    ORDER BY total_watch_minutes DESC
)
WHERE ROWNUM <= 10;

-- 7.2 Compare viewer engagement across content genres.
-- Calculate session count, average watch minutes, and average completion
-- percentage for each genre. Sort by average watch time, highest first.

SELECT
    c.genre,
    COUNT(*) AS total_sessions,
    ROUND(AVG(v.watch_minutes), 2) AS avg_watch_minutes,
    ROUND(AVG(v.completion_pct), 2) AS avg_completion
FROM VIEWING_SESSIONS v
INNER JOIN CONTENT_CATALOGUE c
    ON v.content_id = c.content_id
GROUP BY c.genre
ORDER BY avg_watch_minutes DESC;


/* ============================================================================
   SECTION 8: COMMON TABLE EXPRESSION (CTE)
   ============================================================================ */

-- 8.1 Use a CTE to calculate average watch time for each customer.
-- The main query compares customer counts and average customer-level
-- watch time by churn status. Customers without viewing sessions
-- are excluded by the INNER JOIN.

WITH Customer_Engagement AS (
    SELECT
        c.customer_id,
        c.churn_status,
        AVG(v.watch_minutes) AS avg_watch_minutes
    FROM CUSTOMERS c
    INNER JOIN VIEWING_SESSIONS v
        ON c.customer_id = v.customer_id
    GROUP BY
        c.customer_id,
        c.churn_status
)
SELECT
    churn_status,
    COUNT(*) AS total_customers,
    ROUND(AVG(avg_watch_minutes), 2) AS avg_customer_watch
FROM Customer_Engagement
GROUP BY churn_status;


/* ============================================================================
   END OF PROJECT SQL ANALYSIS
   ============================================================================ */

/*
KEY SQL CONCEPTS DEMONSTRATED
-----------------------------
- CREATE TABLE, PRIMARY KEY, and FOREIGN KEY constraints
- Data dictionary inspection using USER_TAB_COLUMNS
- COUNT, COUNT DISTINCT, SUM, AVG, and ROUND
- WHERE, GROUP BY, and ORDER BY
- INNER JOIN and NOT EXISTS
- CASE WHEN conditional logic
- Subqueries and nested queries
- Common Table Expressions (CTEs)
- Customer churn and engagement segmentation
- Subscription and content performance analysis

DATA NOTE
---------
This project uses synthetic practice data. Findings describe the supplied
dataset and should not be presented as actual results from a real OTT platform.
*/
