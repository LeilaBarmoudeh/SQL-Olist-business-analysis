-- Query 1: Total number of orders
SELECT COUNT(*) AS total_orders
FROM gold_fact_sales;

------ ########
-- Query 2: Number of unique customers who placed orders
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM gold_fact_sales;

-- Query 3: Order status distribution
SELECT
    order_status,
    COUNT(*) AS total_orders,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_orders
FROM gold_fact_sales
GROUP BY order_status
ORDER BY total_orders DESC;

-- Query 4: Monthly order volume trend
SELECT
    DATE_TRUNC('month', order_purchase_ts) AS order_month,
    COUNT(DISTINCT order_id) AS total_orders
FROM gold_fact_sales
GROUP BY order_month
ORDER BY order_month;

-- Query 5: Monthly revenue trend
SELECT
    DATE_TRUNC('month', order_purchase_ts) AS order_month,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(payment_value), 2) AS total_revenue,
    ROUND(AVG(payment_value), 2) AS avg_order_value
FROM gold_fact_sales
GROUP BY order_month
ORDER BY order_month;


-- Query 6: Late delivery rate
SELECT
    is_late_delivery,
    COUNT(*) AS total_orders,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_orders
FROM gold_fact_sales
WHERE order_status = 'delivered'
GROUP BY is_late_delivery
ORDER BY is_late_delivery;

----- ################
-- Query 7: Revenue by customer state
--- This identifies the most important customer geographies.
---This identifies the most important customer geographies.

SELECT
    c.customer_state,
    COUNT(DISTINCT s.order_id) AS total_orders,
    COUNT(DISTINCT s.customer_id) AS unique_customers,
    ROUND(SUM(s.payment_value), 2) AS total_revenue,
    ROUND(AVG(s.payment_value), 2) AS avg_order_value
FROM gold_fact_sales s
JOIN gold_dim_customers c
    ON s.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY total_revenue DESC;

----##############################
-- Query 8: Repeat customer rate
----- It calculates the percentage of customers who placed more than one order
------This is one of the most important customer behavior KPIs.
WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS total_orders
    FROM gold_fact_sales
    GROUP BY customer_id
)
SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN total_orders > 1 THEN 1 ELSE 0 END) AS repeat_customers,
    ROUND(
        100.0 * SUM(CASE WHEN total_orders > 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS repeat_customer_rate_pct
FROM customer_orders;


SELECT
    customer_id,
    COUNT(*) AS orders_per_customer
FROM gold_fact_sales
GROUP BY customer_id
ORDER BY orders_per_customer DESC
LIMIT 10;

------ One more check
WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT s.order_id) AS total_orders
    FROM gold_fact_sales s
    JOIN gold_dim_customers c
        ON s.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
)
SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN total_orders > 1 THEN 1 ELSE 0 END) AS repeat_customers,
    ROUND(
        100.0 * SUM(CASE WHEN total_orders > 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS repeat_customer_rate_pct
FROM customer_orders;

------ One more check
SELECT
    c.customer_unique_id,
    COUNT(DISTINCT s.order_id) AS orders_per_customer
FROM gold_fact_sales s
JOIN gold_dim_customers c
    ON s.customer_id = c.customer_id
GROUP BY c.customer_unique_id
ORDER BY orders_per_customer DESC
LIMIT 20;