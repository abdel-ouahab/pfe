<%-- 
    Document   : specialite
    Created on : Dec 28, 2023, 12:31:51 AM
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
			Tableau des spécialités
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
						<a href="javascript:;">spécialités</a>
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
										
									</div>
									
								</div>
							</div>
							<table class="table table-striped table-hover table-bordered" id="sample_editable_1">
							<thead>
							<tr>
								<th>
									Niveau
								</th>
								<th>
                                                                        Nom spécialité
								</th>
								<th>
								</th>
							</tr>
							</thead>
							<tbody>
							<%
                                                            Connection conn = null;
                                                            try {
                                                                Class.forName("com.mysql.jdbc.Driver");
                                                                conn = DriverManager.getConnection(url, user, pwd);
                                                                String query = "SELECT * FROM specialite WHERE id_dept=?";
                                                                PreparedStatement pstmt = conn.prepareStatement(query);
                                                                pstmt.setString(1, id_dept);
                                                                ResultSet rs = pstmt.executeQuery();

                                                                while (rs.next()) {
                                                                    String id_spec = rs.getString("id_spec");
                                                                    String id_niv = rs.getString("id_niv");
                                                                    String nom_spec = rs.getString("nom_spec");

                                                                    String queryNiveau = "SELECT * FROM niveau WHERE id_niv=?";
                                                                    PreparedStatement pstmtNiveau = conn.prepareStatement(queryNiveau);
                                                                    pstmtNiveau.setString(1, id_niv);
                                                                    ResultSet rsNiveau = pstmtNiveau.executeQuery();

                                                                    String nom_niv = "";
                                                                    if (rsNiveau.next()) {
                                                                        nom_niv = rsNiveau.getString("nom_niv");
                                                                    }
                                                                    %>
                                                                    <tr>
                                                                        <td><%= nom_niv %></td>
                                                                        <td><%= nom_spec %></td>
                                                                        <td>
                                                                            <a class="btn btn-info" href="javascript:;">
                                                                                <i class="fa fa-pencil"></i>
                                                                            </a>
                                                                            <button class="btn btn-large btn-danger" data-href="../../Delete_specialite?deleteid=<%= id_spec %>&id_dept=<%= id_dept %>" data-toggle="confirmation" data-placement="left" data-btn-ok-label="Oui" data-btn-cancel-label="Non" data-original-title="Vous etes sur ?" title="">
                                                                                <i class="fa fa-trash-o"></i>
                                                                            </button>
                                                                        </td>
                                                                    </tr>
                                                                    <%
                                                                }
                                                            } catch (Exception e) {
                                                                e.printStackTrace();
                                                            } finally {
                                                                // Close resources here (rs, stmt, conn) to avoid leaks
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
    <h4 class="modal-title">Ajouter specialite </h4>
   </div>
   <div class="modal-body">
    <form method="post" id="insert_form" action="../../Ajouter_specialite?id_dept=<%=id_dept%>" >
    <div class="input-group">
		<span class="input-group-addon">
		<i class="fa fa-book"></i>
		</span>
		<select name="niv" class="form-control select2me" id='module_1' data-placeholder="choisir Section" multiple="multiple" multiple required>
			
		<%
                    try {
                        String query = "SELECT * FROM niveau WHERE id_dept = ?";
                        PreparedStatement pstmt = conn.prepareStatement(query);
                        pstmt.setString(1, id_dept);
                        ResultSet rs = pstmt.executeQuery();

                        while (rs.next()) {
                            String id_niv = rs.getString("id_niv");
                            String nom_niv = rs.getString("nom_niv");
                %>
                            <option value="<%= id_niv %>"><%= nom_niv %></option>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        // Close resources here (rs, stmt, conn) to avoid leaks
                    }
                %>
	
		</select>
    </div>

    <br />
     <label>Nom de specialite</label>
	 <input type="text" name="nom" id="nom" class="form-control input-circle" placeholder="Enter Nom de specialite" autocomplete="off" required>
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

