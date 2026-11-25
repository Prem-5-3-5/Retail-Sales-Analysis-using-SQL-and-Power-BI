
-- Retail Sales Analysis (Superstore) - MySQL

CREATE DATABASE IF NOT EXISTS retail_project;
USE retail_project;


-- 1. DATA EXPLORATION


-- Row count 
SELECT COUNT(*) AS total_rows FROM superstore;

-- Preview the data
SELECT * FROM superstore LIMIT 10;

-- Size of the dataset: orders, customers, products, cities
SELECT
    COUNT(DISTINCT `Order ID`)      AS total_orders,
    COUNT(DISTINCT `Customer Name`) AS total_customers,
    COUNT(DISTINCT `Product Name`)  AS total_products,
    COUNT(DISTINCT City)            AS total_cities
FROM superstore;


-- 2. DATA CLEANING CHECKS


-- 2.1 NULL / blank values in each column
SELECT
    SUM(`Order ID` IS NULL OR `Order ID` = '')           AS null_order_id,
    SUM(`Customer Name` IS NULL OR `Customer Name` = '') AS null_customer,
    SUM(City IS NULL OR City = '')                       AS null_city,
    SUM(Category IS NULL OR Category = '')               AS null_category,
    SUM(`Product Name` IS NULL OR `Product Name` = '')   AS null_product,
    SUM(Sales IS NULL)                                   AS null_sales
FROM superstore;

-- 2.2 Zero or negative sales
SELECT COUNT(*) AS invalid_sales_rows
FROM superstore
WHERE Sales <= 0;

-- 2.3 Duplicate rows (same order, same product, same sales amount)
SELECT `Order ID`, `Product Name`, Sales, COUNT(*) AS times_repeated
FROM superstore
GROUP BY `Order ID`, `Product Name`, Sales
HAVING COUNT(*) > 1;


-- 3. BUSINESS ANALYSIS

-- Q1. Overall KPIs: total sales, orders, customers, average order value
SELECT
    ROUND(SUM(Sales), 2)                          AS total_sales,
    COUNT(DISTINCT `Order ID`)                    AS total_orders,
    COUNT(DISTINCT `Customer Name`)               AS total_customers,
    ROUND(SUM(Sales) / COUNT(DISTINCT `Order ID`), 2) AS avg_order_value
FROM superstore;

-- Q2. Sales by category, with each category's share of total sales
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Sales) * 100.0 / (SELECT SUM(Sales) FROM superstore), 1) AS pct_of_total
FROM superstore
GROUP BY Category
ORDER BY total_sales DESC;

-- Q3. Top 10 cities by sales
SELECT
    City,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Sales) * 100.0 / (SELECT SUM(Sales) FROM superstore), 1) AS pct_of_total
FROM superstore
GROUP BY City
ORDER BY total_sales DESC
LIMIT 10;

-- Q4. Top 10 customers by sales, ranked with a window function
SELECT
    `Customer Name`,
    ROUND(SUM(Sales), 2) AS total_sales,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS rnk
FROM superstore
GROUP BY `Customer Name`
ORDER BY total_sales DESC
LIMIT 10;

-- Q5. How much of total sales do the top 10 customers bring?
SELECT
    ROUND(SUM(total_sales), 2) AS top10_sales,
    ROUND(SUM(total_sales) * 100.0 / (SELECT SUM(Sales) FROM superstore), 1) AS pct_of_total
FROM (
    SELECT SUM(Sales) AS total_sales
    FROM superstore
    GROUP BY `Customer Name`
    ORDER BY total_sales DESC
    LIMIT 10
) AS top_customers;

-- Q6. Yearly sales with year-over-year growth (year is in the Order ID,
--     e.g. CA-2017-152156 -> 2017)
WITH yearly AS (
    SELECT
        SUBSTRING(`Order ID`, 4, 4) AS order_year,
        SUM(Sales) AS total_sales
    FROM superstore
    GROUP BY SUBSTRING(`Order ID`, 4, 4)
)
SELECT
    order_year,
    ROUND(total_sales, 2) AS total_sales,
    ROUND((total_sales - LAG(total_sales) OVER (ORDER BY order_year))
          * 100.0 / LAG(total_sales) OVER (ORDER BY order_year), 1) AS yoy_growth_pct
FROM yearly
ORDER BY order_year;

-- Q7. Top 10 products by sales
SELECT
    `Product Name`,
    Category,
    ROUND(SUM(Sales), 2) AS total_sales
FROM superstore
GROUP BY `Product Name`, Category
ORDER BY total_sales DESC
LIMIT 10;

-- Q8. Top 3 products in each category (ROW_NUMBER + PARTITION BY)
SELECT Category, `Product Name`, total_sales, rank_in_category
FROM (
    SELECT
        Category,
        `Product Name`,
        ROUND(SUM(Sales), 2) AS total_sales,
        ROW_NUMBER() OVER (PARTITION BY Category ORDER BY SUM(Sales) DESC) AS rank_in_category
    FROM superstore
    GROUP BY Category, `Product Name`
) AS ranked
WHERE rank_in_category <= 3
ORDER BY Category, rank_in_category;
