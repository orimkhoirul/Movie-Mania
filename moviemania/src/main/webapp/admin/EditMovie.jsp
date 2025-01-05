<%-- 
    Document   : EditMovie
    Created on : Jan 5, 2025, 11:04:43 PM
    Author     : acer
--%>

<%@page import="Model.Movie"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Edit Movie Data</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet" />
    <style>
        body {
            width: 100%;
            height: 100vh;
            font-family: "Poppins";
            background-image: url("${pageContext.request.contextPath}/image/bgAdd.jpeg");
            background-size: cover;
        }
        .container {
            display: grid;
            padding: 30px;
            width: 100%;
            max-width: 1200px;
            height: auto;
            grid-template-areas: "movie review";
            grid-template-columns: 5fr 10fr;
            background-color: rgba(240, 237, 255, 0.8);
            border-radius: 20px;
            gap: 20px;
            color: #333;
        }
        .movie-title img {
            width: 100%;
            border-radius: 10px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-control {
            background-color: transparent;
            border: 1px solid #ccc;
            color: #333;
        }
        .save-btn {
            margin-top: 20px;
            padding: 10px 20px;
            border: none;
            background-color: #4caf50;
            color: white;
            border-radius: 5px;
        }
        .save-btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <%-- Retrieve the Movie object from the session --%>
    <%
        Movie movie = (Movie) request.getSession().getAttribute("SingleMovie");
        if (movie == null) {
            response.sendRedirect("error.jsp"); // Redirect to error page if movie is null
            return;
        }
    %>

    <div class="container">
        <div class="movie-title">
            <img src="${pageContext.request.contextPath}/<%= movie.getPosterUrl() %>" alt="Movie Poster" />
        </div>

        <form action="${pageContext.request.contextPath}/MoviesController" method="post" enctype="multipart/form-data">
            <!-- Hidden inputs -->
            <input type="hidden" name="action" value="editMovie">
            <input type="hidden" name="movieID" value="<%= movie.getMovieID() %>">
            <input type="hidden" name="poster_url" value="<%= movie.getPosterUrl() %>">

            <!-- Title -->
            <div class="form-group">
                <label for="title">Title:</label>
                <input type="text" id="title" name="title" class="form-control" value="<%= movie.getTitle() %>" required>
            </div>

            <!-- Genre -->
            <div class="form-group">
                <label for="genre">Genre:</label>
                <input type="text" id="genre" name="genre" class="form-control" value="<%= movie.getGenre() %>" required>
            </div>

            <!-- Release Date -->
            <div class="form-group">
                <label for="date">Release Date:</label>
                <input type="date" id="date" name="date" class="form-control" value="<%= movie.getReleaseDate() %>" required>
            </div>

            <!-- Description -->
            <div class="form-group">
                <label for="description">Description:</label>
                <textarea id="description" name="description" class="form-control" rows="4" required><%= movie.getDescription() %></textarea>
            </div>

            <!-- Poster Upload -->
            <div class="form-group">
                <label for="poster">Upload New Poster:</label>
                <input type="file" id="poster" name="poster" class="form-control" accept="image/*">
            </div>

            <!-- Submit Button -->
            <button type="submit" class="save-btn">Save Changes</button>
        </form>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>
