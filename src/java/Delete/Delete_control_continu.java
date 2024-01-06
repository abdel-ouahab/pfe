/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Delete;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Abd Elouahab
 */
public class Delete_control_continu extends HttpServlet {
@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        
        int id_cc = Integer.parseInt(request.getParameter("id_cc"));
        int id_niv = Integer.parseInt(request.getParameter("id_niv"));
        int id_sec = Integer.parseInt(request.getParameter("id_sec"));
        int id_semm = Integer.parseInt(request.getParameter("id_sem"));

        Connection conn = null;
        PreparedStatement pstmt = null;
        String url = "jdbc:mysql://localhost:3306/pfe_bdd"; 
        String user = "root"; 
        String password = "";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);

            String deleteQuery = "DELETE FROM `controle continu` WHERE id_cc = ?";
            pstmt = conn.prepareStatement(deleteQuery);
            pstmt.setInt(1, id_cc);
            
            int rowsAffected = pstmt.executeUpdate();
            String type ="";
            String message ="";
            if (rowsAffected > 0) {
                 type = "success";
                 message = "Le controle continu est supprimé avec succès";
                
            } else {
                 type = "success";
                 message = "Le controle continu n'est pas supprimé avec succès";
            }
            String redirectURL = "projet/Enseignant/enseignant.jsp?id_niv=" + id_niv + "&id_sec=" + id_sec + "&id_sem=" + id_semm + "&type=" + type + "&message=" + message;
                response.sendRedirect(redirectURL);

            pstmt.close();
            conn.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        }
    }
}
