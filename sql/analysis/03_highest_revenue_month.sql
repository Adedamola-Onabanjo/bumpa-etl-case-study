-- Analysis: Month with the highest total revenue
-- Source: fct_order_summary
-- Insight: Reveals peak-performing period in terms of revenue

SELECT
  order_month,
  SUM(total_revenue) AS total_revenue
FROM `bumpa_marts_data.fct_order_summary`
GROUP BY order_month
ORDER BY total_revenue DESC
LIMIT 1;
