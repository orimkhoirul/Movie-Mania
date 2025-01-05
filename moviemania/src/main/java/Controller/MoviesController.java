/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Movie;
import Model.Review;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author acer
 */
@WebServlet(name = "MoviesController", urlPatterns = {"/MoviesController"})
@MultipartConfig
public class MoviesController extends HttpServlet {

    //private final MoviesDao movieDao = new MoviesDao();
   // private final ReviewsDao ReviewDao = new ReviewsDao();
   // private final UsersDao userDao = new UsersDao();
    //private final String uploadDirectory = "C:/uploaded_images";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action.equals("displayListMovie")) {
            try {
                displayListMovie(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(MoviesController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (action.equals("RecommendedMovie")) {
            try {
                RecommendedMovie(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(MoviesController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (action.equals("SearchMovie")) {
            try {
                SearchMovie(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(MoviesController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (action.equals("displaySingleMovie")) {
            try {
                displaySingleMovie(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(MoviesController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (action.equals("displayEditMovie")) {
            try {
                displayEditMovie(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(MoviesController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String act = request.getParameter("action");

        if ("addMovie".equals(act)) {
            try {
                addMovie(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(MoviesController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if ("deleteMovie".equals(act)) {
            deleteMovie(request, response);
        } else if ("editMovie".equals(act)) {
            editMovie(request, response);
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    protected void displayListMovie(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        List<Movie> movies = movieDao.getAllMovies();
        request.getSession().setAttribute("movies", movies);
        response.sendRedirect("/user/ListMoviePage.jsp");

    }

   

    protected void SearchMovie(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String query = request.getParameter("title");

        List<Movie> SearchedMovies = movieDao.searchMoviesByTitle(query);

        // Only set the attribute if SearchedMovies is not null
        if (SearchedMovies == null) {
            response.sendRedirect("/MoviesController?action=displayListMovie");
        }else{
           request.getSession().setAttribute("movies", SearchedMovies);
           response.sendRedirect("/user/ListMoviePage.jsp");
        }

        
    }

    protected void addMovie(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String title = request.getParameter("judul");
        String description = request.getParameter("description");
        String rating = request.getParameter("rating");
        String genre = request.getParameter("genre");
        String dateString = request.getParameter("date");
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); // Match HTML date format
        Date releaseDate = null;
        try {
            releaseDate = formatter.parse(dateString);
        } catch (ParseException ex) {
            Logger.getLogger(MoviesController.class.getName()).log(Level.SEVERE, null, ex);
        }

        // Handle the uploaded poster image
        Part filePart = request.getPart("poster");
        String fileName = filePart.getSubmittedFileName();
        String filePath = uploadDirectory + File.separator + fileName;

        // Save the file to the server
        File fileSaveDir = new File(uploadDirectory);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdirs(); // Create the directory if it does not exist
        }
        filePart.write(filePath);

        // Relative path to store in the database
        String relativePath = "uploaded_images/" + fileName;

        boolean movieAdded = false;
        try {
            movieAdded = movieDao.addMovie(title, genre, releaseDate, description, rating, relativePath);
        } catch (SQLException ex) {
            Logger.getLogger(MoviesController.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (movieAdded) {

            response.sendRedirect("MoviesController?action=displayListMovie&msg=Berhasil Tambah"); // Refresh the movie list

        } else {

            response.sendRedirect("MoviesController?action=displayListMovie&msg=Gagal Tambah");
        }

    }

    

    protected void editMovie(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String genre = request.getParameter("genre");
        String description = request.getParameter("description");
        String dateString = request.getParameter("date");
        String movieIDParam = request.getParameter("movieID");

        int movieID = 0;
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); // Match HTML date format
        Date releaseDate = null;
        try {
            releaseDate = formatter.parse(dateString);
        } catch (ParseException ex) {
            Logger.getLogger(MoviesController.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (movieIDParam != null) {
            try {
                movieID = Integer.parseInt(movieIDParam);
            } catch (NumberFormatException e) {
                response.getWriter().println("Invalid movie ID format.");
                return;
            }
        } else {
            response.getWriter().println("No movie ID provided.");
            return;
        }

        // Handle the uploaded poster image
        Part filePart = request.getPart("poster");
        String relativePath;

        if (filePart.getSize() > 0) { // If a new file is uploaded
            String fileName = filePart.getSubmittedFileName();
            String filePath = uploadDirectory + File.separator + fileName;

            // Save the file to the server
            File fileSaveDir = new File(uploadDirectory);
            if (!fileSaveDir.exists()) {
                fileSaveDir.mkdirs(); // Create the directory if it does not exist
            }
            filePart.write(filePath);

            // Relative path to store in the database
            relativePath = "uploaded_images/" + fileName;
        } else {
            // Fetch the existing relativePath from the database
            relativePath = request.getParameter("poster_url");
        }

        boolean movieEdited = false;

        try {
            movieEdited = movieDao.updateMovie(movieID, title, genre, releaseDate, description, relativePath);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (movieEdited) {
            response.sendRedirect("MoviesController?action=displayListMovie&msg=Berhasil Edit");
        } else {
            response.sendRedirect("MoviesController?action=displayListMovie&msg=Gagal Edit");
        }
    }

    protected void displaySingleMovie(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String id = request.getParameter("movieID");
        Movie SingleMovie = movieDao.getMovieById(Integer.parseInt(id));
        List<Review> reviews = ReviewDao.getReviewsByMovieID(Integer.parseInt(id));
        SingleMovie.setReview(reviews);
        SingleMovie.setRating(SingleMovie.calculateRating());
        request.getSession().setAttribute("SingleMovie", SingleMovie);
        response.sendRedirect("/user/MoviePage.jsp");

    }

    protected void displayEditMovie(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String id = request.getParameter("movieID");
        Movie SingleMovie = movieDao.getMovieById(Integer.parseInt(id));
        request.getSession().setAttribute("SingleMovie", SingleMovie);
        response.sendRedirect("/admin/EditMovie.jsp");

    }

}
