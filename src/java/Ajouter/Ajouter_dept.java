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
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Abd Elouahab
 */
@WebServlet("/Ajouter")
public class Ajouter_dept extends HttpServlet {
    
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        String url = "jdbc:mysql://localhost:3306/pfe_bdd"; 
        String user = "root"; 
        String password = "";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);

            String id_fac = request.getParameter("faculte");
            String[] nom_niv = request.getParameterValues("niv");
            String nom_dept = request.getParameter("nom");
            String email = request.getParameter("email");
            String telephone = request.getParameter("telephone");
            String add = request.getParameter("add");

            String query = "INSERT INTO dept(id_fac, nom_dept, email, telephone, add_dept) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, id_fac);
            pstmt.setString(2, nom_dept);
            pstmt.setString(3, email);
            pstmt.setString(4, telephone);
            pstmt.setString(5, add);
            pstmt.executeUpdate();
            
            
            String selectQuery = "SELECT id_dept FROM dept WHERE nom_dept=?";
            PreparedStatement selectStmt = conn.prepareStatement(selectQuery);
            selectStmt.setString(1, nom_dept);
            ResultSet rs = selectStmt.executeQuery();
            rs.next();
            int id_dept = rs.getInt("id_dept");

            for (String idn : nom_niv) {
                String insertNivQuery = "INSERT INTO niveau(id_dept, nom_niv) VALUES (?, ?)";
                PreparedStatement insertNivStmt = conn.prepareStatement(insertNivQuery);
                insertNivStmt.setInt(1, id_dept);
                insertNivStmt.setString(2, idn);
                insertNivStmt.executeUpdate();
            }

            

            String type, message;
            if (pstmt.getUpdateCount() > 0) {
                type = "success";
                message = "La departement est ajoutée avec succes ";
            } else {
                type = "error";
                message = "La departement n'est pas ajoutée avec succes";
            }

            response.sendRedirect("projet/Admin/table_dept.jsp?type=" + type + "&message=" + message);

            pstmt.close();
            selectStmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    }