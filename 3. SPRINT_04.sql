-- =================================================================================================================================
-- Sprint 4.1 - Understand Customer Profile and Segmentation
-- =================================================================================================================================

-- My analytical questions for this objective:
--  Q1. How many customers are in each segment, and what does the typical customer in each segment look like (income, credit score)?
--  Q2. Where are most customers located (top cities/states)?
--  Q3. What % of customers have completed KYC vs not?
--  Q4. Are active customers spread evenly across segments, or are some segments mostly inactive?
--  Q5. How long (on average) have customers been with the bank, and does that differ by segment?
--  Q6. Do male/female/non-binary customers differ in income or credit score on average?
-- =================================================================================================================================
USE retail_banking_db;

-- Q1a. Customer count per segment
SELECT segment, COUNT(*) AS customer_count
FROM customers
GROUP BY segment
ORDER BY customer_count DESC;

-- Q1b. Avg income and avg credit score per segment
SELECT segment,
       COUNT(*)                      AS customer_count,
       ROUND(AVG(annual_income), 2)  AS avg_annual_income,
       ROUND(AVG(credit_score), 0)   AS avg_credit_score
FROM customers
GROUP BY segment
ORDER BY avg_annual_income DESC;

-- Q2a. Top 10 cities by number of customers
SELECT city, COUNT(*) AS customer_count
FROM customers
GROUP BY city
ORDER BY customer_count DESC
LIMIT 10;

-- Q2b. Top 10 states by number of customers
SELECT state, COUNT(*) AS customer_count
FROM customers
GROUP BY state
ORDER BY customer_count DESC
LIMIT 10;

-- Q3. KYC status distribution (count + percentage of total customers)
SELECT kyc_status,
       COUNT(*) AS customer_count,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customers), 2) AS pct_of_customers
FROM customers
GROUP BY kyc_status
ORDER BY customer_count DESC;

-- Q4. Active vs inactive customers, split by segment
SELECT segment,
       SUM(CASE WHEN is_active = 'Yes' THEN 1 ELSE 0 END) AS active_customers,
       SUM(CASE WHEN is_active = 'No'  THEN 1 ELSE 0 END) AS inactive_customers,
       COUNT(*) AS total_customers
FROM customers
GROUP BY segment
ORDER BY total_customers DESC;

-- Q5. Average customer tenure (in years) overall and by segment
-- Using latest transaction date as the reference date

SELECT segment,
       ROUND(
           AVG(
               DATEDIFF(
                   (SELECT MAX(transaction_date) FROM transactions),
                   customer_since
               ) / 365.25
           ),
           1
       ) AS avg_tenure_years
FROM customers
GROUP BY segment
ORDER BY avg_tenure_years DESC;

-- Q6. Average income and credit score by gender
SELECT gender,
       COUNT(*)                     AS customer_count,
       ROUND(AVG(annual_income), 2) AS avg_annual_income,
       ROUND(AVG(credit_score), 0)  AS avg_credit_score
FROM customers
GROUP BY gender;

-- =========================================================================================================================================
-- Sprint 4.2 - Understand Account Usage and Branch Activity
-- =========================================================================================================================================

-- My analytical questions for this objective:
--  Q1. Which account type is most common and holds the most money?
--  Q2. How does interest rate differ across account types?
--  Q3. Which branches have the most accounts / most total balance?
--  Q4. Do closed accounts look different from active accounts (lower balance, fewer accounts per customer etc.)?
--  Q5. Which customers hold more than one account (multi-account customers)?
--  Q6. How does account activity differ by region?
-- =========================================================================================================================================

-- Q1a. Number of accounts and total balance by account type
SELECT account_type,
       COUNT(*)                         AS account_count,
       ROUND(SUM(current_balance), 2)   AS total_balance,
       ROUND(AVG(current_balance), 2)   AS avg_balance
FROM accounts
GROUP BY account_type
ORDER BY total_balance DESC;

-- Q2. Average interest rate by account type
SELECT account_type,
       ROUND(AVG(interest_rate), 2) AS avg_interest_rate
FROM accounts
GROUP BY account_type
ORDER BY avg_interest_rate DESC;

-- Q3a. Number of accounts per branch (top 10)
SELECT b.branch_name, b.city, b.region, COUNT(a.account_id) AS account_count
FROM accounts a
JOIN branches b ON a.branch_id = b.branch_id
GROUP BY b.branch_id, b.branch_name, b.city, b.region
ORDER BY account_count DESC
LIMIT 10;

-- Q3b. Total balance held per branch (top 10)
SELECT b.branch_name, b.region, ROUND(SUM(a.current_balance), 2) AS total_balance
FROM accounts a
JOIN branches b ON a.branch_id = b.branch_id
GROUP BY b.branch_id, b.branch_name, b.region
ORDER BY total_balance DESC
LIMIT 10;

-- Q4a. Active vs Closed accounts - count and avg balance
SELECT status,
       COUNT(*)                       AS account_count,
       ROUND(AVG(current_balance), 2) AS avg_balance,
       ROUND(AVG(overdraft_limit), 2) AS avg_overdraft_limit
FROM accounts
GROUP BY status;

-- Q4b. Active vs Closed split by account type
SELECT account_type, status, COUNT(*) AS account_count
FROM accounts
GROUP BY account_type, status
ORDER BY account_type, status;

-- Q5a. Customers who have more than one account (multi-account customers)
SELECT customer_id, COUNT(*) AS number_of_accounts
FROM accounts
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY number_of_accounts DESC;

-- Q5b. How many customers in total have more than 1 account
SELECT COUNT(*) AS customers_with_multiple_accounts
FROM (
    SELECT customer_id
    FROM accounts
    GROUP BY customer_id
    HAVING COUNT(*) > 1
) AS multi_acc_customers;

-- Q6. Account count and average balance by branch region
SELECT b.region,
       COUNT(a.account_id)               AS account_count,
       ROUND(AVG(a.current_balance), 2)  AS avg_balance,
       ROUND(AVG(a.interest_rate), 2)    AS avg_interest_rate
FROM accounts a
JOIN branches b ON a.branch_id = b.branch_id
GROUP BY b.region
ORDER BY account_count DESC;


-- =========================================================================================================================================
-- Sprint 4.3 - Analyze Transaction Patterns
-- =========================================================================================================================================

-- My analytical questions for this objective:
--  Q1. Which transaction type happens the most, and which moves the most money?
--  Q2. Which channel do customers use the most for transactions?
--  Q3. What is the average transaction amount, and does it change by channel?
--  Q4. What are the most common transaction descriptions?
--  Q5. How many transactions are Completed vs Pending vs Failed?
--  Q6. Is transaction activity growing or shrinking over time (year wise)?
--  Q7. Which accounts have the highest total completed transaction amount?
-- =========================================================================================================================================

-- Q1. Transaction count and total amount by transaction type
SELECT transaction_type,
       COUNT(*)                     AS txn_count,
       ROUND(SUM(amount), 2)        AS total_amount,
       ROUND(AVG(amount), 2)        AS avg_amount
FROM transactions
GROUP BY transaction_type
ORDER BY total_amount DESC;

-- Q2. Transaction count by channel
SELECT channel, COUNT(*) AS txn_count
FROM transactions
GROUP BY channel
ORDER BY txn_count DESC;

-- Q3. Average transaction amount by channel
SELECT channel,
       ROUND(AVG(amount), 2) AS avg_amount,
       ROUND(SUM(amount), 2) AS total_amount
FROM transactions
GROUP BY channel
ORDER BY avg_amount DESC;

-- Q4. Most common transaction descriptions
SELECT description, COUNT(*) AS txn_count
FROM transactions
GROUP BY description
ORDER BY txn_count DESC;

-- Q5. Transaction status breakdown (count + percentage)
SELECT status,
       COUNT(*) AS txn_count,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM transactions), 2) AS pct_of_all_txns
FROM transactions
GROUP BY status
ORDER BY txn_count DESC;

-- Q6. Yearly transaction trend - count and total amount per year
SELECT YEAR(transaction_date) AS txn_year,
       COUNT(*)               AS txn_count,
       ROUND(SUM(amount), 2)  AS total_amount
FROM transactions
GROUP BY YEAR(transaction_date)
ORDER BY txn_year;

-- Q7. Top 10 most active accounts by total completed transaction amount
SELECT account_id,
       COUNT(*)              AS txn_count,
       ROUND(SUM(amount), 2) AS total_amount
FROM transactions
WHERE status = 'Completed'
GROUP BY account_id
ORDER BY total_amount DESC
LIMIT 10;

-- Q8. Transaction type split by channel (which channel is used for what)
SELECT channel, transaction_type, COUNT(*) AS txn_count
FROM transactions
GROUP BY channel, transaction_type
ORDER BY channel, txn_count DESC;


-- =========================================================================================================================================
-- Sprint 4.4 - Evaluate Loan Performance and Repayment Behaviour
-- =========================================================================================================================================

-- My analytical questions for this objective:
--  Q1. Which loan type is most common, and which has the biggest average outstanding balance?
--  Q2. What are loans mostly taken for (purpose)?
--  Q3. How many loans are Active / Closed / In Arrears / Defaulted?
--  Q4. Which loans have late payments, and how late on average?
--  Q5. How much penalty has been collected in total, and which loan type gets the most penalties?
--  Q6. What payment methods do customers prefer for EMI payments?
--  Q7. Which branch has the worst loan performance (highest default/arrears rate)?
--  Q8. What % of the scheduled amount actually gets repaid, by loan type (repayment ratio)?
-- =========================================================================================================================================

-- Q1a. Loan count and total/avg amounts by loan type
SELECT loan_type,
       COUNT(*)                              AS loan_count,
       ROUND(SUM(principal_amount), 2)       AS total_principal,
       ROUND(AVG(outstanding_balance), 2)    AS avg_outstanding_balance
FROM loans
GROUP BY loan_type
ORDER BY total_principal DESC;

-- Q2. Loan purpose breakdown
SELECT purpose,
       COUNT(*)                        AS loan_count,
       ROUND(AVG(principal_amount), 2) AS avg_principal_amount
FROM loans
GROUP BY purpose
ORDER BY loan_count DESC;

-- Q3. Loan status breakdown (count + percentage)
SELECT loan_status,
       COUNT(*) AS loan_count,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM loans), 2) AS pct_of_loans,
       ROUND(SUM(outstanding_balance), 2) AS total_outstanding
FROM loans
GROUP BY loan_status
ORDER BY loan_count DESC;

-- Q4a. How many payments were late (days_late > 0) vs on time
SELECT
    CASE WHEN days_late > 0 THEN 'Late' ELSE 'On Time' END AS payment_timing,
    COUNT(*) AS payment_count
FROM loan_payments
GROUP BY payment_timing;

-- Q4b. Average days late (only counting the late ones)
SELECT ROUND(AVG(days_late), 1) AS avg_days_late_when_late
FROM loan_payments
WHERE days_late > 0;

-- Q4c. Payment status breakdown (Paid / Late / Missed / Pending)
SELECT status, COUNT(*) AS payment_count
FROM loan_payments
GROUP BY status
ORDER BY payment_count DESC;

-- Q5a. Total penalty collected
SELECT ROUND(SUM(penalty), 2) AS total_penalty_collected
FROM loan_payments;

-- Q5b. Total penalty by loan type (need to join loans)
SELECT l.loan_type, ROUND(SUM(lp.penalty), 2) AS total_penalty
FROM loan_payments lp
JOIN loans l ON lp.loan_id = l.loan_id
GROUP BY l.loan_type
ORDER BY total_penalty DESC;

-- Q6. Payment method preference
SELECT payment_method, COUNT(*) AS payment_count
FROM loan_payments
GROUP BY payment_method
ORDER BY payment_count DESC;

-- Q7. Loan performance by branch - default/arrears rate (top 10 worst)
SELECT b.branch_name,
       COUNT(*) AS total_loans,
       SUM(CASE WHEN l.loan_status IN ('Defaulted','In Arrears') THEN 1 ELSE 0 END) AS problem_loans,
       ROUND(SUM(CASE WHEN l.loan_status IN ('Defaulted','In Arrears') THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS problem_loan_pct
FROM loans l
JOIN branches b ON l.branch_id = b.branch_id
GROUP BY b.branch_id, b.branch_name
HAVING COUNT(*) >= 3
ORDER BY problem_loan_pct DESC
LIMIT 10;

-- Q8. Repayment ratio by loan type = total paid / total scheduled
SELECT l.loan_type,
       ROUND(SUM(lp.scheduled_amount), 2) AS total_scheduled,
       ROUND(SUM(lp.paid_amount), 2)      AS total_paid,
       ROUND(SUM(lp.paid_amount) * 100.0 / SUM(lp.scheduled_amount), 2) AS repayment_pct
FROM loan_payments lp
JOIN loans l ON lp.loan_id = l.loan_id
GROUP BY l.loan_type
ORDER BY repayment_pct ASC;

-- =========================================================================================================================================
-- Sprint 4.5 - Understand Card Usage and Product Engagement
-- =========================================================================================================================================

-- My analytical questions for this objective:
--  Q1. Debit vs Credit cards - how many of each, and how do credit limit/outstanding balance compare?
--  Q2. How many cards are active vs inactive?
--  Q3. Which card network (Visa/Mastercard/etc.) is most used, and which has the highest average credit limit?
--  Q4. Do customers earn more reward points on Credit or Debit cards?
--  Q5. How many customers use more than one banking product together?
--  Q6. Who are the top reward point earners?
--  Q7. What % of credit cards have used up most of their credit limit (utilization)?
--  Q8. Does Auto-debit have a lower late/missed payment rate than other payment methods?
-- =========================================================================================================================================

-- Q1. Card type breakdown - count, avg credit limit, avg outstanding balance
SELECT card_type,
       COUNT(*)                                AS card_count,
       ROUND(AVG(credit_limit), 2)              AS avg_credit_limit,
       ROUND(AVG(outstanding_balance), 2)       AS avg_outstanding_balance
FROM cards
GROUP BY card_type;

-- Q2. Active vs inactive cards
SELECT is_active, COUNT(*) AS card_count
FROM cards
GROUP BY is_active;

-- Q2b. Active vs inactive split by card type
SELECT card_type, is_active, COUNT(*) AS card_count
FROM cards
GROUP BY card_type, is_active
ORDER BY card_type;

-- Q3. Card network breakdown
SELECT network,
       COUNT(*)                     AS card_count,
       ROUND(AVG(credit_limit), 2)  AS avg_credit_limit
FROM cards
GROUP BY network
ORDER BY card_count DESC;

-- Q4. Average reward points by card type
SELECT card_type, ROUND(AVG(reward_points), 0) AS avg_reward_points
FROM cards
GROUP BY card_type;

-- Q5a. Count of customers using each combination of products (account, card, loan, and combinations of these products)
SELECT
    CASE
        WHEN has_account = 1 AND has_card = 1 AND has_loan = 1
            THEN 'Account + Card + Loan'
        WHEN has_account = 1 AND has_card = 1 AND has_loan = 0
            THEN 'Account + Card only'
        WHEN has_account = 1 AND has_card = 0 AND has_loan = 1
            THEN 'Account + Loan only'
        WHEN has_account = 1 AND has_card = 0 AND has_loan = 0
            THEN 'Account only'
        WHEN has_account = 0 AND has_card = 1 AND has_loan = 0
            THEN 'Card only'
        WHEN has_account = 0 AND has_card = 0 AND has_loan = 1
            THEN 'Loan only'
        ELSE 'No product'
    END AS product_combination,
    COUNT(*) AS customer_count
FROM (
    SELECT c.customer_id,
           CASE WHEN a.customer_id IS NOT NULL THEN 1 ELSE 0 END AS has_account,
           CASE WHEN cd.customer_id IS NOT NULL THEN 1 ELSE 0 END AS has_card,
           CASE WHEN l.customer_id IS NOT NULL THEN 1 ELSE 0 END AS has_loan
    FROM customers c
    LEFT JOIN (
        SELECT DISTINCT customer_id
        FROM accounts
    ) a ON c.customer_id = a.customer_id
    LEFT JOIN (
        SELECT DISTINCT a2.customer_id
        FROM cards ca
        JOIN accounts a2 ON ca.account_id = a2.account_id
    ) cd ON c.customer_id = cd.customer_id
    LEFT JOIN (
        SELECT DISTINCT customer_id
        FROM loans
    ) l ON c.customer_id = l.customer_id
) AS product_flags
GROUP BY product_combination
ORDER BY customer_count DESC;

-- Q6. Top 10 customers by reward points (through their cards)
SELECT c.customer_id, c.first_name, c.last_name, SUM(cd.reward_points) AS total_reward_points
FROM cards cd
JOIN accounts a ON cd.account_id = a.account_id
JOIN customers c ON a.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_reward_points DESC
LIMIT 10;

-- Q7. Credit card utilization (outstanding / credit_limit) - avg and how many cards are using more than 80% of their limit
SELECT
    ROUND(AVG(outstanding_balance / NULLIF(credit_limit, 0)) * 100, 2) AS avg_utilization_pct,
    SUM(CASE WHEN outstanding_balance / NULLIF(credit_limit, 0) > 0.8 THEN 1 ELSE 0 END) AS high_utilization_cards,
    COUNT(*) AS total_credit_cards
FROM cards
WHERE card_type = 'Credit' AND credit_limit > 0;

-- Q8. Does Auto-debit have a lower late/missed payment rate than other payment methods?
SELECT
    payment_method,
    COUNT(*) AS total_payments,
    SUM(CASE
        WHEN status IN ('Late', 'Missed') THEN 1
        ELSE 0
    END) AS late_or_missed_payments,
    ROUND(
        SUM(CASE
            WHEN status IN ('Late', 'Missed') THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS late_or_missed_rate_pct
FROM loan_payments
GROUP BY payment_method
ORDER BY late_or_missed_rate_pct;