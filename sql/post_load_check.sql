DO $$
DECLARE
  problems text := '';
  n bigint;
  t text;
  chk record;
BEGIN
  -- 1. every star-schema table must have rows
  FOREACH t IN ARRAY ARRAY['dim_customer','dim_product','dim_sales_agent','dim_campaign','dim_date',
                           'fact_leads','fact_opportunities','fact_sales','fact_support',
                           'fact_contact_center','fact_website','fact_mobile','fact_social_media'] LOOP
    EXECUTE format('SELECT COUNT(*) FROM %I', t) INTO n;
    IF n = 0 THEN problems := problems || format(' %s is empty;', t); END IF;
  END LOOP;

  -- 2. every required surrogate key must be filled in
  --    (fact_support.date_key is excluded: the support source has no date)
  FOR chk IN SELECT * FROM (VALUES
      ('fact_leads','customer_key'),('fact_leads','sales_agent_key'),('fact_leads','date_key'),
      ('fact_opportunities','customer_key'),('fact_opportunities','sales_agent_key'),
      ('fact_opportunities','product_key'),('fact_opportunities','date_key'),
      ('fact_sales','customer_key'),('fact_sales','sales_agent_key'),('fact_sales','product_key'),('fact_sales','date_key'),
      ('fact_support','customer_key'),
      ('fact_contact_center','customer_key'),('fact_contact_center','date_key'),
      ('fact_website','customer_key'),('fact_website','date_key'),
      ('fact_mobile','customer_key'),('fact_mobile','date_key'),
      ('fact_social_media','customer_key'),('fact_social_media','campaign_key'),('fact_social_media','date_key')
    ) AS v(tbl, col) LOOP
    EXECUTE format('SELECT COUNT(*) FROM %I WHERE %I IS NULL', chk.tbl, chk.col) INTO n;
    IF n > 0 THEN problems := problems || format(' %s.%s has %s empty rows;', chk.tbl, chk.col, n); END IF;
  END LOOP;

  IF problems <> '' THEN
    RAISE EXCEPTION 'ECRMDP post-load check failed:%', problems;
  END IF;
  RAISE NOTICE 'ECRMDP post-load check passed';
END $$;
