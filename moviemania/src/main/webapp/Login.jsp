<%-- 
    Document   : Login
    Created on : Dec 31, 2024, 12:00:03 AM
    Author     : acer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link
    href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
    rel="stylesheet"
  />
  <style>
    body {
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;    
       background-image: url("${pageContext.request.contextPath}/image/bgAdd.jpeg");
      margin: 0;
      font-family: "Poppins", sans-serif;
    }
    .signup-container {
      border-radius: 30px;
      padding: 40px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      text-align: center;
      width: 400px;
      height: 400px;
      background: white;
    }

    .signup-container h2 {
      color: black;
      margin-bottom: 20px;
      font-weight: 700;
      font-style: normal;
    }

    .input-group-text {
      border: none;
      color: #fff;
    }

    .form-control {
      border: none;
      color: #fff;
    }

    .form-control::placeholder {
      color: #ddd;
    }

    .signup-container .btn {
      padding: 0.6rem 1.5rem;
      font-size: 1rem;
      background-color: rgb(138, 74, 222);
      background-image: linear-gradient(
        90deg,
        rgba(145, 129, 244, 1),
        rgba(80, 56, 237, 1)
      );
      color: white;
      border-radius: 20px;
      box-shadow: #4c3a74;
      font-weight: 700;
      font-style: normal;
      border: none;
      transition: background-color 0.3s ease, background-image 0.3s ease;
    }

    .signup-container .btn:hover {
      background: linear-gradient(135deg, #2575fc 0%, #6a11cb 100%);
    }

    .signin-link {
      color: rgba(241, 157, 255, 1);
      display: inline;
      margin-top: 20px;
      text-decoration: none;
    }

    .signin-link:hover {
      text-decoration: underline;
    }

    .divider {
      display: flex;
      align-items: center;
      text-align: center;
      margin: 20px 0;
    }

    .divider::before,
    .divider::after {
      content: "";
      flex: 1;
      border-bottom: 1px solid white;
    }

    .divider::before {
      margin-right: 10px;
    }

    .divider::after {
      margin-left: 10px;
    }

    .divider-text {
      font-weight: bold;
      color: #000;
    }
  </style>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Sign In</title>
    <!-- Bootstrap 5 CDN -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="styles.css" />
  </head>
  <body>



    <div class="signup-container">
      <h2>Login</h2>
     
     


      <form action="/UsersController" method="get">
       <input type="hidden" name="action" value="Login">
      <div class="input-group mb-3">
        <span class="input-group-text" id="username-icon"
          ><svg
            width="24"
            height="24"
            viewBox="0 0 24 24"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              d="M20 22H18V20C18 18.3431 16.6569 17 15 17H9C7.34315 17 6 18.3431 6 20V22H4V20C4 17.2386 6.23858 15 9 15H15C17.7614 15 20 17.2386 20 20V22ZM12 13C8.68629 13 6 10.3137 6 7C6 3.68629 8.68629 1 12 1C15.3137 1 18 3.68629 18 7C18 10.3137 15.3137 13 12 13ZM12 11C14.2091 11 16 9.20914 16 7C16 4.79086 14.2091 3 12 3C9.79086 3 8 4.79086 8 7C8 9.20914 9.79086 11 12 11Z"
              fill="#1C1C1C"
            />
          </svg>
        </span>
        <input
          type="text"
          class="form-control"
          placeholder="Username"
          aria-label="Username"
          aria-describedby="username-icon"
          name="username"
        />
      </div>
      <div class="input-group mb-3">
        <span class="input-group-text" id="password-icon"
          ><svg
            width="24"
            height="24"
            viewBox="0 0 24 24"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              d="M6 8V7C6 3.68629 8.68629 1 12 1C15.3137 1 18 3.68629 18 7V8H20C20.5523 8 21 8.44772 21 9V21C21 21.5523 20.5523 22 20 22H4C3.44772 22 3 21.5523 3 21V9C3 8.44772 3.44772 8 4 8H6ZM19 10H5V20H19V10ZM11 15.7324C10.4022 15.3866 10 14.7403 10 14C10 12.8954 10.8954 12 12 12C13.1046 12 14 12.8954 14 14C14 14.7403 13.5978 15.3866 13 15.7324V18H11V15.7324ZM8 8H16V7C16 4.79086 14.2091 3 12 3C9.79086 3 8 4.79086 8 7V8Z"
              fill="#1C1C1C"
            />
          </svg>
        </span>
        <input
          type="password"
          class="form-control"
          placeholder="Password"
          aria-label="Password"
          aria-describedby="password-icon"
          name="password"
        />
      </div>
      <button type="submit" class="btn btn-primary">Sign In</button>
        </form>
      <div class="divider">
        <span class="divider-text">Or</span>
      </div>
     
      <div>
        Don't have an account?
        <a href="/Register.jsp" class="signin-link"> Register now</a>
        
      </div>
    </div>
      
      
    
    <!-- Bootstrap JS (optional) -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
  </body>
</html>
