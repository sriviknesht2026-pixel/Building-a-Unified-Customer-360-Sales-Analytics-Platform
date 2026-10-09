import pathlib
import pandas as pd

# Paths are relative to the repo, so the script runs from any folder on any laptop
REPO = pathlib.Path(__file__).resolve().parents[2]
RAW = REPO / "datasets"
OUT = REPO / "datasets"

# Load data

customer = pd.read_csv(RAW / "01_customer_master.csv")
lead = pd.read_excel(RAW / "02_lead_management.xlsx")
opportunity = pd.read_json(RAW / "03_opportunity_management.json")
sales = pd.read_xml(RAW / "04_sales_pipeline.xml", parser="etree")
marketing = pd.read_csv(RAW / "05_marketing_campaign.csv")
support = pd.read_csv(RAW / "06_customer_support_tickets.csv")
contact = pd.read_csv(RAW / "07_contact_center_logs.csv")
website = pd.read_csv(RAW / "08_website_registration.csv")
mobile = pd.read_csv(RAW / "09_mobile_application.csv")
social = pd.read_csv(RAW / "10_social_media_engagement.csv")


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
# Title Case breaks country acronyms (UK -> Uk, USA -> Usa); restore them so they match other sources
customer["country"] = customer["country"].replace({"Uk": "UK", "Usa": "USA"})
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

customer.to_csv(OUT / "customer_master_silver.csv", index=False)
lead.to_csv(OUT / "lead_management_silver.csv", index=False)
opportunity.to_csv(OUT / "opportunity_management_silver.csv", index=False)
sales.to_csv(OUT / "sales_pipeline_silver.csv", index=False)
marketing.to_csv(OUT / "marketing_campaign_silver.csv", index=False)
support.to_csv(OUT / "customer_support_tickets_silver.csv", index=False)
contact.to_csv(OUT / "contact_center_logs_silver.csv", index=False)
website.to_csv(OUT / "website_registration_silver.csv", index=False)
mobile.to_csv(OUT / "mobile_application_silver.csv", index=False)
social.to_csv(OUT / "social_media_engagement_silver.csv", index=False)


print("\nData cleaning completed!")
print("Silver files created successfully.")