-- Test Runner Log: Counts failing rows in each QA view and logs with timestamp
-- Impact: Used in Connected Sheets to visualize pipeline health

SELECT 'test_stg_null_order_id' AS test_name,
       COUNT(*) AS failure_count,
       CURRENT_TIMESTAMP() AS run_timestamp
FROM `bumpa_qa.test_stg_null_order_id`
UNION ALL
SELECT 'test_core_price_mismatch', COUNT(*), CURRENT_TIMESTAMP()
FROM `bumpa_qa.test_core_price_mismatch`
UNION ALL
SELECT 'test_mart_repeat_rate_out_of_bounds', COUNT(*), CURRENT_TIMESTAMP()
FROM `bumpa_qa.test_mart_repeat_rate_out_of_bounds`
UNION ALL
SELECT 'test_new_delivery_statuses', COUNT(*), CURRENT_TIMESTAMP()
FROM `bumpa_qa.test_new_delivery_statuses`;
