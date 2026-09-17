-- ==========================================
-- DA2 - STAR SCHEMA
-- ==========================================

-- ==========================================
-- 1. DIMENSION TABLES
-- ==========================================
DROP TABLE IF EXISTS fact_social_media;
DROP TABLE IF EXISTS fact_mobile;
DROP TABLE IF EXISTS fact_website;
DROP TABLE IF EXISTS fact_contact_center;
DROP TABLE IF EXISTS fact_support;
DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS fact_opportunities;
DROP TABLE IF EXISTS fact_leads;

DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS dim_campaign;
DROP TABLE IF EXISTS dim_sales_agent;
DROP TABLE IF EXISTS dim_product;
DROP TABLE IF EXISTS dim_customer;

CREATE TABLE dim_customer (
    customer_key SERIAL PRIMARY KEY,
    customer_id VARCHAR(20),
    customer_name VARCHAR(100),
    email VARCHAR(150),
    gender VARCHAR(20),
    age INT,
    country VARCHAR(50),
    city VARCHAR(50),
    income NUMERIC(12,2),
    education VARCHAR(50),
    marital_status VARCHAR(30),
    registration_date DATE,
    customer_status VARCHAR(30)
);


CREATE TABLE dim_product (
    product_key SERIAL PRIMARY KEY,
    product_name VARCHAR(100)
);


CREATE TABLE dim_sales_agent (
    sales_agent_key SERIAL PRIMARY KEY,
    sales_agent VARCHAR(100)
);


CREATE TABLE dim_campaign (
    campaign_key SERIAL PRIMARY KEY,
    campaign_id VARCHAR(20),
    company VARCHAR(100),
    campaign_type VARCHAR(50),
    target_audience VARCHAR(50),
    duration_days INT,
    channel_used VARCHAR(50),
    location VARCHAR(50)
);


CREATE TABLE dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE,
    day INT,
    month INT,
    month_name VARCHAR(20),
    quarter INT,
    year INT
);


-- ==========================================
-- 2. FACT TABLE - LEADS
-- ==========================================

CREATE TABLE fact_leads (
    lead_fact_key SERIAL PRIMARY KEY,
    lead_id VARCHAR(20),
    customer_key INT,
    sales_agent_key INT,
    date_key INT,
    lead_source VARCHAR(50),
    lead_status VARCHAR(50),
    lead_score INT,

    FOREIGN KEY (customer_key)
        REFERENCES dim_customer(customer_key),

    FOREIGN KEY (sales_agent_key)
        REFERENCES dim_sales_agent(sales_agent_key),

    FOREIGN KEY (date_key)
        REFERENCES dim_date(date_key)
);


-- ==========================================
-- 3. FACT TABLE - OPPORTUNITIES
-- ==========================================

CREATE TABLE fact_opportunities (
    opportunity_fact_key SERIAL PRIMARY KEY,
    opportunity_id VARCHAR(20),
    customer_key INT,
    sales_agent_key INT,
    product_key INT,
    date_key INT,
    lead_id VARCHAR(20),
    opportunity_stage VARCHAR(50),
    opportunity_value NUMERIC(12,2),
    probability NUMERIC(5,2),

    FOREIGN KEY (customer_key)
        REFERENCES dim_customer(customer_key),

    FOREIGN KEY (sales_agent_key)
        REFERENCES dim_sales_agent(sales_agent_key),

    FOREIGN KEY (product_key)
        REFERENCES dim_product(product_key),

    FOREIGN KEY (date_key)
        REFERENCES dim_date(date_key)
);


-- ==========================================
-- 4. FACT TABLE - SALES
-- ==========================================

CREATE TABLE fact_sales (
    sales_fact_key SERIAL PRIMARY KEY,
    deal_id VARCHAR(20),
    customer_key INT,
    product_key INT,
    sales_agent_key INT,
    date_key INT,
    opportunity_id VARCHAR(20),
    deal_stage VARCHAR(50),
    engage_date DATE,
    close_date DATE,
    close_value NUMERIC(12,2),

    FOREIGN KEY (customer_key)
        REFERENCES dim_customer(customer_key),

    FOREIGN KEY (product_key)
        REFERENCES dim_product(product_key),

    FOREIGN KEY (sales_agent_key)
        REFERENCES dim_sales_agent(sales_agent_key),

    FOREIGN KEY (date_key)
        REFERENCES dim_date(date_key)
);


-- ==========================================
-- 5. FACT TABLE - SUPPORT
-- ==========================================

CREATE TABLE fact_support (
    support_fact_key SERIAL PRIMARY KEY,
    ticket_id VARCHAR(20),
    customer_key INT,
    product_purchased VARCHAR(100),
    ticket_type VARCHAR(50),
    ticket_status VARCHAR(50),
    ticket_priority VARCHAR(50),
    first_response_minutes INT,
    resolution_hours NUMERIC(10,2),
    customer_satisfaction_rating INT,

    FOREIGN KEY (customer_key)
        REFERENCES dim_customer(customer_key),

    FOREIGN KEY (date_key)
        REFERENCES dim_date(date_key)
);


-- ==========================================
-- 6. FACT TABLE - CONTACT CENTER
-- ==========================================

CREATE TABLE fact_contact_center (
    contact_fact_key SERIAL PRIMARY KEY,
    interaction_id VARCHAR(20),
    customer_key INT,
    date_key INT,
    agent_id VARCHAR(20),
    channel VARCHAR(50),
    call_reason VARCHAR(100),
    duration_minutes INT,
    outcome VARCHAR(50),
    satisfaction_score INT,

    FOREIGN KEY (customer_key)
        REFERENCES dim_customer(customer_key),

    FOREIGN KEY (date_key)
        REFERENCES dim_date(date_key)
);


-- ==========================================
-- 7. FACT TABLE - WEBSITE
-- ==========================================

CREATE TABLE fact_website (
    website_fact_key SERIAL PRIMARY KEY,
    registration_id VARCHAR(20),
    customer_key INT,
    date_key INT,
    registration_source VARCHAR(50),
    device_type VARCHAR(50),
    browser VARCHAR(50),
    country VARCHAR(50),

    FOREIGN KEY (customer_key)
        REFERENCES dim_customer(customer_key),

    FOREIGN KEY (date_key)
        REFERENCES dim_date(date_key)
);


-- ==========================================
-- 8. FACT TABLE - MOBILE
-- ==========================================

CREATE TABLE fact_mobile (
    mobile_fact_key SERIAL PRIMARY KEY,
    app_event_id VARCHAR(20),
    customer_key INT,
    date_key INT,
    device_type VARCHAR(50),
    app_version VARCHAR(50),
    event_type VARCHAR(50),
    session_duration_minutes NUMERIC(10,2),
    app_source VARCHAR(50),

    FOREIGN KEY (customer_key)
        REFERENCES dim_customer(customer_key),

    FOREIGN KEY (date_key)
        REFERENCES dim_date(date_key)
);


-- ==========================================
-- 9. FACT TABLE - SOCIAL MEDIA
-- ==========================================

CREATE TABLE fact_social_media (
    social_fact_key SERIAL PRIMARY KEY,
    engagement_id VARCHAR(20),
    customer_key INT,
    campaign_key INT,
    date_key INT,
    platform VARCHAR(50),
    post_type VARCHAR(50),
    impressions INT,
    clicks INT,
    likes INT,
    comments INT,
    shares INT,
    engagement_rate NUMERIC(10,4),

    FOREIGN KEY (customer_key)
        REFERENCES dim_customer(customer_key),

    FOREIGN KEY (campaign_key)
        REFERENCES dim_campaign(campaign_key),

    FOREIGN KEY (date_key)
        REFERENCES dim_date(date_key)
);

SELECT 'dim_customer' AS table_name, COUNT(*) AS row_count FROM dim_customer
UNION ALL
SELECT 'dim_product', COUNT(*) FROM dim_product
UNION ALL
SELECT 'dim_sales_agent', COUNT(*) FROM dim_sales_agent
UNION ALL
SELECT 'dim_campaign', COUNT(*) FROM dim_campaign
UNION ALL
SELECT 'dim_date', COUNT(*) FROM dim_date
UNION ALL
SELECT 'fact_leads', COUNT(*) FROM fact_leads
UNION ALL
SELECT 'fact_opportunities', COUNT(*) FROM fact_opportunities
UNION ALL
SELECT 'fact_sales', COUNT(*) FROM fact_sales
UNION ALL
SELECT 'fact_support', COUNT(*) FROM fact_support
UNION ALL
SELECT 'fact_contact_center', COUNT(*) FROM fact_contact_center
UNION ALL
SELECT 'fact_website', COUNT(*) FROM fact_website
UNION ALL
SELECT 'fact_mobile', COUNT(*) FROM fact_mobile
UNION ALL
SELECT 'fact_social_media', COUNT(*) FROM fact_social_media;


-- Customer lookup validation
SELECT 'fact_leads' AS table_name, COUNT(*) AS invalid_rows
FROM fact_leads f
LEFT JOIN dim_customer d ON f.customer_key = d.customer_key
WHERE d.customer_key IS NULL

UNION ALL

SELECT 'fact_opportunities', COUNT(*)
FROM fact_opportunities f
LEFT JOIN dim_customer d ON f.customer_key = d.customer_key
WHERE d.customer_key IS NULL

UNION ALL

SELECT 'fact_sales', COUNT(*)
FROM fact_sales f
LEFT JOIN dim_customer d ON f.customer_key = d.customer_key
WHERE d.customer_key IS NULL

UNION ALL

SELECT 'fact_support', COUNT(*)
FROM fact_support f
LEFT JOIN dim_customer d ON f.customer_key = d.customer_key
WHERE d.customer_key IS NULL

UNION ALL

SELECT 'fact_contact_center', COUNT(*)
FROM fact_contact_center f
LEFT JOIN dim_customer d ON f.customer_key = d.customer_key
WHERE d.customer_key IS NULL

UNION ALL

SELECT 'fact_website', COUNT(*)
FROM fact_website f
LEFT JOIN dim_customer d ON f.customer_key = d.customer_key
WHERE d.customer_key IS NULL

UNION ALL

SELECT 'fact_mobile', COUNT(*)
FROM fact_mobile f
LEFT JOIN dim_customer d ON f.customer_key = d.customer_key
WHERE d.customer_key IS NULL

UNION ALL

SELECT 'fact_social_media', COUNT(*)
FROM fact_social_media f
LEFT JOIN dim_customer d ON f.customer_key = d.customer_key
WHERE d.customer_key IS NULL;



-- Product lookup
SELECT 'fact_opportunities' AS table_name, COUNT(*) AS invalid_rows
FROM fact_opportunities f
LEFT JOIN dim_product d ON f.product_key = d.product_key
WHERE d.product_key IS NULL

UNION ALL

SELECT 'fact_sales', COUNT(*)
FROM fact_sales f
LEFT JOIN dim_product d ON f.product_key = d.product_key
WHERE d.product_key IS NULL;

-- Sales Agent lookup
SELECT 'fact_leads' AS table_name, COUNT(*) AS invalid_rows
FROM fact_leads f
LEFT JOIN dim_sales_agent d ON f.sales_agent_key = d.sales_agent_key
WHERE d.sales_agent_key IS NULL

UNION ALL

SELECT 'fact_opportunities', COUNT(*)
FROM fact_opportunities f
LEFT JOIN dim_sales_agent d ON f.sales_agent_key = d.sales_agent_key
WHERE d.sales_agent_key IS NULL

UNION ALL

SELECT 'fact_sales', COUNT(*)
FROM fact_sales f
LEFT JOIN dim_sales_agent d ON f.sales_agent_key = d.sales_agent_key
WHERE d.sales_agent_key IS NULL;


