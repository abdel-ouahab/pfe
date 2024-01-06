/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modifier;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Abd Elouahab
 */
public class Modifier_admin extends HttpServlet {
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
            String id_adm = request.getParameter("id_adm");
            String nom = request.getParameter("nom");
            String prenom = request.getParameter("prenom");
            String email = request.getParameter("email");
            

            

                PreparedStatement ps = conn.prepareStatement("UPDATE `admin` SET nom= ?,prenom=?,email=? WHERE id_adm= ?");
                ps.setString(1, nom);
                ps.setString(2, prenom);
                ps.setString(3, email);
                ps.setString(4, id_adm);
             
                ps.executeUpdate();

                ps.close();
            
            
            
            String type, message;
            if (ps != null) {
                type = "success";
                message = "L'administrateur est modifie avec succes ";
            } else {
                type = "error";
                message = "L'administrateur n'est pas modifie avec succes";
            }

            response.sendRedirect("projet/Admin_dept/admin.jsp?id_dept="+id_dept+"&type=" + type + "&message=" + message);
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.print(e);
        }
    }
}
