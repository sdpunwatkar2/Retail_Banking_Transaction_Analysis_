# Retail Banking Transaction Analysis

## MySQL Business Analytics Project

A comprehensive SQL and business analytics project focused on understanding customer behaviour, account usage, transaction patterns, loan performance, repayment behaviour, and card product engagement in a retail banking environment.

The project follows a complete analytics workflow: understanding the business requirements, interpreting an ER diagram, designing a relational database, importing data, performing exploratory analysis, conducting objective-based analysis, and deriving meaningful business insights.

---

## Project Objectives

The primary objectives of this project are to:

- Understand customer profiles and segment customers based on demographic and financial characteristics.
- Analyze account usage, balances, account types, and branch-level activity.
- Examine transaction patterns, transaction channels, amounts, and customer transaction behaviour.
- Evaluate loan performance and repayment behaviour.
- Analyze card usage and customer engagement with multiple banking products.
- Generate business insights to support data-driven decision-making.

---

## Business Problem

A retail bank provides multiple banking products and services, including:

- Customer accounts
- Banking cards
- Loans
- Loan repayment services
- Transaction services

The bank operates through multiple branches and serves a large customer base. Management needs a structured analysis of customer behaviour, banking product usage, transaction activity, loan performance, and product engagement.

As a Data Analyst, the objective of this project is to transform raw banking data into meaningful insights using MySQL.

---

## Database Schema

The database contains the following seven tables:

### 1. `branches`
Stores information about bank branches.

**Key information:**
- Branch ID
- Branch name
- City
- State
- Region
- Opening date
- Employee count

### 2. `customers`
Stores customer demographic and financial information.

**Key information:**
- Customer ID
- Name
- Date of birth
- Gender
- Location
- Customer segment
- Annual income
- Credit score
- KYC status
- Active status

### 3. `accounts`
Stores customer bank account information.

**Key information:**
- Account ID
- Customer ID
- Branch ID
- Account type
- Open and close dates
- Current balance
- Interest rate
- Overdraft limit
- Account status

### 4. `cards`
Stores card-related information linked to customer accounts.

**Key information:**
- Card ID
- Account ID
- Card type
- Issue and expiry dates
- Credit limit
- Outstanding balance
- Reward points
- Active status
- Network

### 5. `transactions`
Stores banking transaction information.

**Key information:**
- Transaction ID
- Account ID
- Transaction date and time
- Transaction type
- Amount
- Channel
- Description
- Balance after transaction
- Transaction status

### 6. `loans`
Stores customer loan information.

**Key information:**
- Loan ID
- Customer ID
- Branch ID
- Loan type
- Principal amount
- Interest rate
- Tenure
- Outstanding balance
- Loan status
- Purpose

### 7. `loan_payments`
Stores loan repayment information.

**Key information:**
- Payment ID
- Loan ID
- Payment date
- Scheduled amount
- Paid amount
- Principal paid
- Interest paid
- Penalty
- Days late
- Payment method
- Payment status

---

## Entity Relationships

The database follows a relational design using primary keys and foreign keys.

```text
Customers ────< Accounts >──── Branches
     │              │
     │              └────< Cards
     │
     └────< Loans >──── Branches
                  │
                  └────< Loan Payments

Accounts ────< Transactions
```

### Main Relationships

- One customer can have multiple accounts.
- One branch can manage multiple accounts.
- One account can have multiple cards.
- One account can have multiple transactions.
- One customer can have multiple loans.
- One branch can issue multiple loans.
- One loan can have multiple repayment records.

---

## Dataset Overview

| Table | Number of Rows | Number of Columns |
|---|---:|---:|
| Customers | 500 | 13 |
| Accounts | 700 | 10 |
| Branches | 40 | 7 |
| Loans | 300 | 13 |
| Loan Payments | 2,000 | 11 |
| Cards | 600 | 10 |
| Transactions | 5,000 | 10 |

---

## Project Workflow

### Sprint 1: Business Understanding and Data Understanding

This phase focuses on:

- Understanding the retail banking business.
- Identifying the role of a Data Analyst.
- Studying the Entity Relationship (ER) diagram.
- Understanding tables, columns, primary keys, and foreign keys.
- Identifying which tables are required to answer different business questions.

---

### Sprint 2: Database Setup

This phase includes:

- Creating the `RETAIL_BANK_DB` database.
- Designing all tables based on the ER diagram.
- Defining primary keys and foreign keys.
- Applying constraints such as `NOT NULL` and `DEFAULT`.
- Importing CSV data into the respective tables.
- Verifying the imported data.

---

### Sprint 3: Basic Data Exploration

Basic SQL queries are used to understand the dataset.

Examples include:

- Total number of customers.
- Total number of accounts.
- Different account types.
- Number of active customers.
- Different transaction types.
- Total completed transaction amount.
- Different loan types.
- Total number of loans.
- Different card types.
- Total outstanding loan balance.

---

## Sprint 4: Objective-Based Analysis

### 4.1 Customer Profile and Segmentation

**Business Objective:**  
Understand the customer base and identify differences between customer groups.

### Analysis Areas

- Customer segment distribution
- Gender and demographic analysis
- Customer distribution across cities and states
- Income comparison
- Credit score comparison
- Active versus inactive customers
- KYC status
- Customer tenure

### Sample Business Questions

- Which customer segments have the largest customer base?
- Which cities and states have the highest number of customers?
- How do annual income and credit scores vary across customer segments?
- What proportion of customers are currently active?
- How long have customers been associated with the bank?

---

### 4.2 Account Usage and Branch Activity

**Business Objective:**  
Understand how accounts are used and how account activity differs across account types and branches.

### Analysis Areas

- Account type distribution
- Account balances
- Interest rates
- Customer account ownership
- Branch-level account activity
- Active and closed account comparison

### Sample Business Questions

- Which account type is the most common?
- Which account type maintains the highest average balance?
- Which branches manage the highest number of accounts?
- Which branches have the highest total account balances?
- Which customers have multiple accounts?
- How do interest rates differ across account types?

---

### 4.3 Transaction Pattern Analysis

**Business Objective:**  
Understand how customers use their accounts and how money moves through the banking system.

### Analysis Areas

- Transaction types
- Transaction channels
- Transaction amounts
- Transaction descriptions
- Monthly transaction trends
- Account-level transaction activity
- Customer transaction volume
- Transaction status distribution

### Sample Business Questions

- Which transaction types are most common?
- Which transaction channels are most frequently used?
- What are the average, minimum, and maximum transaction amounts?
- Which accounts generate the highest transaction activity?
- How does transaction volume change over time?
- Which customers generate the highest transaction volume?

---

### 4.4 Loan Performance and Repayment Behaviour

**Business Objective:**  
Understand loan performance and determine whether customers are repaying loans as expected.

### Analysis Areas

- Loan type distribution
- Loan purposes
- Outstanding loan balances
- Loan status
- Delayed payments
- Penalties
- Branch-level loan exposure
- Payment methods

### Sample Business Questions

- Which loan types have the highest number of loans?
- Which loan purposes are most common?
- Which loan types have the highest outstanding balances?
- Which loans have delayed repayments?
- Which loans have generated the highest penalties?
- How does repayment behaviour differ across loan types?
- Which branches have the highest outstanding loan exposure?

---

### 4.5 Card Usage and Product Engagement

**Business Objective:**  
Understand how customers use card products and how card usage relates to their overall banking relationship.

### Analysis Areas

- Card type distribution
- Credit limits
- Outstanding balances
- Active and inactive cards
- Reward points
- Card networks
- Multiple card ownership
- Multi-product customers

### Sample Business Questions

- Which card types are most popular?
- Which card types have the highest average credit limits?
- How many cards are active and inactive?
- Which card types generate the highest reward points?
- Which accounts have multiple cards?
- Which customers use multiple banking products?
- Which customers have the highest overall product engagement?

---

## Technologies Used

- **MySQL**
- **MySQL Workbench**
- **SQL**
- **CSV Data Files**
- **GitHub**

---

## Key SQL Concepts Used

This project demonstrates practical use of:

- `CREATE DATABASE`
- `CREATE TABLE`
- `PRIMARY KEY`
- `FOREIGN KEY`
- `NOT NULL`
- `DEFAULT`
- `SELECT`
- `WHERE`
- `GROUP BY`
- `HAVING`
- `ORDER BY`
- `DISTINCT`
- `COUNT()`
- `SUM()`
- `AVG()`
- `MIN()`
- `MAX()`
- `JOIN`
- `LEFT JOIN`
- `INNER JOIN`
- `CASE`
- Date and time functions
- Aggregate functions
- Subqueries

---

## How to Run the Project

### Step 1: Clone the Repository

```bash
git clone <repository-url>
cd Retail-Banking-Transaction-Analysis
```

### Step 2: Open MySQL Workbench

Connect to your MySQL server using MySQL Workbench.

### Step 3: Create the Database

Run the database creation script:

```sql
CREATE DATABASE RETAIL_BANK_DB;
USE RETAIL_BANK_DB;
```

### Step 4: Create the Tables

Execute the database schema SQL script to create:

- branches
- customers
- accounts
- cards
- transactions
- loans
- loan_payments

### Step 5: Import the Dataset

Import the provided CSV files into their corresponding tables.

### Step 6: Verify the Data

Use queries such as:

```sql
SELECT * FROM customers;
SELECT * FROM accounts;
SELECT * FROM transactions;
```

### Step 7: Run the Analysis Queries

Execute the SQL files for:

- Basic Data Exploration
- Customer Analysis
- Account and Branch Analysis
- Transaction Analysis
- Loan Performance Analysis
- Card and Product Engagement Analysis

---

## Suggested Project Structure

```text
Retail-Banking-Transaction-Analysis/
│
├── README.md
│
├── database/
│   └── retail_bank_database.sql
│
├── data/
│   ├── branches.csv
│   ├── customers.csv
│   ├── accounts.csv
│   ├── cards.csv
│   ├── transactions.csv
│   ├── loans.csv
│   └── loan_payments.csv
│
├── queries/
│   ├── sprint_3_basic_analysis.sql
│   └── sprint_4_objective_based_analysis.sql
│
├── documentation/
│   ├── project_documentation.pdf
│   └── ER_Diagram.png
│
└── results/
    └── business_insights.md
```

---

## Business Value

This project demonstrates how SQL and relational databases can be used to transform banking data into actionable insights.

The analysis can help a bank:

- Better understand its customer base.
- Identify high-value customer segments.
- Evaluate branch and account performance.
- Understand customer transaction behaviour.
- Identify potential loan repayment risks.
- Analyze card product engagement.
- Identify opportunities for cross-selling banking products.
- Support data-driven business decisions.

---

## Future Improvements

The project can be extended by:

- Creating interactive dashboards using Power BI or Tableau.
- Building visual reports for key banking KPIs.
- Adding advanced SQL techniques such as CTEs and window functions.
- Developing customer risk scores.
- Performing customer churn analysis.
- Building predictive models for loan default risk.
- Creating a real-time banking analytics dashboard using Python.

---

## Conclusion

The **Retail Banking Transaction Analysis** project demonstrates how MySQL and data analytics can transform structured banking data into meaningful business insights.

By analyzing customer profiles, account activity, transaction patterns, loan performance, repayment behaviour, and card usage, the project provides a comprehensive view of customer engagement with banking products.

The project also demonstrates the complete workflow of a Data Analyst—from understanding a business problem and designing a relational database to writing SQL queries, analyzing data, interpreting results, and communicating actionable insights.

---

## Author

**Shantanu Punwatkar**

B.Tech Computer Science Engineering | Data Analytics | SQL | MySQL
