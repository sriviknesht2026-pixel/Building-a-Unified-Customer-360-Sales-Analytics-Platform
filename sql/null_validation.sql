-- 1. CUSTOMER MASTER
SELECT
    'customer_master_01' AS table_name,
    COUNT(*) AS total_records,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS customer_id_nulls,
    COUNT(*) FILTER (WHERE customer_name IS NULL) AS customer_name_nulls,
    COUNT(*) FILTER (WHERE email IS NULL) AS email_nulls,
    COUNT(*) FILTER (WHERE gender IS NULL) AS gender_nulls,
    COUNT(*) FILTER (WHERE age IS NULL) AS age_nulls,
    COUNT(*) FILTER (WHERE country IS NULL) AS country_nulls,
    COUNT(*) FILTER (WHERE city IS NULL) AS city_nulls,
    COUNT(*) FILTER (WHERE income IS NULL) AS income_nulls,
    COUNT(*) FILTER (WHERE education IS NULL) AS education_nulls,
    COUNT(*) FILTER (WHERE marital_status IS NULL) AS marital_status_nulls,
    COUNT(*) FILTER (WHERE registration_date IS NULL) AS registration_date_nulls,
    COUNT(*) FILTER (WHERE customer_status IS NULL) AS customer_status_nulls
FROM customer_master_01;


-- 2. LEAD MANAGEMENT
SELECT
    'lead_management_02' AS table_name,
    COUNT(*) AS total_records,
    COUNT(*) FILTER (WHERE lead_id IS NULL) AS lead_id_nulls,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS customer_id_nulls,
    COUNT(*) FILTER (WHERE lead_source IS NULL) AS lead_source_nulls,
    COUNT(*) FILTER (WHERE lead_date IS NULL) AS lead_date_nulls,
    COUNT(*) FILTER (WHERE lead_status IS NULL) AS lead_status_nulls,
    COUNT(*) FILTER (WHERE lead_score IS NULL) AS lead_score_nulls,
    COUNT(*) FILTER (WHERE sales_agent IS NULL) AS sales_agent_nulls
FROM lead_management_02;


-- 3. OPPORTUNITY MANAGEMENT
SELECT
    'opportunity_management_03' AS table_name,
    COUNT(*) AS total_records,
    COUNT(*) FILTER (WHERE opportunity_id IS NULL) AS opportunity_id_nulls,
    COUNT(*) FILTER (WHERE lead_id IS NULL) AS lead_id_nulls,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS customer_id_nulls,
    COUNT(*) FILTER (WHERE product IS NULL) AS product_nulls,
    COUNT(*) FILTER (WHERE opportunity_stage IS NULL) AS opportunity_stage_nulls,
    COUNT(*) FILTER (WHERE opportunity_value IS NULL) AS opportunity_value_nulls,
    COUNT(*) FILTER (WHERE probability IS NULL) AS probability_nulls,
    COUNT(*) FILTER (WHERE created_date IS NULL) AS created_date_nulls,
    COUNT(*) FILTER (WHERE sales_agent IS NULL) AS sales_agent_nulls
FROM opportunity_management_03;


-- 4. SALES PIPELINE
SELECT
    'sales_pipeline_04' AS table_name,
    COUNT(*) AS total_records,
    COUNT(*) FILTER (WHERE deal_id IS NULL) AS deal_id_nulls,
    COUNT(*) FILTER (WHERE opportunity_id IS NULL) AS opportunity_id_nulls,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS customer_id_nulls,
    COUNT(*) FILTER (WHERE product IS NULL) AS product_nulls,
    COUNT(*) FILTER (WHERE deal_stage IS NULL) AS deal_stage_nulls,
    COUNT(*) FILTER (WHERE engage_date IS NULL) AS engage_date_nulls,
    COUNT(*) FILTER (WHERE close_date IS NULL) AS close_date_nulls,
    COUNT(*) FILTER (WHERE close_value IS NULL) AS close_value_nulls,
    COUNT(*) FILTER (WHERE sales_agent IS NULL) AS sales_agent_nulls
FROM sales_pipeline_04;


-- 5. MARKETING CAMPAIGN
SELECT
    'marketing_campaign_05' AS table_name,
    COUNT(*) AS total_records,
    COUNT(*) FILTER (WHERE campaign_id IS NULL) AS campaign_id_nulls,
    COUNT(*) FILTER (WHERE company IS NULL) AS company_nulls,
    COUNT(*) FILTER (WHERE campaign_type IS NULL) AS campaign_type_nulls,
    COUNT(*) FILTER (WHERE target_audience IS NULL) AS target_audience_nulls,
    COUNT(*) FILTER (WHERE duration_days IS NULL) AS duration_days_nulls,
    COUNT(*) FILTER (WHERE channel_used IS NULL) AS channel_used_nulls,
    COUNT(*) FILTER (WHERE conversion_rate IS NULL) AS conversion_rate_nulls,
    COUNT(*) FILTER (WHERE acquisition_cost IS NULL) AS acquisition_cost_nulls,
    COUNT(*) FILTER (WHERE roi IS NULL) AS roi_nulls,
    COUNT(*) FILTER (WHERE location IS NULL) AS location_nulls
FROM marketing_campaign_05;


-- 6. CUSTOMER SUPPORT TICKETS
SELECT
    'customer_support_tickets_06' AS table_name,
    COUNT(*) AS total_records,
    COUNT(*) FILTER (WHERE ticket_id IS NULL) AS ticket_id_nulls,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS customer_id_nulls,
    COUNT(*) FILTER (WHERE customer_name IS NULL) AS customer_name_nulls,
    COUNT(*) FILTER (WHERE customer_email IS NULL) AS customer_email_nulls,
    COUNT(*) FILTER (WHERE product_purchased IS NULL) AS product_purchased_nulls,
    COUNT(*) FILTER (WHERE ticket_type IS NULL) AS ticket_type_nulls,
    COUNT(*) FILTER (WHERE ticket_subject IS NULL) AS ticket_subject_nulls,
    COUNT(*) FILTER (WHERE ticket_status IS NULL) AS ticket_status_nulls,
    COUNT(*) FILTER (WHERE resolution IS NULL) AS resolution_nulls,
    COUNT(*) FILTER (WHERE ticket_priority IS NULL) AS ticket_priority_nulls,
    COUNT(*) FILTER (WHERE ticket_channel IS NULL) AS ticket_channel_nulls,
    COUNT(*) FILTER (WHERE first_response_minutes IS NULL) AS first_response_minutes_nulls,
    COUNT(*) FILTER (WHERE resolution_hours IS NULL) AS resolution_hours_nulls,
    COUNT(*) FILTER (WHERE customer_satisfaction_rating IS NULL) AS customer_satisfaction_rating_nulls
FROM customer_support_tickets_06;


-- 7. CONTACT CENTER LOGS
SELECT
    'contact_center_logs_07' AS table_name,
    COUNT(*) AS total_records,
    COUNT(*) FILTER (WHERE interaction_id IS NULL) AS interaction_id_nulls,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS customer_id_nulls,
    COUNT(*) FILTER (WHERE agent_id IS NULL) AS agent_id_nulls,
    COUNT(*) FILTER (WHERE interaction_datetime IS NULL) AS interaction_datetime_nulls,
    COUNT(*) FILTER (WHERE channel IS NULL) AS channel_nulls,
    COUNT(*) FILTER (WHERE call_reason IS NULL) AS call_reason_nulls,
    COUNT(*) FILTER (WHERE duration_minutes IS NULL) AS duration_minutes_nulls,
    COUNT(*) FILTER (WHERE outcome IS NULL) AS outcome_nulls,
    COUNT(*) FILTER (WHERE satisfaction_score IS NULL) AS satisfaction_score_nulls
FROM contact_center_logs_07;


-- 8. WEBSITE REGISTRATION
SELECT
    'website_registration_08' AS table_name,
    COUNT(*) AS total_records,
    COUNT(*) FILTER (WHERE registration_id IS NULL) AS registration_id_nulls,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS customer_id_nulls,
    COUNT(*) FILTER (WHERE registration_datetime IS NULL) AS registration_datetime_nulls,
    COUNT(*) FILTER (WHERE registration_source IS NULL) AS registration_source_nulls,
    COUNT(*) FILTER (WHERE device_type IS NULL) AS device_type_nulls,
    COUNT(*) FILTER (WHERE browser IS NULL) AS browser_nulls,
    COUNT(*) FILTER (WHERE country IS NULL) AS country_nulls
FROM website_registration_08;


-- 9. MOBILE APPLICATION
SELECT
    'mobile_application_09' AS table_name,
    COUNT(*) AS total_records,
    COUNT(*) FILTER (WHERE app_event_id IS NULL) AS app_event_id_nulls,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS customer_id_nulls,
    COUNT(*) FILTER (WHERE event_datetime IS NULL) AS event_datetime_nulls,
    COUNT(*) FILTER (WHERE device_type IS NULL) AS device_type_nulls,
    COUNT(*) FILTER (WHERE app_version IS NULL) AS app_version_nulls,
    COUNT(*) FILTER (WHERE event_type IS NULL) AS event_type_nulls,
    COUNT(*) FILTER (WHERE session_duration_minutes IS NULL) AS session_duration_minutes_nulls,
    COUNT(*) FILTER (WHERE app_source IS NULL) AS app_source_nulls
FROM mobile_application_09;


-- 10. SOCIAL MEDIA ENGAGEMENT
SELECT
    'social_media_engagement_10' AS table_name,
    COUNT(*) AS total_records,
    COUNT(*) FILTER (WHERE engagement_id IS NULL) AS engagement_id_nulls,
    COUNT(*) FILTER (WHERE campaign_id IS NULL) AS campaign_id_nulls,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS customer_id_nulls,
    COUNT(*) FILTER (WHERE platform IS NULL) AS platform_nulls,
    COUNT(*) FILTER (WHERE post_date IS NULL) AS post_date_nulls,
    COUNT(*) FILTER (WHERE post_type IS NULL) AS post_type_nulls,
    COUNT(*) FILTER (WHERE impressions IS NULL) AS impressions_nulls,
    COUNT(*) FILTER (WHERE clicks IS NULL) AS clicks_nulls,
    COUNT(*) FILTER (WHERE likes IS NULL) AS likes_nulls,
    COUNT(*) FILTER (WHERE comments IS NULL) AS comments_nulls,
    COUNT(*) FILTER (WHERE shares IS NULL) AS shares_nulls,
    COUNT(*) FILTER (WHERE engagement_rate IS NULL) AS engagement_rate_nulls
FROM social_media_engagement_10;