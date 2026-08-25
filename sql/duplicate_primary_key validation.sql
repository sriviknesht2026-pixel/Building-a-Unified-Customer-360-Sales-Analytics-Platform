-- Check duplicate Customer IDs
SELECT customer_id, COUNT(*)
FROM customer_master_01
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Check duplicate Lead IDs
SELECT lead_id, COUNT(*)
FROM lead_management_02
GROUP BY lead_id
HAVING COUNT(*) > 1;

-- Check duplicate Opportunity IDs
SELECT opportunity_id, COUNT(*)
FROM opportunity_management_03
GROUP BY opportunity_id
HAVING COUNT(*) > 1;

-- Check duplicate Deal IDs
SELECT deal_id, COUNT(*)
FROM sales_pipeline_04
GROUP BY deal_id
HAVING COUNT(*) > 1;

-- Check duplicate Campaign IDs
SELECT campaign_id, COUNT(*)
FROM marketing_campaign_05
GROUP BY campaign_id
HAVING COUNT(*) > 1;

-- Check duplicate Ticket IDs
SELECT ticket_id, COUNT(*)
FROM customer_support_tickets_06
GROUP BY ticket_id
HAVING COUNT(*) > 1;

-- Check duplicate Interaction IDs
SELECT interaction_id, COUNT(*)
FROM contact_center_logs_07
GROUP BY interaction_id
HAVING COUNT(*) > 1;

-- Check duplicate Registration IDs
SELECT registration_id, COUNT(*)
FROM website_registration_08
GROUP BY registration_id
HAVING COUNT(*) > 1;

-- Check duplicate App Event IDs
SELECT app_event_id, COUNT(*)
FROM mobile_application_09
GROUP BY app_event_id
HAVING COUNT(*) > 1;

-- Check duplicate Engagement IDs
SELECT engagement_id, COUNT(*)
FROM social_media_engagement_10
GROUP BY engagement_id
HAVING COUNT(*) > 1;