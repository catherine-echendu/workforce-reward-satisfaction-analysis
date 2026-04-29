# 05_powerbi

Stakeholder-facing dashboard built in Power BI.

## Why Power BI and not just a report

A written report tells stakeholders what the data says.
A dashboard lets them ask their own questions. For a Head of
People Analytics deciding where to invest a constrained reward
budget, being able to filter by pay band, contract type, or
benefit access and immediately see how job satisfaction shifts
is more useful than reading a static table.

This dashboard is designed for a non-technical audience. Every
page has a single clear question at the top and a single clear
answer. The methodology is visible but does not get in the way.

## Dashboard structure

**Page 1: Overview**
What is the overall state of employee job satisfaction?
Headline satisfaction score, three-band split (Low, Moderate,
High), key caveats, and sample size.

**Page 2: Pay**
Does how employees feel about their pay matter more than where
they sit in the pay structure?
Pay satisfaction gradient, grouped pay band comparison, and
the headline finding: subjective pay experience is a stronger
predictor of job satisfaction than objective pay level.

**Page 3: Benefits**
Which benefit levers are most strongly associated with higher
job satisfaction?
Job satisfaction by each of the locked benefit levers, ranked
by association strength.

**Page 4: Data quality and methodology**
How were these numbers produced and how reliable are they?
Row counts, weighting approach, missingness summary, variable
definitions, and SQL cross-checks. This page exists because
in a regulated environment, showing your working is not
optional.

## Why this matters for the portfolio

A Customer and Commercial Insights Analyst is not hired to
produce a static report. They are hired to put decision-grade
information in the hands of stakeholders, in the format those
stakeholders can actually use. This dashboard is the equivalent
of what would be delivered to a leadership team in a real
organisation: filterable, focused, and defensible.

Building it on a nationally representative UK workforce survey,
with weighted analysis and cross-tool validation behind every
number, demonstrates the same discipline required in financial
services and regulated commercial environments.

## File

The Power BI source file (.pbix) is treated as a working
source file, equivalent to code. It is versioned here
alongside the R scripts and SQL queries, not in the outputs
folder.

Final exported visuals are saved to 04_outputs/figures/ for
use in the Word report and any presentation materials.

## Data governance

The Power BI file connects to aggregated output tables from
04_outputs/tables/ only. No individual-level WERS microdata
is loaded into Power BI. The WERS microdata is licensed by
the UK Data Service under End User Licence and cannot be
redistributed in any form.
