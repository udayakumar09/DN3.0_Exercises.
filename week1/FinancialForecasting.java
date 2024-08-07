/******************************************************************************

Welcome to GDB Online.
GDB online is an online compiler and debugger tool for C, C++, Python, Java, PHP, Ruby, Perl,
C#, OCaml, VB, Swift, Pascal, Fortran, Haskell, Objective-C, Assembly, HTML, CSS, JS, SQLite, Prolog.
Code, Compile, Run and Debug online from anywhere in world.

*******************************************************************************/
public class FinancialForecasting {

    // Recursive method to calculate future value
    public static double calculateFutureValueRecursive(double presentValue, double rate, int periods) {
        // Base case: no periods left to apply growth
        if (periods == 0) {
            return presentValue;
        }
        // Recursive case: apply growth rate and decrease the number of periods
        return calculateFutureValueRecursive(presentValue * (1 + rate), rate, periods - 1);
    }

    // Iterative method to calculate future value
    public static double calculateFutureValueIterative(double presentValue, double rate, int periods) {
        double futureValue = presentValue;
        for (int i = 0; i < periods; i++) {
            futureValue *= (1 + rate);
        }
        return futureValue;
    }

    public static void main(String[] args) {
        double presentValue = 1000.0; // Example initial amount
        double rate = 0.05;           // Example annual growth rate (5%)
        int periods = 10;             // Example number of periods (years)

        // Calculate future value using the recursive approach
        double futureValueRecursive = calculateFutureValueRecursive(presentValue, rate, periods);
        System.out.printf("Future Value (Recursive): $%.2f\n", futureValueRecursive);

        // Calculate future value using the iterative approach
        double futureValueIterative = calculateFutureValueIterative(presentValue, rate, periods);
        System.out.printf("Future Value (Iterative): $%.2f\n", futureValueIterative);
    }
}