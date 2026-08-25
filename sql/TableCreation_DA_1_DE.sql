DROP TABLE IF EXISTS customer_master_01;
DROP TABLE IF EXISTS lead_management_02;
DROP TABLE IF EXISTS opportunity_management_03;
DROP TABLE IF EXISTS sales_pipeline_04;
DROP TABLE IF EXISTS marketing_campaign_05;
DROP TABLE IF EXISTS customer_support_tickets_06;
DROP TABLE IF EXISTS contact_center_logs_07;
DROP TABLE IF EXISTS website_registration_08;
DROP TABLE IF EXISTS mobile_application_09;
DROP TABLE IF EXISTS social_media_engagement_10;



CREATE TABLE customer_master_01 (
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(150),
    gender VARCHAR(20),
    age INTEGER,
    country VARCHAR(100),
    city VARCHAR(100),
    income NUMERIC(12,2),
    education VARCHAR(100),
    marital_status VARCHAR(30),
    registration_date DATE,
    customer_status VARCHAR(30)
);

CREATE TABLE lead_management_02 (
    lead_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    lead_source VARCHAR(100),
    lead_date DATE,
    lead_status VARCHAR(50),
    lead_score INTEGER,
    sales_agent VARCHAR(100)
);

CREATE TABLE opportunity_management_03 (
    opportunity_id VARCHAR(20) PRIMARY KEY,
    lead_id VARCHAR(20),
    customer_id VARCHAR(20),
    product VARCHAR(100),
    opportunity_stage VARCHAR(50),
    opportunity_value NUMERIC(14,2),
    probability INTEGER,
    created_date DATE,
    sales_agent VARCHAR(100)
);


CREATE TABLE sales_pipeline_04 (
    deal_id VARCHAR(20) PRIMARY KEY,
    opportunity_id VARCHAR(20),
    customer_id VARCHAR(20),
    product VARCHAR(100),
    deal_stage VARCHAR(50),
    engage_date DATE,
    close_date DATE,
    close_value NUMERIC(14,2),
    sales_agent VARCHAR(100)
);


CREATE TABLE marketing_campaign_05 (
    campaign_id VARCHAR(20) PRIMARY KEY,
    company VARCHAR(150),
    campaign_type VARCHAR(100),
    target_audience VARCHAR(150),
    duration_days INTEGER,
    channel_used VARCHAR(100),
    conversion_rate NUMERIC(8,4),
    acquisition_cost NUMERIC(14,2),
    roi NUMERIC(12,4),
    location VARCHAR(100)
);


CREATE TABLE customer_support_tickets_06 (
    ticket_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    customer_name VARCHAR(100),
    customer_email VARCHAR(150),
    product_purchased VARCHAR(100),
    ticket_type VARCHAR(100),
    ticket_subject VARCHAR(255),
    ticket_status VARCHAR(50),
    resolution TEXT,
    ticket_priority VARCHAR(30),
    ticket_channel VARCHAR(50),
    first_response_minutes INTEGER,
    resolution_hours NUMERIC(10,2),
    customer_satisfaction_rating NUMERIC(4,2)
);



CREATE TABLE contact_center_logs_07 (
    interaction_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    agent_id VARCHAR(20),
    interaction_datetime TIMESTAMP,
    channel VARCHAR(50),
    call_reason VARCHAR(150),
    duration_minutes INTEGER,
    outcome VARCHAR(100),
    satisfaction_score NUMERIC(4,2)
);



CREATE TABLE website_registration_08 (
    registration_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    registration_datetime TIMESTAMP,
    registration_source VARCHAR(100),
    device_type VARCHAR(50),
    browser VARCHAR(50),
    country VARCHAR(100)
);


CREATE TABLE mobile_application_09 (
    app_event_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    event_datetime TIMESTAMP,
    device_type VARCHAR(50),
    app_version VARCHAR(30),
    event_type VARCHAR(100),
    session_duration_minutes NUMERIC(10,2),
    app_source VARCHAR(100)
);



CREATE TABLE social_media_engagement_10 (
    engagement_id VARCHAR(20) PRIMARY KEY,
    campaign_id VARCHAR(20),
    customer_id VARCHAR(20),
    platform VARCHAR(50),
    post_date DATE,
    post_type VARCHAR(50),
    impressions INTEGER,
    clicks INTEGER,
    likes INTEGER,
    comments INTEGER,
    shares INTEGER,
    engagement_rate NUMERIC(8,4)
);



