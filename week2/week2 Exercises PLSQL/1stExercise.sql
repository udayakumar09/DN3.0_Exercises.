--Scenario 1

DECLARE
    v_customer_id Customers.CustomerID%TYPE;
    v_dob Customers.DOB%TYPE;
    v_age NUMBER;
BEGIN
    FOR rec IN (SELECT CustomerID, DOB FROM Customers) LOOP
        v_customer_id := rec.CustomerID;
        v_dob := rec.DOB;
        v_age := TRUNC(MONTHS_BETWEEN(SYSDATE, v_dob) / 12);
        
        IF v_age > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE CustomerID = v_customer_id;
        END IF;
    END LOOP;
    
    COMMIT;
END;
/

--Scenario 2

ALTER TABLE Customers add (IsVIP VARCHAR2(3) DEFAULT 'NO');

--ALTER TABLE Customers DROP COLUMN IsVIP;


DECLARE
    v_customer_id Customers.CustomerID%TYPE;
    v_balance Customers.Balance%TYPE;
BEGIN
    FOR rec IN (SELECT CustomerID, Balance FROM Customers) LOOP
        v_customer_id := rec.CustomerID;
        v_balance := rec.Balance;
        
        IF v_balance > 10000 THEN
            UPDATE Customers
            SET IsVIP = 'YES'
            WHERE CustomerID = v_customer_id;
        END IF;
    END LOOP;
    
    COMMIT;
END;
/

--Scenario 3

DECLARE
    v_customer_name Customers.Name%TYPE;
    v_due_date Loans.EndDate%TYPE;
BEGIN
    FOR rec IN (SELECT c.Name, l.EndDate
                FROM Customers c
                JOIN Loans l ON c.CustomerID = l.CustomerID
                WHERE l.EndDate BETWEEN SYSDATE AND SYSDATE + 30) LOOP
        v_customer_name := rec.Name;
        v_due_date := rec.EndDate;
        
        DBMS_OUTPUT.PUT_LINE('Reminder: Dear ' || v_customer_name || 
                             ', your loan is due on ' || TO_CHAR(v_due_date, 'YYYY-MM-DD') || '.');
    END LOOP;
END;
/

--select * from customers ;
--select * from accounts ;
--select * from employees ;
--select * from loans ;




