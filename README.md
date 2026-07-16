# E-commerce Sales Funnel Analysis using SQL (BigQuery)

## Overview

This project analyzes user behavior across an e-commerce sales funnel using SQL in Google BigQuery. The objective is to identify where users drop off, evaluate marketing channel performance, analyze customer purchase journeys, and measure key revenue metrics.

The project demonstrates how SQL can be used to transform raw event data into actionable business insights.

---

## Business Questions

This analysis answers the following questions:

- How many users progress through each stage of the sales funnel?
- Where are the largest conversion drop-offs?
- Which traffic sources generate the highest conversions?
- How long does a customer take to complete a purchase?
- What are the key revenue metrics such as Average Order Value and Revenue per Visitor?

---

## Dataset

The dataset contains user event data from an e-commerce platform.

### Events Included

- Page View
- Add to Cart
- Checkout Start
- Payment Information
- Purchase

### Fields Used

- `user_id`
- `event_type`
- `event_date`
- `traffic_source`
- `amount`

---

## Technologies Used

- Google BigQuery
- SQL
- Google Cloud Platform
- Microsoft Excel (Visualizations)

---

## Analysis Performed

### 1. Sales Funnel Analysis

Calculated the number of unique users at each stage:

| Funnel Stage | Users |
|--------------|------:|
| Page View | 4,159 |
| Add to Cart | 1,272 |
| Checkout | 912 |
| Payment | 738 |
| Purchase | 681 |

---

### 2. Conversion Rate Analysis

| Metric | Rate |
|--------|------:|
| View → Cart | 30.58% |
| Cart → Checkout | 71.70% |
| Checkout → Payment | 80.92% |
| Payment → Purchase | 92.28% |
| Overall Conversion | 16.37% |

---

### 3. Traffic Source Performance

| Source | View → Purchase |
|--------|----------------:|
| Email | **33.49%** |
| Paid Ads | 21.05% |
| Organic | 16.72% |
| Social | 6.93% |

---

### 4. Customer Journey Analysis

Average time between funnel stages:

| Stage | Average Time |
|--------|-------------:|
| View → Cart | 11.27 min |
| Cart → Checkout | 5.40 min |
| Checkout → Payment | 5.07 min |
| Payment → Purchase | 3.06 min |
| Total Purchase Journey | **24.80 min** |

---

### 5. Revenue Analysis

| Metric | Value |
|--------|-------:|
| Total Revenue | **$75,368.44** |
| Visitors | 4,286 |
| Buyers | 701 |
| Average Order Value | $107.52 |
| Revenue per Buyer | $107.52 |
| Revenue per Visitor | $18.00 |
| Conversion Rate | 16% |

---

## Key Insights

- Only **16.37%** of visitors completed a purchase.
- The largest drop-off occurred between **Page View** and **Add to Cart**, where only **30.58%** of users progressed.
- **Email marketing** was the highest-performing acquisition channel with a **33.49%** View-to-Purchase conversion rate.
- **Social media** generated the lowest conversion rate at **6.93%**, indicating an opportunity for optimization.
- Converted customers completed the purchasing process in an average of **24.8 minutes**.
- The platform generated over **$75K** in revenue during the analysis period, with an average order value of **$107.52**.

---

## Business Recommendations

- Improve product pages and calls-to-action to reduce the View-to-Cart drop-off.
- Increase investment in Email campaigns due to their superior conversion performance.
- Review Social media targeting and landing pages to improve conversion efficiency.
- Simplify the purchase flow to further reduce friction during checkout.

---

## SQL Concepts Demonstrated

- Views
- Common Table Expressions (CTEs)
- Aggregate Functions
- Conditional Aggregation
- `COUNT(DISTINCT)`
- `CASE WHEN`
- `GROUP BY`
- `ROUND()`
- `TIMESTAMP_DIFF()`
- Date Filtering
- Revenue Analysis
- Funnel Analysis

---

## Dashboard Preview

<img width="1651" height="991" alt="sales_funnels" src="https://github.com/user-attachments/assets/7b367a3e-7290-4bf8-aebb-c1fe2c89b8dd" />

<img width="1980" height="993" alt="conversion_rates" src="https://github.com/user-attachments/assets/a7325628-9380-432d-920f-55862ad89635" />

<img width="1764" height="993" alt="view_to_purchase_rate" src="https://github.com/user-attachments/assets/9ad2eed2-f21a-41a5-beb5-2cb038299f07" />
