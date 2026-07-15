-- Unique Active Sellers --
SELECT COUNT(DISTINCT oi.seller_id) AS total_unique_sellers
FROM olist_order_items_dataset oi
JOIN olist_orders_dataset o ON oi.order_id = o.order_id
WHERE o.order_status NOT IN ('canceled', 'unavailable');


-- Monthly Active Sellers --
SELECT 
strftime('%Y-%m', o.order_purchase_timestamp) AS order_month,
COUNT (DISTINCT oi.seller_id) AS unique_seller_count
FROM olist_orders_dataset o
JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id 
WHERE o.order_status NOT IN ('unavailable' , 'canceled')
GROUP BY 1;


-- Seller Segmentation -- 

WITH total_gmv AS (
SELECT SUM(oi.price + oi.freight_value) AS rev 
FROM olist_order_items_dataset oi 
JOIN olist_orders_dataset o ON o.order_id = oi.order_id 
WHERE o.order_status NOT IN ('unavailable','canceled')
),
seller_metrics AS (
    SELECT 
        oi.seller_id,
        SUM(oi.price + oi.freight_value) AS total_revenue,
        COUNT(DISTINCT oi.order_id) AS total_orders,
        PERCENT_RANK() OVER (ORDER BY SUM(oi.price + oi.freight_value) DESC) AS rev_percentile
    FROM olist_order_items_dataset oi
    JOIN olist_orders_dataset o ON oi.order_id = o.order_id 
    WHERE o.order_status NOT IN ('canceled', 'unavailable')
    GROUP BY 1
)
SELECT 
    sm.seller_id,
    sm.total_revenue,
    sm.total_orders,
    CASE 
        WHEN sm.rev_percentile <= 0.10 THEN 'Tier 1 - Elite (Top 10%)'
        WHEN sm.rev_percentile <= 0.40 THEN 'Tier 2 - Mid-Tier (Next 30%)'
        ELSE 'Tier 3 - Low-Volume (Bottom 60%)'
    END AS seller_segment,
	ROUND((sm.total_revenue * 100.00)/ tg.rev ,2) AS pct_of_total_gmv
FROM seller_metrics sm
CROSS JOIN total_gmv tg
ORDER BY 5 DESC;


-- Seller Overall Performance --

WITH seller_performance AS (
    SELECT 
        oi.seller_id,
        SUM(oi.price + oi.freight_value) AS total_revenue
    FROM olist_order_items_dataset oi
    JOIN olist_orders_dataset o ON oi.order_id = o.order_id 
    WHERE o.order_status NOT IN ('canceled', 'unavailable')
    GROUP BY 1
),
median_calculation AS (
    SELECT total_revenue
    FROM seller_performance
    ORDER BY total_revenue
    LIMIT 2 - (SELECT COUNT(*) FROM seller_performance) % 2
    OFFSET (SELECT COUNT(*) - 1 FROM seller_performance) / 2
),
final_metrics AS (
    SELECT 
        COUNT(*) AS total_sellers,
        AVG(total_revenue) AS avg_revenue,
        (SELECT AVG(total_revenue) FROM median_calculation) AS median_revenue,
        MAX(total_revenue) AS max_revenue,
        MIN(total_revenue) AS min_revenue
    FROM seller_performance
)
SELECT 'Total Sellers' AS Metric, PRINTF('%,d', total_sellers) AS Value FROM final_metrics
UNION ALL
SELECT 'Average Revenue per Seller', PRINTF('$%,.2f', avg_revenue) FROM final_metrics
UNION ALL
SELECT 'Median Revenue per Seller', PRINTF('$%,.2f', median_revenue) FROM final_metrics
UNION ALL
SELECT 'Max Revenue', PRINTF('$%,.2f', max_revenue) FROM final_metrics
UNION ALL
SELECT 'Min Revenue', PRINTF('$%,.2f', min_revenue) FROM final_metrics;


-- Sellers' Pareto Analysis --

WITH total_gmv AS (
    -- Calculate the total platform GMV
    SELECT SUM(oi.price + oi.freight_value) AS global_rev 
    FROM olist_order_items_dataset oi 
    JOIN olist_orders_dataset o ON o.order_id = oi.order_id 
    WHERE o.order_status NOT IN ('unavailable', 'canceled')
),
ranked_sellers AS (
    -- Rank every seller by revenue and calculate their percentile position
    SELECT 
        oi.seller_id,
        SUM(oi.price + oi.freight_value) AS seller_rev,
        ROW_NUMBER() OVER (ORDER BY SUM(oi.price + oi.freight_value) DESC) AS seller_rank,
        PERCENT_RANK() OVER (ORDER BY SUM(oi.price + oi.freight_value) DESC) AS rank_percentile
    FROM olist_order_items_dataset oi
    JOIN olist_orders_dataset o ON oi.order_id = o.order_id 
    WHERE o.order_status NOT IN ('canceled', 'unavailable')
    GROUP BY 1
),
pareto_metrics AS (
    -- Aggregating GMV shares based on the seller groups
    SELECT
        SUM(CASE WHEN rs.seller_rank <= 10 THEN rs.seller_rev ELSE 0 END) AS top_10_rev,
        SUM(CASE WHEN rs.seller_rank <= 50 THEN rs.seller_rev ELSE 0 END) AS top_50_rev,
        SUM(CASE WHEN rs.seller_rank <= 100 THEN rs.seller_rev ELSE 0 END) AS top_100_rev,
        SUM(CASE WHEN rs.rank_percentile <= 0.20 THEN rs.seller_rev ELSE 0 END) AS top_20_percent_rev
    FROM ranked_sellers rs
)
-- Restructuring columns into rows matching your UI mockup layout
SELECT 
    'Top 10 Sellers' AS "Group",
    PRINTF('%.2f%%', (pm.top_10_rev * 100.0) / tg.global_rev) AS "GMV%"
FROM pareto_metrics pm CROSS JOIN total_gmv tg

UNION ALL

SELECT 
    'Top 50 Sellers',
    PRINTF('%.2f%%', (pm.top_50_rev * 100.0) / tg.global_rev)
FROM pareto_metrics pm CROSS JOIN total_gmv tg

UNION ALL

SELECT 
    'Top 100 Sellers',
    PRINTF('%.2f%%', (pm.top_100_rev * 100.0) / tg.global_rev)
FROM pareto_metrics pm CROSS JOIN total_gmv tg

UNION ALL

SELECT 
    'Top 20% Sellers',
    PRINTF('%.2f%%', (pm.top_20_percent_rev * 100.0) / tg.global_rev)
FROM pareto_metrics pm CROSS JOIN total_gmv tg;



