# Workforce Reward and Satisfaction Analysis

**Customer & Commercial Insights Analyst portfolio project.** 
End-to-end analysis identifying the highest-value reward levers 
for employee retention, using the WERS 2011 UK workforce survey. 
Decision-support analytics for People and HR leaders.

**Tools:** R · SQL · Power BI · Excel · Word

---

## The business question

If a large UK employer can improve only a small number of reward 
levers in the next 12 to 24 months, which changes to pay, pay 
experience, and key benefits are most strongly associated with 
higher employee job satisfaction, and what does that imply for 
retention risk and reward investment priorities?

This is framed as an advisory analysis for a Head of People 
Analytics or HR Director at a large UK service-sector employer.

---

## Why this matters commercially

Job satisfaction is not just a wellbeing metric. It is a leading 
indicator of retention risk. Industry estimates consistently 
place the cost of replacing an employee at between six and nine 
months of salary, once recruitment, onboarding, and lost 
productivity are accounted for (CIPD, 2024). At an organisation 
of 500 or more employees, even a modest improvement in 
satisfaction among the most at-risk groups can represent a 
material reduction in annual turnover cost.

This project gives a Head of People Analytics a short, 
evidence-based answer to a specific investment question: if 
the reward budget is constrained and only one or two levers 
can be prioritised, which changes are most likely to move 
satisfaction in the right direction, and for which employee 
groups does the case for action look strongest?

---

## What this project demonstrates

- **Cleaning and metric design.** A purpose-built job 
  satisfaction index from seven survey items, with documented 
  reasoning for what is included, what is excluded, and why.
- **Methodology discipline.** Survey weights applied per the 
  data provider's own guidance. Every methodology decision 
  recorded in a versioned methodology log.
- **Cross-tool validation.** R for analysis, SQL for independent 
  verification of every key result. The audit trail is in 
  03_QA/qa_validation_log.xlsx.
- **Modelling.** Weighted regression to rank reward levers by 
  strength of association, plus decision-tree modelling to 
  identify which employee segments are most at risk of low 
  satisfaction.
- **Stakeholder delivery.** A four-page Power BI dashboard 
  built around the questions a Head of People Analytics 
  actually asks.
- **Commercial framing.** Findings translated into language 
  a leadership team can act on: cost, risk, prioritisation, 
  return.

---

## Repository structure
00_data/         Data governance and folder for raw and processed data (gitignored)
01_R/            Numbered R scripts for the full analysis pipeline
02_SQL/          SQL queries for cross-tool validation
03_QA/           Methodology log, validation log, original vs revisit log, daily log
04_outputs/      Final report-ready tables and figures
05_powerbi/      Stakeholder dashboard
06_report/       Executive report (Word)
99_archive/      Superseded versions and legacy files
Each folder contains its own README explaining what belongs 
there and why.

---

## Data source and governance

This project uses the WERS 2011 Survey of Employees, accessed 
via the UK Data Service under End User Licence.

**Department for Business, Innovation and Skills (2013)** 
*Workplace Employment Relations Survey, 2011* [computer file]. 
Colchester, Essex: UK Data Archive [distributor], February 2013. 
SN: 7226. http://dx.doi.org/10.5255/UKDA-SN-7226-1

The raw microdata is **not** included in this repository and 
cannot be redistributed. Researchers wishing to reproduce the 
analysis must obtain the data directly from the UK Data Service 
at https://ukdataservice.ac.uk

---

## Methodology and decision log

Every methodology decision in this project is recorded in 
`methodology_log.md` at the root of this repository. This 
includes the outcome metric design, weighting approach, 
benefits lever decisions, modelling plan, and the project 
documentation system itself.

---

## Project status

This project is in active development. The methodology and 
project structure are locked. Weighted descriptive analysis, 
modelling, SQL validation, and Power BI build are in progress. 
Final executive report and full results to follow.

---

## About the author

Catherine Echendu, Customer & Commercial Insights Analyst.
[LinkedIn](https://linkedin.com/in/catherinenwabuwa)
