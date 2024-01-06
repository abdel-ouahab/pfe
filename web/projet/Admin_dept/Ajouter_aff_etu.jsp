<%-- 
    Document   : Ajouter_aff_etu
    Created on : Dec 30, 2023, 11:49:48 PM
    Author     : Abd Elouahab
--%>
<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@include file="head.jsp" %>
<%
if (session.getAttribute("email")==null || session.getAttribute("admin") == null) {
        response.sendRedirect("../../index.jsp");
    }
%>

<!-- BEGIN CONTENT -->
	<div class="page-content-wrapper">
		<div class="page-content">
			
		
			<!-- BEGIN PAGE HEADER-->
			<h3 class="page-title">
			Affectation les etudiants par modules  <small></small>
			</h3>
			<div class="page-bar">
				<ul class="page-breadcrumb">
					<li>
						<i class="fa fa-home"></i>
						<%if (session.getAttribute("admin_p") != null) { %>
						<a href="index.jsp?id_dept=<%=id_dept%>">Accueil</a>
						<% } %>
                                                <%if (session.getAttribute("admin_p") == null) {%>
						<a href="index.jsp">Accueil</a>
						<% } %><a href="index.jsp?id_dept=<%=id_dept%>">Accueil</a>
						<i class="fa fa-angle-right"></i>
					</li>
					<li>
						<%if (session.getAttribute("admin_p") != null) { %>
						<a href="affectation_etudiant.jsp?id_dept=<%=id_dept%>">Affectation les etudiants par modules</a>
						<% } %>
                                                <%if (session.getAttribute("admin_p") == null) {%>
						<a href="affectation_etudiant.jsp">Affectation les etudiants par modules</a>
						<% } %>
                                                <i class="fa fa-angle-right"></i>
					</li>
					<li>
						<a href="#">Ajouter </a>
					</li>
				</ul>
						
				
			</div>
			<!-- END PAGE HEADER-->
			<!-- BEGIN PAGE CONTENT-->
			<div class="row">
				<div class="col-md-12">
					<!-- BEGIN EXAMPLE TABLE PORTLET-->
					<div class="portlet box blue">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-edit"></i>Affectation les etudiants par modules
							</div>
							<div class="tools">
								<a href="javascript:;" class="collapse">
								</a>
								
							</div>
						</div>
						<div class="portlet-body">
							<div class="table-toolbar">
							<form action="../../Ajouter_prog2?id_dept=<%=id_dept%>" class="form-horizontal form-row-sepe" method="POST">
								<div class="form-body">
									
											<div class="form-group">
											<label class="control-label col-md-3">Etudiant</label>
											<div class="col-md-6">
												<div class="input-group">
													<span class="input-group-addon">
													<i class="fa fa-user"></i>
													</span>
													<select name="etud" class="form-control select2me" data-placeholder="choisir Etudiant" required>
													<option></option>
													<%
                                                                                                            Connection conn = null;
                                                                                                            Statement stmt = null;
                                                                                                            ResultSet rs = null;

                                                                                                            try {
                                                                                                                // Establish database connection
                                                                                                                Class.forName("com.mysql.jdbc.Driver");
                                                                                                                conn = DriverManager.getConnection(url, user, pwd);

                                                                                                                    String query = "SELECT * FROM etudiant WHERE (dette='1' OR ajourne='1') AND id_dept=?";
                                                                                                                    PreparedStatement ps = conn.prepareStatement(query);
                                                                                                                    ps.setString(1, id_dept);
                                                                                                                    rs = ps.executeQuery();

                                                                                                                    while (rs.next()) {
                                                                                                                        int id = rs.getInt("id_etud");
                                                                                                                        String nom = rs.getString("nom");
                                                                                                                        String prenom = rs.getString("prenom");
                                                                                                        %>
                                                                                                                        <option value="<%= id %>"><%= prenom + ' ' + nom %></option>
                                                                                                        <%
                                                                                                                    }
                                                                                                            } catch (Exception e) {
                                                                                                                e.printStackTrace();
                                                                                                            }
                                                                                                        %>
		
													</select>
												</div>
												<!-- /input-group -->
											</div>
										</div>
												
												
												
											
											<div class="form-group">
											<label class="control-label col-md-3">Niveau</label>
											<div class="col-md-6">
												<div class="input-group">
													<span class="input-group-addon">
													<i class="fa fa-bars"></i>
													</span>
													<select class="form-control select2me" id="Niveau" data-placeholder="choisir Niveau" required>
														<option></option>
                                                                                                        <%
                                                                                                            try {
                                                                                                                String query = "SELECT * FROM niveau WHERE id_dept=?";
                                                                                                                PreparedStatement ps = conn.prepareStatement(query);
                                                                                                                ps.setString(1, id_dept);
                                                                                                                rs = ps.executeQuery();

                                                                                                                while (rs.next()) {
                                                                                                                    String id_niv = rs.getString("id_niv");
                                                                                                                    String nom_niv = rs.getString("nom_niv");
                                                                                                                
                                                                                                        %>
                                                                                                                <option value="<%= id_niv %>"><%= nom_niv %></option>
                                                                                                        <%}
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
		
													</select>
												</div>
												<!-- /input-group -->
											</div>
										</div>

										<div class="form-group">
											<label class="control-label col-md-3">Section</label>
											<div class="col-md-6 " id="Section">
												<div class="input-group">
													<span class="input-group-addon">
													<i class="fa fa-adjust"></i>
													</span>
													<select  class="form-control select2me" data-placeholder="choisir Section" required>
													<option value=""></option>		
													</select>
												</div>
												
												<!-- /input-group -->
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3">Semestre</label>
											<div class="col-md-6 " id="Semestre">
												<div class="input-group">
													<span class="input-group-addon">
													<i class="fa fa-check"></i>
													</span>
													<select  class="form-control select2me" data-placeholder="choisir Semestre" required>
													<option value=""></option>		
													</select>
												</div>
												
												<!-- /input-group -->
											</div>
										</div>

										<div class="form-group">
											<label class="control-label col-md-3">Module</label>
											<div class="col-md-6 " id="module">
												<div class="input-group">
													<span class="input-group-addon">
													<i class="fa fa-book"></i>
													</span>
													<select name="mod" class="form-control select2me" data-placeholder="choisir module" required>	
													<option value=""></option>		
													</select>
												</div>
												
												<!-- /input-group -->
											</div>
										</div>
										<div class="form-actions">
												<div class="row">
													<div class="col-md-offset-3 col-md-9">
														<button type="submit" name="submit" class="btn btn-circle blue">Insérer</button>
													</div>
												</div>
											</div>
												
												
											
								</div>
							</form>
							</div>
							
						</div>
					</div>
					<!-- END EXAMPLE TABLE PORTLET-->
			






		</div>
	</div>
	<!-- END CONTENT -->
<!-- END CONTAINER -->
<%@include file="end.jsp" %>
<script>
	$(document).ready(function(){
		$(document).on("change","#Niveau", function(){
var id = this.value;
			$('#Section').load( "ajax/get_sec2.jsp?id="+id, function() {
});	
		
  });
});
</script>

<script>
	$(document).ready(function(){
		$(document).on("change","#Niveau", function(){
var id = this.value;
			$('#Semestre').load( "ajax/get_sem.jsp?id="+id, function() {
});	
		
  });
});
</script>
</body>
<!-- END BODY -->
</html>