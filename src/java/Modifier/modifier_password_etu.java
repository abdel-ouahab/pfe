/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modifier;

import Ajouter.Ajouter_enseignant;
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
public class modifier_password_etu extends HttpServlet {
@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    PrintWriter out = response.getWriter();
    String expass = request.getParameter("expass");
    String newpass1 = request.getParameter("newpass1");
    String newpass2 = request.getParameter("newpass2");
    int id = Integer.parseInt(request.getParameter("id"));

    // Assuming conn is your database connection obtained earlier

    String url = "jdbc:mysql://localhost:3306/pfe_bdd"; 
    String user = "root"; 
    String pwd = "";
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, user, pwd);
        String password = null;
        try {
            password = sha1(expass);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(Ajouter_enseignant.class.getName()).log(Level.SEVERE, null, ex);
        }
        String sql = "SELECT * FROM `etudiant` WHERE id_etud=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            String password1 = rs.getString("password");

            if (password.equals(password1)) {
                if (newpass2.equals(newpass1)) {
                    String password3 = sha1(newpass1); // Hash the new password

                    String updateSQL = "UPDATE `etudiant` SET password=? WHERE id_etud=?";
                    PreparedStatement updateStmt = conn.prepareStatement(updateSQL);
                    updateStmt.setString(1, password3);
                    updateStmt.setInt(2, id);
                    updateStmt.executeUpdate();

                    // Redirect with success message
                    response.sendRedirect("projet/Etudiant/modifier_password.jsp?type=success&message=Le mot de passe a ete modifie" );
                } else {
                    // Redirect with confirmation error
                    response.sendRedirect("projet/Etudiant/modifier_password.jsp?type=error&message=Erreur+de+confirmation");
                }
            } else {
                // Redirect with incorrect password error
                response.sendRedirect("projet/Etudiant/modifier_password.jsp?type=error&message=Le+mot+de+passe+n%27est+pas+correct");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.print(e);
        // Handle exceptions here
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
