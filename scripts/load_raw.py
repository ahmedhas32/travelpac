from pathlib import Path
import duckdb, pandas as pd

PROJECT_DIR = Path(__file__).resolve().parents[1]
XLSX = PROJECT_DIR.parent / "TravelPac 2009-2019 Labelled.xlsx"
DB = PROJECT_DIR / "travelpac.duckdb"

df = pd.read_excel(XLSX, sheet_name="Labelled 2009-2019")
con = duckdb.connect(str(DB), config={"storage_compatibility_version": "v1.0.0"})
con.execute("create schema if not exists raw")
con.execute("create or replace table raw.travelpac as select * from df")
print(con.execute("select count(*) from raw.travelpac").fetchone())
con.close()