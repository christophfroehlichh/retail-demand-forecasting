# Supermarket Forecasting Project – 7-Day Sprint Plan

## Ziel nach 7 Tagen (Definition of Done)
- Alle historischen Daten in Postgres
- Simulierte Zeit (`sim_today`) via Offset
- ML-Forecast (LightGBM oder CatBoost) + Baseline
- FastAPI liefert Sales & Forecast
- Streamlit Dashboard (Artikel auswählen → Verkäufe + Forecast)
- Alles per Docker Compose startbar
- Cloud-deploybar ohne Umbau

---

## Tag 1 — Projektgrundgerüst + DB + Daten
1. Git-Repo anlegen, README Skeleton
2. Projektstruktur:
   - `apps/api/`
   - `apps/dashboard/`
   - `jobs/`
   - `db/`
   - `docker/`
3. `docker-compose.yml`:
   - Postgres
   - API (leer / health only)
4. DB-Schema (minimal):
   - `sales` (alle historischen Verkäufe)
   - `items`
   - `stores` (optional)
   - `simulation_state(sim_today, offset_days)`
5. Loader-Script: Dataset → Postgres
6. Sanity Checks (Rowcount, min/max date)

**Deliverable:** `docker compose up` + DB ist gefüllt.

---

## Tag 2 — Simulation + API (Datenzugriff)
7. Simulationslogik festlegen:
   - bekannte Daten = `date <= sim_today`
8. API Endpoints:
   - `GET /items`
   - `GET /sales?store_id=&item_id=&lookback=`
   - `POST /sim/advance?n=1`
9. Rückgabe immer relativ zu `sim_today`

**Deliverable:** API liefert saubere Zeitreihen bis simuliertes Heute.

---

## Tag 3 — Feature Pipeline + Baseline + ML v1
10. Dataset Builder:
    - Lags: 1, 7, 14, 28
    - Rolling Mean: 7, 28
    - Kalenderfeatures (DOW, Month)
11. Baseline:
    - Seasonal Naive (t-7)
12. ML v1:
    - LightGBM oder CatBoost
    - keine Hyperparam-Orgie
13. Mini-Backtest (2–3 Rolling Splits)

**Deliverable:** `train.py` → Metrics + gespeichertes Modell.

---

## Tag 4 — Forecast Job + Speicherung + API
14. Forecast-Tabellen:
    - `forecast_run`
    - `forecast_point`
15. `forecast.py`:
    - lädt Modell
    - erzeugt Forecast (z. B. 14/28 Tage)
    - speichert Ergebnisse in DB
16. API Endpoint:
    - `GET /forecast?store_id=&item_id=&horizon=`
17. Optional: Forecast automatisch nach `sim/advance`

**Deliverable:** API liefert Forecast aus der DB.

---

## Tag 5 — Dashboard (Streamlit)
18. Streamlit App:
    - Store- & Artikel-Auswahl
    - Chart: letzte N Tage Sales + Forecast
    - Anzeige `sim_today`
    - Button: `Advance Day` + `Recompute Forecast`
19. Dashboard dockerisieren + Compose Service

**Deliverable:** Klickbares End-to-End-Demo.

---

## Tag 6 — Stabilisierung + Doku
20. Scope begrenzen:
    - Forecast nur für selektierte Artikel
21. Fehlerhandling & Validierung
22. README:
    - Architektur
    - Setup
    - Beispiel-Screenshots
    - Ergebnisse & Learnings

**Deliverable:** Portfolio-taugliches Projekt.

---

## Tag 7 — Cloud-Readiness (optional Deploy)
23. ENV-Variablen & Secrets sauber
24. Healthchecks
25. CI minimal (Tests + Docker Build)
26. Optional: Deploy (Cloud Run / ECS)

**Deliverable:** Deployt oder zumindest deploy-bereit.

---

## V1-Entscheidungen (bewusst)
- Offset-Simulation statt echtem Daily Pull
- Streamlit statt komplexem Frontend
- 1 starkes ML-Modell + 1 Baseline
- Fokus: End-to-End statt Perfektion

---

## Späteres Upgrade (nach dem Sprint)
- Echter Daily Pull Job
- `fact_sales_live` Tabelle
- Cloud Scheduler
- Model Monitoring & Drift
