<%-- 
    Document   : get_sec2
    Created on : Dec 31, 2023, 12:12:24 AM
    Author     : Abd Elouahab
--%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        // Establish database connection
        Class.forName("com.mysql.jdbc.Driver");
        String url  = "jdbc:mysql://localhost:3306/pfe_bdd";
        String user = "root";
        String pwd  = "";
        conn = DriverManager.getConnection(url, user, pwd);
        int id = 1; // Replace with your ID
        if (request.getParameter("id") != null) {
            id = Integer.parseInt(request.getParameter("id"));
        }
%>
<div class="input-group">
    <span class="input-group-addon">
        <i class="fa fa-adjust"></i>
    </span>
    <select name="sec" class="form-control select2me" id='Section_1' data-placeholder="choisir Section" required>
        <option></option>
        <% 
            String query = "SELECT * FROM section WHERE id_niv=?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            while(rs.next()) {
                int id_sec = rs.getInt("id_sec");
                String sec = rs.getString("sec");
                int id_spec = rs.getInt("id_spec");

                PreparedStatement ps2 = conn.prepareStatement("SELECT * FROM specialite WHERE id_spec=?");
                ps2.setInt(1, id_spec);
                ResultSet rs2 = ps2.executeQuery();
                if (rs2.next()) {
                    String nom_spec = rs2.getString("nom_spec");
        %>
                    <option value="<%= id_sec %>"><%= sec + (nom_spec != null ? "-->" + nom_spec : "") %></option>
        <% 
                }
                rs2.close();
            }
            rs.close();
        %>
    </select>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>




 <script type="text/javascript">
            $(document).ready(function(){
                $('#Section_1').select2();
            });
        </script> 