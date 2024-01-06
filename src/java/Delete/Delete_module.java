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
public class Delete_module extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id_dept = request.getParameter("id_dept");
        String id = request.getParameter("deleteid");
        String url = "jdbc:mysql://localhost:3306/pfe_bdd";
        String user = "root";
        String pwd = "";
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection(url, user, pwd);
                
                String deleteProgrammationQuery = "DELETE FROM programmation WHERE id_mod=?";
                PreparedStatement ps2 = conn.prepareStatement(deleteProgrammationQuery);
                ps2.setString(1, id);
                ps2.executeUpdate();

                String deleteProgrammation2Query = "DELETE FROM programmation2 WHERE id_mod=?";
                PreparedStatement ps3 = conn.prepareStatement(deleteProgrammation2Query);
                ps3.setString(1, id);
                ps3.executeUpdate();

                String deleteModuleQuery = "DELETE FROM module WHERE id_mod=?";
                PreparedStatement ps1 = conn.prepareStatement(deleteModuleQuery);
                ps1.setString(1, id);
                int deletedRows = ps1.executeUpdate();


                String type, message;
                if (deletedRows > 0) {
                    type = "success";
                    message = "Le module est supprimé avec succès";
                } else {
                    type = "error";
                    message = "Le module n'est pas supprimé avec succès";
                }
                response.sendRedirect("projet/Admin_dept/module.jsp?type=" + type + "&message=" + message);
            } catch (Exception e) {
                e.printStackTrace();
            }
        
    }

}
