package com.library;

import com.library.service.BookService;
import com.library.repository.BookRepository; // Import the BookRepository class
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class MainApp {

    public static void main(String[] args) {
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

        BookService bookService = context.getBean(BookService.class);

        // Optionally use setter injection (this is just for demonstration)
        BookRepository anotherRepository = new BookRepository(); // Create a new instance
        bookService.setBookRepository(anotherRepository); // Use setter injection

        bookService.performService();
    }
}
