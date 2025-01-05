/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

/**
 *
 * @author acer
 */
public class Review {
    private int reviewID;
    private int userID;
    private int movieID;
    private int rating;
    private String comment;
    private String username;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    private Date date;

    public Review(int reviewID, int userID, int movieID, int rating, String comment, Date date) {
        this.reviewID = reviewID;
        this.userID = userID;
        this.movieID = movieID;
        this.rating = rating;
        this.comment = comment;
        this.date = date;
    }

    public int getReviewID() {
        return reviewID;
    }

    public int getUserID() {
        return userID;
    }

    public int getMovieID() {
        return movieID;
    }

    public int getRating() {
        return rating;
    }

    public String getComment() {
        return comment;
    }

    public Date getDate() {
        return date;
    }
}

