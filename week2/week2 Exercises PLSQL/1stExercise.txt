--Scenario 1: Apply Discount to Loan Interest Rates for Customers Above 60 Years Old

DECLARE
    CURSOR customer_cursor IS
        SELECT c.CustomerID, TRUNC(MONTHS_BETWEEN(SYSDATE, c.DOB) / 12) AS Age, l.LoanID, l.InterestRate
        FROM Customers c
        JOIN Loans l ON c.CustomerID = l.CustomerID;
    
    v_customer_id Customers.CustomerID%TYPE;
    v_age NUMBER;
    v_loan_id Loans.LoanID%TYPE;
    v_interest_rate Loans.InterestRate%TYPE;
BEGIN
    OPEN customer_cursor;
    LOOP
        FETCH customer_cursor INTO v_customer_id, v_age, v_loan_id, v_interest_rate;
        EXIT WHEN customer_cursor%NOTFOUND;
        
        IF v_age > 60 THEN
            UPDATE Loans
            SET InterestRate = v_interest_rate * 0.99
            WHERE LoanID = v_loan_id;
        END IF;
    END LOOP;
    CLOSE customer_cursor;
    
    COMMIT;
END;
/

-- Check updated loan interest rates
SELECT * FROM Loans;


--Scenario 2: Promote Customers to VIP Status Based on Balance

DECLARE
    CURSOR customer_cursor IS
        SELECT CustomerID, Balance
        FROM Customers;
    
    v_customer_id Customers.CustomerID%TYPE;
    v_balance Customers.Balance%TYPE;
BEGIN
    OPEN customer_cursor;
    LOOP
        FETCH customer_cursor INTO v_customer_id, v_balance;
        EXIT WHEN customer_cursor%NOTFOUND;
        
        IF v_balance > 10000 THEN
            UPDATE Customers
            SET IsVIP = 'YES'
            WHERE CustomerID = v_customer_id;
        END IF;
    END LOOP;
    CLOSE customer_cursor;
    
    COMMIT;
END;
/

-- Check updated customer VIP status
SELECT * FROM Customers WHERE IsVIP = 'YES';


--Scenario 3: Send Reminders to Customers with Loans Due in the Next 30 Days

DECLARE
    CURSOR loan_cursor IS
        SELECT l.LoanID, l.CustomerID, c.Name, l.EndDate
        FROM Loans l
        JOIN Customers c ON l.CustomerID = c.CustomerID
        WHERE l.EndDate BETWEEN SYSDATE AND SYSDATE + 30;
    
    v_loan_id Loans.LoanID%TYPE;
    v_customer_id Loans.CustomerID%TYPE;
    v_customer_name Customers.Name%TYPE;
    v_end_date Loans.EndDate%TYPE;
BEGIN
    OPEN loan_cursor;
    LOOP
        FETCH loan_cursor INTO v_loan_id, v_customer_id, v_customer_name, v_end_date;
        EXIT WHEN loan_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Reminder: Customer ' || v_customer_name || ' (ID: ' || v_customer_id || ') has a loan (ID: ' || v_loan_id || ') due on ' || v_end_date || '.');
    END LOOP;
    CLOSE loan_cursor;
END;
/





