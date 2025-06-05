-- Test: Catch repeat_customer_rate values outside 0–1 (invalid %)
-- Impact: Validates aggregation math integrity in final mart table

SELECT *
FROM `bumpa_marts_data.fct_order_summary`
WHERE repeat_customer_rate < 0 OR repeat_customer_rate > 1;
