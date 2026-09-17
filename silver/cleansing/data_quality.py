import pandas as pd

# Load datasets

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


# ------------------------------------------------
# 1. NULL VALUES
# ------------------------------------------------

print("\nNULL VALUES")

print("Customer:", customer.isnull().sum().sum())
print("Lead:", lead.isnull().sum().sum())
print("Opportunity:", opportunity.isnull().sum().sum())
print("Sales:", sales.isnull().sum().sum())
print("Marketing:", marketing.isnull().sum().sum())
print("Support:", support.isnull().sum().sum())
print("Contact:", contact.isnull().sum().sum())
print("Website:", website.isnull().sum().sum())
print("Mobile:", mobile.isnull().sum().sum())
print("Social:", social.isnull().sum().sum())


# ------------------------------------------------
# 2. DUPLICATE ROWS
# ------------------------------------------------

print("\nDUPLICATE ROWS")

print("Customer:", customer.duplicated().sum())
print("Lead:", lead.duplicated().sum())
print("Opportunity:", opportunity.duplicated().sum())
print("Sales:", sales.duplicated().sum())
print("Marketing:", marketing.duplicated().sum())
print("Support:", support.duplicated().sum())
print("Contact:", contact.duplicated().sum())
print("Website:", website.duplicated().sum())
print("Mobile:", mobile.duplicated().sum())
print("Social:", social.duplicated().sum())


# ------------------------------------------------
# 3. PRIMARY KEY DUPLICATES
# ------------------------------------------------

print("\nPRIMARY KEY DUPLICATES")

print("Customer ID:", customer["customer_id"].duplicated().sum())
print("Lead ID:", lead["lead_id"].duplicated().sum())
print("Opportunity ID:", opportunity["opportunity_id"].duplicated().sum())
print("Deal ID:", sales["deal_id"].duplicated().sum())
print("Campaign ID:", marketing["campaign_id"].duplicated().sum())
print("Ticket ID:", support["ticket_id"].duplicated().sum())
print("Interaction ID:", contact["interaction_id"].duplicated().sum())
print("Registration ID:", website["registration_id"].duplicated().sum())
print("App Event ID:", mobile["app_event_id"].duplicated().sum())
print("Engagement ID:", social["engagement_id"].duplicated().sum())


# ------------------------------------------------
# 4. FOREIGN KEY CHECK
# ------------------------------------------------

print("\nFOREIGN KEY CHECK")

print(
    "Lead -> Customer:",
    (~lead["customer_id"].isin(customer["customer_id"])).sum()
)

print(
    "Opportunity -> Customer:",
    (~opportunity["customer_id"].isin(customer["customer_id"])).sum()
)

print(
    "Opportunity -> Lead:",
    (~opportunity["lead_id"].isin(lead["lead_id"])).sum()
)

print(
    "Sales -> Customer:",
    (~sales["customer_id"].isin(customer["customer_id"])).sum()
)

print(
    "Sales -> Opportunity:",
    (~sales["opportunity_id"].isin(opportunity["opportunity_id"])).sum()
)

print(
    "Support -> Customer:",
    (~support["customer_id"].isin(customer["customer_id"])).sum()
)

print(
    "Contact -> Customer:",
    (~contact["customer_id"].isin(customer["customer_id"])).sum()
)

print(
    "Website -> Customer:",
    (~website["customer_id"].isin(customer["customer_id"])).sum()
)

print(
    "Mobile -> Customer:",
    (~mobile["customer_id"].isin(customer["customer_id"])).sum()
)

print(
    "Social -> Customer:",
    (~social["customer_id"].isin(customer["customer_id"])).sum()
)

print(
    "Social -> Campaign:",
    (~social["campaign_id"].isin(marketing["campaign_id"])).sum()
)


# ------------------------------------------------
# 5. RANGE CHECKS
# ------------------------------------------------

print("\nRANGE CHECKS")

print("Invalid age:", ((customer["age"] < 18) | (customer["age"] > 100)).sum())

print("Invalid lead score:",
      ((lead["lead_score"] < 0) | (lead["lead_score"] > 100)).sum())

print("Invalid probability:",
      ((opportunity["probability"] < 0) |
       (opportunity["probability"] > 100)).sum())

print("Invalid support rating:",
      ((support["customer_satisfaction_rating"] < 1) |
       (support["customer_satisfaction_rating"] > 5)).sum())

print("Invalid contact rating:",
      ((contact["satisfaction_score"] < 1) |
       (contact["satisfaction_score"] > 5)).sum())


# ------------------------------------------------
# 6. SALES DATE CHECK
# ------------------------------------------------

print("\nDATE CHECK")

sales["engage_date"] = pd.to_datetime(sales["engage_date"])
sales["close_date"] = pd.to_datetime(sales["close_date"])

print(
    "Close date before engage date:",
    (sales["close_date"] < sales["engage_date"]).sum()
)


print("\nDATA QUALITY CHECK COMPLETED")