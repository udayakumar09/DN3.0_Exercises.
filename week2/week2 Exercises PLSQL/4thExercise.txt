-- Scenario 1: Calculate the Age of Customers

CREATE OR REPLACE FUNCTION CalculateAge (
    p_dob DATE
) RETURN NUMBER IS
    v_age NUMBER;
BEGIN
    v_age := TRUNC(MONTHS_BETWEEN(SYSDATE, p_dob) / 12);
    RETURN v_age;
END CalculateAge;
/


-- Test CalculateAge
SELECT CalculateAge(TO_DATE('1985-05-15', 'YYYY-MM-DD')) AS Age FROM DUAL;

-- Scenario 2: Compute the Monthly Installment for a Loan

CREATE OR REPLACE FUNCTION CalculateMonthlyInstallment (
    p_loan_amount NUMBER,
    p_interest_rate NUMBER,
    p_duration_years NUMBER
) RETURN NUMBER IS
    v_monthly_rate NUMBER;
    v_total_months NUMBER;
    v_monthly_installment NUMBER;
BEGIN
    v_monthly_rate := p_interest_rate / 12 / 100;
    v_total_months := p_duration_years * 12;
    
    IF v_monthly_rate = 0 THEN
        v_monthly_installment := p_loan_amount / v_total_months;
    ELSE
        v_monthly_installment := p_loan_amount * v_monthly_rate / (1 - POWER(1 + v_monthly_rate, -v_total_months));
    END IF;

    RETURN v_monthly_installment;
END CalculateMonthlyInstallment;
/


-- Test CalculateMonthlyInstallment
SELECT CalculateMonthlyInstallment(10000, 5, 5) AS MonthlyInstallment FROM DUAL;


-- Scenario 3: Check if a Customer Has Sufficient Balance

CREATE OR REPLACE FUNCTION HasSufficientBalance (
    p_account_id NUMBER,
    p_amount NUMBER
) RETURN BOOLEAN IS
    v_balance Accounts.Balance%TYPE;
BEGIN
    SELECT Balance INTO v_balance
    FROM Accounts
    WHERE AccountID = p_account_id;

    IF v_balance >= p_amount THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
END HasSufficientBalance;
/



-- Test HasSufficientBalance
SELECT HasSufficientBalance(1, 500) AS SufficientBalance FROM DUAL;
