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
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Abd Elouahab
 */
public class Delete_specialite extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        Statement stmt = null;
        String url = "jdbc:mysql://localhost:3306/pfe_bdd"; 
        String user = "root"; 
        String password = "";
        
        String id = request.getParameter("deleteid");
        String id_dept = request.getParameter("id_dept");
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);
            
            PreparedStatement pstmt1 = conn.prepareStatement("DELETE FROM semestre WHERE id_spec = ?");
            pstmt1.setString(1, id);
            pstmt1.executeUpdate();

            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM specialite WHERE id_spec = ?");
            pstmt.setString(1, id);
            pstmt.executeUpdate();

            
            String type, message;
            if (pstmt.getUpdateCount() > 0) {
                type = "success";
                message = "La departement est supprimée avec succes";
            } else {
                type = "error";
                message = "La departement n'est pas supprimée avec succes";
            }

            response.sendRedirect("projet/Admin_dept/specialite.jsp?type=" + type + "&message=" + message);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
