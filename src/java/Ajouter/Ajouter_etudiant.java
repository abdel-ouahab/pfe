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
import java.sql.Statement;
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
public class Ajouter_etudiant extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String num = request.getParameter("num");
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String date = request.getParameter("date");
        String section = request.getParameter("section");
        String dette = request.getParameter("dette");
        String ajourne = request.getParameter("ajourne");

        String id_dept = request.getParameter("id_dept");
        String id_spec = request.getParameter("id_spec");
        String id_niv = request.getParameter("id_niv");

        String email = num + "@etu.univ-chlef.dz";
        String pass = date;
        String password = null;
        try {
            password = sha1(pass);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(Ajouter_enseignant.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(dette ==null){ dette="0";}
        if(ajourne ==null){ ajourne="0";}
        
        String url = "jdbc:mysql://localhost:3306/pfe_bdd"; 
        String user = "root"; 
        String pwd = "";
        PrintWriter out =response.getWriter();
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, pwd);
            
            
            String query = "SELECT num_inscri FROM etudiant WHERE num_inscri=?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, num);
            ResultSet rs = ps.executeQuery();

            if (!rs.next()) {
                String query1 = "INSERT INTO etudiant(id_dept, id_niv, num_inscri, nom, prenom, date, email, password, id_spec, id_sec, dette, ajourne) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement ps1 = conn.prepareStatement(query1);
                ps1.setString(1, id_dept);
                ps1.setString(2, id_niv);
                ps1.setString(3, num);
                ps1.setString(4, nom);
                ps1.setString(5, prenom);
                ps1.setString(6, date);
                ps1.setString(7, email);
                ps1.setString(8, password);
                ps1.setString(9, id_spec);
                ps1.setString(10, section);
                ps1.setString(11, dette);
                ps1.setString(12, ajourne);
                ps1.executeUpdate();
                
                if (("0".equals(dette)) && ("0".equals(ajourne))) {
                    String sql = "SELECT * FROM etudiant WHERE num_inscri=?";
                    PreparedStatement ps2 = conn.prepareStatement(sql);
                    ps2.setString(1, num);
                    ResultSet rs1 = ps2.executeQuery();
                    if (rs1.next()) {
                    String id_etud = rs1.getString("id_etud");

                    sql = "SELECT * FROM semestre WHERE id_niv=?";
                    PreparedStatement ps3 = conn.prepareStatement(sql);
                    ps3.setString(1, id_niv);
                    ResultSet rs2 = ps3.executeQuery();

                    while (rs2.next()) {
                        String id_sem = rs2.getString("id_sem");

                        sql = "SELECT * FROM module WHERE id_sem=?";
                        PreparedStatement ps4 = conn.prepareStatement(sql);
                        ps4.setString(1, id_sem);
                        ResultSet rsModules = ps4.executeQuery();

                        while (rsModules.next()) {
                            String id_mod = rsModules.getString("id_mod");

                            sql = "INSERT INTO programmation2(id_etud, id_sec, id_mod, id_dept) VALUES (?, ?, ?, ?)";
                            PreparedStatement ps5 = conn.prepareStatement(sql);
                            ps5.setString(1, id_etud);
                            ps5.setString(2, section);
                            ps5.setString(3, id_mod);
                            ps5.setString(4, id_dept);
                            ps5.executeUpdate();
                        }
                    }
                }}
            }

            // Set appropriate success or error messages
            String type, message;
            if (ps == null) {
                type = "success";
                message = "La specialté est ajoutée avec succes ";
            } else {
                type = "error";
                message = "La specialté n'est pas ajoutée avec succes";
            }
            response.sendRedirect("projet/Admin_dept/etudiant.jsp?id_niv=" + id_niv + "&id_spec=" + id_spec + "&type=" + type + "&message=" + message);
        } catch (Exception e) {
            e.printStackTrace();
            out.print(e);
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
