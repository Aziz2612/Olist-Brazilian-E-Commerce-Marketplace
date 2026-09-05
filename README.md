# 🛒 Olist E-Commerce Marketplace Analysis

## 📌 Project Overview

This project analyzes the **Olist Brazilian E-Commerce Marketplace** using SQL and Power BI to uncover actionable business insights across marketplace performance, customers, sellers, product categories, geography, and operational performance.

The project goes beyond SQL querying by translating data into **business questions, performance metrics, insights, and actionable recommendations**.

The analysis was structured around a real-world marketplace business case to understand:

- What drives marketplace revenue and growth?
- How concentrated is revenue across sellers?
- Which product categories perform best?
- Where is marketplace activity geographically concentrated?
- How strong is customer retention and repeat purchasing?
- How does delivery performance affect customer satisfaction?

---

## 🎯 Business Objectives

The main objectives of this analysis are to:

- Evaluate overall marketplace performance and growth.
- Analyze customer purchasing behavior and retention.
- Measure new vs returning customer activity.
- Understand customer purchase frequency and cohort retention.
- Evaluate seller performance and revenue concentration.
- Identify high-performing and high-potential product categories.
- Analyze geographic differences in marketplace performance.
- Investigate the relationship between delivery performance and customer satisfaction.
- Translate analytical findings into actionable business recommendations.

---

## 🗂 Dataset

The project uses the **Olist Brazilian E-Commerce Public Dataset**, a real-world marketplace dataset containing approximately 100K orders from the Brazilian e-commerce platform Olist.

The dataset includes information about:

- Orders
- Customers
- Sellers
- Products
- Product Categories
- Payments
- Reviews
- Delivery
- Customer Geography
- Seller Geography
- Geolocation

---

## 🛠 Tools & Technologies

- **SQL**
- **SQLite**
- **Power BI**
- **DAX**
- **Excel**
- Common Table Expressions (CTEs)
- Window Functions
- Aggregate Functions
- Data Cleaning & Validation
- Business KPI Analysis
- Data Visualization

---

# 📊 Key Marketplace KPIs

| KPI | Value |
|---|---:|
| Total GMV | **$15.74M** |
| Total Orders | **~98K** |
| Total Customers | **~95K** |
| Total Sellers | **3,053** |
| Average Order Value | **~$160.24** |
| Average Delivery Time | **~12.5 Days** |
| Average Review Score | **~4.12 / 5** |

> KPIs are calculated using non-cancelled and non-unavailable orders, with order-level payment aggregation to avoid duplication.

---

# 📈 Power BI Dashboard

The SQL analysis was transformed into an interactive **Power BI dashboard** covering six analytical areas:

01. Executive Overview
02. Sellers' Performance
03. Product Category Performance
04. Geographical Performance
05. Customer Performance
06. Operational Performance

---

## 1️⃣ Executive Overview

The Executive Overview provides a high-level view of marketplace performance, including GMV, orders, customers, sellers, AOV, delivery time, and customer review trends.

![Executive Overview](Dashboard%20Screenshots/01.%20Executive%20Overview.png)

---

## 2️⃣ Seller Performance

This page analyzes seller revenue, seller segmentation, revenue concentration, seller productivity, and the distribution of marketplace GMV across sellers.

![Seller Performance](Dashboard%20Screenshots/02_Seller_Performance.png)

---

## 3️⃣ Product Category Performance

This page evaluates product categories based on GMV, orders, AOV, seller competition, customer reviews, and delivery performance.

![Product Category Performance](Dashboard%20Screenshots/03_Product_Category_Performance.png)

---

## 4️⃣ Geographical Performance

This page analyzes marketplace performance across Brazilian states and cities, including GMV, orders, customers, sellers, AOV, delivery time, and customer satisfaction.

![Geographical Performance](Dashboard%20Screenshots/04_Geographical_Performance.png)

---

## 5️⃣ Customer Performance

This page focuses on customer acquisition, new vs returning customers, purchase frequency, repeat purchasing, and cohort retention.

![Customer Performance](Dashboard%20Screenshots/05_Customer_Performance.png)

---

## 6️⃣ Operational & Customer Experience

This page analyzes delivery performance and its relationship with customer satisfaction, highlighting slow delivery segments and operational opportunities.

![Operational & Customer Experience](Dashboard%20Screenshots/06_Operational_Customer_Experience.png)

---

# 🔍 Analysis Performed

## 1. Executive & Sales Analysis

- Total GMV
- Total Orders
- Average Order Value (AOV)
- Monthly GMV Trend
- Monthly Order Trend
- Monthly Customer Growth
- Revenue Growth Analysis
- Customer Review Trends
- Delivery Performance Trends

---

## 2. Customer Analysis

- New vs Returning Customers
- Customer Purchase Frequency
- Repeat Purchase Rate
- Monthly Active Customers
- Customer Cohort Analysis
- Customer Retention
- Customer Lifetime Insights

The analysis uses `customer_unique_id` to represent unique customers and avoid treating multiple customer accounts as separate individuals.

---

## 3. Seller Analysis

- Monthly Active Sellers
- Seller Revenue
- Seller Order Volume
- Seller Segmentation
- Revenue Distribution
- Top Seller Contribution
- GMV Contribution by Seller
- Seller Productivity
- Revenue Concentration Analysis

---

## 4. Product Category Analysis

- Orders by Category
- GMV by Category
- AOV by Category
- GMV Contribution %
- Sellers per Category
- GMV per Seller
- Orders per Seller
- Customer Review Score
- Delivery Performance

---

## 5. Geographical Analysis

- GMV by State
- Orders by State
- Customers by State
- Sellers by State
- AOV by State
- GMV per Seller by State
- Delivery Performance by State
- Customer Satisfaction by State
- Top Cities by GMV

---

## 6. Operational & Customer Experience Analysis

- Delivery Time
- Delivery Time Distribution
- Delivery Buckets
- Late Delivery Analysis
- Average Delivery Time
- Review Score by Delivery Time
- Delivery Performance by Category
- Delivery Performance by Geography
- Relationship between Delivery Time and Customer Satisfaction

---

# 🔍 Key Business Insights

## 1. Customer Growth is Acquisition-Driven

The marketplace has a very large customer base, but repeat purchasing is relatively limited.

The customer purchase frequency analysis shows that the overwhelming majority of customers make only one purchase, indicating that marketplace growth is heavily dependent on **customer acquisition rather than repeat purchasing**.

### Business Implication

Improving the second-purchase conversion rate represents a significant opportunity to increase customer lifetime value and reduce dependency on continuous customer acquisition.

---

## 2. Seller Revenue is Highly Concentrated

Revenue is heavily concentrated among a relatively small group of sellers.

The **top 20% of sellers generate approximately 82% of total GMV**, while the median seller revenue is significantly lower than the average seller revenue.

### Business Implication

The marketplace has a strong dependency on high-performing sellers, creating both an opportunity and a concentration risk.

---

## 3. Revenue Distribution Across Sellers is Highly Skewed

The average seller GMV is approximately **$5.15K**, compared with a median of approximately **$1.01K**.

This large gap indicates a highly right-skewed seller revenue distribution, where a small number of sellers generate significantly more revenue than the majority.

### Business Implication

Seller development programs should focus on moving promising mid-tier sellers into higher-performing segments.

---

## 4. Product Categories Have Different Growth Profiles

Product categories vary significantly in:

- GMV
- AOV
- Seller competition
- Delivery performance
- Customer satisfaction

Some categories generate high GMV with relatively few sellers, while others have broader seller participation but lower revenue productivity.

### Business Implication

Category strategy should consider both **revenue potential and competitive intensity**, rather than focusing only on total sales.

---

## 5. Geographic Performance is Highly Concentrated

Marketplace GMV is concentrated in a limited number of Brazilian states, with **São Paulo representing the largest market by GMV**.

At the same time, delivery performance varies significantly across states.

### Business Implication

Geographic expansion and logistics investment should consider both market size and operational performance.

---

## 6. Delivery Performance is Linked to Customer Satisfaction

The analysis shows a relationship between longer delivery times and lower customer review scores.

Orders experiencing significantly longer delivery times tend to receive weaker customer ratings.

### Business Implication

Reducing severe delivery delays represents an important opportunity to improve customer experience and potentially support customer retention.

---

## 7. Growth Can Create Operational Pressure

During periods of strong customer and order growth, the marketplace also experienced pressure on:

- Average Order Value
- Delivery Time
- Customer Review Scores

This highlights the importance of maintaining operational quality while scaling customer acquisition.

> The dataset does not contain sufficient marketing or discount information to directly attribute changes in AOV to promotions or campaigns.

---

# 💡 Business Recommendations

## 1. Improve Customer Retention

Develop strategies focused on converting first-time buyers into repeat customers:

- Post-purchase engagement
- Personalized product recommendations
- Cross-selling
- Second-order incentives
- Win-back campaigns
- Category-based remarketing

The primary objective should be improving the **first-to-second purchase conversion rate**.

---

## 2. Develop Mid-Tier Sellers

Since marketplace GMV is highly concentrated among top sellers:

- Identify high-potential mid-tier sellers.
- Provide seller performance support.
- Encourage assortment expansion.
- Monitor seller productivity.
- Create programs to move mid-tier sellers into higher-performance segments.

This can help increase GMV while reducing dependency on a small group of sellers.

---

## 3. Prioritize Logistics Improvements

Focus operational improvements on:

- Orders taking more than 20 days.
- States with consistently high delivery times.
- Categories with poor delivery performance.
- Areas where long delivery times coincide with lower review scores.

Improving the worst-performing delivery segments is likely to have a greater impact than optimizing already fast deliveries.

---

## 4. Optimize Product Category Strategy

Use category-level performance to identify:

- High-GMV categories.
- High-AOV categories.
- High-GMV / low-competition opportunities.
- Categories with strong demand but limited seller participation.
- Categories suffering from poor delivery performance.

This can support more targeted seller acquisition and category investment decisions.

---

## 5. Balance Growth with Customer Experience

Rapid customer acquisition should be supported by sufficient:

- Seller capacity
- Logistics capacity
- Delivery performance
- Customer support
- Marketplace operational infrastructure

The objective is to avoid sacrificing customer experience while scaling marketplace volume.

---
