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
public class Modifier_dept_del extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Connection conn = null;
        PreparedStatement delNivStmt =null;
        PreparedStatement deleltNiv =null;
        String url = "jdbc:mysql://localhost:3306/pfe_bdd"; 
        String user = "root"; 
        String pwd = "";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, pwd);
            
            String id_dept = request.getParameter("id_dept");
            String nom_niv = request.getParameter("niv");
            
                String delNiv = "DELETE FROM `semestre` WHERE `id_niv` =?";
                deleltNiv = conn.prepareStatement(delNiv);
                deleltNiv.setString(1, nom_niv);
                deleltNiv.executeUpdate();
            
                String delNivQuery = "DELETE FROM `niveau` WHERE `id_niv` =?";
                delNivStmt = conn.prepareStatement(delNivQuery);
                delNivStmt.setString(1, nom_niv);
                delNivStmt.executeUpdate();
            
                

                delNivStmt.close();
            
            
            
            String type, message;
            if (delNivStmt != null) {
                type = "success";
                message = "Le niveau est Supprimer avec succes ";
            } else {
                type = "error";
                message = "Le niveau n'est pas Supprimer avec succes";
            }

            response.sendRedirect("projet/Admin/modifier_dept.jsp?id_dept="+id_dept+"&type=" + type + "&message=" + message);
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.print(e);
        }
}
}
