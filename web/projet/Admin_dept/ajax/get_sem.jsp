<%-- 
    Document   : get_sem
    Created on : Dec 30, 2023, 5:51:43 PM
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
                <i class="fa fa-check"></i>
            </span>
            <select class="form-control select2me" id="Semestre_1" data-placeholder="choisir Semestre" required>
                <option></option>
<%
                String query = "SELECT * FROM semestre WHERE id_niv = ?";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setInt(1, id);
                rs = ps.executeQuery();

                while (rs.next()) {
                    int id_sem = rs.getInt("id_sem");
                    String sem = rs.getString("sem");
                    int id_nivv = rs.getInt("id_niv");
                    int id_spec = rs.getInt("id_spec");

                    String querySpec = "SELECT * FROM specialite WHERE id_spec = ?";
                    PreparedStatement psSpec = conn.prepareStatement(querySpec);
                    psSpec.setInt(1, id_spec);
                    ResultSet rsSpec = psSpec.executeQuery();

                    String nom_spec = null;
                    if (rsSpec.next()) {
                        nom_spec = rsSpec.getString("nom_spec");
                    }

                    String queryNiv = "SELECT * FROM niveau WHERE id_niv = ?";
                    PreparedStatement psNiv = conn.prepareStatement(queryNiv);
                    psNiv.setInt(1, id_nivv);
                    ResultSet rsNiv = psNiv.executeQuery();

                    String nom_n = null;
                    if (rsNiv.next()) {
                        nom_n = rsNiv.getString("nom_niv");
                    }
%>
                    <option value="<%= id_sem %>"><%= sem + (nom_spec != null ? " --> " + nom_spec : "") + (nom_n != null ? " --> " + nom_n : "") %></option>
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
                $('#Semestre_1').select2();
            });
</script> 

<script>
	$(document).ready(function(){
		$(document).on("change","#Semestre_1", function(){
var id = this.value;
			$('#module').load( "ajax/get_mod.jsp?id="+id, function() {
});	
		
  });
});
</script>