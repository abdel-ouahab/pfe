/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Login;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Abd Elouahab
 */
@WebServlet(name = "login", urlPatterns = {"/Login"})
public class login extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
                HttpSession session = request.getSession();
		String email = request.getParameter("email");
		String passw = request.getParameter("password");
                
                int id_dep = 0;
                String type = "";
                
		String url  = "jdbc:mysql://localhost:3306/pfe_bdd";
		String user = "root";
		String pwd  = "";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, pwd);
                        
                        MessageDigest md = MessageDigest.getInstance("SHA-1");
                        md.update(passw.getBytes());
                        byte[] bytes = md.digest();
                        StringBuilder sb = new StringBuilder();
                        for (byte aByte : bytes) {
                            sb.append(Integer.toString((aByte & 0xff) + 0x100, 16).substring(1));
                        }
                        String password = sb.toString();
                        //admin
			PreparedStatement pst=con.prepareStatement("SELECT * FROM admin WHERE email=? AND password=?");
			pst.setString(1,email);
			pst.setString(2,password);
			ResultSet rs = pst.executeQuery();
                        
                        //enseignant
                        
                        PreparedStatement pst_ens=con.prepareStatement("SELECT * FROM enseignant WHERE email=? AND password=?");
			pst_ens.setString(1,email);
			pst_ens.setString(2,password);
			ResultSet rs_ens = pst_ens.executeQuery();
                        
                        //etudiant
                        
                        PreparedStatement pst_etu=con.prepareStatement("SELECT * FROM etudiant WHERE email=? AND password=?");
			pst_etu.setString(1,email);
			pst_etu.setString(2,password);
			ResultSet rs_etu = pst_etu.executeQuery();
                        
			if(rs.next())     {  
                            id_dep = rs.getInt(2);
                            type =rs.getString(7);
                        } 
                        if(rs_ens.next()) {  
                            id_dep = rs_ens.getInt(2);
                            type =rs_ens.getString(7);
                        }
                        if(rs_etu.next()) {  
                            id_dep = rs_etu.getInt(2);
                            type =rs_etu.getString(12);
                        }
                            
                            
                            
                                if ("admin".equals(type) && id_dep == 0) {  
                                    session.setAttribute("id_adm", rs.getString(1));
                                    session.setAttribute("id_dept", rs.getString(2));
                                    session.setAttribute("nom", rs.getString(3));
                                    session.setAttribute("prenom", rs.getString(4));
                                    session.setAttribute("email", rs.getString(5));
                                    session.setAttribute("admin", rs.getString(7));
                                    session.setAttribute("admin_p", rs.getString(7));
                                    response.sendRedirect("projet/Admin/index.jsp");
                                }else if ("admin".equals(type) && id_dep > 0) {
                                    session.setAttribute("id_adm", rs.getString(1));
                                    session.setAttribute("id", rs.getString(2));
                                    session.setAttribute("nom", rs.getString(3));
                                    session.setAttribute("prenom", rs.getString(4));
                                    session.setAttribute("email", rs.getString(5));
                                    session.setAttribute("admin", rs.getString(7));
                                    response.sendRedirect("projet/Admin_dept/index.jsp");
                            } else  
                                    if ("enseignant".equals(type)) {
                                    session.setAttribute("id", rs_ens.getString(1));
                                    session.setAttribute("id_dept", rs_ens.getString(2));
                                    session.setAttribute("nom", rs_ens.getString(3));
                                    session.setAttribute("prenom", rs_ens.getString(4));
                                    session.setAttribute("email", rs_ens.getString(5));
                                    session.setAttribute("enseignant", rs_ens.getString(7));
                                    response.sendRedirect("projet/Enseignant/index.jsp");
                            } else 
                                    if ("etudiant".equals(type)) {
                                    session.setAttribute("id", rs_etu.getString(1));
                                    session.setAttribute("id_dept", rs_etu.getString(2));
                                    session.setAttribute("nom", rs_etu.getString(5));
                                    session.setAttribute("prenom", rs_etu.getString(6));
                                    session.setAttribute("email", rs_etu.getString(8));
                                    session.setAttribute("num_inscri", rs_etu.getString(4));
                                    session.setAttribute("date", rs_etu.getString(7));
                                    session.setAttribute("dette", rs_etu.getString(13));
                                    session.setAttribute("ajourne", rs_etu.getString(14));
                                    session.setAttribute("etudiant", rs_etu.getString(12));
                                    response.sendRedirect("projet/Etudiant/index.jsp");
                            }else response.sendRedirect("index.jsp?error=faux");
			rs.close();
			pst.close();
			con.close();
		}catch(Exception e) {
			System.out.print(e);
                        out.println("Er login"+email+"pass"+passw+"id "+id_dep+ "type"+type);
                        out.print(e);
		}
	}
}