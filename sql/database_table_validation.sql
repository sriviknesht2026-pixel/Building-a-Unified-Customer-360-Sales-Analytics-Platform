SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;

SELECT 'customer_master' AS table_name, COUNT(*) AS records FROM customer_master_01
UNION ALL
SELECT 'lead_management', COUNT(*) FROM lead_management_02
UNION ALL
SELECT 'opportunity_management', COUNT(*) FROM opportunity_management_03
UNION ALL
SELECT 'sales_pipeline', COUNT(*) FROM sales_pipeline_04
UNION ALL
SELECT 'marketing_campaign', COUNT(*) FROM marketing_campaign_05
UNION ALL
SELECT 'customer_support_tickets', COUNT(*) FROM customer_support_tickets_06
UNION ALL
SELECT 'contact_center_logs', COUNT(*) FROM contact_center_logs_07
UNION ALL
SELECT 'website_registration', COUNT(*) FROM website_registration_08
UNION ALL
SELECT 'mobile_application', COUNT(*) FROM mobile_application_09
UNION ALL
SELECT 'social_media_engagement', COUNT(*) FROM social_media_engagement_10;