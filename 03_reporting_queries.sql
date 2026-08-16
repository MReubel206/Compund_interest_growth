-- ============================================================
-- 03_reporting_queries.sql
-- Compound Interest Growth: Banking vs. Investing
-- Queries used to feed the Excel PivotTable and comparison chart
-- ============================================================

-- Distinct scenario reference list
SELECT DISTINCT scenario_id, account_type, principal, monthly_rate
FROM scenarios
ORDER BY scenario_id;

-- Full growth timeline across all account types
SELECT 
    account_type,
    scenario_id,
    month_number,
    balance
FROM growth_results
WHERE account_type IN ('banking', 'investing', '1yr_CD', '3yr_CD', '5yr_CD')
ORDER BY account_type, scenario_id, month_number;

-- Chart dataset: banking, investing, and CD scenarios side-by-side
SELECT 
    account_type,
    month_number,
    balance
FROM growth_results
WHERE scenario_id IN (2, 4, 9, 10, 11)
ORDER BY account_type, month_number;

-- Alternate chart dataset comparing a different scenario mix
SELECT 
    account_type,
    month_number,
    balance 
FROM growth_results
WHERE scenario_id IN (2, 8, 9, 10, 11)
ORDER BY account_type, month_number;

DESCRIBE scenarios;
