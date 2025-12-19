supermarket-forecasting/
│
├─ apps/
│  ├─ api/          # FastAPI (liefert Sales & Forecast)
│  └─ dashboard/    # Streamlit Dashboard
│
├─ src/             # CORE LOGIK (ML + Data)
│  ├─ data/         # Laden, Queries, Simulation
│  ├─ features/     # Feature Engineering
│  ├─ models/       # ML-Modelle (train / predict)
│  ├─ evaluation/   # Metrics, Backtests
│
├─ jobs/            # ausführbare Jobs (train, forecast, ingest)
│
├─ db/              # Schema, Migrations
│
├─ docker/          # Dockerfiles
│
├─ tests/
│
├─ data/            # raw data (gitignored)
│
├─ README.md
