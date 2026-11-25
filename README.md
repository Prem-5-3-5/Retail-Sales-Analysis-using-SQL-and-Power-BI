# Retail Sales Analysis using SQL and Power BI

## Project Overview

This project focuses on analyzing retail sales data using MySQL and Microsoft Power BI.

The objective is to explore sales performance, identify top-performing products and customers, analyze category-wise sales, and extract meaningful business insights from retail data.

SQL was used for data exploration, data quality checks, and business analysis, while Power BI was used to visualize product sales and create a sales analysis dashboard.

## Tools & Technologies

- MySQL
- Microsoft Power BI
- SQL
- CSV Dataset

## Key Analysis

### 1. Data Exploration
- Examined the retail sales dataset.
- Analyzed orders, customers, products, and cities.
- Explored the structure and contents of the dataset.

### 2. Data Quality Checks
- Checked for missing and blank values.
- Identified zero or negative sales values.
- Checked for duplicate order-product records.

### 3. Business Analysis
- Calculated total sales, total orders, and total customers.
- Calculated average order value.
- Analyzed sales by product category.
- Identified the top 10 cities by sales.
- Ranked the top 10 customers by sales.
- Calculated the sales contribution of the top 10 customers.
- Analyzed yearly sales and year-over-year growth.
- Identified the top 10 products by sales.
- Ranked the top 3 products within each category.

## SQL Concepts Used

- SELECT statements
- Aggregate functions
- GROUP BY and ORDER BY
- Subqueries
- Common Table Expressions (CTEs)
- Window functions
- RANK()
- ROW_NUMBER()
- LAG()
- Data quality checks

## Power BI Dashboard

The Power BI dashboard visualizes product sales performance and helps compare the sales contribution of different products.

### Dashboard Preview

![Retail Sales Dashboard](dashboard.png)

## Project Files

| File | Description |
|---|---|
| `retail_analysis.sql` | SQL queries for data exploration and business analysis |
| `retails analysis bi.csv` | Exported analysis results |
| `dashboard.png` | Power BI dashboard screenshot |
| `retail_sales_dashboard.pbix` | Power BI dashboard file |

## How to Run the Project

1. Install MySQL and Microsoft Power BI Desktop.
2. Import the retail sales dataset into MySQL.
3. Create or select the `retail_project` database.
4. Import the dataset into a table named `superstore`.
5. Open `retail_analysis.sql` in MySQL Workbench.
6. Execute the SQL queries to perform the analysis.
7. Open the Power BI `.pbix` file to explore the dashboard.

## Learning Outcomes

- Improved SQL querying and data analysis skills.
- Practiced data exploration and data quality checks.
- Learned to use SQL window functions for ranking and trend analysis.
- Developed data visualization skills using Power BI.
- Gained experience in converting raw sales data into business insights.



