-- =========================================================
-- FINAL GOLD WAREHOUSE VALIDATION
-- =========================================================


-- 1. CUSTOMER-KEY INTEGRITY
-- Check whether fact tables contain customer keys
-- that do not exist in dim_customer

SELECT 'fact_leads' AS table_name, COUNT(*) AS invalid_rows
FROM fact_leads f
LEFT JOIN dim_customer d
    ON f.customer_key = d.customer_key
WHERE d.customer_key IS NULL

UNION ALL

SELECT 'fact_opportunities', COUNT(*)
FROM fact_opportunities f
LEFT JOIN dim_customer d
    ON f.customer_key = d.customer_key
WHERE d.customer_key IS NULL

UNION ALL

SELECT 'fact_sales', COUNT(*)
FROM fact_sales f
LEFT JOIN dim_customer d
    ON f.customer_key = d.customer_key
WHERE d.customer_key IS NULL

UNION ALL

SELECT 'fact_support', COUNT(*)
FROM fact_support f
LEFT JOIN dim_customer d
    ON f.customer_key = d.customer_key
WHERE d.customer_key IS NULL

UNION ALL

SELECT 'fact_contact_center', COUNT(*)
FROM fact_contact_center f
LEFT JOIN dim_customer d
    ON f.customer_key = d.customer_key
WHERE d.customer_key IS NULL

UNION ALL

SELECT 'fact_website', COUNT(*)
FROM fact_website f
LEFT JOIN dim_customer d
    ON f.customer_key = d.customer_key
WHERE d.customer_key IS NULL

UNION ALL

SELECT 'fact_mobile', COUNT(*)
FROM fact_mobile f
LEFT JOIN dim_customer d
    ON f.customer_key = d.customer_key
WHERE d.customer_key IS NULL

UNION ALL

SELECT 'fact_social_media', COUNT(*)
FROM fact_social_media f
LEFT JOIN dim_customer d
    ON f.customer_key = d.customer_key
WHERE d.customer_key IS NULL;


-- =========================================================
-- 2. PRODUCT-KEY INTEGRITY
-- =========================================================

SELECT 'fact_opportunities' AS table_name, COUNT(*) AS invalid_rows
FROM fact_opportunities f
LEFT JOIN dim_product d
    ON f.product_key = d.product_key
WHERE d.product_key IS NULL

UNION ALL

SELECT 'fact_sales', COUNT(*)
FROM fact_sales f
LEFT JOIN dim_product d
    ON f.product_key = d.product_key
WHERE d.product_key IS NULL;


-- =========================================================
-- 3. SALES-AGENT-KEY INTEGRITY
-- =========================================================

SELECT 'fact_leads' AS table_name, COUNT(*) AS invalid_rows
FROM fact_leads f
LEFT JOIN dim_sales_agent d
    ON f.sales_agent_key = d.sales_agent_key
WHERE d.sales_agent_key IS NULL

UNION ALL

SELECT 'fact_opportunities', COUNT(*)
FROM fact_opportunities f
LEFT JOIN dim_sales_agent d
    ON f.sales_agent_key = d.sales_agent_key
WHERE d.sales_agent_key IS NULL

UNION ALL

SELECT 'fact_sales', COUNT(*)
FROM fact_sales f
LEFT JOIN dim_sales_agent d
    ON f.sales_agent_key = d.sales_agent_key
WHERE d.sales_agent_key IS NULL;


-- =========================================================
-- 4. CAMPAIGN-KEY INTEGRITY
-- =========================================================

SELECT 'fact_social_media' AS table_name, COUNT(*) AS invalid_rows
FROM fact_social_media f
LEFT JOIN dim_campaign d
    ON f.campaign_key = d.campaign_key
WHERE d.campaign_key IS NULL;


-- =========================================================
-- 5. DATE-KEY INTEGRITY
-- =========================================================

SELECT 'fact_leads' AS table_name, COUNT(*) AS invalid_rows
FROM fact_leads f
LEFT JOIN dim_date d
    ON f.date_key = d.date_key
WHERE d.date_key IS NULL

UNION ALL

SELECT 'fact_opportunities', COUNT(*)
FROM fact_opportunities f
LEFT JOIN dim_date d
    ON f.date_key = d.date_key
WHERE d.date_key IS NULL

UNION ALL

SELECT 'fact_sales', COUNT(*)
FROM fact_sales f
LEFT JOIN dim_date d
    ON f.date_key = d.date_key
WHERE d.date_key IS NULL

UNION ALL

SELECT 'fact_contact_center', COUNT(*)
FROM fact_contact_center f
LEFT JOIN dim_date d
    ON f.date_key = d.date_key
WHERE d.date_key IS NULL

UNION ALL

SELECT 'fact_website', COUNT(*)
FROM fact_website f
LEFT JOIN dim_date d
    ON f.date_key = d.date_key
WHERE d.date_key IS NULL

UNION ALL

SELECT 'fact_mobile', COUNT(*)
FROM fact_mobile f
LEFT JOIN dim_date d
    ON f.date_key = d.date_key
WHERE d.date_key IS NULL

UNION ALL

SELECT 'fact_social_media', COUNT(*)
FROM fact_social_media f
LEFT JOIN dim_date d
    ON f.date_key = d.date_key
WHERE d.date_key IS NULL;


-- =========================================================
-- 6. NULL CHECK
-- =========================================================

SELECT
    'dim_customer' AS table_name,
    COUNT(*) AS null_rows
FROM dim_customer
WHERE customer_key IS NULL
   OR customer_id IS NULL

UNION ALL

SELECT
    'dim_product',
    COUNT(*)
FROM dim_product
WHERE product_key IS NULL
   OR product_name IS NULL

UNION ALL

SELECT
    'dim_sales_agent',
    COUNT(*)
FROM dim_sales_agent
WHERE sales_agent_key IS NULL
   OR sales_agent IS NULL

UNION ALL

SELECT
    'dim_campaign',
    COUNT(*)
FROM dim_campaign
WHERE campaign_key IS NULL
   OR campaign_id IS NULL

UNION ALL

SELECT
    'dim_date',
    COUNT(*)
FROM dim_date
WHERE date_key IS NULL
   OR full_date IS NULL;


-- =========================================================
-- 7. DUPLICATE CHECK — DIMENSIONS
-- =========================================================

SELECT 'dim_customer' AS table_name, COUNT(*) AS duplicate_rows
FROM (
    SELECT customer_id
    FROM dim_customer
    GROUP BY customer_id
    HAVING COUNT(*) > 1
) x

UNION ALL

SELECT 'dim_product', COUNT(*)
FROM (
    SELECT product_name
    FROM dim_product
    GROUP BY product_name
    HAVING COUNT(*) > 1
) x

UNION ALL

SELECT 'dim_sales_agent', COUNT(*)
FROM (
    SELECT sales_agent
    FROM dim_sales_agent
    GROUP BY sales_agent
    HAVING COUNT(*) > 1
) x

UNION ALL

SELECT 'dim_campaign', COUNT(*)
FROM (
    SELECT campaign_id
    FROM dim_campaign
    GROUP BY campaign_id
    HAVING COUNT(*) > 1
) x

UNION ALL

SELECT 'dim_date', COUNT(*)
FROM (
    SELECT date_key
    FROM dim_date
    GROUP BY date_key
    HAVING COUNT(*) > 1
) x;


-- =========================================================
-- 8. DUPLICATE CHECK — FACT TABLES
-- =========================================================

SELECT 'fact_leads' AS table_name, COUNT(*) AS duplicate_rows
FROM (
    SELECT lead_id
    FROM fact_leads
    GROUP BY lead_id
    HAVING COUNT(*) > 1
) x

UNION ALL

SELECT 'fact_opportunities', COUNT(*)
FROM (
    SELECT opportunity_id
    FROM fact_opportunities
    GROUP BY opportunity_id
    HAVING COUNT(*) > 1
) x

UNION ALL

SELECT 'fact_sales', COUNT(*)
FROM (
    SELECT deal_id
    FROM fact_sales
    GROUP BY deal_id
    HAVING COUNT(*) > 1
) x

UNION ALL

SELECT 'fact_support', COUNT(*)
FROM (
    SELECT ticket_id
    FROM fact_support
    GROUP BY ticket_id
    HAVING COUNT(*) > 1
) x

UNION ALL

SELECT 'fact_contact_center', COUNT(*)
FROM (
    SELECT interaction_id
    FROM fact_contact_center
    GROUP BY interaction_id
    HAVING COUNT(*) > 1
) x

UNION ALL

SELECT 'fact_website', COUNT(*)
FROM (
    SELECT registration_id
    FROM fact_website
    GROUP BY registration_id
    HAVING COUNT(*) > 1
) x

UNION ALL

SELECT 'fact_mobile', COUNT(*)
FROM (
    SELECT app_event_id
    FROM fact_mobile
    GROUP BY app_event_id
    HAVING COUNT(*) > 1
) x

UNION ALL

SELECT 'fact_social_media', COUNT(*)
FROM (
    SELECT engagement_id
    FROM fact_social_media
    GROUP BY engagement_id
    HAVING COUNT(*) > 1
) x;


-- =========================================================
-- 9. FACT-DIMENSION RELATIONSHIP CHECK
-- =========================================================

SELECT
    'fact_leads → dim_customer' AS relationship,
    COUNT(*) AS invalid_rows
FROM fact_leads f
LEFT JOIN dim_customer d
    ON f.customer_key = d.customer_key
WHERE d.customer_key IS NULL

UNION ALL

SELECT
    'fact_opportunities → dim_customer',
    COUNT(*)
FROM fact_opportunities f
LEFT JOIN dim_customer d
    ON f.customer_key = d.customer_key
WHERE d.customer_key IS NULL

UNION ALL

SELECT
    'fact_opportunities → dim_product',
    COUNT(*)
FROM fact_opportunities f
LEFT JOIN dim_product d
    ON f.product_key = d.product_key
WHERE d.product_key IS NULL

UNION ALL

SELECT
    'fact_sales → dim_customer',
    COUNT(*)
FROM fact_sales f
LEFT JOIN dim_customer d
    ON f.customer_key = d.customer_key
WHERE d.customer_key IS NULL

UNION ALL

SELECT
    'fact_sales → dim_product',
    COUNT(*)
FROM fact_sales f
LEFT JOIN dim_product d
    ON f.product_key = d.product_key
WHERE d.product_key IS NULL

UNION ALL

SELECT
    'fact_social_media → dim_campaign',
    COUNT(*)
FROM fact_social_media f
LEFT JOIN dim_campaign d
    ON f.campaign_key = d.campaign_key
WHERE d.campaign_key IS NULL;