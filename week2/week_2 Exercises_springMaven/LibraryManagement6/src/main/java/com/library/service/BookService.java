package com.library.service;

import com.library.repository.BookRepository; // Ensure this import is present
import org.springframework.stereotype.Service;

@Service
public class BookService {

    private final BookRepository bookRepository;

    // Constructor-based dependency injection
    public BookService(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    public void performService() {
        System.out.println("Service is being performed...");
        bookRepository.doSomething();
    }
}
