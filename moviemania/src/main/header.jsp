<%-- 
    Document   : userHeader
    Created on : 19 Nov 2024, 13.51.48
    Author     : Sutan Rifky T
--%>

<%@page import="Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    .nav {
        display: flex;
        justify-content: space-between;
        align-items: center;
        width: 90%;
        max-width: 1200px;
        margin: 0 auto;
        color: white;
    }

    .nav-left a {
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

    .nav2 {
        display: flex;
        align-items: center;
        gap: 15px;
        
        padding: 15px 25px;
        border-radius: 5px;
       
        margin-left: auto;
    }

    #userProfile {
        color: white;
        font-weight: bold;
        text-decoration: none;
    }

    .navImg {
        outline: 2px solid black;
        width: 50px;
        height: 50px;
        border-radius: 50%;
        
    }
</style>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Header</title>
    </head>
    <body>
        <% User user = (User) request.getSession().getAttribute("user"); %>
        <div class="nav">
            <div class="nav-left">
                <p>Hi <%= user.getUsername()%> 👋 Mau nonton apa hari ini! </p>
                <a href="<%= request.getContextPath()%>/MoviesController?action=displayListMovie">Home</a>
                <a href="<%= request.getContextPath()%>/MoviesController?action=RecommendedMovie">Recommend Movies</a>
                <a href="<%= request.getContextPath()%>/UsersController?action=Logout">Logout</a>
            </div>
            <div class="nav-right">
                <form action="<%= request.getContextPath()%>/MoviesController" method="get">
                    <input type="hidden" name="action" value="SearchMovie">
                    <input type="text" name="title" placeholder="Search...">
                    <button type="submit" class="search-btn">🔍</button>
                </form>
            </div>
            <div class="nav2">
                <a id="userProfile" href="<%= request.getContextPath()%>/editProfile.jsp">Edit Profile</a>
                <% if (user != null && user.getPictureUrl() != null && !user.getPictureUrl().isEmpty()) { %>
                <img class="navImg" src="<%= request.getContextPath() + "/" + user.getPictureUrl()%>" />
                <% } else { %>
                <img class="navImg" src="<%= request.getContextPath()%>/uploaded_images/default.jpg" />
                <% } %>
            </div>
        </div>
    </body>
</html>
