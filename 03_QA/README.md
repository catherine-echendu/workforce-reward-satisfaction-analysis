# 03_QA

Project quality assurance and operational logs.

## Why this folder exists

In commercial and regulated analytics environments, the analysis
is only as trustworthy as the audit trail behind it. This folder
holds the documents that make this project auditable: every
methodology decision, every cross-tool check, every deliberate
departure from the original analysis, and a session-by-session
record of progress and decisions made.

A hiring manager or senior stakeholder should be able to open
any file in this folder and understand exactly what was done,
why it was done, and what was checked. That is the standard
this project is built to.

## Files

**qa_validation_log.xlsx**
Every cross-tool check between R and SQL. Each row records what
was checked, the R result, the SQL result, whether they matched,
and any notes on investigation or resolution. Updated every time
a validation check is run. This is the document that answers
the interview question: how do you know your numbers are right?

**original_vs_revisit_log.xlsx**
A structured record of every deliberate change made between the
original MSc analysis and this revisit. Two tabs: a summary
table for quick reference, and detailed analytical notes
explaining the reasoning behind each change. Makes the
evolution of the project fully transparent and defensible.

**daily_work_log.xlsx**
A session-by-session record across two tabs. Tab 1 captures
what was done, what was learned, and what comes next. Tab 2
is a project status tracker showing where each workflow stage
stands. Kept deliberately simple so it reflects how a real
analyst actually works over time.

## The four-document system

This project uses exactly four operational documents. No more.
Each one earns its place by serving a specific, recurring
purpose. Additional documents such as risk logs, stakeholder
logs, and sprint boards are deliberately excluded because on a
solo analytical project they produce admin overhead without
adding analytical value. The full reasoning behind each
exclusion is recorded in the methodology log.
