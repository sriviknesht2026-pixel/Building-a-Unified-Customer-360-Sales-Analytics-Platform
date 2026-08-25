-- 1. LEAD → CUSTOMER
-- Every lead.customer_id should exist in customer_master

SELECT
    'Lead → Customer' AS relationship,
    COUNT(*) AS unmatched_records
FROM lead_management_02 l
LEFT JOIN customer_master_01 c
    ON l.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


-- 2. OPPORTUNITY → CUSTOMER

SELECT
    'Opportunity → Customer' AS relationship,
    COUNT(*) AS unmatched_records
FROM opportunity_management_03 o
LEFT JOIN customer_master_01 c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


-- 3. OPPORTUNITY → LEAD

SELECT
    'Opportunity → Lead' AS relationship,
    COUNT(*) AS unmatched_records
FROM opportunity_management_03 o
LEFT JOIN lead_management_02 l
    ON o.lead_id = l.lead_id
WHERE l.lead_id IS NULL;


-- 4. SALES PIPELINE → CUSTOMER

SELECT
    'Sales Pipeline → Customer' AS relationship,
    COUNT(*) AS unmatched_records
FROM sales_pipeline_04 s
LEFT JOIN customer_master_01 c
    ON s.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


-- 5. SALES PIPELINE → OPPORTUNITY

SELECT
    'Sales Pipeline → Opportunity' AS relationship,
    COUNT(*) AS unmatched_records
FROM sales_pipeline_04 s
LEFT JOIN opportunity_management_03 o
    ON s.opportunity_id = o.opportunity_id
WHERE o.opportunity_id IS NULL;


-- 6. CUSTOMER SUPPORT → CUSTOMER

SELECT
    'Customer Support → Customer' AS relationship,
    COUNT(*) AS unmatched_records
FROM customer_support_tickets_06 t
LEFT JOIN customer_master_01 c
    ON t.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


-- 7. CONTACT CENTER → CUSTOMER

SELECT
    'Contact Center → Customer' AS relationship,
    COUNT(*) AS unmatched_records
FROM contact_center_logs_07 cc
LEFT JOIN customer_master_01 c
    ON cc.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


-- 8. WEBSITE → CUSTOMER

SELECT
    'Website → Customer' AS relationship,
    COUNT(*) AS unmatched_records
FROM website_registration_08 w
LEFT JOIN customer_master_01 c
    ON w.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


-- 9. MOBILE APPLICATION → CUSTOMER

SELECT
    'Mobile Application → Customer' AS relationship,
    COUNT(*) AS unmatched_records
FROM mobile_application_09 m
LEFT JOIN customer_master_01 c
    ON m.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


-- 10. SOCIAL MEDIA → CUSTOMER

SELECT
    'Social Media → Customer' AS relationship,
    COUNT(*) AS unmatched_records
FROM social_media_engagement_10 s
LEFT JOIN customer_master_01 c
    ON s.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


-- 11. SOCIAL MEDIA → MARKETING CAMPAIGN

SELECT
    'Social Media → Marketing Campaign' AS relationship,
    COUNT(*) AS unmatched_records
FROM social_media_engagement_10 s
LEFT JOIN marketing_campaign_05 m
    ON s.campaign_id = m.campaign_id
WHERE m.campaign_id IS NULL;