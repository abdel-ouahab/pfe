<%-- 
    Document   : get_spec
    Created on : Dec 28, 2023, 3:56:05 PM
    Author     : Abd Elouahab
--%>
<%@ page import="java.sql.*" %>
<div class="input-group">
<span class="input-group-addon">
<i class="fa fa-book"></i>
</span>
<select name="spec" class="form-control select2me" id='spec_1' data-placeholder="choisir specialite" multiple="multiple" multiple required>
		
<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet res = null;
    String url  = "jdbc:mysql://localhost:3306/pfe_bdd";
    String user = "root";
    String pwd  = "";
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, pwd);
        int id = Integer.parseInt(request.getParameter("id"));

        stmt = conn.createStatement();
        String query = "SELECT * FROM specialite WHERE id_niv = " + id;
        res = stmt.executeQuery(query);

            while (res.next()) {
                int id_spec = res.getInt("id_spec");
                String nom_spec = res.getString("nom_spec");
%>
                <option value="<%= id_spec %>"><%= nom_spec %></option>
<%
            }
        
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</select>
</div>

 <script type="text/javascript">
            $(document).ready(function(){
                $('#spec_1').select2();
            });
        </script> 