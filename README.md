# Compound Interest Growth: Banking vs. Investing

A SQL portfolio project that models and compares long-term growth across three savings/investment scenarios — a standard **bank savings account**, a **brokerage/investment account**, and a **Certificate of Deposit (CD)** — using compound interest calculations built entirely in MySQL.

## Project Overview

This project answers a simple question with real numbers: *how much does the type of account you choose actually matter over time?* Using a shared schema of scenarios and time periods, the project calculates month-by-month compounded growth for each account type and visualizes the results in a comparison chart.

## Schema

Built in MySQL Workbench under the `compound_interest-project_8426` schema.

| Table/View | Purpose |
|---|---|
| `scenarios` | Defines each account type (Banking, Investing, CD) along with starting principal and interest rate |
| `months` | Time series of months over which growth is tracked |
| `growth_results` (view) | Calculates compounded balance per scenario, per month, using `POWER()` |

## Key SQL Concepts Used

- **Views** — `growth_results` encapsulates the compounding logic so it can be queried like a table
- **`POWER()`** — used to calculate compound growth: `principal * POWER((1 + rate), months)`
- **Multi-table relationships** — joining `scenarios` and `months` to generate a full growth timeline
- **Aggregate/comparison queries** — pulling final balances and growth differences across scenarios

## Visualization

Growth results were exported and charted in Excel using a PivotTable and line chart, comparing the three scenarios side-by-side over the full time period. The chart includes labeled axes, a cleaned-up legend, and endpoint data labels marking the final balance for each scenario.

📊 [View the full chart and calculations in the Excel workbook](./Growth_Chart_081526.xlsx)

## Debugging Log

Part of this project involved verifying the schema and troubleshooting the workbook before finalizing results. Below is the debug log documenting that process:

```sql
SHOW TABLES;

DESCRIBE scenarios;
DESCRIBE months;
DESCRIBE growth_results;

SELECT DATABASE();

-- There was one error due to partial highlighting; no actual bugs were found.
-- Debugging was clean — everything ran smoothly in the Report-Chart.
```

**Outcome:** No structural or logic errors found. The one issue encountered was a false alarm caused by partially highlighting a query before execution (a common MySQL Workbench gotcha) rather than an actual bug in the schema or view logic.

## How to Run

1. Import the schema into MySQL Workbench (or run the provided `.sql` script)
2. Confirm tables loaded correctly:
   ```sql
   SHOW TABLES;
   ```
3. Query the `growth_results` view to see compounded balances per scenario/month
4. Export results to Excel (or your tool of choice) to chart and compare

## Skills Demonstrated

- Relational schema design
- SQL views and compound interest calculations
- Debugging and verifying database state before analysis
- Data visualization (Excel PivotTable + chart)
- Technical documentation
