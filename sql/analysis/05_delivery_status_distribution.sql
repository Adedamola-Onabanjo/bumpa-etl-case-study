-- Analysis: Distribution of delivery_status values
-- Source: stg_customer_orders
-- Insight: Understands fulfillment health and failure reasons

WITH base_orders AS (
  SELECT
    order_id,
    FORMAT_DATE('%Y-%m', order_date) AS order_month,
    product_category,
    delivery_status
  FROM `quixotic-card-438408-j8.bumpa_stg_data.stg_customer_orders`
)

SELECT
  order_month,
  product_category,
  delivery_status,
  COUNT(order_id) AS total_orders,
  ROUND(
    100.0 * COUNT(order_id) / 
    SUM(COUNT(order_id)) OVER (
      PARTITION BY order_month, product_category
    ), 
    2
  ) AS percentage_within_category_month
FROM base_orders
GROUP BY
  order_month,
  product_category,
  delivery_status
ORDER BY
  order_month,
  product_category,
  percentage_within_category_month DESC;
