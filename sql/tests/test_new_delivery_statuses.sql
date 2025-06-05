-- Test: Find delivery_status values not mapped in meta table
-- Impact: Ensures no unclassified delivery statuses break downstream joins

SELECT DISTINCT delivery_status
FROM `bumpa_stg_data.stg_customer_orders`
WHERE delivery_status NOT IN (
  SELECT delivery_status FROM `bumpa_meta_data.delivery_status_lookup`
)
