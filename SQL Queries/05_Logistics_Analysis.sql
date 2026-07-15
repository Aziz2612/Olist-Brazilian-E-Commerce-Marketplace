-- Delivery Buckets Performance --  
WITH delivery_days AS (
SELECT 
o.order_id, CAST(CASE WHEN o.order_delivered_customer_date IS NOT NULL 
THEN julianday(o.order_delivered_customer_date) - julianday(o.order_purchase_timestamp) 
ELSE NULL END AS INT) AS delivery_days

FROM olist_orders_dataset o
WHERE order_status NOT IN ('canceled','unavailable')
GROUP BY 1
),
bucketed_deliveries AS (
    SELECT 
        order_id,
        delivery_days,
        CASE 
            WHEN delivery_days IS NULL THEN 'Not Delivered Yet'
            WHEN delivery_days BETWEEN 0 AND 3 THEN '0:3'
            WHEN delivery_days BETWEEN 4 AND 7 THEN '4:7'
            WHEN delivery_days BETWEEN 8 AND 10 THEN '8:10'
            WHEN delivery_days BETWEEN 11 AND 14 THEN '11:14'
            WHEN delivery_days BETWEEN 15 AND 20 THEN '15:20'
            WHEN delivery_days > 20 THEN '20<'
            ELSE 'Negative/Error'
        END AS delivery_bucket
    FROM delivery_days
),
latest_order_reviews AS(
SELECT order_id,
review_score
FROM ( SELECT order_id, review_score, row_number () OVER (PARTITION BY order_id ORDER BY review_answer_timestamp DESC) AS rn
FROM olist_order_reviews_dataset)
WHERE rn = 1
)
SELECT 
    bd.delivery_bucket,
    COUNT(bd.order_id) AS total_orders,
    ROUND(COUNT(bd.order_id) * 100.0 / SUM(COUNT(bd.order_id)) OVER(), 2) AS percentage,
	ROUND(AVG(lor.review_score),2) AS avg_review_score
FROM bucketed_deliveries bd
LEFT JOIN latest_order_reviews lor ON lor.order_id = bd.order_id 
GROUP BY 1
ORDER BY 
    CASE delivery_bucket
        WHEN '0:3' THEN 1
        WHEN '4:7' THEN 2
        WHEN '8:10' THEN 3
        WHEN '11:14' THEN 4
        WHEN '15:20' THEN 5
        WHEN '20<' THEN 6
        ELSE 7
    END;


