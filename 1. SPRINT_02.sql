-- ========================================================================================================================
-- RETAIL BANKING TRANSACTION ANALYSIS PROJECT
-- Author: Syed. Muskan


--  SPRINT 2: Database and Table Creation
-- ========================================================================================================================
-- I am creating one database for the whole project called retail_banking_db. All 7 tables from the project go inside it.
-- Tables are created in the following order because of foreign key relationships:

--   1. customers      (no foreign key, independent table)
--   2. branches       (no foreign key, independent table)
--   3. accounts       (needs customers + branches)
--   4. loans          (needs customers + branches)
--   5. loan_payments  (needs loans)
--   6. cards          (needs accounts)
--   7. transactions   (needs accounts)
-- ========================================================================================================================

-- ------------------------------------------------------------
-- STEP 1: CREATE DATABASE
-- ------------------------------------------------------------

DROP DATABASE IF EXISTS retail_banking_db;

CREATE DATABASE retail_banking_db;

USE retail_banking_db;

-- ------------------------------------------------------------
-- STEP 2: VIEW DATABASE
-- ------------------------------------------------------------

SHOW DATABASES;

-- ------------------------------------------------------------
-- STEP 3: CREATE THE TABLES
-- ------------------------------------------------------------

-- ============================================================
-- TABLE 1: CUSTOMERS TABLE
-- One row represents one bank customer.
-- customer_id is the primary key.
-- ============================================================

CREATE TABLE customers (
    customer_id     VARCHAR(20)    PRIMARY KEY,
    first_name      VARCHAR(50),
    last_name       VARCHAR(50),
    date_of_birth   DATE,
    gender          VARCHAR(20),
    city            VARCHAR(50),
    state           VARCHAR(50),
    customer_since  DATE,
    kyc_status      VARCHAR(30),
    segment         VARCHAR(30),
    annual_income   DECIMAL(15,2),
    credit_score    INT,
    is_active       VARCHAR(10)
);

SHOW TABLES;

DESCRIBE customers;

-- ============================================================
-- TABLE 2: BRANCHES TABLE
-- Basic information about every bank branch.
-- branch_id is the primary key.
-- ============================================================

CREATE TABLE branches (
    branch_id       VARCHAR(20)    PRIMARY KEY,
    branch_name     VARCHAR(100),
    city            VARCHAR(50),
    state           VARCHAR(50),
    region          VARCHAR(50),
    opening_date    DATE,
    employee_count  INT
);

SHOW TABLES;

DESCRIBE branches;

-- ============================================================
-- TABLE 3: ACCOUNTS TABLE
-- Every account belongs to one customer and one branch.
-- customer_id references customers.
-- branch_id references branches.
-- close_date can be NULL for active accounts.
-- ============================================================

CREATE TABLE accounts (
    account_id       VARCHAR(20)    PRIMARY KEY,
    customer_id      VARCHAR(20),
    branch_id        VARCHAR(20),
    account_type     VARCHAR(50),
    open_date        DATE,
    close_date       VARCHAR(50),
    current_balance  DECIMAL(15,2),
    interest_rate    DECIMAL(5,2),
    overdraft_limit  DECIMAL(15,2),
    status            VARCHAR(30),

	FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

	FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id)
);


-- ------------------------------------------------------------
-- HANDLING NULL VALUES IN CLOSE_DATE:
-- ------------------------------------------------------------
-- Empty string values in close_date are converted to NULL
-- before changing the column data type from VARCHAR to DATE.
-- ------------------------------------------------------------

SET SQL_SAFE_UPDATES = 0;

UPDATE accounts
SET close_date = NULL
WHERE close_date = '';

SET SQL_SAFE_UPDATES = 1;

ALTER TABLE accounts
MODIFY COLUMN close_date DATE;

-- ------------------------------------------------------------

SHOW TABLES;

DESCRIBE accounts;

-- ============================================================
-- TABLE 4: LOANS TABLE
-- Every loan belongs to one customer and is issued from one branch.
-- customer_id references customers.
-- branch_id references branches.
-- ============================================================

CREATE TABLE loans (
    loan_id             VARCHAR(20)    PRIMARY KEY,
    customer_id         VARCHAR(20),
    branch_id           VARCHAR(20),
    loan_type           VARCHAR(50),
    principal_amount    DECIMAL(15,2),
    interest_rate       DECIMAL(5,2),
    tenure_months       INT,
    disbursement_date   DATE,
    maturity_date       DATE,
    emi_amount          DECIMAL(15,2),
    outstanding_balance DECIMAL(15,2),
    loan_status         VARCHAR(30),
    purpose             VARCHAR(100),

	FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

	FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id)
);

SHOW TABLES;

DESCRIBE loans;

-- ============================================================
-- TABLE 5: LOAN_PAYMENTS TABLE
-- Every payment record belongs to one loan.
-- One loan can have many payment records.
-- loan_id references loans.
-- ============================================================

CREATE TABLE loan_payments (
    payment_id        VARCHAR(20)    PRIMARY KEY,
    loan_id           VARCHAR(20),
    payment_date      DATE,
    scheduled_amount  DECIMAL(15,2),
    paid_amount       DECIMAL(15,2),
    principal_paid    DECIMAL(15,2),
    interest_paid     DECIMAL(15,2),
    penalty           DECIMAL(15,2),
    days_late         INT,
    payment_method    VARCHAR(50),
    status            VARCHAR(30),

	FOREIGN KEY (loan_id)
        REFERENCES loans(loan_id)
);

SHOW TABLES;

DESCRIBE loan_payments;

-- ============================================================
-- TABLE 6: CARDS TABLE
-- Every card is linked to one account.
-- account_id references accounts.
-- ============================================================

CREATE TABLE cards (
    card_id             VARCHAR(20)    PRIMARY KEY,
    account_id          VARCHAR(20),
    card_type           VARCHAR(50),
    issue_date          DATE,
    expiry_date         DATE,
    credit_limit        DECIMAL(15,2),
    outstanding_balance DECIMAL(15,2),
    reward_points       INT,
    is_active           VARCHAR(10),
    network             VARCHAR(50),

	FOREIGN KEY (account_id)
        REFERENCES accounts(account_id)
);

SHOW TABLES;

DESCRIBE cards;

-- ============================================================
-- TABLE 7: TRANSACTIONS TABLE
-- Every transaction happens on one account.
-- account_id references accounts.
-- ============================================================

CREATE TABLE transactions (
    transaction_id    VARCHAR(20)    PRIMARY KEY,
    account_id        VARCHAR(20),
    transaction_date  DATE,
    transaction_time  TIME,
    transaction_type  VARCHAR(50),
    amount            DECIMAL(15,2),
    channel           VARCHAR(50),
    description       VARCHAR(100),
    balance_after     DECIMAL(15,2),
    status            VARCHAR(30),

	FOREIGN KEY (account_id)
        REFERENCES accounts(account_id)
);

SHOW TABLES;

DESCRIBE transactions;


-- ============================================================
-- STEP 4: RUN ANALYSIS QUERIES
-- Run these queries after importing the CSV files.
-- These queries check the number of records in each table.
-- ============================================================

-- CUSTOMERS
SELECT COUNT(*) AS total_customers
FROM customers;

-- BRANCHES
SELECT COUNT(*) AS total_branches
FROM branches;

-- ACCOUNTS
SELECT COUNT(*) AS total_accounts
FROM accounts;

-- LOANS
SELECT COUNT(*) AS total_loans
FROM loans;

-- LOAN_PAYMENTS
SELECT COUNT(*) AS total_loan_payments
FROM loan_payments;

-- CARDS
SELECT COUNT(*) AS total_cards
FROM cards;

-- TRANSACTIONS
SELECT COUNT(*) AS total_transactions
FROM transactions;
