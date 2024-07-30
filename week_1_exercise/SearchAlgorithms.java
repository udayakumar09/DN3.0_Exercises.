/******************************************************************************

Welcome to GDB Online.
GDB online is an online compiler and debugger tool for C, C++, Python, Java, PHP, Ruby, Perl,
C#, OCaml, VB, Swift, Pascal, Fortran, Haskell, Objective-C, Assembly, HTML, CSS, JS, SQLite, Prolog.
Code, Compile, Run and Debug online from anywhere in world.

*******************************************************************************/
import java.util.Arrays;

// Define the Product class
class Product {
    private int productId;
    private String productName;
    private String category;

    public Product(int productId, String productName, String category) {
        this.productId = productId;
        this.productName = productName;
        this.category = category;
    }

    public int getProductId() {
        return productId;
    }

    public String getProductName() {
        return productName;
    }

    public String getCategory() {
        return category;
    }

    @Override
    public String toString() {
        return "ProductID: " + productId + ", Name: " + productName + ", Category: " + category;
    }
}

// Define search algorithms
public class SearchAlgorithms {

    // Linear Search
    public static Product linearSearch(Product[] products, int searchId) {
        for (Product product : products) {
            if (product.getProductId() == searchId) {
                return product;
            }
        }
        return null; // Not found
    }

    // Binary Search
    public static Product binarySearch(Product[] products, int searchId) {
        int left = 0;
        int right = products.length - 1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (products[mid].getProductId() == searchId) {
                return products[mid];
            } else if (products[mid].getProductId() < searchId) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return null; // Not found
    }

    // Utility method to sort products by ID (needed for binary search)
    public static void sortProducts(Product[] products) {
        Arrays.sort(products, (p1, p2) -> Integer.compare(p1.getProductId(), p2.getProductId()));
    }

    public static void main(String[] args) {
        Product[] products = {
            new Product(3, "Laptop", "Electronics"),
            new Product(1, "Smartphone", "Electronics"),
            new Product(2, "Tablet", "Electronics")
        };

        // Linear Search
        System.out.println("Linear Search:");
        Product foundProduct = linearSearch(products, 2);
        System.out.println(foundProduct != null ? foundProduct : "Product not found");

        // Binary Search requires sorted array
        sortProducts(products);
        System.out.println("\nBinary Search:");
        foundProduct = binarySearch(products, 2);
        System.out.println(foundProduct != null ? foundProduct : "Product not found");
    }
}