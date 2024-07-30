class Logger {
    // Private static instance of the Logger class
    private static Logger instance;

    // Private constructor to prevent instantiation
    private Logger() {}

    // Public static method to get the instance of the Logger class
    public static Logger getInstance() {
        if (instance == null) {
            instance = new Logger();
        }
        return instance;
    }

    // Method to log messages
    public void log(String message) {
        System.out.println("Log: " + message);
    }
}

public class Main {
    public static void main(String[] args) {
        // Get the instance of Logger
        Logger logger1 = Logger.getInstance();
        Logger logger2 = Logger.getInstance();

        // Log messages
        logger1.log("First message");
        logger2.log("Second message");

        // Check if logger1 and logger2 are the same instance
        if (logger1 == logger2) {
            System.out.println("Logger is a singleton. Both logger1 and logger2 are the same instance.");
        } else {
            System.out.println("Logger is not a singleton. logger1 and logger2 are different instances.");
        }
    }
}