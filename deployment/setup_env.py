"""
ECRMDP one-command local setup.

What it does (safe to run again any time):
  1. Reads your database settings from config/db.env
  2. Writes them into Pentaho's ~/.kettle/kettle.properties as DB_HOST, DB_PORT,
     DB_NAME, DB_USER, DB_PASSWORD (the DA-1_Project connection in every .ktr uses these)
  3. Creates the database if it does not exist
  4. Runs the SQL scripts that create the staging tables and the star schema

Usage (from the repo root):
  pip install psycopg2-binary
  copy config\\db.env.example config\\db.env      (Windows)
  cp config/db.env.example config/db.env           (Mac/Linux)
  -> edit config/db.env with your password
  python deployment/setup_env.py

Options:
  --skip-db     only write kettle.properties, don't touch PostgreSQL
"""
import pathlib
import sys

REPO = pathlib.Path(__file__).resolve().parent.parent
ENV_FILE = REPO / "config" / "db.env"
KEYS = ["DB_HOST", "DB_PORT", "DB_NAME", "DB_USER", "DB_PASSWORD"]
SQL_FILES = ["sql/TableCreation_DA_1_DE.sql", "sql/Silver.sql"]


def load_env():
    if not ENV_FILE.exists():
        sys.exit(f"Missing {ENV_FILE}\nCopy config/db.env.example to config/db.env and fill in your values.")
    cfg = {}
    for line in ENV_FILE.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if line and not line.startswith("#") and "=" in line:
            k, v = line.split("=", 1)
            cfg[k.strip()] = v.strip()
    missing = [k for k in KEYS if not cfg.get(k)]
    if missing:
        sys.exit(f"config/db.env is missing: {', '.join(missing)}")
    return cfg


def write_kettle_properties(cfg):
    kettle_dir = pathlib.Path.home() / ".kettle"
    kettle_dir.mkdir(parents=True, exist_ok=True)
    props = kettle_dir / "kettle.properties"
    lines = props.read_text(encoding="utf-8").splitlines() if props.exists() else []
    # keep every existing line except our own keys, then append ours
    marker = "# ECRMDP database connection (written by deployment/setup_env.py)"
    kept = [l for l in lines if l.split("=", 1)[0].strip() not in KEYS and l.strip() != marker]
    while kept and not kept[-1].strip():
        kept.pop()
    kept += ["", marker]
    kept += [f"{k}={cfg[k]}" for k in KEYS]
    props.write_text("\n".join(kept).strip() + "\n", encoding="utf-8")
    print(f"[ok] Pentaho variables written to {props}")


def setup_database(cfg):
    try:
        import psycopg2
        from psycopg2 import sql
    except ImportError:
        sys.exit("psycopg2 is not installed. Run:  pip install psycopg2-binary")

    conn_args = dict(host=cfg["DB_HOST"], port=cfg["DB_PORT"],
                     user=cfg["DB_USER"], password=cfg["DB_PASSWORD"])

    # 1. create the database if needed (connect to the default 'postgres' db first)
    con = psycopg2.connect(dbname="postgres", **conn_args)
    con.autocommit = True
    with con.cursor() as cur:
        cur.execute("SELECT 1 FROM pg_database WHERE datname = %s", (cfg["DB_NAME"],))
        if cur.fetchone():
            print(f"[ok] Database '{cfg['DB_NAME']}' already exists")
        else:
            cur.execute(sql.SQL("CREATE DATABASE {}").format(sql.Identifier(cfg["DB_NAME"])))
            print(f"[ok] Created database '{cfg['DB_NAME']}'")
    con.close()

    # 2. run the schema scripts
    con = psycopg2.connect(dbname=cfg["DB_NAME"], **conn_args)
    con.autocommit = True
    with con.cursor() as cur:
        for rel in SQL_FILES:
            cur.execute((REPO / rel).read_text(encoding="utf-8"))
            print(f"[ok] Ran {rel}")
        cur.execute("SELECT count(*) FROM information_schema.tables WHERE table_schema = 'public'")
        print(f"[ok] {cur.fetchone()[0]} tables now in '{cfg['DB_NAME']}'")
    con.close()


if __name__ == "__main__":
    cfg = load_env()
    write_kettle_properties(cfg)
    if "--skip-db" not in sys.argv:
        setup_database(cfg)
    print("\nDone. Restart Spoon so it picks up the new variables, then run the Pentaho jobs.")
