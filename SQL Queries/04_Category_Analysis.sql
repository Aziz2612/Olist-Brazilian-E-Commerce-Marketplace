-- Category Analysis -- 
WITH CategoryMetrics AS (
    SELECT 
        op.product_category_name,
        COUNT(DISTINCT oi.order_id) AS orders,
        SUM(oi.price + oi.freight_value) AS GMV,
        ROUND(SUM(oi.price + oi.freight_value) / COUNT(DISTINCT oi.order_id), 2) AS AOV,
		COUNT(DISTINCT oi.seller_id) AS unique_sellers
    FROM olist_order_items_dataset oi
    JOIN olist_products_dataset op ON oi.product_id = op.product_id
    JOIN olist_orders_dataset o ON o.order_id = oi.order_id
    WHERE o.order_status NOT IN ('canceled', 'unavailable')
    GROUP BY 1
),
CategoryReviews AS (
    SELECT DISTINCT 
        oi.order_id,
        op.product_category_name,
        r.review_score
    FROM olist_order_items_dataset oi 
    JOIN olist_products_dataset op ON oi.product_id = op.product_id 
    JOIN olist_orders_dataset o ON o.order_id = oi.order_id 
    JOIN olist_order_reviews_dataset r ON oi.order_id = r.order_id 
    WHERE o.order_status NOT IN ('canceled', 'unavailable')
),
CategoryDelivery AS (
    SELECT DISTINCT
        oi.order_id,
        op.product_category_name,
        (julianday(o.order_delivered_customer_date) - julianday(o.order_purchase_timestamp)) AS delivery_days
    FROM olist_order_items_dataset oi
    JOIN olist_products_dataset op ON oi.product_id = op.product_id
    JOIN olist_orders_dataset o ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    AND o.order_delivered_customer_date IS NOT NULL
)

SELECT 
    m.product_category_name,
    m.orders,
    m.GMV,
    m.AOV,
	ROUND((m.GMV / SUM(m.GMV) OVER()) * 100, 2) AS gmv_contribution_pct,
    m.unique_sellers,
    ROUND(m.GMV / m.unique_sellers, 2) AS GMV_per_seller,
	ROUND(m.orders / m.unique_sellers, 2) AS orders_per_sellers,
    ROUND(AVG(rev.review_score), 2) AS avg_score,
    ROUND(AVG(del.delivery_days), 1) AS avg_delivery_days

FROM CategoryMetrics m
LEFT JOIN CategoryReviews rev ON m.product_category_name = rev.product_category_name
LEFT JOIN CategoryDelivery del ON m.product_category_name = del.product_category_name 
AND rev.order_id = del.order_id 
GROUP BY 1
ORDER BY m.orders DESC;
