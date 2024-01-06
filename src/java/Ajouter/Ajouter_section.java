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
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Abd Elouahab
 */
public class Ajouter_section extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        String url = "jdbc:mysql://localhost:3306/pfe_bdd"; 
        String user = "root"; 
        String pwd = "";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, pwd);
            
            String[] id_spec = request.getParameterValues("spec");
            String nom_sec = request.getParameter("sec");
            String id_niv = request.getParameter("id_niv");
            String id_dept = request.getParameter("id_dept");

            for (String idn : id_spec) {
                pstmt = conn.prepareStatement("INSERT INTO section(id_spec,id_niv, sec,id_dept) VALUES (?, ?, ?, ?)");
                pstmt.setString(1, idn);
                pstmt.setString(2, id_niv);
                pstmt.setString(3, nom_sec);
                pstmt.setString(4, id_dept);
                pstmt.executeUpdate();
            }
            
            String type, message;
            if (pstmt != null) {
                type = "success";
                message = "La section est ajoutée avec succes ";
            } else {
                type = "error";
                message = "La section n'est pas ajoutée avec succes";
            }

            response.sendRedirect("projet/Admin_dept/section.jsp?type=" + type + "&message=" + message);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
