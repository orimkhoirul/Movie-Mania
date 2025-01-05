/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 *
 * @author acer
 */
public interface Sign {
    void Login(HttpServletRequest request, HttpServletResponse response)throws IOException ;
    void Register(HttpServletRequest request, HttpServletResponse response)throws IOException ;
    void Logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
}
