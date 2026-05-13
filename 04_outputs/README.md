# Outputs

Final analysis outputs exported from R.

## Structure

- `tables/` contains CSV exports of weighted descriptives, SQL-validated summary tables, regression coefficients and decision-tree rules.
- `figures/` contains PNG exports of report figures, including the decision-tree segment visual.

## Current outputs

Completed outputs include:

- weighted job satisfaction summary
- weighted pay satisfaction gradient
- weighted grouped pay band summary
- weighted benefit lever summaries
- model coefficients
- decision-tree rules
- decision-tree figure

The Word report in `06_report/` pulls from these files. The Power BI dashboard in `05_powerbi/` will use the final CSV outputs as its source or reference layer.

No raw or row-level microdata should be stored here.