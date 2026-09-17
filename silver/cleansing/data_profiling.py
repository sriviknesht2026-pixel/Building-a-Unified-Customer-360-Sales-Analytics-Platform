import pandas as pd


# -----------------------------------------
# FILE PATHS
# -----------------------------------------

files = {
    "customer_master": "../Datasets/customer_360_mixed_formats/01_customer_master(2).csv",
    "lead_management": "../Datasets/customer_360_mixed_formats/02_lead_management(1).xlsx",
    "opportunity_management": "../Datasets/customer_360_mixed_formats/03_opportunity_management(1).json",
    "sales_pipeline": "../Datasets/customer_360_mixed_formats/04_sales_pipeline(1).xml",
    "marketing_campaign": "../Datasets/customer_360_mixed_formats/05_marketing_campaign(2).csv",
    "customer_support_tickets": "../Datasets/customer_360_mixed_formats/06_customer_support_tickets(2).csv",
    "contact_center_logs": "../Datasets/customer_360_mixed_formats/07_contact_center_logs(2).csv",
    "website_registration": "../Datasets/customer_360_mixed_formats/08_website_registration(2).csv",
    "mobile_application": "../Datasets/customer_360_mixed_formats/09_mobile_application(2).csv",
    "social_media_engagement": "../Datasets/customer_360_mixed_formats/10_social_media_engagement(2).csv"
}


# -----------------------------------------
# LOAD DATA
# -----------------------------------------

def load_data(name, path):

    print("\nLoading:", name)

    if path.endswith(".csv"):
        return pd.read_csv(path)

    elif path.endswith(".xlsx"):
        return pd.read_excel(path)

    elif path.endswith(".json"):
        return pd.read_json(path)

    elif path.endswith(".xml"):
        return pd.read_xml(path)


# -----------------------------------------
# LOAD ALL DATASETS
# -----------------------------------------

data = {}

for name, path in files.items():

    df = load_data(name, path)

    data[name] = df

    print("Rows    :", len(df))
    print("Columns :", len(df.columns))


# -----------------------------------------
# PROFILING
# -----------------------------------------

for name, df in data.items():

    print("\n")
    print("=" * 60)
    print("DATASET:", name)
    print("=" * 60)

    # Shape
    print("\nShape:")
    print(df.shape)

    # Columns
    print("\nColumns:")
    print(df.columns.tolist())

    # Data types
    print("\nData Types:")
    print(df.dtypes)

    # Missing values
    print("\nMissing Values:")
    print(df.isnull().sum())

    # Missing percentage
    print("\nMissing Percentage:")
    print(
        (df.isnull().sum() / len(df) * 100).round(2)
    )

    # Duplicate rows
    print("\nDuplicate Rows:")
    print(df.duplicated().sum())

    # Unique values
    print("\nUnique Values:")
    print(df.nunique())

    # Numerical statistics
    print("\nNumerical Statistics:")
    print(df.describe())

    # Categorical values
    print("\nCategorical Values:")

    categorical_columns = df.select_dtypes(
        include=["object", "category"]
    ).columns

    for column in categorical_columns:

        print("\n", column)

        print(
            df[column]
            .value_counts(dropna=False)
            .head(20)
        )

    # First 5 rows
    print("\nFirst 5 Rows:")
    print(df.head())


# -----------------------------------------
# COMPLETED
# -----------------------------------------

print("\n")
print("=" * 60)
print("DATA PROFILING COMPLETED")
print("=" * 60)