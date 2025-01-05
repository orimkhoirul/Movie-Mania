<%-- 
    Document   : editUser
    Created on : Oct 31, 2024, 11:09:03 PM
    Author     : acer
--%>

<%@page import="Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Edit Profile</title>
    <link rel="stylesheet" href="style.css" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
    />
    <style>
      /* Reset */
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: Arial, sans-serif;
      }

      body {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        background: linear-gradient(135deg, #6a11cb, #2575fc);
      }

      .profile-container {
        width: 90%;
        max-width: 400px;
        background: rgba(255, 255, 255, 0.1);
        border-radius: 15px;
        padding: 20px;
        color: white;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        text-align: center;
      }

      .profile-container h2 {
        margin-bottom: 20px;
        font-size: 1.5rem;
        color: white;
      }

      .profile-form {
        display: flex;
        flex-direction: column;
        gap: 15px;
        width: 100%;
      }

      .form-group {
        background: rgba(255, 255, 255, 0.15);
        border-radius: 10px;
        padding: 10px 15px;
        text-align: left;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        margin: 10px;
      }

      .form-group label {
        display: block;
        font-size: 0.9rem;
        color: #f0f0f0;
        margin-bottom: 5px;
      }

      .form-group input {
        width: 100%;
        padding: 8px;
        border: none;
        border-radius: 8px;
        font-size: 1rem;
        background: rgba(255, 255, 255, 0.1);
        color: white;
        outline: none;
        transition: background 0.3s ease;
      }

      .form-group input:focus {
        background: rgba(255, 255, 255, 0.2);
      }

      .profile-image-container {
        margin: 15px 0;
      }

      .profile-image-container img {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        object-fit: cover;
        border: 2px solid white;
      }

      .edit-link {
        display: inline-block;
        margin-top: 10px;
        color: #fff;
        text-decoration: none;
        background: rgba(255, 255, 255, 0.15);
        padding: 5px 10px;
        border-radius: 5px;
        font-size: 0.9rem;
        transition: background 0.3s ease;
      }

      .edit-link:hover {
        background: rgba(255, 255, 255, 0.25);
      }

      .save-button {
        width: 100%;
        padding: 10px;
        font-size: 1rem;
        font-weight: bold;
        color: white;
        background-color: rgba(255, 255, 255, 0.15);
        border: none;
        border-radius: 8px;
        cursor: pointer;
        transition: background 0.3s ease;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
      }

      .save-button:hover {
        background-color: rgba(255, 255, 255, 0.25);
      }

      .alert {
        margin-top: 15px;
        padding: 15px;
        border-radius: 10px;
        text-align: center;
        font-size: 1rem;
        display: flex;
        align-items: center;
        gap: 10px;
        justify-content: center;
      }

      .alert.success {
        background-color: rgba(0, 255, 0, 0.2);
        color: chartreuse;
      }

      .alert.fail {
        background-color: rgba(255, 0, 0, 0.2);
        color: red;
      }

      .alert i {
        font-size: 1.2rem;
      }

      .back-button {
        margin-top: 15px;
        display: inline-block;
        background: rgba(255, 255, 255, 0.15);
        padding: 10px 15px;
        color: white;
        text-decoration: none;
        font-weight: bold;
        border-radius: 8px;
        transition: background 0.3s ease;
      }

      .back-button:hover {
        background: rgba(255, 255, 255, 0.25);
      }
    </style>
  </head>
  <body>
      <% 
          User user = (User) request.getSession().getAttribute("user"); 
          if (user == null) { 
              response.sendRedirect("login.jsp"); 
              return; 
          } 
      %>
    <div class="profile-container">
      <h2>Edit Profile</h2>
      
      <form action="/UsersController" method="post" enctype="multipart/form-data">
        <input type="hidden" name="action" value="editUserProfile" />
        
        <div class="profile-image-container">
          <img src="${pageContext.request.contextPath}/<%= user.getPictureUrl()!= null ? user.getPictureUrl(): "default-profile.png" %>" alt="Profile Picture" />
          
        </div>
          <a href="#" onclick="document.getElementById('profileImage').click();" class="edit-link">Change Picture</a>

        <div class="form-group">
          <label for="username">Username</label>
          <input type="text" id="username" name="username" value="<%=user.getUsername()%>" required />
        </div>

        <div class="form-group">
          <label for="full-name">Full Name</label>
          <input type="text" id="full-name" name="fullName" value="<%=user.getFullname()%>" required />
        </div>

        <div class="form-group" style="display:none;">
          <input
            type="file"
            id="profileImage"
            name="profilePicture"
            accept="image/*"
          />
        </div>

        <button type="submit" class="save-button">Save Changes</button>
      </form>

      <a href="<%= request.getContextPath() %>/MoviesController?action=displayListMovie" class="back-button">Back to Movies</a>

      <% 
        Boolean res = (Boolean) request.getSession().getAttribute("isEditSuccess");
        request.getSession().removeAttribute("isEditSuccess");
        if (res != null) {
      %>
          <% if (res) { %>
          <div class="alert success">
            <i class="fas fa-check-circle"></i>
            User Profile Berhasil di Ubah
          </div>
          <% } else { %>
          <div class="alert fail">
            <i class="fas fa-times-circle"></i>
            User Profile Gagal di Ubah
          </div>
          <% } %>
      <% } %>
    </div>
  </body>
</html>
