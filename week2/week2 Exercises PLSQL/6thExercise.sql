-- Scenario 1: Generate Monthly Statements for All Customers

DECLARE
    CURSOR transactions_cursor IS
        SELECT c.CustomerID, c.Name, t.TransactionDate, t.Amount, t.TransactionType
        FROM Customers c
        JOIN Accounts a ON c.CustomerID = a.CustomerID
        JOIN Transactions t ON a.AccountID = t.AccountID
        WHERE EXTRACT(MONTH FROM t.TransactionDate) = EXTRACT(MONTH FROM SYSDATE)
          AND EXTRACT(YEAR FROM t.TransactionDate) = EXTRACT(YEAR FROM SYSDATE)
        ORDER BY c.CustomerID, t.TransactionDate;

    v_customer_id Customers.CustomerID%TYPE;
    v_name Customers.Name%TYPE;
    v_transaction_date Transactions.TransactionDate%TYPE;
    v_amount Transactions.Amount%TYPE;
    v_transaction_type Transactions.TransactionType%TYPE;
BEGIN
    OPEN transactions_cursor;
    LOOP
        FETCH transactions_cursor INTO v_customer_id, v_name, v_transaction_date, v_amount, v_transaction_type;
        EXIT WHEN transactions_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Customer ID: ' || v_customer_id || ', Name: ' || v_name);
        DBMS_OUTPUT.PUT_LINE('Date: ' || v_transaction_date || ', Amount: ' || v_amount || ', Type: ' || v_transaction_type);
        DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    END LOOP;
    CLOSE transactions_cursor;
END;
/


-- Check updated transactions for monthly statements
SELECT * FROM Transactions WHERE EXTRACT(MONTH FROM TransactionDate) = EXTRACT(MONTH FROM SYSDATE)
AND EXTRACT(YEAR FROM TransactionDate) = EXTRACT(YEAR FROM SYSDATE);

-- Scenario 2: Apply Annual Fee to All Accounts

DECLARE
    CURSOR accounts_cursor IS
        SELECT AccountID, Balance
        FROM Accounts;

    v_account_id Accounts.AccountID%TYPE;
    v_balance Accounts.Balance%TYPE;
    v_annual_fee CONSTANT NUMBER := 50; -- Annual fee amount
BEGIN
    OPEN accounts_cursor;
    LOOP
        FETCH accounts_cursor INTO v_account_id, v_balance;
        EXIT WHEN accounts_cursor%NOTFOUND;
        IF v_balance >= v_annual_fee THEN
            UPDATE Accounts
            SET Balance = Balance - v_annual_fee
            WHERE AccountID = v_account_id;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Insufficient funds for Account ID: ' || v_account_id);
        END IF;
    END LOOP;
    CLOSE accounts_cursor;
    COMMIT;
END;
/


-- Check updated balances for annual fee
SELECT * FROM Accounts;


-- Scenario 3: Update the Interest Rate for All Loans Based on a New Policy

DECLARE
    CURSOR loans_cursor IS
        SELECT LoanID, InterestRate
        FROM Loans;

    v_loan_id Loans.LoanID%TYPE;
    v_interest_rate Loans.InterestRate%TYPE;
    v_new_interest_rate CONSTANT NUMBER := 6; -- New interest rate policy
BEGIN
    OPEN loans_cursor;
    LOOP
        FETCH loans_cursor INTO v_loan_id, v_interest_rate;
        EXIT WHEN loans_cursor%NOTFOUND;
        UPDATE Loans
        SET InterestRate = v_new_interest_rate
        WHERE LoanID = v_loan_id;
    END LOOP;
    CLOSE loans_cursor;
    COMMIT;
END;
/


-- Check updated interest rates for loans
SELECT * FROM Loans;