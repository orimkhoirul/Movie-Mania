package Dao;
import Model.Review;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
public class ReviewsDao {
    private final String url = "jdbc:mysql://localhost:3306/mydb";
    private final String dbUser = "root";
    private final String dbPassword = "ori2305";
    public boolean addReview(int movieID, int userID, float rating, String comment) {
        String query = "INSERT INTO reviews (Movies_movieID, Users_UserID, rating, comment, date) VALUES (?, ?, ?, ?, NOW())";

        try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, movieID);
            stmt.setInt(2, userID);
            stmt.setFloat(3, rating);
            stmt.setString(4, comment);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public List<Review> getReviewsByMovieID(int movieID) {
        List<Review> reviews = new ArrayList<>();
        String query = "SELECT * FROM reviews WHERE Movies_movieID = ? ORDER BY date DESC";

        try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, movieID);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Review review = new Review(
                    rs.getInt("ReviewID"),
                    rs.getInt("Users_UserID"),
                    rs.getInt("Movies_movieID"),
                   (int) rs.getFloat("rating"),
                    rs.getString("comment"),
                    rs.getDate("date")
                );
                reviews.add(review);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reviews;
    }
}
