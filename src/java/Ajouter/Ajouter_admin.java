/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ajouter;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Abd Elouahab
 */
public class Ajouter_admin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
            String prenom = request.getParameter("prenom");
            String email = request.getParameter("email");
            String pass = request.getParameter("password");
            String passwordc = request.getParameter("passwordc");

            if (pass.equals(passwordc)) {
                MessageDigest md = MessageDigest.getInstance("SHA-1");
                md.update(pass.getBytes());
                byte[] bytes = md.digest();
                StringBuilder sb = new StringBuilder();
                for (byte aByte : bytes) {
                    sb.append(Integer.toString((aByte & 0xff) + 0x100, 16).substring(1));
                }
                String password = sb.toString();

                PreparedStatement ps = conn.prepareStatement("SELECT * FROM `admin` WHERE nom=? AND prenom=? AND email=? AND password=?");
                ps.setString(1, nom);
                ps.setString(2, prenom);
                ps.setString(3, email);
                ps.setString(4, password);
                ResultSet rs = ps.executeQuery();

                if (!rs.next()) {
                    insertStmt = conn.prepareStatement("INSERT INTO `admin` (id_dept, nom, prenom, email, password) VALUES (?, ?, ?, ?, ?)");
                    insertStmt.setString(1, id_dept);
                    insertStmt.setString(2, nom);
                    insertStmt.setString(3, prenom);
                    insertStmt.setString(4, email);
                    insertStmt.setString(5, password);
                    insertStmt.executeUpdate();
                }
                rs.close();
                ps.close();
            }
            
            
            String type, message;
            if (insertStmt != null) {
                type = "success";
                message = "La departement est ajoutée avec succes ";
            } else {
                type = "error";
                message = "La departement n'est pas ajoutée avec succes";
            }

            response.sendRedirect("projet/Admin_dept/admin.jsp?type=" + type + "&message=" + message);
            conn.close();
        } catch (ClassNotFoundException | SQLException | NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
    }

}
