/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;
import java.util.List;

/**
 *
 * @author acer
 */
public class Movie {
    private int movieID;
    private String title;
    private String genre;
    private Date releaseDate;
    private String description;
    private float rating;
    private String posterUrl;
    private List<Review> reviews;  // Composition relationship with Review

    public Movie(){};
        
    
    
    public Movie(int movieID, String title, String genre, Date releaseDate, String description, String posterUrl) {
        this.movieID = movieID;
        this.title = title;
        this.genre = genre;
        this.releaseDate = releaseDate;
        this.description = description;
        this.posterUrl = posterUrl;
        
    }

    public int getMovieID() {
        return movieID;
    }

    public String getTitle() {
        return title;
    }

    public String getGenre() {
        return genre;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public String getDescription() {
        return description;
    }

    public float getRating() {
        return calculateRating();
    }

    public String getPosterUrl() {
        return posterUrl;
    }

    public List<Review> getReviews() {
        return reviews;
    }

    public void setReview(List<Review> review) {
        reviews=review;
        
    }
    
    public void setMovieID(int id) {
        this.movieID=id;
        
    }
    
    
    
    public void setGenre(String genre) {
        this.genre=genre;
        
    }
    
    
    public void setReleaseDate(Date date) {
        this.releaseDate=date;
    }
    
    public void setDescription(String desc) {
        this.description=desc;
        
    }
    
    public void setRating(double rating) {
        this.rating=(float) rating;
        
    }
    
    public void setTitle(String title) {
        this.title=title;
        
    }
    
    public void setPosterUrl(String poster) {
        this.posterUrl=poster;
        
    }

    public float calculateRating() {
        if (reviews.isEmpty()) return 0;
        int totalRating = 0;
        for (Review review : reviews) {
            totalRating += review.getRating();
        }
        return (float) totalRating / reviews.size();
    }
}

