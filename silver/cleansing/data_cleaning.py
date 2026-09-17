import pandas as pd

# Load data

customer = pd.read_csv("../Datasets/customer_360_mixed_formats/01_customer_master(2).csv")
lead = pd.read_excel("../Datasets/customer_360_mixed_formats/02_lead_management(1).xlsx")
opportunity = pd.read_json("../Datasets/customer_360_mixed_formats/03_opportunity_management(1).json")
sales = pd.read_xml("../Datasets/customer_360_mixed_formats/04_sales_pipeline(1).xml")
marketing = pd.read_csv("../Datasets/customer_360_mixed_formats/05_marketing_campaign(2).csv")
support = pd.read_csv("../Datasets/customer_360_mixed_formats/06_customer_support_tickets(2).csv")
contact = pd.read_csv("../Datasets/customer_360_mixed_formats/07_contact_center_logs(2).csv")
website = pd.read_csv("../Datasets/customer_360_mixed_formats/08_website_registration(2).csv")
mobile = pd.read_csv("../Datasets/customer_360_mixed_formats/09_mobile_application(2).csv")
social = pd.read_csv("../Datasets/customer_360_mixed_formats/10_social_media_engagement(2).csv")


# Remove duplicate rows

customer = customer.drop_duplicates()
lead = lead.drop_duplicates()
opportunity = opportunity.drop_duplicates()
sales = sales.drop_duplicates()
marketing = marketing.drop_duplicates()
support = support.drop_duplicates()
contact = contact.drop_duplicates()
website = website.drop_duplicates()
mobile = mobile.drop_duplicates()
social = social.drop_duplicates()


# Remove duplicate IDs

customer = customer.drop_duplicates("customer_id")
lead = lead.drop_duplicates("lead_id")
opportunity = opportunity.drop_duplicates("opportunity_id")
sales = sales.drop_duplicates("deal_id")
marketing = marketing.drop_duplicates("campaign_id")
support = support.drop_duplicates("ticket_id")
contact = contact.drop_duplicates("interaction_id")
website = website.drop_duplicates("registration_id")
mobile = mobile.drop_duplicates("app_event_id")
social = social.drop_duplicates("engagement_id")


# Clean text

customer["email"] = customer["email"].str.strip().str.lower()

support["customer_email"] = support["customer_email"].str.strip().str.lower()

customer["gender"] = customer["gender"].str.strip().str.title()
customer["country"] = customer["country"].str.strip().str.title()
customer["city"] = customer["city"].str.strip().str.title()

lead["lead_source"] = lead["lead_source"].str.strip().str.title()
lead["lead_status"] = lead["lead_status"].str.strip().str.title()

opportunity["product"] = opportunity["product"].str.strip()
opportunity["opportunity_stage"] = opportunity["opportunity_stage"].str.strip().str.title()

sales["product"] = sales["product"].str.strip()
sales["deal_stage"] = sales["deal_stage"].str.strip().str.title()


# Convert dates

customer["registration_date"] = pd.to_datetime(
    customer["registration_date"], errors="coerce"
)

lead["lead_date"] = pd.to_datetime(
    lead["lead_date"], errors="coerce"
)

opportunity["created_date"] = pd.to_datetime(
    opportunity["created_date"], errors="coerce"
)

sales["engage_date"] = pd.to_datetime(
    sales["engage_date"], errors="coerce"
)

sales["close_date"] = pd.to_datetime(
    sales["close_date"], errors="coerce"
)


# Fill missing numeric values

customer["income"] = customer["income"].fillna(customer["income"].median())

customer["age"] = customer["age"].fillna(customer["age"].median())

lead["lead_score"] = lead["lead_score"].fillna(lead["lead_score"].median())

opportunity["probability"] = opportunity["probability"].fillna(
    opportunity["probability"].median()
)


# Save cleaned data

customer.to_csv("../Datasets/customer_master_silver.csv", index=False)
lead.to_csv("../Datasets/lead_management_silver.csv", index=False)
opportunity.to_csv("../Datasets/opportunity_management_silver.csv", index=False)
sales.to_csv("../Datasets/sales_pipeline_silver.csv", index=False)
marketing.to_csv("../Datasets/marketing_campaign_silver.csv", index=False)
support.to_csv("../Datasets/customer_support_tickets_silver.csv", index=False)
contact.to_csv("../Datasets/contact_center_logs_silver.csv", index=False)
website.to_csv("../Datasets/website_registration_silver.csv", index=False)
mobile.to_csv("../Datasets/mobile_application_silver.csv", index=False)
social.to_csv("../Datasets/social_media_engagement_silver.csv", index=False)


print("\nData cleaning completed!")
print("Silver files created successfully.")