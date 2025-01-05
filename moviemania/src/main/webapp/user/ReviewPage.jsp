<%-- 
    Document   : ReviewPageUser
    Created on : Dec 31, 2024, 12:03:48 AM
    Author     : acer
--%>

<%@page import="Model.Review"%>
<%@page import="java.util.List"%>
<%@page import="Model.User"%>
<%@page import="Model.Movie"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Film Review</title>
    

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Review Page</title>
    <style>
        body {
            background-color: #2d2c47;
            color: white;
            font-family: Arial, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            display: flex;
             background-image: url("${pageContext.request.contextPath}/image/bgAdd.jpeg");
            border-radius: 20px;
            padding: 20px;
            width: 95%;
            height:90%;
            
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }
        .left-side {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
            background-color: rgb(215, 209, 252);
            border-radius: 15px;
            max-height:80%;
            max-width: 350px;
        }
        .left-side img {
            width: 50%;
            max-width: 350px;
            border-radius: 15px;
            margin-bottom: 15px;
            padding:15px;
            max-height:100%;
           
            
        }
        .movie-title {
            font-size: 1.5rem;
            font-weight: bold;
            text-align: center;
            
        }
        .right-side {
            flex: 2;
            padding: 20px;
        }
        .review {
            display: flex;
            align-items: center;
            background-color: rgba(255, 255, 255, 0.15);
            border-radius: 15px;
            padding: 10px 15px;
            margin-bottom: 15px;
        }
        .review .user-icon {
            font-size: 1.5rem;
            margin-right: 10px;
        }
        .review-text {
            flex: 1;
        }
        .new-review {
            display: flex;
            align-items: center;
            background-color: rgba(255, 255, 255, 0.15);
            border-radius: 15px;
            padding: 10px 15px;
            box-shadow: 0px 3px 6px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }
        .new-review .user-icon {
            font-size: 1.5rem;
            margin-right: 10px;
        }
        .new-review input[type="text"], .new-review input[type="number"] {
            flex: 1;
            padding: 10px;
            background-color: transparent;
            border: none;
            color: white;
            outline: none;
            font-size: 1rem;
            margin-right: 10px;
           
        }
        .new-review .submit-button {
            background-color: #9575cd;
            border: none;
            border-radius: 50%;
            padding: 10px;
            cursor: pointer;
            font-size: 1.2rem;
            color: white;
            transition: background-color 0.3s ease;
        }
        .new-review .submit-button:hover {
            background-color: #7e57c2;
        }
        .new-review input[type="text"]::placeholder, 
        .new-review input[type="number"]::placeholder {
         color: rgba(255, 255, 255, 0.7); /* Lighten the placeholder text color */
}
    </style>
</head>
<%
    Movie movie = (Movie) request.getSession().getAttribute("SingleMovie");
    User user = (User) request.getSession().getAttribute("user");
    List<Review> reviews = (List<Review>) request.getSession().getAttribute("reviews");
    if (movie == null) {
        out.println("Movie not found.");
        return;
    }
    if (user == null) {
        out.println("Please log in to leave a review.");
        return;
    }
%>
<body>
    <div class="container">
        <!-- Left Side: Movie Poster and Title -->
        <div class="left-side">
           <img src="${pageContext.request.contextPath}/<%= movie.getPosterUrl() %>" style="width: 100%; border-radius: 10px;" />
            <div class="movie-title"><%= movie.getTitle() %></div>
        </div>

        <!-- Right Side: Reviews Section -->
        <div class="right-side">
            <h2>Reviews</h2>
            
            <!-- Existing Reviews -->
            <% if (reviews != null && !reviews.isEmpty()) { %>
                <% for (Review review : reviews) { %>
                
                    <div class="review">
                        <div class="user-icon">👤 <%= review.getUsername() %></div>
                        <div class="review-text"><%= review.getComment() %></div>
                    </div>
                <% } %>
            <% } else { %>
                <p>No reviews available for this movie.</p>
            <% } %>

            <!-- Form for Adding New Review -->
            <form action="/ReviewsController" method="post" class="new-review">
                <input type="hidden" name="action" value="addReview">
               <input type="hidden" name="movieID" value="<%= movie.getMovieID() %>">
               <input type="hidden" name="userID" value="<%= user.getUserID() %>">

                
                <div class="user-icon">👤 <%= user.getUsername() %></div>
                <input type="number" name="rating" min="0" max="10" step="0.1" placeholder="Rating (0-10)" required>
                <input type="text" name="comment" placeholder="Masukkan review..." required>
                <button type="submit" class="submit-button">➤</button>
            </form>
        </div>
    </div>
</body>
</html>
