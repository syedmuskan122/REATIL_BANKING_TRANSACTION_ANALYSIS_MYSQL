# 👩‍💻 Retail Banking Transaction Analysis - MySQL

A complete MySQL data analysis project built on a retail bank's data - customers, accounts, branches, cards, loans, loan payments, and transactions. I built the database from scratch, imported 5,000+ transaction records, and wrote SQL queries to answer real business questions about customer behaviour, loan risk, and card usage.

## What this project does?

- Designs and builds a normalized relational database (`retail_banking`) with 7 tables from raw CSV files
- Loads and verifies ~9,000+ rows of banking data across customers, accounts, branches, cards, loans, loan payments, and transactions
- Answers 5 business objectives using SQL (customer profile, account/branch activity, transaction patterns, loan performance, card usage)
- Turns the query results into real business insights and recommendations

## Key findings:

- **56% of all loans** in this dataset are Defaulted or In Arrears - the biggest risk signal found
- Only **6.2% of issued cards** are currently active
- **42% of customers** hold more than one account - a strong existing cross-sell base
- Only **28.6% of customers** have fully completed KYC verification
- Transaction status is split almost exactly evenly across Completed / Pending / Failed - flagged as worth double-checking with the data source

Full write-up with all insights is in `Retail_Banking_Project_Report.docx`.

## Repository structure:

```
Retail-Banking-Transaction-Analysis-MySQL/
├── 01_sprint02 -create_database.sql                  # Database + table creation (DDL, PKs, FKs, constraints)
|
├── 02_sprint3 -basic_analysis.sql                    # Basic exploration queries (row counts, distinct values, totals)
|
├── 03_sprint4 -objective_based_analysis.sql          # All 5 business objectives (4.1 - 4.5) in one file
|
├── Retail_Banking_Project_Report.docx                # Full written report - business understanding, ER diagram
│                                                       reasoning, all findings and recommendations.
|
├── datasets/                                         # Raw CSV files (customers, accounts, branches, cards,
│                                                       loans, loan_payments, transactions)
|
├── LICENSE
└── README.md
```

### What's inside `04_sprint4_objective_based_analysis.sql` ?

This single file covers all five business objectives, each as its own clearly commented section:

| Objective | What it covers |
|---|---|
| 4.1 | Customer Profile & Segmentation |
| 4.2 | Account Usage & Branch Activity |
| 4.3 | Transaction Patterns |
| 4.4 | Loan Performance & Repayment Behaviour |
| 4.5 | Card Usage & Product Engagement |

## Tech stack:

- **Database:** MySQL 8.0
- **SQL concepts used:** DDL, DML, DQL, JOINs (INNER/LEFT), GROUP BY, HAVING, subqueries, CASE statements, aggregate functions, window-style ratio calculations
- **Tools:** MySQL Workbench

## How to run this project:

1. **Create the database and tables & Import the datasets:**
   Run `01_create_database.sql` in MySQL Workbench (or any MySQL client). This creates the `retail_banking` database and all 7 tables with proper primary keys, foreign keys, and constraints.

2. **Verify the import**
   The end of `02_import_data.sql` runs a row-count check. Expected counts:
   `customers = 500`, `accounts = 700`, `branches = 40`, `loans = 300`, `loan_payments = 2000`, `cards = 600`, `transactions = 5000`.

3. **Run the analysis**
   Run `03_sprint3_basic_analysis.sql` for the basic exploration queries, then `04_sprint4_objective_based_analysis.sql` for the full objective-based analysis.

4. **Read the findings**
   Open `Retail_Banking_Project_Report.docx` for the full write-up - business understanding, ER diagram reasoning, every insight pulled from the queries, and final recommendations.

## Database design (ER overview):

- `customers` and `branches` are independent tables (no foreign keys)
- `accounts` → `customers`, `branches`
- `cards` → `accounts`
- `loans` → `customers`, `branches`
- `loan_payments` → `loans`
- `transactions` → `accounts`

## About me:
SYED. MUSKAN
I am interested in using data to solve real-world problems, discover meaningful insights, and build data- driven solutions using AI and analytics.


- LinkedIn: : www.linkedin.com/in/syed-muskan-b51483316 

- GitHub: https://github.com/syedmuskan122


## License:

This project is licensed under the MIT License - see [LICENSE](LICENSE) for details.

