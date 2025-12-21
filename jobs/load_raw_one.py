import pandas as pd
from sqlalchemy import create_engine, text

DB_URL = "postgresql+psycopg://app:app@localhost:5433/forecasting"
CSV_PATH = "data/raw/holidays_events.csv"
TABLE = "holidays_events"

engine = create_engine(DB_URL)

df = pd.read_csv(CSV_PATH)

df["transferred"] = df["transferred"].astype("bool")
df["date"] = pd.to_datetime(df["date"], errors="raise").dt.date

with engine.begin() as conn:
    # optional: vorher leeren, damit du beim Test nicht doppelt lädst
    conn.execute(text(f"TRUNCATE TABLE raw.{TABLE};"))

df.to_sql(TABLE, engine, schema="raw", if_exists="append", index=False, method="multi", chunksize=50_000)


print("OK loaded:", len(df))
