# 📊 Retail Business Performance Dashboard

### Enterprise Business Intelligence & Commercial Analytics Suite

> **Interactive Business Intelligence Dashboard analyzing 9,900+ retail transaction records using Microsoft Power BI (DAX), SQL Extraction, and Advanced MS Excel Modeling.**

[![Power BI](https://img.shields.io/badge/Power%20BI-DAX%20%26%20Data%20Modeling-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)](#)
[![SQL](https://img.shields.io/badge/SQL-Advanced%20ETL%20%26%20Window%20Functions-CC2B2B?style=for-the-badge&logo=sqlite&logoColor=white)](#)
[![MS Excel](https://img.shields.io/badge/MS%20Excel-Formulas%20%26%20KPI%20Scorecard-107C41?style=for-the-badge&logo=microsoftexcel&logoColor=white)](#)
[![Records](https://img.shields.io/badge/Dataset-9%2C900%2B%20Transactions-6366F1?style=for-the-badge)](#)

---

## 📌 Project Overview

This project delivers an enterprise-grade commercial analytics solution for a multi-category omnichannel retail business. By analyzing **9,900+ multi-year customer orders**, the suite evaluates revenue drivers, regional market penetration, category profit margins, and discount-induced margin erosion.

### Key Objectives:
1. **Revenue & Margin Transparency:** Track overall sales revenue, net profit margins, and average order value (AOV) across segments.
2. **Regional Performance Attribution:** Evaluate regional sales distribution across West, East, Central, and South territories.
3. **Product Profitability & Leakage Detection:** Pinpoint categories where high discount rates (>40%) cause negative margins and profit leakages.
4. **Data Modeling & BI Governance:** Transform raw transaction tables into clean star-schema analytical models with custom DAX time-intelligence calculations.

---

## 🏗️ Technical Pipeline & Data Architecture

```
  ┌──────────────────────────────────────────────────────────────┐
  │  1. SQL Data Extraction & Transformation                     │
  │  - Window functions (LAG, MoM revenue growth)               │
  │  - Multi-table aggregations, regional contribution breakdown │
  └──────────────────────────────┬───────────────────────────────┘
                                 │
                                 ▼
  ┌──────────────────────────────────────────────────────────────┐
  │  2. Power Query Data Modeling (Star Schema)                  │
  │  - Dimension tables: Customers, Calendar, Geography, Products│
  │  - Fact table: Retail_Transactions (9,900+ rows)             │
  │  - Handled data types, date formatting, and missing keys    │
  └──────────────────────────────┬───────────────────────────────┘
                                 │
                                 ▼
  ┌──────────────────────────────────────────────────────────────┐
  │  3. Custom DAX Measures & Business Logic                     │
  │  - Total Sales, Total Profit, Profit Margin %                │
  │  - Time Intelligence (SAMEPERIODLASTYEAR, YoY Growth %)      │
  │  - Dynamic formatting & profit status indicators             │
  └──────────────────────────────┬───────────────────────────────┘
                                 │
                                 ▼
  ┌──────────────────────────────────────────────────────────────┐
  │  4. Executive BI Dashboard & Slicers                         │
  │  - Dynamic KPI summary tiles (Revenue, Margin, Orders)       │
  │  - Interactive slicers: Region, Category, Customer Segment   │
  │  - Category vs Margin Scatter & Regional contribution maps   │
  └──────────────────────────────────────────────────────────────┘
```

---

## 📈 Key Business Performance Highlights

| Metric | Result | Commercial Significance |
|---|---|---|
| **Total Transactions Analyzed** | **9,994 Orders** | Comprehensive multi-year omnichannel dataset |
| **Total Gross Revenue** | **$11.50M** | High-volume cross-category commercial sales |
| **Total Realized Profit** | **$1.06M** | Net operating bottom-line profit |
| **Overall Profit Margin** | **9.26%** | Healthy aggregate profit margin across 3 departments |
| **Top Performing Category** | **Technology (Phones & Copiers)** | Consistently generates >30% profit margins |
| **Margin Erosion Alert** | **Furniture (Tables & Bookcases)** | Heavy discounting (>30%) causes margin erosion into negative returns |

---

## 💻 SQL Analytical Queries Included (`Retail_Analytics_SQL_Queries.sql`)

The repository includes modular, production-ready SQL scripts:
- **Query 1:** Executive Summary KPIs (`COUNT DISTINCT`, `SUM`, `AVG`).
- **Query 2:** Regional Sales Contribution & Market Share calculation using subqueries.
- **Query 3:** Category & Sub-Category profit rankings.
- **Query 4:** Deep-dive into Discount brackets (0%, 1-20%, 21-40%, >40%) to quantify profit leakages.
- **Query 5:** Month-over-Month (MoM) revenue growth using `LAG()` window functions.

---

## 📐 Custom DAX Measures Catalog (`Retail_DAX_Measures.dax`)

```dax
// 1. Total Sales Revenue
Total Sales = SUM(Retail_Transactions[Sales])

// 2. Total Profit
Total Profit = SUM(Retail_Transactions[Profit])

// 3. Profit Margin %
Profit Margin % = DIVIDE([Total Profit], [Total Sales], 0)

// 4. YoY Sales Growth %
YoY Sales Growth % = 
VAR SalesGrowth = [Total Sales] - CALCULATE([Total Sales], SAMEPERIODLASTYEAR('Calendar'[Date]))
RETURN
DIVIDE(SalesGrowth, CALCULATE([Total Sales], SAMEPERIODLASTYEAR('Calendar'[Date])), 0)

// 5. Dynamic Profit Status
Profit Status = 
IF([Profit Margin %] >= 0.15, "High Margin (>15%)", 
   IF([Profit Margin %] >= 0, "Healthy Margin (0-15%)", "Unprofitable / Leakage"))
```

---

## 📁 Repository Structure

```
├── Retail_Business_Performance_Analysis.xlsx   # 2-Sheet Excel workbook with formulas & KPI scorecard
├── Retail_Superstore_Transactions.csv          # Clean dataset with 9,994 transaction rows
├── Retail_Analytics_SQL_Queries.sql            # 6 Production-grade SQL analytical queries
├── Retail_DAX_Measures.dax                     # 11 Custom DAX measures for Power BI
└── README.md                                   # Comprehensive portfolio documentation
```

---

## 🛠️ Competencies & Tools Demonstrated

- **Business Intelligence:** Microsoft Power BI (Data Modeling, DAX, KPI Tiles, Interactive Slicers)
- **Database Querying:** Advanced SQL (CTEs, Window Functions, Group By Aggregations, Subqueries)
- **Spreadsheet Modeling:** MS Excel (Dynamic Formulas, Data Cleansing, Financial Formatting)
- **Commercial Acumen:** Profit Margin Optimization, Discount Leakage Detection, Omnichannel Retail Dynamics

---

## 📬 Contact & Portfolio

- **Ajay Saini**  
- **Email:** [ajayysaiini@gmail.com](mailto:ajayysaiini@gmail.com)  
- **GitHub:** [github.com/ajayysainii](https://github.com/ajayysainii)
