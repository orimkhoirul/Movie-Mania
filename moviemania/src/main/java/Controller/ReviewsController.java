/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Dao.MoviesDao;
import Dao.ReviewsDao;
import Dao.UsersDao;
import Model.Review;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author acer
 */
@WebServlet(name = "ReviewsController", urlPatterns = {"/ReviewsController"})
public class ReviewsController extends HttpServlet {
     private final ReviewsDao ReviewDao = new ReviewsDao();
     private final UsersDao UserDao = new UsersDao();
     private final MoviesDao MovieDao = new MoviesDao();
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
            
        String action=request.getParameter("action");
           
           if(action.equals("DisplayReview")){
               DisplayReview(request,response);
           }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
           String action=request.getParameter("action");
           
           if(action.equals("addReview")){
               AddReview(request,response);
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
    
    
    protected void AddReview(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String movieIDParam = request.getParameter("movieID");
        String UserIDParam = request.getParameter("userID");
        int movieID = Integer.parseInt(movieIDParam);
        int userID = Integer.parseInt(UserIDParam);
        float rating = Float.parseFloat(request.getParameter("rating"));
        String comment = request.getParameter("comment");
        List<Review>reviews=ReviewDao.getReviewsByMovieID(movieID);
        request.getSession().setAttribute("reviews", reviews);
        boolean reviewed=ReviewDao.addReview(movieID, userID, rating, comment);
        
         if(reviewed){
             
             MovieDao.updateMovieRating(movieID);
             response.sendRedirect("MoviesController?action=displayListMovie&msg=Berhasil review");
         }else{
             response.sendRedirect("MoviesController?action=displayListMovie&msg=Gagal review");
         }
        
        

        
       
       
    }
    
    protected void DisplayReview(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String movieIDParam = request.getParameter("movieID");
        int movieID = Integer.parseInt(movieIDParam);
        List<User>listUser= UserDao.getAllUsers();
        List<Review>reviews=ReviewDao.getReviewsByMovieID(movieID);
        
        for(Review r:reviews){
            
            for(User user:listUser){
                if(r.getUserID()==(user.getUserID())){
                    r.setUsername(user.getUsername());
                }
            }
        }
        
        request.getSession().setAttribute("reviews", reviews);
        response.sendRedirect("/user/ReviewPage.jsp");
       
    }

}
