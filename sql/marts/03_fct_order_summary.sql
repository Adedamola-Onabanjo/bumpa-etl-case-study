CREATE OR REPLACE TABLE `quixotic-card-438408-j8.bumpa_marts.fct_order_summary` AS

WITH base AS (
  SELECT
    order_id,                                                                 -- Unique order identifier
    customer_id,                                                              -- ID of the customer
    order_month,                                                              -- Year-month of the order
    product_category,                                                         -- Product category
    quantity,                                                                 -- Quantity of items in the order
    price_per_unit,                                                           -- Unit price of the product
    discount_applied,                                                         -- Discount applied to the order
    gross_order_value,                                                        -- Value before discount
    total_price,                                                              -- Final price after discount
    delivery_stage                                                            -- Status of delivery (e.g., fulfilled, pending)
  FROM `bumpa_core_data.int_orders`                                           -- Source: core intermediate model
),

agg AS (
  SELECT
    order_month,                                                              -- Aggregation level: year-month
    product_category,                                                         -- Aggregation level: product category

    -- Core Metrics
    COUNT(DISTINCT order_id) AS total_orders,                                 -- Total number of unique orders
    COUNT(DISTINCT customer_id) AS unique_customers,                          -- Number of distinct customers
    SUM(total_price) AS total_revenue,                                        -- Net revenue earned after discounts
    SUM(gross_order_value) AS gross_revenue,                                  -- Gross revenue before discounts
    SUM(gross_order_value - total_price) AS revenue_lost_to_discount,         -- Total discount impact on revenue
    SUM(quantity) AS total_quantity_sold,                                     -- Total number of items sold

    -- Average & Derived Metrics
    SAFE_DIVIDE(SUM(total_price), COUNT(DISTINCT order_id)) AS avg_order_value, -- Average amount spent per order
    SAFE_DIVIDE(SUM(discount_applied), COUNTIF(discount_applied > 0)) AS avg_discount_pct, -- Average % discount on discounted orders
    SAFE_DIVIDE(COUNTIF(discount_applied > 0), COUNT(DISTINCT order_id)) AS discount_usage_rate, -- Share of orders using a discount
    SAFE_DIVIDE(COUNTIF(delivery_stage = 'fulfilled'), COUNT(DISTINCT order_id)) AS fulfillment_rate, -- Share of orders that were fulfilled
    SAFE_DIVIDE(COUNTIF(order_count_per_customer > 1), COUNT(DISTINCT customer_id)) AS repeat_customer_rate, -- Share of customers with >1 order that month

    CURRENT_TIMESTAMP() AS record_inserted_at                                 -- Timestamp when record was generated
  FROM (
    SELECT *,
      COUNT(order_id) OVER (PARTITION BY customer_id, order_month) AS order_count_per_customer -- Orders per customer per month
    FROM base                                                                 -- Base CTE with cleaned and joined data
  )

  GROUP BY order_month, product_category                                      -- Aggregate by month and category
)

SELECT * FROM agg;                                                             -- Final SELECT from the aggregated metrics
