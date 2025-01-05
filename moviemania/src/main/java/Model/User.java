/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author acer
 */


import java.util.ArrayList;
import java.util.List;



/**
 *
 * @author acer
 */
public class User {
    protected  int userID;
    protected String username;
    protected String password;
    protected String fullname;
    private String description;
    private String pictureUrl;
    protected List<Review>review;
    private String role;

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public User(){};

    public void setDescription(String description) {
        this.description = description;
    }

    public void setPictureUrl(String pictureUrl) {
        this.pictureUrl = pictureUrl;
    }

    public String getDescription() {
        return description;
    }

    public String getPictureUrl() {
        return pictureUrl;
    }
    
    public User(int userID, String username, String password, String fullname, String description, String pictureUrl) {
        this.userID = userID;
        this.username = username;
        this.password = password;
        this.fullname = fullname;
        this.description = description;
        this.pictureUrl = pictureUrl;
    }
    public User( String username, String password) {
        
        this.username = username;
        this.password = password;
       }
        

    public String getUsername(){
        return username;
    }
    
    public void setID(int userID){
        this.userID=userID;
    }
    
    public void setFullname(String fullname){
        this.fullname=fullname;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }

    public String getFullname(){
        return fullname;
    }
    
    public String getPassword() {
        return password;
    }
    
    public List<Review> getReviews() {
        return review;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public void login(String username, String password) {
        System.out.println("User logged in with username: " + username);
    }

    
    public void signUp(String username, String password) {
        System.out.println("User signed up with username: " + username);
    }

    public List<Movie> searchMovies(String query) {
        System.out.println("Searching for movies with query: " + query);
        return new ArrayList<>();  // Mock implementation
    }

    public void reviewMovie(Movie movie, Review review) {
        
    }

    public List<Movie> getRecommendations() {
        System.out.println("Getting recommendations for user: " + username);
        return new ArrayList<>();  // Mock implementation
    }

    public void editProfile(String username, String password) {
        this.username = username;
        this.password = password;
        System.out.println("Profile updated.");
    }

    public void editReview(Movie movie, Review review) {
        
    }

    public int getUserID() {
        return userID;
    }
}
