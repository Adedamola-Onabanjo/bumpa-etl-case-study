-- Test: Ensure no null order_id values exist in the staging table
-- Impact: Prevents downstream integrity issues in joins or rollups

SELECT *
FROM `bumpa_stg_data.stg_customer_orders`
WHERE order_id IS NULL;
