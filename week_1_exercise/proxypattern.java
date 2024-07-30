/******************************************************************************

Welcome to GDB Online.
GDB online is an online compiler and debugger tool for C, C++, Python, Java, PHP, Ruby, Perl,
C#, OCaml, VB, Swift, Pascal, Fortran, Haskell, Objective-C, Assembly, HTML, CSS, JS, SQLite, Prolog.
Code, Compile, Run and Debug online from anywhere in world.

*******************************************************************************/
// Define the Image interface
interface Image {
    void display();
}

// Implement the RealImage class that implements Image and loads an image from a remote server
class RealImage implements Image {
    private String filename;

    public RealImage(String filename) {
        this.filename = filename;
        loadImageFromDisk();
    }

    private void loadImageFromDisk() {
        System.out.println("Loading image from disk: " + filename);
    }

    @Override
    public void display() {
        System.out.println("Displaying image: " + filename);
    }
}

// Implement the ProxyImage class that implements Image and holds a reference to RealImage
class ProxyImage implements Image {
    private RealImage realImage;
    private String filename;

    public ProxyImage(String filename) {
        this.filename = filename;
    }

    @Override
    public void display() {
        if (realImage == null) {
            realImage = new RealImage(filename);
        }
        realImage.display();
    }
}

// Main class to test the Proxy Pattern
public class Main {
    public static void main(String[] args) {
        Image image1 = new ProxyImage("test_image1.jpg");
        Image image2 = new ProxyImage("test_image2.jpg");

        // Images will be loaded from disk and displayed
        image1.display();
        System.out.println();
        
        // Image will be displayed without loading from disk
        image1.display();
        System.out.println();
        
        // Images will be loaded from disk and displayed
        image2.display();
        System.out.println();
        
        // Image will be displayed without loading from disk
        image2.display();
    }
}