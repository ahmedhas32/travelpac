import duckdb, pandas as pd

df = pd.read_excel(r"C:\Users\user\Downloads\travelpac\TravelPac for upload\TravelPac 2009-2019 Labelled.xlsx", sheet_name="Labelled 2009-2019")
con = duckdb.connect("travelpac.duckdb", config={"storage_compatibility_version": "v1.0.0"})
con.execute("create schema if not exists raw")
con.execute("create or replace table raw.travelpac as select * from df")
print(con.execute("select count(*) from raw.travelpac").fetchone())
con.close()