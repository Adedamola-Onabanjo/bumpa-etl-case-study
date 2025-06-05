-- Analysis: Average order value (AOV) for delivered orders only
-- Source: stg_customer_orders (raw delivery_status values)
-- Insight: Highlights monetary value of fulfilled orders

SELECT
  SAFE_DIVIDE(SUM(quantity * price_per_unit * (1 - discount_applied / 100)), COUNT(DISTINCT order_id)) AS avg_order_value
FROM `bumpa_stg_data.stg_customer_orders`
WHERE LOWER(TRIM(delivery_status)) = 'delivered';
