-- Late delivery analysis
SELECT
    is_late_delivery,
    COUNT(*) AS total_orders,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_orders
FROM gold_fact_sales
WHERE order_status = 'delivered'
GROUP BY is_late_delivery;


---- Which regions have:
---worst delivery performance
---potential logistics issues

SELECT
    c.customer_state,
    COUNT(*) AS total_orders,
    SUM(is_late_delivery) AS late_orders,
    ROUND(100.0 * SUM(is_late_delivery) / COUNT(*), 2) AS late_rate_pct
FROM gold_fact_sales s
JOIN gold_dim_customers c
    ON s.customer_id = c.customer_id
WHERE order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY late_rate_pct DESC;

------ Adding filter to previous code
SELECT
    c.customer_state,
    COUNT(*) AS total_orders,
    SUM(is_late_delivery) AS late_orders,
    ROUND(100.0 * SUM(is_late_delivery) / COUNT(*), 2) AS late_rate_pct
FROM gold_fact_sales s
JOIN gold_dim_customers c
    ON s.customer_id = c.customer_id
WHERE order_status = 'delivered'
GROUP BY c.customer_state
HAVING COUNT(*) >= 20
ORDER BY late_rate_pct DESC;

---------- delivery for sellers considering their location as well
 SELECT
    s.seller_state,
    f.seller_id,
    COUNT(*) AS total_orders,
    SUM(f.is_late_delivery) AS late_orders,
    ROUND(100.0 * SUM(f.is_late_delivery) / COUNT(*), 2) AS late_rate_pct
FROM gold_fact_sales_items f
JOIN gold_dim_sellers s
    ON f.seller_id = s.seller_id
WHERE f.order_status = 'delivered'
GROUP BY s.seller_state, f.seller_id
HAVING COUNT(*) >= 10
ORDER BY late_rate_pct DESC;

------------- 
-- Best performing sellers
SELECT
    seller_id,
    COUNT(*) AS total_orders,
    SUM(is_late_delivery) AS late_orders,
    ROUND(100.0 * SUM(is_late_delivery) / COUNT(*), 2) AS late_rate_pct
FROM gold_fact_sales_items
WHERE order_status = 'delivered'
GROUP BY seller_id
HAVING COUNT(*) >= 20
ORDER BY late_rate_pct ASC
LIMIT 10;