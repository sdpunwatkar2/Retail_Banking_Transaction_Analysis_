-- ============================================
-- RETAIL BANKING DATABASE
-- ============================================

CREATE DATABASE RETAIL_BANK_DB;

USE RETAIL_BANK_DB;


-- ============================================
-- 1. BRANCHES TABLE
-- ============================================

CREATE TABLE branches (
    branch_id VARCHAR(10) PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    state VARCHAR(30),
    region VARCHAR(30),
    opening_date DATE NOT NULL,
    employee_count INT
);

SELECT * FROM branches;


-- ============================================
-- 2. CUSTOMERS TABLE
-- ============================================

CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(20) NOT NULL,
    city VARCHAR(50),
    state VARCHAR(30),
    customer_since DATE NOT NULL,
    kyc_status VARCHAR(20),
    segment VARCHAR(30),
    annual_income DECIMAL(12,2),
    credit_score INT,
    is_active VARCHAR(3) DEFAULT 'yes'
);

SELECT * FROM customers;


-- ============================================
-- 3. ACCOUNTS TABLE
-- ============================================

CREATE TABLE accounts (
    account_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    branch_id VARCHAR(10) NOT NULL,
    account_type VARCHAR(30) NOT NULL,
    open_date DATE NOT NULL,
    close_date DATE DEFAULT '2099-12-31',
    current_balance DECIMAL(15,2) NOT NULL,
    interest_rate DECIMAL(5,2) NOT NULL,
    overdraft_limit DECIMAL(12,2) NOT NULL,
    status VARCHAR(20),

    CONSTRAINT fk_accounts_customers
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    CONSTRAINT fk_accounts_branches
        FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id)
);

SELECT * FROM accounts;


-- ============================================
-- 4. CARDS TABLE
-- ============================================

CREATE TABLE cards (
    card_id VARCHAR(20) PRIMARY KEY,
    account_id VARCHAR(20) NOT NULL,
    card_type VARCHAR(20) NOT NULL,
    issue_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    credit_limit DECIMAL(12,2) NOT NULL,
    outstanding_balance DECIMAL(12,2) NOT NULL,
    reward_points INT,
    is_active VARCHAR(3) DEFAULT 'yes',
    network VARCHAR(20),

    CONSTRAINT fk_cards_accounts
        FOREIGN KEY (account_id)
        REFERENCES accounts(account_id)
);

SELECT * FROM cards;


-- ============================================
-- 5. TRANSACTIONS TABLE
-- ============================================

CREATE TABLE transactions (
    transaction_id VARCHAR(20) PRIMARY KEY,
    account_id VARCHAR(20) NOT NULL,
    transaction_date DATE NOT NULL,
    transaction_time TIME NOT NULL,
    transaction_type VARCHAR(30) NOT NULL,
    amount DECIMAL(15,2),
    channel VARCHAR(30),
    description VARCHAR(50) NOT NULL,
    balance_after DECIMAL(15,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'Pending',

    CONSTRAINT fk_transactions_accounts
        FOREIGN KEY (account_id)
        REFERENCES accounts(account_id)
);

SELECT * FROM transactions;


-- ============================================
-- 6. LOANS TABLE
-- ============================================

CREATE TABLE loans (
    loan_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    branch_id VARCHAR(10) NOT NULL,
    loan_type VARCHAR(30),
    principal_amount DECIMAL(15,2),
    interest_rate DECIMAL(15,2),
    tenure_months INT,
    disbursement_date DATE,
    maturity_date DATE,
    emi_amount DECIMAL(12,2),
    outstanding_balance DECIMAL(15,2),
    loan_status VARCHAR(30),
    purpose VARCHAR(50),

    CONSTRAINT fk_loans_customers
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    CONSTRAINT fk_loans_branch
        FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id)
);

SELECT * FROM loans;


-- ============================================
-- 7. LOAN PAYMENTS TABLE
-- ============================================

CREATE TABLE loan_payments (
    payment_id VARCHAR(20) PRIMARY KEY,
    loan_id VARCHAR(20),
    payment_date DATE,
    scheduled_amount DECIMAL(12,2),
    paid_amount DECIMAL(12,2),
    principal_paid DECIMAL(12,2),
    interest_paid DECIMAL(12,2),
    penalty DECIMAL(12,2),
    days_late INT,
    payment_method VARCHAR(30),
    status VARCHAR(20),

    CONSTRAINT fk_loan_repayment
        FOREIGN KEY (loan_id)
        REFERENCES loans(loan_id)
);

SELECT * FROM loan_payments;

-- ============================================
-- RETAIL BANKING TRANSACTION ANALYSIS
-- Sprint 3: Basic Analysis / Data Exploration
-- ============================================


-- 11. What is the total number of customers?
SELECT COUNT(*) AS total_customers
FROM customers;


-- 12. What is the total number of accounts?
SELECT COUNT(*) AS total_accounts
FROM accounts;


-- 13. What are the different account types available?
SELECT DISTINCT account_type
FROM accounts;


-- 14. How many customers are currently active?
SELECT COUNT(*) AS active_customers
FROM customers
WHERE is_active = 'yes';


-- 15. What are the different transaction types available?
SELECT DISTINCT transaction_type
FROM transactions;


-- 16. What is the total amount of completed transactions?
SELECT SUM(amount) AS total_completed_transaction_amount
FROM transactions
WHERE status = 'Completed';


-- 17. What are the different loan types available?
SELECT DISTINCT loan_type
FROM loans;


-- 18. What is the total number of loans?
SELECT COUNT(*) AS total_loans
FROM loans;


-- 19. What are the different card types available?
SELECT DISTINCT card_type
FROM cards;


-- 20. What is the total outstanding loan balance?
SELECT SUM(outstanding_balance) AS total_outstanding_loan_balance
FROM loans;



-- =========================================================
-- RETAIL BANKING TRANSACTION ANALYSIS
-- SPRINT 4: OBJECTIVE-BASED ANALYSIS
-- =========================================================

USE RETAIL_BANK_DB;


-- =========================================================
-- 4.1 UNDERSTAND CUSTOMER PROFILE AND SEGMENTATION
-- =========================================================

-- Q1. How are customers distributed across different segments?
SELECT 
    segment,
    COUNT(*) AS total_customers
FROM customers
GROUP BY segment
ORDER BY total_customers DESC;


-- Q2. What is the demographic distribution of customers by gender?
SELECT 
    gender,
    COUNT(*) AS total_customers
FROM customers
GROUP BY gender;


-- Q3. Which cities have the highest number of customers?
SELECT 
    city,
    COUNT(*) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC;


-- Q4. How does customer distribution vary across states?
SELECT 
    state,
    COUNT(*) AS total_customers
FROM customers
GROUP BY state
ORDER BY total_customers DESC;


-- Q5. How do income and credit scores differ across customer segments?
SELECT 
    segment,
    AVG(annual_income) AS avg_annual_income,
    AVG(credit_score) AS avg_credit_score
FROM customers
GROUP BY segment
ORDER BY avg_annual_income DESC;


-- Q6. What is the distribution of active and inactive customers?
SELECT 
    is_active,
    COUNT(*) AS total_customers
FROM customers
GROUP BY is_active;


-- Q7. What is the KYC status distribution among customers?
SELECT 
    kyc_status,
    COUNT(*) AS total_customers
FROM customers
GROUP BY kyc_status
ORDER BY total_customers DESC;


-- Q8. Which customers have the longest relationship with the bank?
SELECT 
    customer_id,
    first_name,
    last_name,
    customer_since,
    TIMESTAMPDIFF(YEAR, customer_since, CURDATE()) AS tenure_years
FROM customers
ORDER BY tenure_years DESC;


-- =========================================================
-- 4.2 UNDERSTAND ACCOUNT USAGE AND BRANCH ACTIVITY
-- =========================================================

-- Q1. How are accounts distributed across account types?
SELECT 
    account_type,
    COUNT(*) AS total_accounts
FROM accounts
GROUP BY account_type
ORDER BY total_accounts DESC;


-- Q2. What is the average balance for each account type?
SELECT 
    account_type,
    COUNT(*) AS total_accounts,
    AVG(current_balance) AS average_balance,
    SUM(current_balance) AS total_balance
FROM accounts
GROUP BY account_type
ORDER BY total_balance DESC;


-- Q3. Which branches manage the highest number of accounts?
SELECT 
    b.branch_name,
    b.city,
    COUNT(a.account_id) AS total_accounts
FROM branches b
LEFT JOIN accounts a
    ON b.branch_id = a.branch_id
GROUP BY b.branch_id, b.branch_name, b.city
ORDER BY total_accounts DESC;


-- Q4. Which branches have the highest total account balances?
SELECT 
    b.branch_name,
    SUM(a.current_balance) AS total_account_balance
FROM branches b
JOIN accounts a
    ON b.branch_id = a.branch_id
GROUP BY b.branch_id, b.branch_name
ORDER BY total_account_balance DESC;


-- Q5. What are the average interest rates across account types?
SELECT 
    account_type,
    AVG(interest_rate) AS average_interest_rate
FROM accounts
GROUP BY account_type
ORDER BY average_interest_rate DESC;


-- Q6. How many accounts exist under each status?
SELECT 
    status,
    COUNT(*) AS total_accounts
FROM accounts
GROUP BY status;


-- Q7. Which customers have multiple accounts?
SELECT 
    customer_id,
    COUNT(account_id) AS total_accounts
FROM accounts
GROUP BY customer_id
HAVING COUNT(account_id) > 1
ORDER BY total_accounts DESC;


-- Q8. What is the account distribution across branches and account types?
SELECT 
    b.branch_name,
    a.account_type,
    COUNT(*) AS total_accounts
FROM accounts a
JOIN branches b
    ON a.branch_id = b.branch_id
GROUP BY b.branch_name, a.account_type
ORDER BY b.branch_name, total_accounts DESC;


-- =========================================================
-- 4.3 ANALYZE TRANSACTION PATTERNS
-- =========================================================

-- Q1. Which transaction types are most common?
SELECT 
    transaction_type,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount
FROM transactions
GROUP BY transaction_type
ORDER BY transaction_count DESC;


-- Q2. Which transaction channels are used most frequently?
SELECT 
    channel,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount
FROM transactions
GROUP BY channel
ORDER BY transaction_count DESC;


-- Q3. What is the average transaction amount by transaction type?
SELECT 
    transaction_type,
    AVG(amount) AS average_transaction_amount,
    MAX(amount) AS highest_transaction,
    MIN(amount) AS lowest_transaction
FROM transactions
GROUP BY transaction_type;


-- Q4. What are the most common transaction descriptions?
SELECT 
    description,
    COUNT(*) AS frequency
FROM transactions
GROUP BY description
ORDER BY frequency DESC;


-- Q5. How does transaction activity change over time?
SELECT 
    YEAR(transaction_date) AS transaction_year,
    MONTH(transaction_date) AS transaction_month,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_transaction_amount
FROM transactions
GROUP BY YEAR(transaction_date), MONTH(transaction_date)
ORDER BY transaction_year, transaction_month;


-- Q6. Which accounts have the highest transaction activity?
SELECT 
    account_id,
    COUNT(transaction_id) AS transaction_count,
    SUM(amount) AS total_transaction_amount
FROM transactions
GROUP BY account_id
ORDER BY transaction_count DESC;


-- Q7. Which customers generate the highest transaction volume?
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(t.transaction_id) AS transaction_count,
    SUM(t.amount) AS total_transaction_amount
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_transaction_amount DESC;


-- Q8. What is the transaction status distribution?
SELECT 
    status,
    COUNT(*) AS total_transactions,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM transactions),
        2
    ) AS percentage
FROM transactions
GROUP BY status;


-- =========================================================
-- 4.4 EVALUATE LOAN PERFORMANCE AND REPAYMENT BEHAVIOUR
-- =========================================================

-- Q1. How are loans distributed across different loan types?
SELECT 
    loan_type,
    COUNT(*) AS total_loans,
    SUM(principal_amount) AS total_principal_amount
FROM loans
GROUP BY loan_type
ORDER BY total_loans DESC;


-- Q2. Which loan purposes are most common?
SELECT 
    purpose,
    COUNT(*) AS total_loans
FROM loans
GROUP BY purpose
ORDER BY total_loans DESC;


-- Q3. What is the total outstanding balance for each loan type?
SELECT 
    loan_type,
    SUM(outstanding_balance) AS total_outstanding_balance
FROM loans
GROUP BY loan_type
ORDER BY total_outstanding_balance DESC;


-- Q4. How are loans distributed by loan status?
SELECT 
    loan_status,
    COUNT(*) AS total_loans
FROM loans
GROUP BY loan_status;


-- Q5. Which loans have delayed payments?
SELECT 
    loan_id,
    COUNT(*) AS delayed_payments,
    AVG(days_late) AS average_days_late
FROM loan_payments
WHERE days_late > 0
GROUP BY loan_id
ORDER BY average_days_late DESC;


-- Q6. Which loans have the highest penalties?
SELECT 
    loan_id,
    SUM(penalty) AS total_penalty
FROM loan_payments
GROUP BY loan_id
ORDER BY total_penalty DESC;


-- Q7. How does repayment behaviour differ across loan types?
SELECT 
    l.loan_type,
    AVG(lp.days_late) AS average_days_late,
    SUM(lp.penalty) AS total_penalty,
    SUM(lp.paid_amount) AS total_amount_paid
FROM loans l
JOIN loan_payments lp
    ON l.loan_id = lp.loan_id
GROUP BY l.loan_type
ORDER BY average_days_late DESC;


-- Q8. Which branches have the highest outstanding loan balances?
SELECT 
    b.branch_name,
    COUNT(l.loan_id) AS total_loans,
    SUM(l.outstanding_balance) AS total_outstanding_balance
FROM branches b
JOIN loans l
    ON b.branch_id = l.branch_id
GROUP BY b.branch_id, b.branch_name
ORDER BY total_outstanding_balance DESC;


-- Q9. Which payment methods are most commonly used?
SELECT 
    payment_method,
    COUNT(*) AS total_payments,
    SUM(paid_amount) AS total_paid_amount
FROM loan_payments
GROUP BY payment_method
ORDER BY total_payments DESC;


-- =========================================================
-- 4.5 UNDERSTAND CARD USAGE AND PRODUCT ENGAGEMENT
-- =========================================================

-- Q1. How are cards distributed across different card types?
SELECT 
    card_type,
    COUNT(*) AS total_cards
FROM cards
GROUP BY card_type
ORDER BY total_cards DESC;


-- Q2. What is the average credit limit and outstanding balance for each card type?
SELECT 
    card_type,
    AVG(credit_limit) AS average_credit_limit,
    AVG(outstanding_balance) AS average_outstanding_balance
FROM cards
GROUP BY card_type;


-- Q3. How many cards are active and inactive?
SELECT 
    is_active,
    COUNT(*) AS total_cards
FROM cards
GROUP BY is_active;


-- Q4. Which card type has the highest reward points?
SELECT 
    card_type,
    AVG(reward_points) AS average_reward_points,
    SUM(reward_points) AS total_reward_points
FROM cards
GROUP BY card_type
ORDER BY total_reward_points DESC;


-- Q5. How are cards distributed across different networks?
SELECT 
    network,
    COUNT(*) AS total_cards,
    AVG(credit_limit) AS average_credit_limit
FROM cards
GROUP BY network
ORDER BY total_cards DESC;


-- Q6. Which accounts have multiple cards?
SELECT 
    account_id,
    COUNT(card_id) AS total_cards
FROM cards
GROUP BY account_id
HAVING COUNT(card_id) > 1
ORDER BY total_cards DESC;


-- Q7. Which customers use multiple banking products?
SELECT DISTINCT
    c.customer_id,
    c.first_name,
    c.last_name
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN cards ca
    ON a.account_id = ca.account_id
JOIN loans l
    ON c.customer_id = l.customer_id;


-- Q8. How many products does each customer use?
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT a.account_id) AS total_accounts,
    COUNT(DISTINCT ca.card_id) AS total_cards,
    COUNT(DISTINCT l.loan_id) AS total_loans
FROM customers c
LEFT JOIN accounts a
    ON c.customer_id = a.customer_id
LEFT JOIN cards ca
    ON a.account_id = ca.account_id
LEFT JOIN loans l
    ON c.customer_id = l.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_accounts DESC, total_cards DESC, total_loans DESC;


-- Q9. Which customers have the highest overall product engagement?
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT a.account_id) +
    COUNT(DISTINCT ca.card_id) +
    COUNT(DISTINCT l.loan_id) AS total_products
FROM customers c
LEFT JOIN accounts a
    ON c.customer_id = a.customer_id
LEFT JOIN cards ca
    ON a.account_id = ca.account_id
LEFT JOIN loans l
    ON c.customer_id = l.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_products DESC;