-- ============================================================
-- 02_data_and_view.sql
-- Compound Interest Growth: Banking vs. Investing
-- Adds full scenario dataset and creates the growth_results view
-- ============================================================

SELECT * FROM `compound_interest-project_8426`.scenarios;
SELECT @@autocommit;

-- Full scenario dataset: banking and investing accounts at varying principals
INSERT INTO scenarios (scenario_id, principal, monthly_rate, account_type) VALUES
(1, 1000.00, 0.004074, 'banking'),
(2, 5000.00, 0.004074, 'banking'),
(3, 50000.00, 0.009489, 'investing'),
(4, 100000.00, 0.009489, 'investing'),
(5, 1000.00, 0.004074, 'banking'),
(6, 5000.00, 0.004074, 'banking'),
(7, 1000.00, 0.009489, 'investing'),
(8, 5000.00, 0.009489, 'investing');

SELECT * FROM scenarios;
SELECT DATABASE();

-- Preview compounded balances before formalizing as a view
SELECT 
    s.scenario_id,
    s.principal,
    s.monthly_rate,
    s.account_type,
    m.month_number,
    ROUND(s.principal * POWER(1 + s.monthly_rate, m.month_number), 2) AS balance
FROM scenarios s
JOIN months m
ORDER BY s.scenario_id, m.month_number;

-- Core view: compounded balance per scenario, per month
CREATE VIEW growth_results AS
SELECT 
    s.scenario_id,
    s.principal,
    s.monthly_rate,
    s.account_type,
    m.month_number,
    ROUND(s.principal * POWER(1 + s.monthly_rate, m.month_number), 2) AS balance
FROM scenarios s
JOIN months m;

SELECT * FROM growth_results LIMIT 10;
DESCRIBE growth_results;

-- Final balances at month 60 (5 years), ranked highest to lowest
SELECT scenario_id, principal, account_type, balance
FROM growth_results
WHERE month_number = 60
ORDER BY balance DESC;

-- Month-over-month dollar increase per scenario
SELECT
    curr.scenario_id,
    curr.account_type,
    curr.month_number,
    curr.balance AS current_balance,
    prev.balance AS previous_balance,
    ROUND(curr.balance - prev.balance, 2) AS dollar_increase
FROM growth_results curr
JOIN growth_results prev
    ON curr.scenario_id = prev.scenario_id
    AND curr.month_number = prev.month_number + 1
ORDER BY curr.scenario_id, curr.month_number;

-- Single largest month-over-month dollar increase across all scenarios
SELECT 
    curr.scenario_id,
    curr.account_type,
    curr.month_number,
    ROUND(curr.balance - prev.balance, 2) AS dollar_increase
FROM growth_results curr
JOIN growth_results prev
    ON curr.scenario_id = prev.scenario_id
    AND curr.month_number = prev.month_number + 1
ORDER BY dollar_increase DESC
LIMIT 1;

-- ============================================================
-- Adding CD (Certificate of Deposit) scenarios with varying terms
-- ============================================================

SELECT MAX(scenario_id) FROM scenarios;
SELECT * FROM scenarios ORDER BY scenario_id;

INSERT INTO scenarios (scenario_id, principal, monthly_rate, account_type) VALUES
(9, 5000.00, 0.004074, '1yr_CD'),
(10, 5000.00, 0.003683, '3yr_CD'),
(11, 5000.00, 0.003274, '5yr_CD');

SELECT * FROM scenarios WHERE scenario_id IN (9, 10, 11);

-- Widen monthly_rate precision to accommodate CD rate decimals
ALTER TABLE scenarios
MODIFY COLUMN monthly_rate DECIMAL(9, 6);

UPDATE scenarios SET monthly_rate = 0.004074 WHERE scenario_id = 9;
UPDATE scenarios SET monthly_rate = 0.003683 WHERE scenario_id = 10;
UPDATE scenarios SET monthly_rate = 0.003274 WHERE scenario_id = 11;

SELECT * FROM scenarios WHERE scenario_id IN (9, 10, 11);
SELECT COUNT(*) FROM growth_results;

-- Final balances at month 60, now including CD scenarios
SELECT scenario_id, principal, account_type, balance
FROM growth_results
WHERE month_number = 60
ORDER BY balance DESC;
