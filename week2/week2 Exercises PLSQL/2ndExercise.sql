-- Scenario 1: Handle Exceptions During Fund Transfers Between Accounts

CREATE OR REPLACE PROCEDURE SafeTransferFunds (
    p_from_account_id IN NUMBER,
    p_to_account_id IN NUMBER,
    p_amount IN NUMBER
) IS
    v_from_balance Accounts.Balance%TYPE;
    v_to_balance Accounts.Balance%TYPE;
    insufficient_funds EXCEPTION;
BEGIN
    -- Fetch the balance of the source account
    SELECT Balance INTO v_from_balance 
    FROM Accounts 
    WHERE AccountID = p_from_account_id;
    
    -- Check if the source account has sufficient funds
    IF v_from_balance < p_amount THEN
        RAISE insufficient_funds;
    END IF;

    -- Transfer funds
    UPDATE Accounts
    SET Balance = Balance - p_amount
    WHERE AccountID = p_from_account_id;

    UPDATE Accounts
    SET Balance = Balance + p_amount
    WHERE AccountID = p_to_account_id;

    COMMIT;

EXCEPTION
    WHEN insufficient_funds THEN
        DBMS_OUTPUT.PUT_LINE('Error: Insufficient funds in the source account.');
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: An unexpected error occurred during the fund transfer.');
        ROLLBACK;
END SafeTransferFunds;
/

-- Test SafeTransferFunds
EXEC SafeTransferFunds(1, 2, 100);

-- Scenario 2: Manage Errors When Updating Employee Salaries

CREATE OR REPLACE PROCEDURE UpdateSalary (
    p_employee_id IN NUMBER,
    p_percentage IN NUMBER
) IS
    v_current_salary Employees.Salary%TYPE;
    employee_not_found EXCEPTION;
BEGIN
    -- Fetch the current salary of the employee
    SELECT Salary INTO v_current_salary 
    FROM Employees 
    WHERE EmployeeID = p_employee_id;

    -- Update the salary
    UPDATE Employees
    SET Salary = Salary + (Salary * p_percentage / 100)
    WHERE EmployeeID = p_employee_id;

    COMMIT;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Employee ID ' || p_employee_id || ' not found.');
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: An unexpected error occurred during the salary update.');
        ROLLBACK;
END UpdateSalary;
/

-- Test UpdateSalary
EXEC UpdateSalary(1, 10);


-- Scenario 3: Ensure Data Integrity When Adding a New Customer

CREATE OR REPLACE PROCEDURE AddNewCustomer (
    p_customer_id IN NUMBER,
    p_name IN VARCHAR2,
    p_dob IN DATE,
    p_balance IN NUMBER
) IS
    customer_already_exists EXCEPTION;
BEGIN
    -- Insert the new customer
    INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
    VALUES (p_customer_id, p_name, p_dob, p_balance, SYSDATE);

    COMMIT;

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Error: Customer with ID ' || p_customer_id || ' already exists.');
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: An unexpected error occurred during the insertion.');
        ROLLBACK;
END AddNewCustomer;
/


-- Test AddNewCustomer
EXEC AddNewCustomer(3, 'Tom Harris', TO_DATE('1975-12-30', 'YYYY-MM-DD'), 2000);
