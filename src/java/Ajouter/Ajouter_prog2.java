/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ajouter;

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
public class Ajouter_prog2 extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out =response.getWriter();
        Connection conn = null;
        PreparedStatement ps = null;
        
        
        String id_dept = request.getParameter("id_dept");
        String id_etud = request.getParameter("etud");
        String[] id_sec = request.getParameterValues("sec");
        String[] id_mod = request.getParameterValues("mod");

        String url = "jdbc:mysql://localhost:3306/pfe_bdd"; 
        String user = "root"; 
        String pwd = "";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, pwd);
            for (String ids : id_sec) {
                for (String idm : id_mod) {
                    String query = "INSERT INTO programmation2(id_etud, id_sec, id_mod, id_dept) VALUES (?, ?, ?, ?)";
                        ps = conn.prepareStatement(query);
                        ps.setString(1, id_etud);
                        ps.setString(2, ids);
                        ps.setString(3, idm);
                        ps.setString(4, id_dept);
                        ps.executeUpdate();
                    
                }
            }
            String type, message;
            if (ps != null) {
                type = "success";
                message = "L'affectation est effectué avec succes ";
            } else {
                type = "error";
                message = "L'affectation n'est pas effectué avec succes ";
                
            }

            response.sendRedirect("projet/Admin_dept/affectation_etudiant.jsp?type=" + type + "&message=" + message);

        } catch (Exception e) {
            e.printStackTrace();
            out.print(e);
        }
    }
}
