-- ============================================================
-- 01_schema_setup.sql
-- Compound Interest Growth: Banking vs. Investing
-- Creates the core tables: scenarios and months
-- ============================================================

SELECT DATABASE();

-- Scenarios table: holds each account scenario (principal, rate, type)
CREATE TABLE scenarios (
    scenario_id INT PRIMARY KEY,
    principal DECIMAL(10,2),
    monthly_rate DECIMAL(5,4)
);

-- Initial seed data (rates/types refined later in 02_data_and_view.sql)
INSERT INTO scenarios (scenario_id, principal, monthly_rate) VALUES
(1, 1000.00, 0.05),
(2, 5000.00, 0.05),
(3, 50000.00, 0.05),
(4, 100000.00, 0.05);

-- Add account_type column to categorize each scenario
ALTER TABLE scenarios
ADD COLUMN account_type VARCHAR(20);

UPDATE scenarios
SET monthly_rate = 0.004074, account_type = 'banking'
WHERE scenario_id IN (1, 2);

UPDATE scenarios
SET monthly_rate = 0.009489, account_type = 'investing'
WHERE scenario_id IN (3, 4);

DESCRIBE scenarios;
SELECT * FROM scenarios;

-- Months table: 60-month (5-year) time series used to project growth
CREATE TABLE months (
    month_number INT PRIMARY KEY
);

INSERT INTO months (month_number)
WITH RECURSIVE month_seq AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM month_seq WHERE n < 60
)
SELECT n FROM month_seq;

SELECT COUNT(*) FROM months;
SELECT * FROM months ORDER BY month_number LIMIT 5;
