select * from `sales.user_events`;

select count(*) from `sales.user_events`;

CREATE OR REPLACE VIEW `sales-funnel-analysis-502019.sales.funnel_stages` AS
SELECT 
    COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS stage_1_views,
    COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) AS stage_2_cart,
    COUNT(DISTINCT CASE WHEN event_type = 'checkout_start' THEN user_id END) AS stage_3_checkout,
    COUNT(DISTINCT CASE WHEN event_type = 'payment_info' THEN user_id END) AS stage_4_payment,
    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS stage_5_purchase
FROM `sales.user_events`
WHERE event_date >= '2026-01-01' AND event_date <= '2026-01-30';

select * from `sales.funnel_stages`;

CREATE OR REPLACE VIEW `sales-funnel-analysis-502019.sales.conversion_rates` AS
SELECT 
    ROUND(stage_2_cart * 100 / stage_1_views, 2) AS view_to_cart_rate,
    ROUND(stage_3_checkout * 100 / stage_2_cart, 2) AS cart_to_checkout_rate,
    ROUND(stage_4_payment * 100 / stage_3_checkout, 2) AS checkout_to_payment_rate,
    ROUND(stage_5_purchase * 100 / stage_4_payment, 2) AS payment_to_purchase_rate,
    ROUND(stage_5_purchase * 100 / stage_1_views, 2) AS overall_conversion_rate
FROM `sales.funnel_stages`;

select * from sales.conversion_rates;

CREATE OR REPLACE VIEW `sales-funnel-analysis-502019.sales.source_funnels` AS
SELECT 
    traffic_source,
    COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS views,
    COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) AS carts,
    COUNT(DISTINCT CASE WHEN event_type = 'checkout_start' THEN user_id END) AS checkouts,
    COUNT(DISTINCT CASE WHEN event_type = 'payment_info' THEN user_id END) AS payments,
    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS purchases
FROM sales.user_events
WHERE event_date >= '2026-01-01' AND event_date <= '2026-01-30' 
GROUP BY traffic_source;

select * from sales.source_funnels;

CREATE OR REPLACE VIEW sales-funnel-analysis-502019.sales.source_conversion_rates AS
SELECT
    traffic_source,
    views,
    carts,
    purchases,
    ROUND(carts * 100 / views, 2) AS view_to_cart_rate,
    ROUND(purchases * 100 / payments, 2) AS payment_to_purchase_rate,
    ROUND(purchases * 100 / views, 2) AS view_to_purchase_rate
FROM sales.source_funnels;

select * from `sales.source_conversion_rates`;

CREATE OR REPLACE VIEW sales-funnel-analysis-502019.sales.user_journey AS
SELECT 
    user_id,
    MIN(CASE WHEN event_type = 'page_view' THEN event_date END) AS view_time,
    MIN(CASE WHEN event_type = 'add_to_cart' THEN event_date END) AS cart_time,
    MIN(CASE WHEN event_type = 'checkout_start' THEN event_date END) AS checkout_time,
    MIN(CASE WHEN event_type = 'payment_info' THEN event_date END) AS payment_time,
    MIN(CASE WHEN event_type = 'purchase' THEN event_date END) AS purchase_time
FROM sales.user_events
WHERE event_date >= '2026-01-01' AND event_date <= '2026-01-30' 
GROUP BY user_id
HAVING MIN(CASE WHEN event_type = 'purchase' THEN event_date END) IS NOT NULL;

select * from sales.user_journey;

CREATE OR REPLACE VIEW `sales-funnel-analysis-502019.sales.converted_user_journey` AS
SELECT 
    COUNT(user_id) AS converted_users,
    ROUND(AVG(TIMESTAMP_DIFF(cart_time, view_time, MINUTE)), 2) AS avg_view_to_cart_mins,
    ROUND(AVG(TIMESTAMP_DIFF(checkout_time, cart_time, MINUTE)), 2) AS avg_cart_to_checkout_mins,
    ROUND(AVG(TIMESTAMP_DIFF(payment_time, checkout_time, MINUTE)), 2) AS avg_checkout_to_payment_mins,
    ROUND(AVG(TIMESTAMP_DIFF(purchase_time, payment_time, MINUTE)), 2) AS avg_payment_to_purchase_mins,
    ROUND(AVG(TIMESTAMP_DIFF(purchase_time, view_time, MINUTE)), 2) AS avg_view_to_purchase_mins
FROM `sales-funnel-analysis-502019.sales.user_journey`;

select * from sales.converted_user_journey;

CREATE OR REPLACE VIEW sales-funnel-analysis-502019.sales.funnel_revenue_analysis AS
WITH funnel_revenue AS (
    SELECT 
        COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS total_visitors,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS total_buyers,
        SUM(CASE WHEN event_type = 'purchase' THEN amount END) AS total_revenue,
        COUNT(CASE WHEN event_type = 'purchase' THEN 1 END) AS total_orders
    FROM sales.user_events
    WHERE date(event_date) BETWEEN DATE '2026-01-01' AND DATE '2026-01-30'
)
SELECT 
    total_visitors,
    total_buyers,
    round(total_revenue, 2) as revenue,
    total_orders,
    ROUND(total_revenue / total_orders, 2) AS avg_order_value,
    ROUND(total_revenue / total_buyers, 2) AS revenue_per_buyer,
    ROUND(total_revenue / total_visitors) AS revenue_per_visitor,
    ROUND(total_buyers * 100 / total_visitors) AS conversion_rate
FROM funnel_revenue;

select * from sales.funnel_revenue_analysis;
