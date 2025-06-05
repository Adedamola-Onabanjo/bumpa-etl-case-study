CREATE OR REPLACE TABLE `quixotic-card-438408-j8.bumpa_stg_data.stg_customer_orders` AS
SELECT
  SAFE_CAST(order_id AS STRING) AS order_id,                         -- Ensure order_id is treated as a string for consistency
  SAFE_CAST(customer_id AS STRING) AS customer_id,                   -- Convert customer_id to string for reliable joins
  SAFE_CAST(order_date AS DATE) AS order_date,                       -- Cast order_date to proper DATE format as indicated
  UPPER(TRIM(product_category)) AS product_category,                 -- Clean and standardize product_category to uppercase
  TRIM(product_name) AS product_name,                                -- Remove leading/trailing spaces from product_name
  SAFE_CAST(quantity AS INT64) AS quantity,                          -- Ensure quantity is a numeric type suitable for aggregation
  SAFE_CAST(price_per_unit AS FLOAT64) AS price_per_unit,           -- Convert price_per_unit to float for arithmetic operations
  IFNULL(discount_applied, 0.0) AS discount_applied,                 -- Default null discounts to 0.0 to avoid null handling later
  LOWER(TRIM(delivery_status)) AS delivery_status                   -- Normalize delivery_status to lowercase for analysis
FROM `bumpa_source_data.raw_customer_orders`;                        -- Source table containing raw customer order data
