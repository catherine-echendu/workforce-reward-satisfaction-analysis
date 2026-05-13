-- ============================================================
-- File: 02_validate_weighted_means.sql
-- Purpose: Cross-check key weighted results from R against
--          SQL weighted calculations.
-- 12 checks passed on 11 May 2026. Maximum difference: 0.004.
-- 7 additional checks performed on 12 May 2026. All passed. Maximum difference: 0.005.
-- Maximum difference across all 19 checks: 0.005
-- Project: WERS Workforce Reward and Satisfaction Analysis
-- Date: 11 May 2026
-- ============================================================


-- ---- Check 1: overall weighted mean job satisfaction -------
-- Expected: 3.650 | SQL result: 3.647 | Pass

SELECT
    COUNT(*) AS n,
    ROUND(
        (SUM(job_sat_index * seqwtnrc_apr13) / SUM(seqwtnrc_apr13))
    ::NUMERIC, 3) AS weighted_mean_jsat
FROM wers_employees
WHERE job_sat_index  IS NOT NULL
  AND seqwtnrc_apr13 IS NOT NULL;


-- ---- Check 2: weighted mean by pay satisfaction category ---
-- Expected: 4.430, 3.890, 3.590, 3.430, 2.960
-- SQL results: 4.430, 3.893, 3.591, 3.427, 2.961 | All pass

SELECT
    qa8f_clean                                          AS pay_sat_category,
    COUNT(*)                                            AS n,
    ROUND(
        (SUM(job_sat_index * seqwtnrc_apr13) / SUM(seqwtnrc_apr13))
    ::NUMERIC, 3)                                       AS weighted_mean_jsat
FROM wers_employees
WHERE job_sat_index  IS NOT NULL
  AND qa8f_clean     IS NOT NULL
  AND seqwtnrc_apr13 IS NOT NULL
GROUP BY qa8f_clean
ORDER BY qa8f_clean;


-- ---- Check 3: weighted mean by training days ---------------
-- Expected: 3.460, 3.520, 3.660, 3.780, 3.850, 4.000
-- SQL results: 3.458, 3.519, 3.659, 3.780, 3.851, 4.004 | All pass

SELECT
    qb3_clean                                           AS training_category,
    COUNT(*)                                            AS n,
    ROUND(
        (SUM(job_sat_index * seqwtnrc_apr13) / SUM(seqwtnrc_apr13))
    ::NUMERIC, 3)                                       AS weighted_mean_jsat
FROM wers_employees
WHERE job_sat_index  IS NOT NULL
  AND qb3_clean      IS NOT NULL
  AND seqwtnrc_apr13 IS NOT NULL
GROUP BY qb3_clean
ORDER BY qb3_clean;


-- ---- Check 4: weighted mean by pension access -------------
-- Expected: No pension 3.670, Has pension 3.610

SELECT
    qe12mul6_clean                                      AS pension,
    COUNT(*)                                            AS n,
    ROUND(
        (SUM(job_sat_index * seqwtnrc_apr13) / SUM(seqwtnrc_apr13))
    ::NUMERIC, 3)                                       AS weighted_mean_jsat
FROM wers_employees
WHERE job_sat_index    IS NOT NULL
  AND qe12mul6_clean   IS NOT NULL
  AND seqwtnrc_apr13   IS NOT NULL
GROUP BY qe12mul6_clean
ORDER BY qe12mul6_clean;


-- ---- Check 5: weighted mean by extra hours pay ------------
-- Expected: No extra hours pay 3.670, Has extra hours pay 3.600

SELECT
    qe12mul5_clean                                      AS extra_hours_pay,
    COUNT(*)                                            AS n,
    ROUND(
        (SUM(job_sat_index * seqwtnrc_apr13) / SUM(seqwtnrc_apr13))
    ::NUMERIC, 3)                                       AS weighted_mean_jsat
FROM wers_employees
WHERE job_sat_index    IS NOT NULL
  AND qe12mul5_clean   IS NOT NULL
  AND seqwtnrc_apr13   IS NOT NULL
GROUP BY qe12mul5_clean
ORDER BY qe12mul5_clean;


-- ---- Check 6: weighted mean by flexi-time access ----------
-- Expected: Uses 3.680, Available not used 3.890, Not available 3.570

SELECT
    qb1a_clean                                          AS flexitime,
    COUNT(*)                                            AS n,
    ROUND(
        (SUM(job_sat_index * seqwtnrc_apr13) / SUM(seqwtnrc_apr13))
    ::NUMERIC, 3)                                       AS weighted_mean_jsat
FROM wers_employees
WHERE job_sat_index  IS NOT NULL
  AND qb1a_clean     IS NOT NULL
  AND seqwtnrc_apr13 IS NOT NULL
GROUP BY qb1a_clean
ORDER BY qb1a_clean;