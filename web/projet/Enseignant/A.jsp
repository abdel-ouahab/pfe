<%-- 
    Document   : A
    Created on : Jan 4, 2024, 1:00:36 AM
    Author     : Abd Elouahab
--%>
<%@ page import="java.io.*, java.sql.*, javax.servlet.ServletException, javax.servlet.http.*, javax.servlet.annotation.WebServlet" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.nio.file.*, java.nio.file.Paths, java.nio.file.StandardCopyOption" %>

<%
// Get form data

        String nom_cour = request.getParameter("nom_cour");
        String descreption = request.getParameter("descreption");
        int id_mod = Integer.parseInt(request.getParameter("id_mod"));
        int id_niv = Integer.parseInt(request.getParameter("id_niv"));
        int id_sec = Integer.parseInt(request.getParameter("id_sec"));
        int id_sem = Integer.parseInt(request.getParameter("id_sem"));

String targetDir = "../Admin_dept/cours/";
String message = "";
String type = "";

// File upload handling
Part filePart = request.getPart("target_dir");
String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix
String fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();

// Valid file extensions
String[] extensionsArr = {"doc", "pdf"};

// Check extension
boolean isValidExtension = false;
for (String ext : extensionsArr) {
    if (ext.equals(fileExtension)) {
        isValidExtension = true;
        break;
    }
}

if (isValidExtension) {
    String filePath = targetDir + fileName;

    // Save file to the specified directory
    try (InputStream fileContent = filePart.getInputStream()) {
        Files.copy(fileContent, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
    }

    // Database insertion
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pfe_bdd", "root", "");

        // Your insert query
        String insertQuery = "INSERT INTO `cour`(id_mod, nom_cour, descreption, target_dir) VALUES (?, ?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(insertQuery);

        // Set parameters
        pstmt.setInt(1, id_mod); // Replace id_mod with the actual value
        pstmt.setString(2, nom_cour);
        pstmt.setString(3, descreption);
        pstmt.setString(4, filePath);

        int rowsInserted = pstmt.executeUpdate();
        if (rowsInserted > 0) {
            type = "success";
            message = "Le cour est ajouté avec succès";
        } else {
            type = "error";
            message = "Erreur lors de l'ajout du cour";
        }

        pstmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        type = "error";
        message = "Erreur lors de l'opération avec la base de données";
    }
} else {
    type = "error";
    message = "Extension de fichier invalide. Les extensions valides sont 'doc' et 'pdf'.";
}

// Redirect with parameters
response.sendRedirect("enseignant.jsp?id_niv=" + id_niv + "&id_sec=" + id_sec + "&id_sem=" + id_sem + "&type1=" + type + "&message=" + message);
%>

