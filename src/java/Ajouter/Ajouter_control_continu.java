/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ajouter;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author Abd Elouahab
 */
public class Ajouter_control_continu extends HttpServlet {
private static final long serialVersionUID = 1L;

@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        String url = "jdbc:mysql://localhost:3306/pfe_bdd"; 
        String user = "root"; 
        String pwd = "";

        String nmr_cc = request.getParameter("nmr_cc");
        String typecc = request.getParameter("type");
        int id_mod = Integer.parseInt(request.getParameter("id_mod"));
        int id_niv = Integer.parseInt(request.getParameter("id_niv"));
        int id_sec = Integer.parseInt(request.getParameter("id_sec"));
        int id_sem = Integer.parseInt(request.getParameter("id_sem"));

        String uploadPath = "../Admin_dept/cours/";

        String fileName = "";
        String message = "";
        String type = "";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, pwd);
            
            Part filePart = request.getPart("target_dir");
            
            fileName = getSubmittedFileName(filePart);

            // Valid file extensions
            String[] extensionsArr = { "doc", "pdf" };

            // Check extension
            String extension = fileName.substring(fileName.lastIndexOf(".") + 1);
            boolean isValidExtension = false;
            for (String ext : extensionsArr) {
                if (ext.equals(extension)) {
                    isValidExtension = true;
                    break;
                }
            }

            if (isValidExtension) {
                // Upload file
                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);

                pstmt = conn.prepareStatement("INSERT INTO `controle continu`(type,id_mod,nmr_cc,target_dir) VALUES (?, ?, ?, ?)");
                pstmt.setString(1, typecc);
                pstmt.setInt(2, id_mod);
                pstmt.setString(3, nmr_cc);
                pstmt.setString(4, filePath);

                int rowsInserted = pstmt.executeUpdate();
                if (rowsInserted > 0) {
                    type = "success";
                    message = "Le cour est ajouté avec succès";
                }
            } else {
                type = "error";
                message = "Extension de fichier invalide. Les extensions valides sont 'doc' et 'pdf'.";
            }
            String redirectURL = "projet/Enseignant/enseignant.jsp?id_niv=" + id_niv + "&id_sec=" + id_sec + "&id_sem=" + id_sem + "&type=" + type + "&message=" + message;
        response.sendRedirect(redirectURL);
        } catch (Exception e) {
            e.printStackTrace();
            message = "Une erreur s'est produite lors de l'ajout du cours.";
            out.print(e);
        }

        
    }

    private String getSubmittedFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                return fileName.substring(fileName.lastIndexOf('/') + 1).substring(fileName.lastIndexOf('\\') + 1);
            }
        }
        return null;
    }
}
