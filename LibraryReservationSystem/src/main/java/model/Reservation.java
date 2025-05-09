package model;

import java.sql.Timestamp;

public class Reservation {
    private int id;         // reservation ID (primary key)
    private int bookId;     // to update stock
    private String title;
    private String author;
    private String category;
    private Timestamp reservedOn;
    
    private Timestamp returnDue;

    

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public Timestamp getReservedOn() { return reservedOn; }
    public void setReservedOn(Timestamp reservedOn) { this.reservedOn = reservedOn; }
    
    public Timestamp getReturnDue() {
        return returnDue;
    }

    public void setReturnDue(Timestamp returnDue) {
        this.returnDue = returnDue;
    }
}
