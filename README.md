# OTT Platform Intelligence
### Content Performance, Viewer Engagement & Customer Churn Analytics

## Project Overview

OTT Platform Intelligence is an end-to-end data analytics project focused on understanding customer behaviour, subscription patterns, content performance and viewer engagement on a simulated Over-The-Top (OTT) streaming platform.

The project uses Excel, Oracle SQL and Power BI to transform raw data into meaningful business insights and actionable recommendations.

The primary objective is to identify customer churn patterns, understand content consumption behaviour and highlight opportunities to improve customer retention.

## Business Objectives

- Analyse overall customer churn and retention.
- Identify subscription plans with higher churn rates.
- Compare customer churn across geographical regions.
- Understand viewing behaviour of active and churned customers.
- Evaluate content performance across different genres.
- Analyse the relationship between customer engagement and churn.
- Identify retention opportunities based on customer behaviour.

## Tools & Technologies

| Tool | Purpose |
|---|---|
| Microsoft Excel | Data exploration, cleaning and Pivot Table analysis |
| Oracle SQL | Data validation, joins, aggregations and business analysis |
| Power BI | Interactive dashboards, visualisations and DAX measures |

## Dataset Description

The project uses three synthetic datasets containing 3,120 records in total.

| Dataset | Records | Description |
|---|---:|---|
| Customers | 500 | Customer demographics, subscription plans, region and churn information |
| Content Catalogue | 120 | Content titles, genres, languages and metadata |
| Viewing Sessions | 2,500 | Customer viewing activity, watch time and completion percentage |

**Note:** The datasets are synthetically generated for educational and portfolio purposes. They do not represent actual data from JioHotstar or any other OTT provider.

## Project Workflow

### 1. Excel Analysis

- Explored and cleaned the datasets.
- Analysed customer churn by subscription plan and region.
- Evaluated customer engagement and viewing behaviour.
- Used Pivot Tables to identify business patterns.

### 2. Oracle SQL Analysis

- Created relational tables with primary and foreign key constraints.
- Validated records and key relationships.
- Used JOINs, GROUP BY, aggregate functions and CASE WHEN.
- Applied subqueries and Common Table Expressions (CTEs).
- Analysed customer churn, content performance and engagement.

### 3. Power BI Dashboard

Developed a three-page interactive dashboard.

**Page 1 – Executive Overview**
- Total, active and churned customers.
- Overall churn rate.
- Churn by subscription plan.
- Regional churn analysis.
- Auto-renewal analysis.

**Page 2 – Content Performance**
- Top 10 content titles by total watch time.
- Average completion by genre.
- Total viewing sessions by genre.
- Average watch time by genre.

**Page 3 – Customer Retention & Engagement**
- Churn by subscription plan.
- Churn by customer tenure.
- Churn by preferred device.
- Engagement-level analysis.
- Acquisition channel analysis.

## Key Business Findings

### 1. Overall Customer Churn

- Total customers: 500
- Active customers: 394
- Churned customers: 106
- Overall churn proportion: 21.2%

### 2. Subscription Plan Analysis

| Subscription Plan | Customers Churned | Churn Rate |
|---|---:|---:|
| Mobile | 51 | 28.81% |
| Super | 37 | 19.17% |
| Premium | 18 | 13.85% |

The Mobile subscription plan has the highest churn rate, indicating a need to investigate customer expectations, pricing and perceived subscription value.

### 3. Regional Churn Analysis

| Region | Churn Rate |
|---|---:|
| North | 23.30% |
| Central | 22.41% |
| West | 20.93% |
| East | 19.63% |
| South | 19.32% |

North has the highest churn rate, while Central has the highest churn count. Both regions deserve attention from the customer retention team.

### 4. Customer Engagement Analysis

| Engagement Level | Churn Rate |
|---|---:|
| High | 18.35% |
| Medium | 21.03% |
| Low | 24.37% |

Customers in the Low Engagement category have the highest churn rate among customers with viewing sessions.

### 5. Content Performance

- Romance has the highest average watch time at 84.69 minutes.
- Comedy has the highest average completion percentage at 69.01%.
- Comedy also records the highest number of viewing sessions at 375.

### 6. Auto-Renewal Analysis

Customers with auto-renewal disabled show a churn rate of 58.24%, compared with 0% among customers with auto-renewal enabled.

This is an observed association in the dataset, not proof that disabling auto-renewal causes churn.

## Business Recommendations

1. **Improve Mobile Plan Retention:** Investigate pricing, subscription value and content expectations among Mobile plan customers.

2. **Prioritise Regional Retention:** Investigate the reasons behind higher churn in North while monitoring the high churn volume in Central.

3. **Improve Viewer Engagement:** Introduce personalised recommendations and targeted content promotions for low-engagement customers.

4. **Encourage Subscription Renewal:** Test renewal incentives for customers approaching subscription expiry, particularly those with auto-renewal disabled.

5. **Strengthen Content Strategy:** Evaluate the performance of popular genres and use viewing patterns to inform content recommendations.

## Repository Structure

```text
OTT_PLATFORM_INTELLIGENCE/
│
├── Dataset/
│   ├── Customers.csv
│   ├── Content_Catalogue.csv
│   └── Viewing_Sessions.csv
│
├── Excel_Analysis/
│   └── OTT_Platform_Analytics_Excel.xlsx
│
├── SQL_Analysis/
│   └── OTT_Analytics_SQL_Queries.sql
│
├── PowerBI_Dashboard/
│   └── OTT powebi.pbix
│
├── Screenshots/
│   ├── 01_Executive_Overview.png
│   ├── 02_Content_Performance.png
│   └── 03_Customer_Retention.png
│
└── README.md
```

## Dashboard Preview

### Executive Overview
![Executive Overview](Screenshots/01_Executive_Overview.png)

### Content Performance
![Content performance](Screenshots/02_Content_Performance.png)

### Customer Retention & Engagement
![Customer retention](Screenshots/03_Customer_Retention.png)

## Project Limitations

- The dataset is synthetic and intended for analytical practice.
- The findings represent patterns in the supplied dataset, not actual OTT industry performance.
- Observed associations should not be interpreted as causal relationships.
- Revenue, customer lifetime value and acquisition profitability were not independently established in this analysis.

## Conclusion

This project demonstrates an end-to-end data analytics workflow using Excel, Oracle SQL and Power BI.

It transforms raw datasets into structured analysis, interactive dashboards and business recommendations, with a focus on customer retention, viewer engagement and content performance.
