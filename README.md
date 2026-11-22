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


## 📊 Power BI Dashboard Preview

### 1. Executive Overview
![Executive Overview](Screenshots/Executive%20Overview.png)

### 2. Content Performance
![Content Performance](Screenshots/Content%20performance.png)

### 3. Customer Retention
![Customer Retention](Screenshots/Customer%20retention.png)


## Project Limitations

- The dataset is synthetic and intended for analytical practice.
- The findings represent patterns in the supplied dataset, not actual OTT industry performance.
- Observed associations should not be interpreted as causal relationships.
- Revenue, customer lifetime value and acquisition profitability were not independently established in this analysis.

## Conclusion

This project demonstrates an end-to-end data analytics workflow using Excel, Oracle SQL and Power BI.

It transforms raw datasets into structured analysis, interactive dashboards and business recommendations, with a focus on customer retention, viewer engagement and content performance.


## 📌 Project Overview

**OTT Platform Intelligence: Content Performance, Viewer Engagement & Customer Churn Analytics**

### 1. Business Problem

The objective of this project is to analyse customer behaviour and content consumption patterns on a simulated OTT platform.

The analysis focuses on identifying customer churn patterns, understanding viewer engagement, evaluating content performance, and discovering opportunities to improve customer retention.

### 2. Project Objectives

- Analyse overall customer churn and retention.
- Identify subscription plans and regions with higher churn rates.
- Understand viewing behaviour across different customer segments.
- Evaluate content performance based on watch time and completion percentage.
- Analyse the relationship between customer engagement and churn.
- Develop data-driven recommendations to improve customer retention.

### 3. Dataset Description

The project uses a synthetic dataset created for educational and analytical purposes.

| Dataset | Records | Description |
|---|---:|---|
| Customers | 500 | Customer profiles, subscription details and churn status |
| Content Catalogue | 120 | Content titles, genres, languages and other attributes |
| Viewing Sessions | 2,500 | Viewing activity, watch time and completion percentage |
| **Total** | **3,120** | **Records across three datasets** |

### 4. Tools and Technologies

- **Microsoft Excel:** Data inspection, cleaning, Pivot Tables and preliminary analysis.
- **Oracle SQL:** Database creation, table relationships, joins, aggregations, subqueries and business analysis.
- **Power BI:** Data modelling, DAX measures, interactive dashboards and visual storytelling.
- **Python:** Planned for further exploratory data analysis.

### 5. Key Business Findings

- Overall customer churn is **21.20%**.
- The Mobile subscription plan has the highest churn rate at **28.81%**.
- North region has the highest regional churn rate at **23.30%**.
- Central region has the highest churn volume.
- Organic acquisition has the highest churn rate at **25.00%**.
- Customers with low engagement have a higher churn rate (**24.37%**) than customers with high engagement (**18.35%**).
- Comedy has the highest average content completion at **69.01%**.
- Romance has the highest average watch time at **84.69 minutes**.

### 6. Power BI Dashboard

The interactive Power BI report contains three analytical pages:

1. **Executive Overview:** Overall customer metrics, subscription analysis and regional churn.
2. **Content Performance:** Genre-wise engagement, content completion and top-performing titles.
3. **Customer Retention & Engagement:** Customer segmentation, tenure, acquisition channels and churn patterns.

### 7. Business Recommendations

- Investigate the reasons behind higher churn among Mobile plan subscribers.
- Prioritise customer retention initiatives in the North region.
- Review customer expectations and satisfaction across acquisition channels.
- Develop targeted engagement strategies for low-engagement customers.
- Explore content preferences and completion patterns to support content planning.
- Review subscription renewal behaviour and consider targeted renewal incentives.

### 8. Project Limitations

- The dataset is synthetic and does not represent actual data from any OTT company.
- The findings demonstrate analytical patterns within the generated dataset.
- Observed associations should not be interpreted as proof of causation.
- Further analysis with real-world data would be required before making actual business decisions.

### 9. Project Status

Excel analysis, Oracle SQL analysis and the three-page Power BI dashboard have been completed. Python analysis and final project documentation are the next stages.

---

**Note:** This project is developed for learning and portfolio demonstration purposes.

