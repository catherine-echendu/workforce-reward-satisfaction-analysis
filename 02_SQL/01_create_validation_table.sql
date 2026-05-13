-- ============================================================
-- File: 01_create_validation_table.sql
-- Purpose: Create the main employee validation table in
--          wers_project database for cross-checking R outputs.
-- Project: WERS Workforce Reward and Satisfaction Analysis
-- Date: 11 May 2026
-- ============================================================

CREATE TABLE IF NOT EXISTS wers_employees (
    serno               NUMERIC,
    seqwtnrc_apr13      NUMERIC,
    job_sat_index       NUMERIC,
    qa8f_clean          NUMERIC,
    qe11_clean          NUMERIC,
    qb3_clean           NUMERIC,
    qe12mul5_clean      NUMERIC,
    qe12mul6_clean      NUMERIC,
    qb1a_clean          NUMERIC,
    qb1b_clean          NUMERIC
);