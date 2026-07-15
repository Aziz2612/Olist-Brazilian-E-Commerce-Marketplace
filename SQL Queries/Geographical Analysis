-- State Performance -- 

SELECT 
    c.customer_state, 
    SUM(oi.price + oi.freight_value) AS GMV, 
    COUNT(DISTINCT oi.order_id) AS orders, 
    COUNT(DISTINCT c.customer_unique_id) AS customers,
    COUNT(DISTINCT oi.seller_id) AS sellers,
	ROUND(SUM(oi.price + oi.freight_value) / COUNT(DISTINCT oi.seller_id) , 2) GMV_per_seller,
	ROUND(SUM(oi.price + oi.freight_value) / COUNT(DISTINCT oi.order_id) , 2) AOV,
    ROUND(AVG(julianday(o.order_delivered_customer_date) - julianday(o.order_purchase_timestamp)),2) AS avg_delivery_days,
    ROUND(AVG(latest_review.review_score),2) AS avg_review_score
FROM olist_order_items_dataset oi 
JOIN olist_orders_dataset o ON o.order_id = oi.order_id
JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
-- ربط الجدول بآخر تقييم فقط لكل أوردر لمنع التكرار
LEFT JOIN (
    SELECT order_id, review_score
    FROM olist_order_reviews_dataset
    GROUP BY order_id
    HAVING review_creation_date = MAX(review_creation_date)
) latest_review ON o.order_id = latest_review.order_id
WHERE o.order_status NOT IN ('canceled','unavailable')
GROUP BY 1
ORDER BY GMV DESC;
