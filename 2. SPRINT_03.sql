-- ========================================================================================================================
-- Sprint 3 - Basic Analysis / Data Exploration
-- Just getting familiar with the data before doing the real analysis in Sprint 4.
-- ========================================================================================================================
USE retail_banking_db;

-- Q11. Total number of customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- Q12. Total number of accounts
SELECT COUNT(*) AS total_accounts
FROM accounts;

-- Q13. Different account types available
SELECT DISTINCT account_type
FROM accounts;

-- Q14. How many customers are currently active
SELECT COUNT(*) AS active_customers
FROM customers
WHERE is_active = 'Yes';

-- Q15. Different transaction types available
SELECT DISTINCT transaction_type
FROM transactions;

-- Q16. Total amount of completed transactions
SELECT SUM(amount) AS total_completed_amount
FROM transactions
WHERE status = 'Completed';

-- Q17. Different loan types available
SELECT DISTINCT loan_type
FROM loans;

-- Q18. Total number of loans
SELECT COUNT(*) AS total_loans
FROM loans;

-- Q19. Different card types available
SELECT DISTINCT card_type
FROM cards;

-- Q20. Total outstanding loan balance
SELECT SUM(outstanding_balance) AS total_outstanding_loan_balance
FROM loans;
