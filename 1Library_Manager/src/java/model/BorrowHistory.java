/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author SonLam29
 */
import java.util.Date;

public class BorrowHistory {
    private String bookTitle;
    private Date borrowDate;
    private Date returnDate;

    public BorrowHistory(String bookTitle, Date borrowDate, Date returnDate) {
        this.bookTitle = bookTitle;
        this.borrowDate = borrowDate;
        this.returnDate = returnDate;
    }

    public String getBookTitle() { return bookTitle; }
    public Date getBorrowDate() { return borrowDate; }
    public Date getReturnDate() { return returnDate; }
}

