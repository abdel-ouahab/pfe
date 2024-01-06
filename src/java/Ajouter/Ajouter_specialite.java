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
public class Ajouter_specialite extends HttpServlet {
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

            String id_dept = request.getParameter("id_dept");
            String[] id_niv = request.getParameterValues("niv");
            String nom_spec = request.getParameter("nom");

            for (String idn : id_niv) {
                pstmt = conn.prepareStatement("INSERT INTO specialite(id_niv, id_dept, nom_spec) VALUES (?, ?, ?)");
                pstmt.setString(1, idn);
                pstmt.setString(2, id_dept);
                pstmt.setString(3, nom_spec);
                pstmt.executeUpdate();
            }

            PreparedStatement pstmt2 = conn.prepareStatement("SELECT * FROM specialite WHERE nom_spec=?");
            pstmt2.setString(1, nom_spec);
            ResultSet rs2 = pstmt2.executeQuery();
            String id_spec = "";
            while (rs2.next()) {
                id_spec = rs2.getString("id_spec");
            }

            for (String idn : id_niv) {
                PreparedStatement pstmt3 = conn.prepareStatement("SELECT * FROM niveau WHERE id_niv=?");
                pstmt3.setString(1, idn);
                ResultSet rs3 = pstmt3.executeQuery();

                while (rs3.next()) {
                    String nom_niv1 = rs3.getString("nom_niv");

                    if (nom_niv1.equals("Master 2")) {
                        PreparedStatement pstmt4 = conn.prepareStatement("DELETE FROM semestre WHERE id_niv=? AND id_dept=? AND id_spec='0'");
                        pstmt4.setString(1, idn);
                        pstmt4.setString(2, id_dept);
                        pstmt4.executeUpdate();

                        PreparedStatement pstmt5 = conn.prepareStatement("INSERT INTO semestre(id_spec, id_niv, id_dept, sem) VALUES (?, ?, ?, ?)");
                        pstmt5.setString(1, id_spec);
                        pstmt5.setString(2, idn);
                        pstmt5.setString(3, id_dept);
                        pstmt5.setString(4, "Semestre 1");
                        pstmt5.executeUpdate();
                    } else {
                        PreparedStatement pstmt6 = conn.prepareStatement("DELETE FROM semestre WHERE id_niv=? AND id_dept=? AND id_spec='0'");
                        pstmt6.setString(1, idn);
                        pstmt6.setString(2, id_dept);
                        pstmt6.executeUpdate();

                        PreparedStatement pstmt7 = conn.prepareStatement("INSERT INTO semestre(id_spec, id_niv, id_dept, sem) VALUES (?, ?, ?, ?)");
                        pstmt7.setString(1, id_spec);
                        pstmt7.setString(2, idn);
                        pstmt7.setString(3, id_dept);
                        pstmt7.setString(4, "Semestre 1");
                        pstmt7.executeUpdate();

                        PreparedStatement pstmt8 = conn.prepareStatement("INSERT INTO semestre(id_spec, id_niv, id_dept, sem) VALUES (?, ?, ?, ?)");
                        pstmt8.setString(1, id_spec);
                        pstmt8.setString(2, idn);
                        pstmt8.setString(3, id_dept);
                        pstmt8.setString(4, "Semestre 2");
                        pstmt8.executeUpdate();
                    }
                }
            }
            
            String type, message;
            if (pstmt != null) {
                type = "success";
                message = "La specialté est ajoutée avec succes ";
            } else {
                type = "error";
                message = "La specialté n'est pas ajoutée avec succes";
            }

            response.sendRedirect("projet/Admin_dept/specialite.jsp?type=" + type + "&message=" + message);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources here (rs, stmt, conn) to avoid leaks
        }
    }
}
