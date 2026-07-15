-- Monthly Performance -- 


WITH monthly_sellers AS (
    SELECT 
        DATE(o.order_purchase_timestamp, 'start of month') AS order_month_start,
        COUNT(DISTINCT oi.seller_id) AS unique_seller_count
    FROM olist_orders_dataset o
    JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id 
    WHERE o.order_status NOT IN ('unavailable', 'canceled')
    GROUP BY 1
),
payments AS (
    SELECT op.order_id, SUM(op.payment_value) AS payment_value
    FROM olist_order_payments_dataset op
    JOIN olist_orders_dataset o ON o.order_id = op.order_id
    WHERE o.order_status NOT IN ('canceled', 'unavailable')
    GROUP BY 1
),
ranked_reviews AS (
    SELECT order_id, review_score, ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY review_answer_timestamp DESC) AS rn
    FROM olist_order_reviews_dataset 
),
latest_reviews AS (
    SELECT order_id, review_score
    FROM ranked_reviews
    WHERE rn = 1
)
SELECT 
    DATE(o.order_purchase_timestamp, 'start of month') AS date, 
    COUNT(DISTINCT o.order_id) AS orders, 
    SUM(p.payment_value) AS GMV, 
    COUNT(DISTINCT oc.customer_unique_id) AS customers,
    MAX(ms.unique_seller_count) AS unique_sellers,
    ROUND(SUM(p.payment_value) / COUNT(DISTINCT o.order_id), 2) AS AOV, 
    ROUND(AVG(r.review_score), 2) AS average_scores, 
    CAST(AVG(CASE WHEN o.order_delivered_customer_date IS NOT NULL THEN JULIANDAY(o.order_delivered_customer_date) - JULIANDAY(o.order_purchase_timestamp) ELSE NULL END) AS INT) AS avg_delivery_days

FROM olist_orders_dataset o 
JOIN payments p ON o.order_id = p.order_id 
JOIN olist_customers_dataset oc ON o.customer_id = oc.customer_id
LEFT JOIN latest_reviews r ON o.order_id = r.order_id
LEFT JOIN monthly_sellers ms ON DATE(o.order_purchase_timestamp, 'start of month') = ms.order_month_start
WHERE o.order_status NOT IN ('canceled', 'unavailable')
GROUP BY 1;
