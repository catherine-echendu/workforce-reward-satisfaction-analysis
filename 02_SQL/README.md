# SQL validation queries

Cross-tool QA layer. Each query reproduces a result from R and
confirms it independently. Used to evidence end-to-end pipeline
validation, not as a primary analysis tool.

**Status: Complete — 12 May 2026**
19 validation checks run. All passed. Maximum difference 0.005.
Full results logged in 03_QA/qa_validation_log.xlsx.

## Validation scope

**Initial checks (11 May 2026) — 12 checks:**
- Overall weighted mean job satisfaction
- Pay satisfaction gradient (5 categories)
- Training gradient (6 categories)

**Extended checks (12 May 2026) — 7 additional checks:**
- Pension (2 categories)
- Extra hours pay (2 categories)
- Flexi-time (3 categories)

**Rationale for extension:** initial 12 checks covered headline
findings. Extended to 19 to align with real-life validation
standards and ensure all five benefit levers are independently
confirmed.

## Files

- `00_check_connection.sql`  
  Confirms the active PostgreSQL connection, database name, user and server port.

- `00_create_wers_database.sql`  
  Creates the separate `wers_project` PostgreSQL database. Run once from the default `postgres` connection.

- `01_create_validation_table.sql`  
  Creates the `wers_employees` validation table in the `wers_project` database. The table is populated manually from the local `wers_validation.csv` file, which is not committed to GitHub.

- `02_validate_weighted_means.sql`  
  Runs all 19 weighted mean checks: overall job satisfaction, pay satisfaction gradient, training gradient, pension, extra hours pay and flexi-time.

Each result and any discrepancy is logged in `03_QA/qa_validation_log.xlsx`.
