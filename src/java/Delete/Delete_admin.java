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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Abd Elouahab
 */
public class Delete_admin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id_dept = request.getParameter("id_dept");
        String id = request.getParameter("deleteid");
        String url = "jdbc:mysql://localhost:3306/pfe_bdd"; 
        String user = "root"; 
        String password = "";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);
            
            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM `admin` WHERE `id_adm`=?");
            pstmt.setString(1, id);
            pstmt.executeUpdate();
           
            
            String type, message;
            if (pstmt.getUpdateCount() > 0) {
                type = "success";
                message = "Le module est supprimé avec succes ";
            } else {
                type = "error";
                message = "Le module n'est pas supprimé avec succes";
            }

            response.sendRedirect("projet/Admin_dept/admin.jsp?type=" + type + "&message=" + message);

            pstmt.close();
            conn.close();
        } catch (Exception e) {
        }
        }
}
