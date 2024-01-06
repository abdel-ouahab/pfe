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
public class Ajouter_enseignant extends HttpServlet {
protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id_dept = request.getParameter("id_dept");
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String email = request.getParameter("prenom").charAt(0) + "." + nom + "@univ-chlef.dz";
        String pass = request.getParameter("prenom").charAt(0) + "" + request.getParameter("prenom").charAt(1)
                + request.getParameter("nom");
        String password = null;
        try {
            password = sha1(pass);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(Ajouter_enseignant.class.getName()).log(Level.SEVERE, null, ex);
        }

        String url = "jdbc:mysql://localhost:3306/pfe_bdd"; 
        String user = "root"; 
        String pwd = "";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, pwd);

            String query = "SELECT * FROM enseignant WHERE nom=? AND prenom=? AND email=? AND password=?";
            ps = conn.prepareStatement(query);
            ps.setString(1, nom);
            ps.setString(2, prenom);
            ps.setString(3, email);
            ps.setString(4, password);
            rs = ps.executeQuery();

            if (!rs.next()) {
                String insertQuery = "INSERT INTO enseignant(id_dept, nom, prenom, email, password) VALUES (?, ?, ?, ?, ?)";
                ps = conn.prepareStatement(insertQuery);
                ps.setString(1, id_dept);
                ps.setString(2, nom);
                ps.setString(3, prenom);
                ps.setString(4, email);
                ps.setString(5, password);
                ps.executeUpdate();
            }

            // Set appropriate success or error messages
            String type, message;
            if (ps != null) {
                type = "success";
                message = "L'enseignant est ajouté avec succes";
            } else {
                type = "error";
                message = "L'enseignant n'est pas ajouté avec succes";
            }
            response.sendRedirect("projet/Admin_dept/enseignant.jsp?type=" + type + "&message=" + message);
        } catch (Exception e) {
            e.printStackTrace();
        } 
        
    }

    private String sha1(String input) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("SHA-1");
        md.update(input.getBytes());
        byte[] digest = md.digest();
        StringBuilder sb = new StringBuilder();
        for (byte b : digest) {
            sb.append(String.format("%02x", b & 0xff));
        }
        return sb.toString();
    }
}