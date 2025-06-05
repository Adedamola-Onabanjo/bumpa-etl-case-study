-- Analysis: Revenue trend by month
-- Source: fct_order_summary
-- Insight: Monthly performance trends for strategic planning

SELECT
  order_month,
  SUM(total_revenue) AS total_revenue
FROM `bumpa_marts_data.fct_order_summary`
GROUP BY order_month
ORDER BY order_month;
