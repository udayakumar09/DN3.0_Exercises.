/******************************************************************************

Welcome to GDB Online.
GDB online is an online compiler and debugger tool for C, C++, Python, Java, PHP, Ruby, Perl,
C#, OCaml, VB, Swift, Pascal, Fortran, Haskell, Objective-C, Assembly, HTML, CSS, JS, SQLite, Prolog.
Code, Compile, Run and Debug online from anywhere in world.

*******************************************************************************/
// Define the Subject interface
interface Subject {
    void request();
}

// Implement the RealSubject class that implements Subject
class RealSubject implements Subject {
    @Override
    public void request() {
        System.out.println("RealSubject: Handling request.");
    }
}

// Implement the Proxy class that implements Subject
class Proxy implements Subject {
    private RealSubject realSubject;

    @Override
    public void request() {
        if (realSubject == null) {
            realSubject = new RealSubject();
        }
        System.out.println("Proxy: Delegating request to RealSubject.");
        realSubject.request();
    }
}

// Main class to test the Proxy Pattern
public class Main {
    public static void main(String[] args) {
        // Create a Proxy instance
        Subject proxy = new Proxy();

        // Use the Proxy to handle a request
        proxy.request();
    }
}