<%-- 
    Document   : get_sec
    Created on : Dec 30, 2023, 5:48:14 PM
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
            <select name="sec" class="form-control select2me" id="Section_1" data-placeholder="choisir Section" multiple="multiple" multiple="multiple" required>
                <option></option>
<%
                String query = "SELECT * FROM section WHERE id_niv = ?";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setInt(1, id);
                rs = ps.executeQuery();

                while (rs.next()) {
                    int id_sec = rs.getInt("id_sec");
                    String sec = rs.getString("sec");
                    int id_spec = rs.getInt("id_spec");

                    String querySpec = "SELECT * FROM specialite WHERE id_spec = ?";
                    PreparedStatement psSpec = conn.prepareStatement(querySpec);
                    psSpec.setInt(1, id_spec);
                    ResultSet rsSpec = psSpec.executeQuery();

                    String nom_spec = null;
                    if (rsSpec.next()) {
                        nom_spec = rsSpec.getString("nom_spec");
                    }
%>
                    <option value="<%= id_sec %>"><%= sec + (nom_spec != null ? " --> " + nom_spec : "") %></option>
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
                $('#Section_1').select2();
            });
        </script> 