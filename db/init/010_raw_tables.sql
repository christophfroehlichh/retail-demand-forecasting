-- RAW = 1:1 aus CSV (so wenig Logik wie möglich)

CREATE TABLE IF NOT EXISTS raw.train (
  id            BIGINT PRIMARY KEY,
  date          DATE NOT NULL,
  store_nbr     INTEGER NOT NULL,
  item_nbr      INTEGER NOT NULL,
  unit_sales    DOUBLE PRECISION,
  onpromotion   BOOLEAN
);

CREATE TABLE IF NOT EXISTS raw.test (
  id            BIGINT PRIMARY KEY,
  date          DATE NOT NULL,
  store_nbr     INTEGER NOT NULL,
  item_nbr      INTEGER NOT NULL,
  onpromotion   BOOLEAN
);

CREATE TABLE IF NOT EXISTS raw.transactions (
  date          DATE NOT NULL,
  store_nbr     INTEGER NOT NULL,
  transactions  INTEGER,
  PRIMARY KEY (date, store_nbr)
);

CREATE TABLE IF NOT EXISTS raw.items (
  item_nbr     INTEGER PRIMARY KEY,
  family       TEXT,
  class        INTEGER,
  perishable   INTEGER
);

CREATE TABLE IF NOT EXISTS raw.stores (
  store_nbr    INTEGER PRIMARY KEY,
  city         TEXT,
  state        TEXT,
  type         TEXT,
  cluster      INTEGER
);

CREATE TABLE IF NOT EXISTS raw.oil (
  date        DATE PRIMARY KEY,
  dcoilwtico  DOUBLE PRECISION
);

CREATE TABLE IF NOT EXISTS raw.holidays_events (
  date          DATE NOT NULL,
  type          TEXT,
  locale        TEXT,
  locale_name   TEXT,
  description   TEXT,
  transferred   BOOLEAN
);

CREATE TABLE IF NOT EXISTS raw.sample_submission (
  id          BIGINT PRIMARY KEY,
  unit_sales  DOUBLE PRECISION
);
