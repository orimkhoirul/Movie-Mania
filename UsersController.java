/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Dao.MoviesDao;
import Dao.UsersDao;
import Model.Sign;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;

/**
 *
 * @author acer
 */
@MultipartConfig
@WebServlet(name = "UsersController", urlPatterns = {"/UsersController"})
public class UsersController extends HttpServlet implements Sign{
    private UsersDao userDao;
    private MoviesDao movieDao;
    private final String uploadDirectory = "C:/uploaded_images";
    
    public UsersController(){
        userDao=new UsersDao();
        movieDao=new MoviesDao();
    }
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
            
     if(action.equals("Login")){
        Login(request,response);
    }else if(action.equals("Logout")){
        Logout(request,response);
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
            
            if(action.equals("Register")){
                Register(request,response);
            }else if(action.equals("editUserProfile")){
                editUserProfile(request,response);
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
    
    
   @Override
    public void Login(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        boolean validateUser=userDao.validateUser(username, password);
        boolean validateAdmin=userDao.validateAdmin(username, password);
        if (validateUser) {
            User user=userDao.selectUser(username, password);
            user.setRole("User");
            
            request.getSession().setAttribute("user", user);
            //response.getWriter().print(user.getUsername()+""+user.getUserID()+""+user.getPassword());
            response.sendRedirect("/MoviesController?action=displayListMovie"); // Redirect to dashboard if sign-in is successful
        }else if(validateAdmin){
            User user=userDao.selectAdmin(username, password);
            user.setRole("Admin");
            request.getSession().setAttribute("user", user);
            response.sendRedirect("/MoviesController?action=displayListMovie");
        } else {
            
            response.sendRedirect("/Login.jsp?msg=Invalid Username or Password");
        } 
    }
    
    @Override
    public void Logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // Invalidate the current session
    HttpSession session = request.getSession();
    if (session != null) {
        session.invalidate();
    }

    // Redirect to login page
    response.sendRedirect(request.getContextPath() + "/Login.jsp");

    }
    @Override
    public void Register(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Assume registerUser adds a new user to the database
         boolean success=userDao.insertUser(username, password);
        
        if (success) {
            
            response.sendRedirect("/UsersController?action=Login"); // Redirect after successful registration
        } else {
            response.getWriter().println("Sign up failed. Try again.");
            String notifGagal="username sudah dipakai!";
            request.getSession().setAttribute("notifGagal", notifGagal);
            response.sendRedirect("/views/SignUp.jsp");
        }
    }
    
    public void editUserProfile(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        String userName=request.getParameter("username");
        String fullName=request.getParameter("fullName");
        
            
        Part filePart = request.getPart("profilePicture");
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
        
        boolean res=userDao.editUser(((User)request.getSession().getAttribute("user")).getUserID(), userName, fullName, relativePath);
        if(res){
            request.getSession().setAttribute("isEditSuccess", res);
            User user=(User) request.getSession().getAttribute("user");
            user.setPictureUrl(relativePath);
            user.setUsername(userName);
            user.setFullname(fullName);
            request.getSession().setAttribute("user",user);
            response.sendRedirect("/editProfile.jsp");
        }else {
        request.getSession().setAttribute("isEditSuccess", false);
        response.sendRedirect("/editProfile.jsp");
    }
    }

}
