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
public class Modifier_dept_add extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Connection conn = null;
        PreparedStatement insertNivStmt =null;
        String url = "jdbc:mysql://localhost:3306/pfe_bdd"; 
        String user = "root"; 
        String pwd = "";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, pwd);
            
            String id_dept = request.getParameter("id_dept");
            String[] nom_niv = request.getParameterValues("niv");
            
            for (String idn : nom_niv) {
                String insertNivQuery = "INSERT INTO niveau(id_dept, nom_niv) VALUES (?, ?)";
                insertNivStmt = conn.prepareStatement(insertNivQuery);
                insertNivStmt.setString(1, id_dept);
                insertNivStmt.setString(2, idn);
                insertNivStmt.executeUpdate();
            }
                

                insertNivStmt.close();
            
            
            
            String type, message;
            if (insertNivStmt != null) {
                type = "success";
                message = "Le niveau est ajouté avec succes ";
            } else {
                type = "error";
                message = "Le niveau n'est pas ajouté avec succes";
            }

            response.sendRedirect("projet/Admin/modifier_dept.jsp?id_dept="+id_dept+"&type=" + type + "&message=" + message);
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.print(e);
        }
}
}
