-- BANK LOAN REPORT | SUMMARY

SELECT * FROM bank_loan_data;


------------------ Loan Applications -----------------------

-- 1. Total Loan Applications
-- 2. MTD Loan Applications
-- 3. PMTD Loan Applications

SELECT 
	COUNT(id) AS Total_Loan_Applications,
	COUNT(CASE WHEN MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021 THEN id END) AS MTD_Applications,
	COUNT(case when month(issue_date) = 11 AND YEAR(issue_date) = 2021 THEN id END) AS PMTD_Applications
FROM bank_loan_data;


------------------ Founded Amount -----------------------

-- 1. Total Founded Amount
-- 2. MTD Founded Amount
-- 3. PMTD Founded Amount

SELECT 
	SUM(loan_amount) AS Total_Founded_Amount,
	SUM(CASE WHEN MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021 THEN loan_amount END) AS MTD_Founded_Amount,
	SUM(case when month(issue_date) = 11 AND YEAR(issue_date) = 2021 THEN loan_amount END) AS PMTD_FoundedAmount
FROM bank_loan_data;

------------------ Amount Received -----------------------

-- 1. Total Amount Received
-- 2. MTD Amount Received
-- 3. PMTD Amount Received

SELECT 
	SUM(total_payment) AS Total_Amount_Received,
	SUM(CASE WHEN MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021 THEN total_payment END) AS MTD_Amount_Received,
	SUM(case when month(issue_date) = 11 AND YEAR(issue_date) = 2021 THEN total_payment END) AS PMTD_Amount_Received
FROM bank_loan_data;

------------------ Interest Rate -----------------------

-- 1. AVG Interest Rate
-- 2. MTD AVG Interest Rate
-- 3. PMTD AVG Interest Rate

SELECT 
	ROUND(AVG(int_rate) * 100, 2) AS AVG_Interest_Rate,
	ROUND(AVG(CASE WHEN MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021 THEN int_rate END) * 100, 2) AS MTD_AVG_Interest_Rate,
	ROUND(AVG(CASE WHEN MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021 THEN int_rate END) * 100, 2) AS PMTD_AVG_Interest_Rate
FROM bank_loan_data;


------------------ Depth To Income -----------------------

-- 1. AVG Depth To Income
-- 2. MTD AVG Depth To Income
-- 3. PMTD AVG Depth To Income

SELECT 
	ROUND(AVG(dti) * 100, 2) AS AVG_DTI,
	ROUND(AVG(CASE WHEN MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021 THEN dti END) * 100, 2) AS MTD_AVG_DTI,
	ROUND(AVG(CASE WHEN MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021 THEN dti END) * 100, 2) AS PMTD_AVG_DTI
FROM bank_loan_data;


--------------------------------------------------------------------------------

------------------ GOOD LOAN ISSUED -----------------------

-- 1. Good Loan Percentage
-- 2. Good Loan Applications 
-- 3. Good Loan Founded Amount 
-- 4. Good Loan Received amount 

SELECT DISTINCT loan_status FROM bank_loan_data;

SELECT 
	ROUND(COUNT(CASE WHEN loan_status IN ('Fully Paid', 'Current') THEN id END) * 100 / COUNT(id), 2) AS Good_Loan_Percentage,
	COUNT(CASE WHEN loan_status IN ('Fully Paid', 'Current') THEN id END) AS Good_Loan_Applications,
	SUM(CASE WHEN loan_status IN ('Fully Paid', 'Current') THEN loan_amount END) AS Good_Loan_Founded_Amount,
	SUM(CASE WHEN loan_status IN ('Fully Paid', 'Current') THEN total_payment END) AS Good_Loan_Received_Amount
FROM bank_loan_data;


------------------ BAD LOAN ISSUED -----------------------

-- 1. BAD Loan Percentage
-- 2. BAD Loan Applications 
-- 3. BAD Loan Founded Amount 
-- 4. BAD Loan Received amount 


SELECT 
	ROUND(COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100 / COUNT(id), 2) AS Bad_Loan_Percentage,
	COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) AS Bad_Loan_Applications,
	SUM(CASE WHEN loan_status = 'Charged Off' THEN loan_amount END) AS Bad_Loan_Founded_Amount,
	SUM(CASE WHEN loan_status = 'Charged Off' THEN total_payment END) AS Bad_Loan_Received_Amount
FROM bank_loan_data;

------------------ Loan Status -----------------------

-- for every status in loan_status we need to calculate: 
	-- 1. Total Applications
	-- 2. Total Amount Received
	-- 3. Total Founded Amount 
	-- 4. AVG Interest Rate
	-- 5. AVG DTI

SELECT DISTINCT loan_status FROM bank_loan_data;

SELECT
	loan_status AS Loan_Status,
	COUNT(id) AS Total_Applications,
	SUM(total_payment) AS Total_Amount_Reveived,
	SUM(loan_amount) AS Total_Amount_Founded,
	ROUND(AVG(int_rate) * 100, 2) AS AVG_Interest_Rate,
	ROUND(AVG(dti) * 100, 2) AS AVG_DTI,
	SUM(CASE WHEN MONTH(issue_date) = 12 THEN total_payment END) AS MTD_Total_Amount_Received, 
	SUM(CASE WHEN MONTH(issue_date) = 12 THEN loan_amount END) AS MTD_Total_Funded_Amount
FROM bank_loan_data
GROUP BY loan_status






-- BANK LOAN REPORT | OVERVIEW


------------------ Overview By Month -----------------------
SELECT 
	MONTH(issue_date) AS Month_Munber, 
	DATENAME(MONTH, issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)


------------------ Overview By STATE -----------------------
SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state


------------------ Overview By TERM -----------------------
SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY term

------------------ Overview By Emp Length -----------------------
SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length


------------------ Overview By Perpose -----------------------
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose


------------------ Overview By Home Ownership -----------------------
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership




