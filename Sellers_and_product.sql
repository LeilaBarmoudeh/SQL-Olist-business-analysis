-- Top sellers by revenue
SELECT
    seller_id,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(*) AS total_items_sold,
    ROUND(SUM(payment_value), 2) AS total_revenue
FROM gold_fact_sales_items
GROUP BY seller_id
ORDER BY total_revenue DESC
LIMIT 20;

----- ########## improved based on price
SELECT
    seller_id,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(*) AS total_items_sold,
    ROUND(SUM(price), 2) AS total_revenue
FROM gold_fact_sales_items
GROUP BY seller_id
ORDER BY total_revenue DESC
LIMIT 20; 

-------##### Sellers performance by state
-- Seller performance by state
---- Which regions have the strongest sellers?

SELECT
    s.seller_state,
    COUNT(DISTINCT f.order_id) AS total_orders,
    COUNT(*) AS total_items_sold,
    ROUND(SUM(f.price), 2) AS total_revenue,
    ROUND(AVG(f.price), 2) AS avg_item_price
FROM gold_fact_sales_items f
JOIN gold_dim_sellers s
    ON f.seller_id = s.seller_id
GROUP BY s.seller_state
ORDER BY total_revenue DESC;

------- ############# Product- category analysis
---- What products drive revenue?
---- Which categories dominate?

-- Product category performance
SELECT
    p.product_category_name,
    COUNT(DISTINCT f.order_id) AS total_orders,
    COUNT(*) AS total_items_sold,
    ROUND(SUM(f.price), 2) AS total_revenue,
    ROUND(AVG(f.price), 2) AS avg_price
FROM gold_fact_sales_items f
JOIN gold_dim_products p
    ON f.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 20;
