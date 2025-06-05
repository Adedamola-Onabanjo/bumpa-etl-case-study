CREATE OR REPLACE TABLE `quixotic-card-438408-j8.bumpa_core_data.int_orders` AS
SELECT
  o.order_id,                                                                 -- Unique order identifier
  o.customer_id,                                                              -- ID of the customer placing the order
  o.order_date,                                                               -- Date the order was placed
  FORMAT_DATE('%Y-%m', o.order_date) AS order_month,                          -- Extract year-month for monthly aggregation
  o.product_category,                                                         -- Product category, already standardized

  o.product_name,                                                             -- Name of the product ordered
  o.quantity,                                                                 -- Number of units ordered
  o.price_per_unit,                                                           -- Unit price of the product
  o.discount_applied,                                                         -- Discount applied (as a percentage)

  o.quantity * o.price_per_unit AS gross_order_value,                         -- Total order value before discount
  o.quantity * o.price_per_unit * (1 - o.discount_applied / 100) AS total_price, -- Final price after applying discount

  COALESCE(l.delivery_stage, 'unknown') AS delivery_stage                     -- Mapped delivery stage or 'unknown' if not found
FROM
  `quixotic-card-438408-j8.bumpa_stg_data.stg_customer_orders` o              -- Source: cleaned customer orders staging table
LEFT JOIN
  `quixotic-card-438408-j8.bumpa_meta.delivery_status_lookup` l              -- Lookup table to map delivery_status to delivery_stage
ON
  o.delivery_status = l.delivery_status                                       -- Join on normalized delivery status
WHERE
  o.order_id IS NOT NULL                                                      -- Filter out incomplete records without order ID
  AND o.customer_id IS NOT NULL;                                              -- Ensure only records with a valid customer ID are included
