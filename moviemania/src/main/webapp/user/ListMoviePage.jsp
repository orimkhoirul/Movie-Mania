<%-- 
    Document   : MoviePageUser
    Created on : Dec 31, 2024, 12:02:52 AM
    Author     : acer
--%>

<%@page import="Dao.MoviesDao"%>
<%@page import="Model.User"%>
<%@page import="Model.Movie"%>
<%@page import="java.util.ArrayList"%>

<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Movie Page</title>

        <style>
            /* General styling */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: Arial, sans-serif;
            }

            body {
                background:#2d2c47;
                color: white;
                display: flex;
                flex-direction: column;
                align-items: center;
                min-height: 100vh;
            }

            header {
                width: 100%;
                background-color: #3b2c8d;
                padding: 10px 0;
            }

            nav {
                display: flex;
                justify-content: space-between;
                align-items: center;
                width: 90%;
                max-width: 1200px;
                margin: 0 auto;
                color: white;
            }

            .nav-left  a{
                margin-right: 15px;
                margin-top: 15px;
                text-decoration: none;
                color: white;
                font-weight: bold;

            }

            .nav-right {
                display: flex;
                align-items: center;
            }

            .nav-right input {
                background: none;
                border: none;
                outline: none;
                color: white;
                border-bottom: 1px solid white;
                padding: 5px;
                margin-right: 10px;
            }

            .search-btn {
                background: none;
                border: none;
                color: white;
                font-size: 1.2rem;
                cursor: pointer;
            }

            main {
                width: 90%;
                max-width: 1200px;
                margin: 20px auto;
            }

            .movie-section {
                margin-top: 20px;
            }

            .movie-section h2 {
                font-size: 1.5em;
                margin-bottom: 10px;
            }

            .movie-grid {
                display: grid;
                grid-template-columns: repeat(5, 1fr);
                gap: 15px;
                margin: 20px;
            }

            .movie-card {
                border-radius: 10px;
                text-align: center;
                padding: 10px;
                transition: transform 0.3s;
                background-color: #3b2c8d;
            }

            .movie-card:hover {
                transform: scale(1.05);
            }

            .movie-thumbnail {
                background-color: rgba(255, 255, 255, 0.2);
                height: 200px;
                border-radius: 10px;
                margin-bottom: 10px;
            }

            .movie-title {
                font-size: 0.9em;
            }

            a{
                text-decoration: none;
                color:white;
            }

            .add-movie-btn {
                background-color: #4caf50;
                border: none;
                color: white;
                font-size: 1.5rem;
                padding: 10px 15px;
                border-radius: 10%;
                cursor: pointer;
                display: inline-block;
                text-align: center;
                transition: background-color 0.3s;
            }
            
            .edit-btn {
                background-color: blue;
                border: none;
                color: white;
                
                padding: 5px 5px;
                border-radius: 10%;
                cursor: pointer;
                display: inline-block;
                text-align: center;
                transition: background-color 0.3s;
            }
            
            .delete-btn {
                background-color: red;
                border: none;
                color: white;
                
                padding: 5px 5px;
                border-radius: 10%;
                cursor: pointer;
                display: inline-block;
                text-align: center;
                transition: background-color 0.3s;
            }

            .add-movie-btn:hover {
                background-color: #45a049;
            }

        </style>

    </head>
    <%
        List<Movie> displayMovies = (List<Movie>) request.getSession().getAttribute("movies");
        User user = (User) request.getSession().getAttribute("user");
    %>

    <body>
        <header>
            <nav>
                <div class="nav-left">
                    <p>Hi <%= user.getUsername()%> 👋 Mau nonton apa hari ini! </p>
                    <a href="/MoviesController?action=displayListMovie">Home</a>
                    <a href="/MoviesController?action=RecommendedMovie">Recommend Movies</a>
                    
                    <a href="\">Back</a>
                       </div>
                       <div class="nav-right">
                        <form action="/MoviesController" method="get">
                            <input type="hidden" name="action" value="SearchMovie">
                            <input type="text" name="title" placeholder="Search...">
                            <button type="submit" class="search-btn">🔍</button>
                        </form>
                </div>
            </nav>
        </header>
        <% String msg = request.getParameter("msg");
            if (msg != null && !msg.isEmpty()) {
                out.print(msg);
            }


        %>
         
        <main>
            <% if ("Admin".equals(user.getRole())) { %>
            <a href="/admin/AddMovie.jsp" class="add-movie-btn">Add Movie</a>
            <% } %>
            <section class="movie-section">
                <div class="movie-grid">
                    <% if (!displayMovies.isEmpty()) { %>
                    <% for (Movie movie : displayMovies) {%>
                    <a href="/MoviesController?action=displaySingleMovie&movieID=<%= movie.getMovieID()%>" class="movie-card-link">
                        <div class="movie-card">
                            <div class="movie-thumbnail">
                                <img src="${pageContext.request.contextPath}/<%= movie.getPosterUrl()%>" style="height: 100%; width: 100%; border-radius: 10px;" />
                            </div>
                            <p class="movie-title"><%= movie.getTitle()%></p>
                            <p class="movie-title"><%= movie.getGenre()%></p>
                            <p class="movie-title"><%= movie.getReleaseDate()%></p>
                            <% if (user.getRole().equals("Admin")) {%>
                            <div>
                                <form action="/MoviesController" method="get" style="display: inline-block;">
                                    <input type="hidden" name="action" value="displayEditMovie">
                                    <input type="hidden" name="movieID" value="<%= movie.getMovieID()%>">
                                    <button type="submit" class="edit-btn">Edit</button>
                                </form>
                                <form action="/MoviesController" method="post" style="display: inline-block;">
                                    <input type="hidden" name="action" value="deleteMovie">
                                    <input type="hidden" name="movieID" value="<%= movie.getMovieID()%>">
                                    <button type="submit" class="delete-btn">Delete</button>
                                </form>
                            </div>
                            <% } %>
                        </div>
                    </a>
                    <% } %>
                    <% } else { %>
                    <p>No movies available to display.</p>
                    <% }%>
                </div>
            </section>
        </main>
    </body>
</html>
