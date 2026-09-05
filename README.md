🏦 Retail Banking Transaction Analysis:
A MySQL-based Business Analytics project for analyzing customers, banking products, transactions, loans, cards, and branch activity.

📌 Project Overview:
Retail Banking Transaction Analysis is a relational database and SQL analytics project built around a realistic retail banking scenario.

The project transforms raw banking datasets into structured MySQL tables and then uses SQL to answer business questions around:

👤 Customer profiles and segmentation

💳 Account and banking-product usage

💸 Transaction patterns and trends

🏦 Branch activity

💰 Loan performance and repayment behaviour

💳 Card usage and customer product engagement

The main goal is to demonstrate how relational database design + SQL analysis can turn raw banking data into useful business insights and actionable recommendations.


🎯 Business Objectives
The analysis is organized into five major objectives:

Objective	Focus
4.1 Customer Profile & Segmentation	Customer segments, location, KYC, activity, tenure, gender
4.2 Account Usage & Branch Activity	Account types, balances, interest rates, branches, regions
4.3 Transaction Patterns	Transaction types, channels, descriptions, status, yearly trends
4.4 Loan Performance & Repayment	Loan types, purposes, loan status, late payments, penalties
4.5 Card Usage & Product Engagement	Card activation, utilization, rewards, multi-product customers


🗄️ Database Overview
The project uses one MySQL database:
retail_banking_db
It contains 7 interconnected tables with 9,140 total records.


📊 Dataset Summary:
Table	Records	Purpose
customers	500	Customer demographic, KYC, income and credit information
branches	40	Bank branch and regional information
accounts	700	Customer accounts, balances, rates and status
loans	300	Loans, principal, outstanding balance and status
loan_payments	2,000	EMI payments, delays, penalties and payment methods
cards	600	Debit/credit card details, limits and rewards
transactions	5,000	Banking transactions, channels, amounts and status
Total	9,140	
🔗 Database Relationships
The database follows a relational structure with primary keys and foreign keys.

                         ┌───────────────┐
                         │   CUSTOMERS   │
                         │    500 rows   │
                         └───────┬───────┘
                                 │
                 ┌───────────────┼───────────────┐
                 │               │               │
                 ▼               ▼               ▼
          ┌────────────┐  ┌────────────┐  ┌────────────┐
          │  ACCOUNTS  │  │   LOANS    │  │  BRANCHES  │
          │ 700 rows   │  │ 300 rows   │  │  40 rows   │
          └─────┬──────┘  └─────┬──────┘  └────────────┘
                │               │
          ┌─────┴──────┐       ▼
          │            │  ┌──────────────┐
          ▼            ▼  │LOAN_PAYMENTS │
       ┌───────┐  ┌────────┤  2,000 rows  │
       │ CARDS │  │TRANS.  └──────────────┘
       │600    │  │5,000
       └───────┘  └────────
Foreign Key Relationships
accounts.customer_id       → customers.customer_id
accounts.branch_id         → branches.branch_id
cards.account_id           → accounts.account_id
loans.customer_id          → customers.customer_id
loans.branch_id            → branches.branch_id
loan_payments.loan_id      → loans.loan_id
transactions.account_id    → accounts.account_id
🛠️ Technologies Used
MySQL

SQL

MySQL Workbench

CSV datasets

Relational database design

Primary & foreign keys

Joins

Aggregations

GROUP BY

ORDER BY

Filtering

Subqueries

Conditional logic with CASE

Date functions

Business-oriented analytical queries

📂 Repository Structure
Retail-Banking-Transaction-Analysis/
│
├── 📄 1. SPRINT_02.sql
│   └── Database creation, table creation and relationships
│
├── 📄 2. SPRINT_03.sql
│   └── Basic data exploration and validation queries
│
├── 📄 3. SPRINT_04.sql
│   └── Objective-based business analysis
│
├── 📁 DataSets/
│   ├── accounts.csv
│   ├── branches.csv
│   ├── cards.csv
│   ├── customers.csv
│   ├── loans.csv
│   ├── loan_payments.csv
│   └── transactions.csv
│
├── 📊 IRL(MySQL Project PPT).pptx
│   └── Project presentation
│
└── 📑 Retail_Banking_Project_Report.docx
    └── Detailed project report
🚀 Project Workflow
Sprint 2 — Database Setup
The database was designed and implemented in MySQL.

Main tasks
Created the retail_banking_db database.

Created all seven relational tables.

Defined appropriate data types.

Added primary keys.

Added foreign key constraints.

Imported the seven CSV datasets.

Verified table structures and record counts.

Handled NULL values in close_date.

Table creation order
customers
    ↓
branches
    ↓
accounts
    ↓
loans
    ↓
loan_payments
    ↓
cards
    ↓
transactions
🔎 Sprint 3 — Basic Data Exploration
Sprint 3 focuses on understanding the dataset before performing deeper business analysis.

The SQL script answers questions such as:

How many customers are present?

How many accounts exist?

What account types are available?

How many customers are active?

What transaction types exist?

What is the total amount of completed transactions?

What loan types are available?

How many loans exist?

What card types are available?

What is the total outstanding loan balance?

This stage provides a basic understanding of the data before moving into objective-based analysis.

📈 Sprint 4 — Objective-Based Analysis
Sprint 4 contains the main business analysis.

4.1 Customer Profile & Segmentation
Key findings
Student is the largest customer segment with 100 customers (20%).

Senior is the smallest segment with 73 customers (14.6%).

Premium customers have the highest average annual income at approximately $158.7K.

Only 28.6% of customers have Verified KYC status.

Approximately 75% of customers are active.

Student customers have the highest active rate at approximately 84%.

Senior customers have the lowest active rate at approximately 65.8%.

Average customer tenure is approximately 7.4 years.

Customer tenure is relatively consistent across segments.

Business takeaway
The biggest customer-side opportunities are KYC completion and understanding why some customer segments have lower activity.

4.2 Account Usage & Branch Activity
Key findings
IRA accounts hold the highest total balance at approximately $2.89M.

Certificate of Deposit has the highest average interest rate at approximately 4.62%.

Jacksonville Branch has the highest number of accounts with 67.

Washington Branch holds the highest total balance at approximately $1.06M.

211 of 500 customers (42.2%) hold more than one account.

The South region has the highest number of accounts.

The West region has the highest average balance per account.

Active accounts have an average balance of approximately $20.5K, while closed accounts have a $0 average balance in the dataset.

Business takeaway
The 42.2% multi-account customer rate indicates a strong base for cross-selling and product expansion.

4.3 Transaction Patterns
Key findings
All six transaction types are relatively evenly distributed.

Interest transactions move the highest total value at approximately $6.39M.

Online is the most-used transaction channel.

Investment is the most common transaction description.

Transaction statuses are unusually balanced:

Completed: 33.76%

Pending: 33.68%

Failed: 32.56%

Transaction volume increased from 1,279 in 2022 to 1,723 in 2023 and 1,933 in 2024.

2025 contains very limited data, so it should not be used as strong evidence of a full-year trend.

Business takeaway
The unusually high proportion of pending and failed transactions should be validated with the dataset owner before making operational decisions.

4.4 Loan Performance & Repayment Behaviour
Key findings
⚠️ Loan portfolio risk is the biggest concern identified in the project.

56.34% of loans are either Defaulted (28.67%) or In Arrears (27.67%).

Education loans are the most common loan type with 64 loans.

Education loans have approximately $15.7M in total principal disbursed.

Home loans have the highest average outstanding balance per loan.

500 of 2,000 payment records (25%) were late.

Average lateness for late payments is approximately 22.5 days.

Combining Late and Missed statuses, approximately 48.4% of payments were not made on schedule.

Total penalties collected are approximately $93,961.47.

Education loans contribute the largest penalty amount.

Business takeaway
Loan recovery, early-warning monitoring, and repayment behaviour should be treated as high-priority business areas.

4.5 Card Usage & Product Engagement
Key findings
Only 6.2% of the 600 issued cards are marked Active.

93.8% of issued cards are marked Inactive.

Debit cards: 358 (59.7%)

Credit cards: 242 (40.3%)

Average credit card limit: approximately $24.3K.

Average credit card outstanding balance: approximately $10.2K.

Average credit card utilization is approximately 39.7%.

No credit card exceeds 80% utilization in the analyzed dataset.

124 customers (24.8%) use Account + Card + Loan.

143 customers (28.6%) use Account + Card.

74 customers (14.8%) have no account, card, or loan recorded.

Business takeaway
The extremely low card activation rate indicates a major opportunity to investigate card engagement, replacement/expiry status, and customer adoption.

💡 Overall Key Findings
Area	Finding	Priority
👤 Customers	75% active, but only 28.6% Verified KYC	🔴 High
🏦 Accounts	42.2% of customers have multiple accounts	🟢 Opportunity
💸 Transactions	Online is the leading channel; status split is unusually balanced	🟠 Investigate
💰 Loans	56.34% Defaulted/In Arrears	🔴 Critical
💳 Cards	Only 6.2% marked Active	🔴 High
📌 Business Recommendations
1. Strengthen Loan Early-Warning Monitoring
Create an early-warning system for loans showing missed payments or increasing repayment delays before they move into arrears or default.

2. Promote Automated Repayments
Encourage customers to use Auto Debit for EMI payments to reduce manual-payment delays and missed payments.

3. Improve KYC Completion
Run a targeted KYC completion campaign for customers in Pending/Partial status and separately review failed KYC cases.

4. Investigate Card Inactivity
Determine whether the 93.8% inactive-card rate is caused by:

Expired cards

Replaced cards

Dormant customers

Data-quality issues

Genuine low card engagement

5. Use Multi-Product Customers for Cross-Selling
Customers already using multiple products represent a strong opportunity for targeted offers and deeper product engagement.

6. Validate Unusual Dataset Patterns
Before using the findings for real business decisions, validate unusually high or evenly distributed values with the data/source team.

▶️ How to Run the Project
Prerequisites
Install:

MySQL Server

MySQL Workbench

Step 1 — Clone the Repository
git clone <YOUR-GITHUB-REPOSITORY-URL>
cd <YOUR-REPOSITORY-FOLDER>
Step 2 — Open MySQL Workbench
Connect to your local MySQL server.

Step 3 — Run Sprint 2
Open:

1. SPRINT_02.sql
Run the complete script.

This creates:

retail_banking_db
and all seven tables.

Step 4 — Import the CSV Files
Import the seven files from:

DataSets/
into the corresponding MySQL tables.

Step 5 — Run Sprint 3
Open:

2. SPRINT_03.sql
Run the queries to perform basic data exploration.

Step 6 — Run Sprint 4
Open:

3. SPRINT_04.sql
Run the objective-based analysis covering sections 4.1 through 4.5.

📊 Skills Demonstrated
This project demonstrates practical SQL and data analytics skills including:

Database Design
        ↓
Data Import
        ↓
Data Validation
        ↓
Relational Modeling
        ↓
SQL Querying
        ↓
Joins & Aggregations
        ↓
Business Analysis
        ↓
Insight Generation
        ↓
Business Recommendations
SQL Concepts Used
CREATE DATABASE

CREATE TABLE

PRIMARY KEY

FOREIGN KEY

ALTER TABLE

UPDATE

SELECT

WHERE

DISTINCT

GROUP BY

ORDER BY

LIMIT

JOIN

COUNT

SUM

AVG

ROUND

CASE

Subqueries

Date functions such as DATEDIFF

📁 Project Deliverables
This repository contains:

🗃️ Database creation SQL

🔍 Basic exploration SQL

📈 Objective-based analysis SQL

📊 Seven banking datasets

📑 Detailed project report

🎤 Project presentation

⚠️ Data & Analysis Notes
This project uses a project/demonstration banking dataset for analytical practice. The findings should therefore be treated as analytical outputs from the supplied dataset rather than real banking statistics.

Some results are intentionally flagged for validation because they are unusual—for example, the near three-way split between Completed, Pending and Failed transactions and the high proportion of loans in Default/In Arrears.

👩‍💻 Author
Syed. Muskan

Project: Retail Banking Transaction Analysis
Technology: MySQL & SQL
Focus: Data Analytics / Business Intelligence

⭐ If you found this project useful
Feel free to star ⭐ the repository and explore the SQL scripts, datasets, report, and presentation.

🏁 Conclusion
This project demonstrates how a relational banking dataset can be transformed into meaningful business analysis using SQL.

The analysis identifies several important areas for management attention:

Loan risk, KYC completion, transaction reliability, and card engagement.

At the same time, the project highlights opportunities in multi-account customers, cross-selling, and digital banking adoption.

The overall workflow shows the practical path from:

Raw Data → Database Design → SQL Analysis → Business Insights → Recommendations

