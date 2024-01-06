<%-- 
    Document   : enseignant
    Created on : Dec 29, 2023, 12:35:45 AM
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

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>  
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<!-- BEGIN CONTENT -->
	<div class="page-content-wrapper">
		<div class="page-content">
			
		
			<!-- BEGIN PAGE HEADER-->
			<h3 class="page-title">
			Tableau des Enseignants
			</h3>
                        <div id="response" class="<% if(request.getParameter("type") != null) {
                            out.print(request.getParameter("type") +" display-block");}%>">
                             <%if(request.getParameter("message") != null) { out.print(request.getParameter("message"));}%></div>
                        
			<div class="page-bar">
				<ul class="page-breadcrumb">
					<li>
						<i class="fa fa-home"></i>
						<%if (session.getAttribute("admin_p") != null) { %>
						<a href="index.jsp?id_dept=<%=id_dept%>">Accueil</a>
						<% } %>
                                                <%if (session.getAttribute("admin_p") == null) {%>
						<a href="index.jsp">Accueil</a>
						<% } %>
						<i class="fa fa-angle-right"></i>
					</li>
					<li>
						<a href="javascript:;">Enseignants</a>
						</i>
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
								<i class="fa fa-table"></i>Tableau
							</div>
							<div class="tools">
								<a href="javascript:;" class="collapse">
								</a>
								
							</div>
						</div>
						
						<div class="portlet-body">
							<div class="table-toolbar">
								<div class="row">
									<div class="col-md-6">
										<div class="btn-group">
											<button type="button" name="age" id="age" data-toggle="modal" data-target="#add_data_Modal" class="btn green">
											Ajouter <i class="fa fa-plus"></i>
											</button>
										</div>
										<!--<a href="import1.php?action=impt&id_dept=<?php echo $id_dept; ?>">
										<div class="btn-group">
										<button type="button" name="age"  class="btn blue-madison">
										importer EXEL  <i class="fa fa-cloud-download"></i>
											</button>
										</div>
										</a>-->
									</div>
									
								</div>
							</div>
							<table class="table table-striped table-hover table-bordered" id="sample_editable_1" >
							<thead>
							<tr>
							    <th>
									Nom
								</th>
								<th>
									 Prenom
								</th>
								
								<th>
									 E-mail
								</th>
								<th>
								</th>
							</tr>
							</thead>
							<tbody>
                                                            <%
                                                                Connection conn = null;
                                                                Statement stmt = null;
                                                                ResultSet rs = null;

                                                                try {
                                                                    Class.forName("com.mysql.jdbc.Driver");
                                                                    conn = DriverManager.getConnection(url, user, pwd);
                                                                    String query = "SELECT * FROM enseignant WHERE id_dept='" + id_dept + "' ORDER BY prenom";
                                                                    stmt = conn.createStatement();
                                                                    rs = stmt.executeQuery(query);

                                                                    while (rs.next()) {
                                                                        int id = rs.getInt("id_ens");
                                                                        String nom = rs.getString("nom");
                                                                        String prenom = rs.getString("prenom");
                                                                        String email = rs.getString("email");
                                                                        String password = rs.getString("password");
                                                            %>
                                                                        <tr>
                                                                            <td><%= nom %></td>
                                                                            <td><%= prenom %></td>
                                                                            <td><%= email %></td>
                                                                            <td>
                                                                                <a class="btn btn-info" href="javascript:;">
                                                                                    <i class="fa fa-pencil"></i>
                                                                                </a>
                                                                                <button class="btn btn-large btn-danger" data-href="../../Delete_enseignant?deleteid=<%= id %>&id_dept=<%= id_dept %>" data-toggle="confirmation" data-placement="left" data-btn-ok-label="Oui" data-btn-cancel-label="Non" data-original-title="Vous etes sur ?" title="">
                                                                                    <i class="fa fa-trash-o"></i>
                                                                                </button>
                                                                            </td>
                                                                        </tr>
                                                            <%
                                                                    }
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

                                                       
							</table>
						</div>
					</div>
					<!-- END EXAMPLE TABLE PORTLET-->
		</div>
	</div>
	<!-- END CONTENT -->
<!-- END CONTAINER -->

<%@include file="end.jsp" %>
</body>
<!-- END BODY -->
</html>

<div id="add_data_Modal" class="modal fade">
 <div class="modal-dialog">
  <div class="modal-content">
   <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal">&times;</button>
    <h4 class="modal-title">Ajouter Enseignant </h4>
   </div>
   <div class="modal-body">
    <form method="post" id="insert_form" action="../../Ajouter_enseignant?id_dept=<%=id_dept%>" >
     <label>Nom</label>
	 <input type="text" name="nom" id="nom" class="form-control input-circle" placeholder="Enter Nom de l'enseignant" autocomplete="off" required>
     <br />
     <label>Prenom</label>
     <input type="text" name="prenom" id="prenom" class="form-control input-circle" placeholder="Enter Prenom de l'enseignant" autocomplete="off" required>
     <br />
     <input type="submit" name="submit" id="insert" value="Insérer" class="btn btn-success"/>

    </form>
   </div>
   <div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
   </div>
  </div>
 </div>
</div>
