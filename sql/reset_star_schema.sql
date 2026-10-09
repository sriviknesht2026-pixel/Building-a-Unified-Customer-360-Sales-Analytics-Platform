-- Clears the star schema so the master ETL job can reload it from scratch (bronze tables are truncated by their own transformations).
TRUNCATE TABLE fact_leads, fact_opportunities, fact_sales, fact_support, fact_contact_center, fact_website, fact_mobile, fact_social_media, dim_customer, dim_product, dim_sales_agent, dim_campaign, dim_date RESTART IDENTITY CASCADE;
