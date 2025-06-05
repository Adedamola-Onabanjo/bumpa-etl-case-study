-- Analysis: Top 5 product categories by total revenue
-- Source: fct_order_summary (aggregated)
-- Insight: Identifies revenue leaders by category

SELECT
  product_category,
  SUM(total_revenue) AS total_revenue
FROM `bumpa_marts_data.fct_order_summary`
GROUP BY product_category
ORDER BY total_revenue DESC
LIMIT 5;
