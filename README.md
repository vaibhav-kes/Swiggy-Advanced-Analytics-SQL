# 🍽️ Swiggy Data Analysis — Advanced SQL Window Functions

## 📌 Project Overview

This repository showcases an **advanced SQL analysis** performed on a Swiggy restaurant dataset. The project evolves from exploratory queries to sophisticated business logic with a strong emphasis on **Window Functions** and **Common Table Expressions (CTEs)**. The goal is to simulate real-world analytics tasks such as ranking competition, estimating revenue impact, and understanding concentration effects across cities and cuisines.

The analysis is designed to be **recruiter-ready**, readable, and extensible for BI tools or further modeling.

---

## 🚀 Key Features & SQL Techniques

### 🥇 Ranking & Competition Analysis

* Used `RANK()`, `DENSE_RANK()`, and `ROW_NUMBER()`
* Identified top-performing restaurants by cost, popularity, and estimated revenue

### 🌍 Geographic & Cuisine Segmentation

* Applied `PARTITION BY` to generate city-level and cuisine-level insights
* Enabled fair comparisons within localized markets

### 💰 Revenue Modeling

* Designed a **Revenue Proxy** metric (derived from price and popularity signals)
* Used as a scalable estimate for restaurant performance where actual revenue is unavailable

### 📊 Business Intelligence (Pareto / 80–20 Rule)

* Implemented cumulative revenue logic using window aggregates
* Tested whether a small percentage of restaurants dominate overall platform revenue

---

## 📂 Repository Structure

* `Swiggy Analysis` — Core SQL script containing:

  * Exploratory queries
  * Ranking logic
  * Partitioned analysis (city & cuisine)
  * Revenue proxy calculations
  * Pareto (80/20) analysis

---

## 📈 Sample Business Questions Answered

1. **Market Leaders:** Who are the top 5 restaurants per city by estimated revenue?
2. **Cuisine Profitability:** Which cuisines dominate revenue among their top performers?
3. **Revenue Concentration:** Do the top 1% or top 20% of restaurants generate the majority of revenue?
4. **Competitive Positioning:** How do restaurants rank within the same city and cuisine category?

---

## 🛠️ Tech Stack

* **Language:** SQL (Standard SQL)
* **Database:** MySQL / PostgreSQL compatible
* **Tools:** MySQL Workbench, DBeaver, Command Line SQL
* **Analysis Type:** Exploratory Data Analysis (EDA) + Business Analytics

---

## ▶️ How to Run

1. Create or select a database named `swiggy`
2. Import the `restaurants` dataset (CSV or table)
3. Open and execute `Swiggy Analysis` sequentially
4. Review result sets for insights and rankings

---

## 💡 Key Learnings

* Window functions enable **advanced analytics without complex joins**
* Partitioned ranking provides more realistic competitive insights
* Revenue proxies are useful when direct financial data is unavailable
* Pareto analysis is powerful for identifying platform dependency risks

---

## 📌 Future Enhancements

* Add **JOIN-based analysis** (orders, customers, delivery data)
* Refine the **Revenue Proxy** using discounts and order frequency
* Connect results to **Power BI / Tableau** dashboards
* Convert insights into **stored procedures or views**

---

## 👤 Author

**Vaibhav Kesarwani**
Data Analytics Professional

📧 Email: [vaibhavkesa77@gmail.com](mailto:vaibhavkesa77@gmail.com)
💼 LinkedIn: [https://www.linkedin.com/in/vaibhav-kesarwani-b73750293](https://www.linkedin.com/in/vaibhav-kesarwani-b73750293)

---
