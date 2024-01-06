<%-- 
    Document   : get_mod
    Created on : Dec 30, 2023, 5:54:45 PM
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
                <i class="fa fa-book"></i>
            </span>
            <select name="mod" class="form-control select2me" id="module_1" data-placeholder="choisir Section" multiple="multiple" multiple required>
<%
                String query = "SELECT * FROM module WHERE id_sem = ?";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setInt(1, id);
                rs = ps.executeQuery();

                while (rs.next()) {
                    int id_mod = rs.getInt("id_mod");
                    String mod = rs.getString("nom_mod");
%>
                    <option value="<%= id_mod %>"><%= mod %></option>
<%
                }
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
                $('#module_1').select2();
            });
        </script> 