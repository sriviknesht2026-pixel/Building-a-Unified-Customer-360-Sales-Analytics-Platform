# Building-a-Unified-Customer-360-Sales-Analytics-Platform
Enterprise Customer Relationship Management Data Platform (ECRMDP) that integrates multi-source CRM and digital-channel data using Pentaho, PostgreSQL, Python/Pandas, and Power BI to enable unified Customer 360, sales analytics, marketing insights, and executive reporting.

## Local setup (any laptop)

Prerequisites: PostgreSQL, Pentaho Data Integration (Spoon), Python 3.

1. Install the database driver:
   ```
   pip install psycopg2-binary
   ```
2. Create your own config file from the template and put your PostgreSQL password in it:
   ```
   cp config/db.env.example config/db.env        # Mac/Linux
   copy config\db.env.example config\db.env      # Windows
   ```
   `config/db.env` is git-ignored, so each teammate keeps their own credentials.
3. Run the setup script from the repo root:
   ```
   python deployment/setup_env.py
   ```
   It writes `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, `DB_PASSWORD` into `~/.kettle/kettle.properties`,
   creates the database if needed, and creates all staging and star-schema tables.
4. Restart Spoon and run **`pentaho/jobs/ECRMDP_Master_ETL.kjb`**. In one run it:
   - clears the star schema (`sql/reset_star_schema.sql`), so it is safe to run again,
   - loads the 10 bronze staging tables,
   - builds `dim_date` and the other dimensions, then the 8 facts,
   - runs `sql/post_load_check.sql`, which fails the job if any table is empty or a required key is missing.

   The individual jobs (`pentaho/jobs/ECRMDP_Sprint1_ETL.kjb`, `silver/job_1.kjb`) still work on their own.

All Pentaho files use paths relative to the repo and a `DA-1_Project` connection built from those variables,
so nothing needs editing per machine.

## Reconciliation & validation report

After the master ETL job finishes, run from the repo root:
```
pip install pandas openpyxl psycopg2-binary
python python/reconciliation.py
```
It compares every layer (raw file → bronze → silver → warehouse) on row counts, column totals and business IDs,
checks every surrogate key for empty or orphan values, and writes `docs/ECRMDP_Validation_Report.xlsx`.
The script exits with code 1 if any check fails.

## Continuous deployment

`.github/workflows/deploy.yml` runs on every push to `main`: it deploys the SQL schema to a fresh PostgreSQL,
runs `sql/gold_validation.sql`, and builds a project bundle. Pushing a tag such as `v1.0.0` publishes the bundle as a GitHub Release.
