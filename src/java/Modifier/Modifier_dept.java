/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modifier;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Abd Elouahab
 */
public class Modifier_dept extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Connection conn = null;
        PreparedStatement insertStmt= null;
        String url = "jdbc:mysql://localhost:3306/pfe_bdd"; 
        String user = "root"; 
        String pwd = "";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, pwd);

            String id_dept = request.getParameter("id_dept");
            String nom = request.getParameter("nom");
            String telephone = request.getParameter("telephone");
            String email = request.getParameter("email");
            String add_dept = request.getParameter("add_dept");
            

            

                PreparedStatement ps = conn.prepareStatement("UPDATE `dept` SET nom_dept=?, Telephone=?, email=?, add_dept=? WHERE id_dept=?");
                ps.setString(1, nom);
                ps.setString(2, telephone);
                ps.setString(3, email);
                ps.setString(4, add_dept);
                ps.setString(5, id_dept);
             
                ps.executeUpdate();

                ps.close();
            
            
            
            String type, message;
            if (ps != null) {
                type = "success";
                message = "La departement est modifiée avec succes ";
            } else {
                type = "error";
                message = "La departement n'est pas modifiée avec succes";
            }

            response.sendRedirect("projet/Admin/table_dept.jsp?type=" + type + "&message=" + message);
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.print(e);
        }
    }
}
