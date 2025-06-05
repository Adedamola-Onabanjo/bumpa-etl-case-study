-- Test: Flag cases where total_price exceeds gross_order_value
-- Impact: Detects over-discounting or incorrect math logic in int_orders

SELECT *
FROM `bumpa_core_data.int_orders`
WHERE total_price > gross_order_value;
