  <div align="center">

# 🔗 Supply Chain Analytics — End-to-End Business Intelligence System

### *Turned raw supply chain data into executive-ready decisions — 29 SQL-engineered KPIs tracking $194M revenue, 66% OTD rate, and supplier performance across 3 BI platforms.*

<br>

[![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Power BI](https://img.shields.io/badge/Power%20BI-Live%20Dashboard-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)](https://app.powerbi.com/groups/414e2d19-0c5e-4b91-9ae3-42245edd8581/reports/bd107a39-d967-4964-8592-6d2e4faf3705/02a6f13eb5cfc514fb0d?experience=power-bi)
[![Tableau](https://img.shields.io/badge/Tableau-Live%20Dashboard-E97627?style=for-the-badge&logo=tableau&logoColor=white)](https://public.tableau.com/app/profile/bibha.kumari/viz/sales_analytics_17807314646940/SummaryDashboard)
[![Excel](https://img.shields.io/badge/Microsoft%20Excel-Dashboard-217346?style=for-the-badge&logo=microsoftexcel&logoColor=white)](.)

<br>

| 📅 Data Period | 🌍 Regions | 📦 Orders | 💰 Revenue | 🏭 Suppliers | 🚚 Ship Modes |
|:---:|:---:|:---:|:---:|:---:|:---:|
| Jan 2023 – Dec 2024 | 5 Global | 12,000+ | $193.99M | 10+ | 5 |

</div>

---

## 📌 Table of Contents

- [Live Dashboards](#-live-dashboards)
- [The Business Problem](#-the-business-problem)
- [What This Project Demonstrates](#-what-this-project-demonstrates)
- [Tech Stack](#-tech-stack)
- [Data Architecture](#-data-architecture--why-star-schema)
- [SQL Views & KPI Engineering](#-sql-views--kpi-engineering)
- [Dashboards](#-dashboards)
- [Key Insights & Recommended Actions](#-key-insights--recommended-actions)
- [Contact](#-contact)

---

## 🔴 Live Dashboards

> **Fully interactive — click, filter, and explore the data yourself. No login required.**

<div align="center">

| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Platform &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; What You Can Explore &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
|:---:|:---|:---:|
| 📊 **Power BI** | Filter by Year, Region, Carrier, Product & Category — cross-filtering across all visuals simultaneously | [**🔴 Open Live**](https://app.powerbi.com/groups/414e2d19-0c5e-4b91-9ae3-42245edd8581/reports/bd107a39-d967-4964-8592-6d2e4faf3705/02a6f13eb5cfc514fb0d?experience=power-bi) |
| 📈 **Tableau** | Switch between Summary Dashboard, Performance Dashboard, Revenue Map, Top Products & more | [**🔴 Open Live**](https://public.tableau.com/app/profile/bibha.kumari/viz/sales_analytics_17807314646940/SummaryDashboard) |

</div>

---

## 🔴 The Business Problem

Supply chain teams operating at scale **drown in data but starve for decisions.** Without a unified view across sales, inventory, logistics, and supplier performance, operations leaders face three recurring failures:


> ❌ **Late deliveries go unattributed** — no one knows whether the delay is the carrier, the supplier, or the warehouse
>
> ❌ **Revenue looks healthy on the surface** — while gross margin erodes quietly through shipping cost and COGS inefficiencies

**This project was built to solve exactly that** — one connected analytics system, from raw MySQL data modeling to interactive executive dashboards, that makes every layer of supply chain performance visible and actionable.

---

## 💡 What This Project Demonstrates

| Skill Area | Evidence in This Project |
|:---|:---|
| 🗄️ **Data Modeling** | Star schema with 2 fact tables and 5 dimension tables — deliberate design, not accidental structure |
| 🔧 **SQL Engineering** | 29 production-ready views with dynamic K/M/B auto-formatting and window functions (`LAG`, `NULLIF`) |
| 📐 **Business KPI Design** | Perfect Order Rate, Days Inventory on Hand, Fill Rate, Supplier OTD — not just counts and sums |
| 📊 **Multi-Tool BI Delivery** | Same data model delivered across Excel, Power BI, and Tableau for different stakeholder audiences |
| 🧠 **Analytical Thinking** | Every insight includes root cause analysis and a concrete recommended business action |

---

## 🛠️ Tech Stack

| Tool | Role in This Project |
|:---|:---|
| **MySQL** | Database design, star schema modeling, 29 reusable analytical KPI views |
| **Microsoft Excel** | Operational dashboard with slicers for regional managers and sales teams |
| **Power BI** | Enterprise dashboard for cross-functional leadership with full cross-filtering |
| **Tableau Public** | Executive summary and performance drill-down with geographic map visualization |

---

## 🗄️ Data Architecture — Why Star Schema?

The data model follows a **Star Schema** — a deliberate choice over a normalized 3NF model for three concrete reasons:

1. 🚀 **Query performance** — Analytical queries run faster with denormalized dimension joins, critical for dashboard responsiveness
2. 🔌 **Native BI compatibility** — Power BI and Tableau both optimize for star schema relationships natively
3. ♻️ **Reusability** — A single `Fact_Orders` table powers sales, logistics, supplier, and cost analysis without redundant data pipelines

```
Fact_Orders       ← Revenue, COGS, delivery dates, shipping cost, order quantity
Fact_Inventory    ← Stock on hand, reorder levels by product and warehouse

Dim_Product       ← Name, category, sub-category, unit cost
Dim_Customer      ← Segment, region, country, city
Dim_Supplier      ← Name, tier, reliability score
Dim_Warehouse     ← Location, capacity units
```

---

## 🔧 SQL Views & KPI Engineering

> **29 reusable views** built to serve all three dashboards from a **single source of truth.**
> Every monetary value dynamically auto-formats to K / M / B.
> Window functions (`LAG`, `NULLIF`) handle MoM growth and division-by-zero safety throughout.

<details>
<summary><b>💰 Sales & Revenue — 10 Views</b></summary>

<br>

| View | Business Question Answered |
|:---|:---|
| `vw_total_orders` | How many orders did we process? |
| `vw_total_sales_revenue` | What is our total revenue? |
| `vw_average_order_value` | How much does a typical order generate? |
| `vw_sales_by_product_category` | Which products and categories drive the most revenue? |
| `vw_orders_by_region` | Where are our customers and how much do they spend? |
| `vw_monthly_sales_trend` | Is revenue growing month over month? |
| `vw_daily_sales_trend` | Are there daily patterns we can operationalize? |
| `vw_sales_growth` | What is our MoM growth rate? *(uses `LAG` window function)* |
| `vw_top_5_products` | What are our highest-revenue products? |
| `vw_top_customers` | Who are our most valuable customers by segment? |

</details>

<details>
<summary><b>📦 Inventory Management — 6 Views</b></summary>

<br>

| View | Business Question Answered |
|:---|:---|
| `vw_stock_on_hand` | How much stock do we have per product and warehouse? |
| `vw_inventory_value` | What is our total capital tied up in inventory? |
| `vw_inventory_turnover` | How efficiently are we converting inventory to sales? |
| `vw_days_inventory_on_hand` | How many days can we operate before restocking? |
| `vw_reorder_status` | Which products need immediate reordering? |
| `vw_warehouse_utilization` | Are our warehouses under or over capacity? |

</details>

<details>
<summary><b>🚚 Logistics & Fulfillment — 9 Views</b></summary>

<br>

| View | Business Question Answered |
|:---|:---|
| `vw_on_time_delivery` | What % of orders arrive by the promised date? |
| `vw_avg_delivery_lead_time` | How long does it take from order to delivery on average? |
| `vw_average_delay_days` | When orders are late, how late are they? |
| `vw_orders_by_ship_mode` | Which shipping modes are used most and generate the most revenue? |
| `vw_freight_cost_per_order` | What is our average shipping cost per order? |
| `vw_order_cycle_time` | How long is our full order cycle? |
| `vw_fill_rate` | What % of ordered quantity actually ships? |
| `vw_backorder_rate` | How often do we partially fulfill orders? |
| `vw_perfect_order_rate` | What % of orders are on-time AND fully shipped? |

</details>

<details>
<summary><b>🏭 Supplier & Cost Analysis — 4 Views</b></summary>

<br>

| View | Business Question Answered |
|:---|:---|
| `vw_supplier_performance` | Which suppliers deliver the most value with the least delay? |
| `vw_supplier_otd` | What is each supplier's on-time delivery rate? |
| `vw_spend_by_supplier` | How much of our COGS is concentrated with each supplier? |
| `vw_cost_to_serve_customer` | What does it actually cost to serve each customer segment? |

</details>

---

## 📊 Dashboards

---

### 📗 Excel — Operational Dashboard
> *Built for regional managers and sales teams who need fast answers with familiar tooling*

**Filters:** `Ship Mode` · `Customer Segment` · `Customer Region` · `Product Category`

**Headline KPIs:** Total Sales **194.0M** · Sales Growth **4.93%** · YTD **100.9M** · QTD **25.8M** · MTD **9.3M**

![Excel Dashboard](https://github.com/bbhakumari123/Supply-Chain-Analytics/blob/2571f89481c8fd0484207481635079087fd89746/Supply_Chain_Analysis/Screenshot/Excel_Dashboard.png)

---

### 📘 Power BI — Enterprise Analytics Dashboard
> *Built for cross-functional leadership needing a single version of the truth with full cross-filtering*

**Filters:** `Year` · `Ship Mode` · `Carrier` · `Region` · `Product` · `Category`

| Total Revenue | Total Orders | Total Cost | Total Inventory | Shipping Cost |
|:---:|:---:|:---:|:---:|:---:|
| **$193.99M** | **12K** | **$125.45M** | **9M units** | **$1.62M** |

![Power BI Dashboard](https://github.com/bbhakumari123/Supply-Chain-Analytics/blob/94f2d8a2c1be509e27987574e0857c0759db3db1/Supply_Chain_Analysis/Screenshot/Power_bi_dashboard.png)

<div align="center">

[**🔴 → Interact with the Live Power BI Dashboard**](https://app.powerbi.com/groups/414e2d19-0c5e-4b91-9ae3-42245edd8581/reports/bd107a39-d967-4964-8592-6d2e4faf3705/02a6f13eb5cfc514fb0d?experience=power-bi)

</div>

---

### 📙 Tableau — Summary Dashboard
> *For executives who need the 30-second story with global geographic context*

| Total Revenue | Total Orders | Gross Profit | Delayed Order % | On-Time Delivery % | Avg Delay | Fill Rate |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **$193.99M** | **12K** | **$70.16M** | **0.34%** | **66.03%** | **4 days** | **96.78%** |

![Tableau Summary Dashboard](https://github.com/bbhakumari123/Supply-Chain-Analytics/blob/968b4c2fa1ee93193e1e26493938b62252d88a4f/Supply_Chain_Analysis/Screenshot/Tableau_dashboard.png)

---

### 📙 Tableau — Performance Dashboard
> *For operations managers doing root cause analysis across delivery, profitability, and product*

**Visuals:** Delivery Status by Month · Gross Profit by Order · Revenue by Category (treemap) · Top 10 Products by Revenue

![Tableau Performance Dashboard](https://github.com/bbhakumari123/Supply-Chain-Analytics/blob/d8019d6d878bc130d58e2b3ea7b51b6884fe7603/Supply_Chain_Analysis/Screenshot/Tableau_dashboard2.png)

<div align="center">

[**🔴 → Interact with the Live Tableau Dashboard**](https://public.tableau.com/app/profile/bibha.kumari/viz/sales_analytics_17807314646940/SummaryDashboard)

</div>

---

## 🔍 Key Insights & Recommended Actions

> These are not observations — they are **findings with a recommended next step.**

---

**1. 🚨 On-time delivery at 66.03% is critically below the 80% industry benchmark**

The 14-point gap represents roughly **4,000+ late orders annually.** Root cause points directly to carrier performance — DHL (482 delays), FedEx (465), and Local Courier (450) account for the majority of late shipments.

> ✅ **Recommended Action:** Renegotiate SLAs with DHL and FedEx or redistribute shipment volume to better-performing carriers. Even a 5% shift reduces late orders by ~200 annually.

---

**2. ⚡ Electronics is the revenue engine — and the biggest concentration risk**

Laptops ($101.30M) and Smartphones ($29.73M) represent **68% of total revenue.** Gaming Laptop Deluxe alone generates $40.27M — a single SKU driving 20%+ of business.

> ✅ **Recommended Action:** Prioritize safety stock and supplier redundancy for top Electronics SKUs. A stockout in this category is a material revenue event, not an operational inconvenience.

---

**3. 🌏 Asia leads at 36.57% but North America and Europe are significantly underperforming**

North America (24.2%) and Europe (21.65%) trail Asia by 12–15 points despite being high-purchasing-power markets. São Paulo (23M) and Singapore (14M) are the top individual cities.

> ✅ **Recommended Action:** Investigate whether logistics cost, delivery lead time, or product availability is suppressing western market revenue — these regions should outperform their current share.

---

**4. 📦 Fill rate at 96.78% is strong — but that 3.22% gap means ~400 unfulfilled order lines**

With 12K total orders, a 3.22% backorder rate has real customer impact at scale.

> ✅ **Recommended Action:** Map backorders to specific SKUs and warehouses to determine whether root cause is demand forecasting error or reorder threshold misconfiguration.

---

**5. ✈️ Road dominates at 38.69% but Air carries disproportionate cost ($0.74M)**

Air accounts for 30.03% of orders but costs nearly double Road per shipment.

> ✅ **Recommended Action:** Audit which product categories and regions trigger air shipping. Shifting even 10% of air volume to road or rail reduces freight cost meaningfully at this revenue scale.

---

**6. 🏭 Apex Global leads supplier spend at $27M — a single-supplier concentration risk**

High spend concentration with one supplier creates supply chain fragility. A disruption at Apex Global puts $27M of pipeline at risk.

> ✅ **Recommended Action:** Build a secondary supplier qualification process for top-5 spend suppliers. Dual-sourcing even 20% of Apex Global volume creates meaningful resilience.

---





---
<div align="center">

*⭐ If this project helped you, consider giving it a star — it helps others find it too.*

`MySQL` · `Power BI` · `Tableau` · `Excel` · `Supply Chain Analytics` · `Business Intelligence` · `Star Schema` · `KPI Engineering`

</div>
