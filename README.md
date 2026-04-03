# SQL-Olist-business-analysis
SQL-based business analysis of Olist e-commerce data using DuckDB, covering sales, sellers, products, and delivery performance insights.

## Project Overview
This project analyzes the Brazilian E-Commerce Public Dataset by Olist using SQL in DuckDB. The goal is to simulate a real-world business analytics case by examining marketplace performance across customers, sellers, product categories, and delivery operations.
The analysis was built on cleaned gold-layer tables and focuses on answering business questions related to revenue generation, seller performance, customer geography, product demand, and delivery reliability.

## Business Questions
This project answers questions such as:
- How many orders and customers are in the dataset?
- How does revenue vary across customer states?
- Which sellers generate the most revenue?
- Which seller states dominate marketplace supply?
- Which product categories drive the most revenue?
- What is the late delivery rate?
- Which customer states experience the highest late delivery rates?
- Are delivery issues driven more by geography or by specific sellers?
- Which sellers demonstrate the best and worst delivery performance?

## Tools Used
- SQL
- DuckDB
- DBeaver
- GitHub

## Dataset
The project uses cleaned gold-layer tables:

### Dimension Tables
- `gold_dim_customers`
- `gold_dim_sellers`
- `gold_dim_product`

### Fact Tables
- `gold_fact_sales`
- `gold_fact_sales_items`

## Data Model Notes
- `gold_fact_sales` was used for order-level analysis such as total orders, revenue trends, and late delivery rate.
- `gold_fact_sales_items` was used for item-level analysis such as seller performance and product/category performance.
- `customer_unique_id` was investigated for retention analysis, but the sampled dataset did not support meaningful repeat-purchase analysis.

## Key Findings
- São Paulo (SP) dominates both demand and seller supply in the marketplace.
- Revenue is distributed across multiple sellers, but seller performance varies significantly.
- Product demand is diversified, with home-related categories such as `cama_mesa_banho` driving strong revenue.
- The overall late delivery rate is about 8%, indicating generally acceptable delivery performance.
- Delivery issues appear to be driven more by specific underperforming sellers than by broad regional problems.
- Some sellers maintain extremely low delay rates even at high order volume, showing that strong operational performance is achievable.

## Delivery Performance Insights
- Approximately 92% of delivered orders arrived on time.
- Around 8% of delivered orders were late.
- Among major customer states, late delivery rates ranged from about 4% to 10%.
- Rio de Janeiro (RJ) showed the highest delay rate among major states in the filtered analysis.
- Seller-level analysis revealed much larger performance gaps than state-level analysis, with some sellers exceeding 25% to 35% late delivery rates.

## Recommendations
- Investigate underperforming sellers with consistently high late delivery rates.
- Use top-performing sellers as operational benchmarks for fulfillment quality.
- Prioritize delivery improvements in high-volume states such as São Paulo and Rio de Janeiro.
- Continue expanding strong product categories while monitoring category-level pricing and demand patterns.
- Improve seller performance monitoring using delivery KPIs, not just revenue KPIs.

## Project Structure
```text
olist-marketplace-sql-analysis/
│
├── README.md
├── data_dictionary.md
├── project_overview.md
│
├── sql/
│   ├── 00_setup_views.sql
│   ├── 01_foundation_queries.sql
│   ├── 02_customer_analysis.sql
│   ├── 03_seller_analysis.sql
│   ├── 04_product_analysis.sql
│   ├── 05_delivery_analysis.sql
│   ├── 06_advanced_delivery_analysis.sql
│
├── insights/
│   ├── executive_summary.md
│   ├── key_findings.md
│   ├── recommendations.md
│
└── images/
