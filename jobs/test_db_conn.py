from sqlalchemy import create_engine, text

DB_URL = "postgresql+psycopg://app1:app1@127.0.0.1:5433/forecasting"

engine = create_engine(DB_URL, echo=False)

with engine.connect() as conn:
    print(conn.execute(text("select current_user, current_database(), version()")).one())
