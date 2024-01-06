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
public class Delete_dept extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id_dept = request.getParameter("id_dept");
        String url = "jdbc:mysql://localhost:3306/pfe_bdd"; 
        String user = "root"; 
        String password = "";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);
            
            String query = "DELETE FROM `niveau` WHERE `id_dept`="+id_dept ;
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.executeUpdate();
            String query_dept = "DELETE FROM `dept` WHERE `id_dept`="+id_dept ;
            PreparedStatement pst = conn.prepareStatement(query_dept);
            pst.executeUpdate();
            
            String type, message;
            if (pst.getUpdateCount() > 0) {
                type = "success";
                message = "La departement est supprimée avec succes";
            } else {
                type = "error";
                message = "La departement n'est pas supprimée avec succes";
            }

            response.sendRedirect("projet/Admin/table_dept.jsp?type=" + type + "&message=" + message);

            pstmt.close();
            pst.close();
            conn.close();
        } catch (Exception e) {
        }
        }
    }
