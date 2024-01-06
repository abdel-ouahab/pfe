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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Abd Elouahab
 */
public class Ajouter_module extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id_dept = request.getParameter("id_dept");
        String nom = request.getParameter("nom");
        String id_sem = request.getParameter("semestre");
        String tp = request.getParameter("tp");
        String td = request.getParameter("td");
        
        if(tp ==null){ tp="0";}
        if(td ==null){ td="0";}

        String url = "jdbc:mysql://localhost:3306/pfe_bdd"; 
        String user = "root"; 
        String pwd = "";
        PrintWriter out =response.getWriter();
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, pwd);

            PreparedStatement ps1 = conn.prepareStatement("INSERT INTO module(id_sem, id_dept, nom_mod, TP, TD) VALUES (?, ?, ?, ?, ?)");
            ps1.setString(1, id_sem);
            ps1.setString(2, id_dept);
            ps1.setString(3, nom);
            ps1.setString(4, tp);
            ps1.setString(5, td);
            ps1.executeUpdate();

            String type, message;
            if (ps1 != null) {
                type = "success";
                message = "Le module est ajouté avec succès";
            } else {
                type = "error";
                message = "Le module n'est pas ajouté avec succès";
            }

            response.sendRedirect("projet/Admin_dept/module.jsp?type=" + type + "&message=" + message);
        } catch (Exception e) {
            e.printStackTrace();
            out.print(e);
        }
    }

}
