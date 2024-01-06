<%-- 
    Document   : affectation_enseignant
    Created on : Dec 30, 2023, 2:40:01 PM
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
			Affectation les modules par enseignant  <small></small>
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
						<a href="javascript:;">Affectation les modules par enseignant</a>
					</li>
					<li>
						<a href="#"></a>
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
										<a href="Ajouter_aff_ens.jsp?id_dept=<%=id_dept%>">
										<div class="btn-group">
										<button type="button" name="age"  class="btn green">
										Ajouter  <i class="fa fa-plus"></i>
											</button>
										</div>
										</a>
									</div>
									
								</div>
							</div>
							<table class="table table-striped table-hover table-bordered" id="sample_editable_1">
							<thead>
							<tr>
								<th>
									 enseignant
								</th>
								<th>
									 Section
								</th>
								<th>
									 Module
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
                                                                // Establish database connection
                                                                Class.forName("com.mysql.jdbc.Driver");
                                                                conn = DriverManager.getConnection(url, user, pwd);

                                                                String query = "SELECT * FROM programmation where id_dept="+ id_dept;
                                                                stmt = conn.createStatement();
                                                                rs = stmt.executeQuery(query);

                                                                if (rs != null) {
                                                                    while (rs.next()) {
                                                                        int id_prog = rs.getInt("id_prog");
                                                                        int id_ens = rs.getInt("id_ens");
                                                                        int id_sec = rs.getInt("id_sec");
                                                                        int id_mod = rs.getInt("id_mod");

                                                                        PreparedStatement ps1 = conn.prepareStatement("SELECT nom, prenom FROM enseignant WHERE id_ens=? AND id_dept=?");
                                                                        ps1.setInt(1, id_ens);
                                                                        ps1.setString(2, id_dept);
                                                                        ResultSet rs1 = ps1.executeQuery();
                                                                        String ens1 = "";
                                                                        String ens2 = "";
                                                                        if (rs1.next()) {
                                                                            ens1 = rs1.getString("nom");
                                                                            ens2 = rs1.getString("prenom");
                                                                        }

                                                                        PreparedStatement ps2 = conn.prepareStatement("SELECT sec FROM section WHERE id_sec=? AND id_dept=?");
                                                                        ps2.setInt(1, id_sec);
                                                                        ps2.setString(2, id_dept);
                                                                        ResultSet rs2 = ps2.executeQuery();
                                                                        String sec = "";
                                                                        if (rs2.next()) {
                                                                            sec = rs2.getString("sec");
                                                                        }

                                                                        PreparedStatement ps3 = conn.prepareStatement("SELECT nom_mod FROM module WHERE id_mod=? AND id_dept=?");
                                                                        ps3.setInt(1, id_mod);
                                                                        ps3.setString(2, id_dept);
                                                                        ResultSet rs3 = ps3.executeQuery();
                                                                        String mod = "";
                                                                        if (rs3.next()) {
                                                                            mod = rs3.getString("nom_mod");
                                                                        }

                                                                        %>
                                                                        <tr>
                                                                            <td><%= ens1 %> <%= ens2 %></td>
                                                                            <td><%= sec %></td>
                                                                            <td><%= mod %></td>
                                                                            <td>
                                                                                <a class="btn btn-info" href="javascript:;">
                                                                                    <i class="fa fa-pencil"></i>
                                                                                </a>
                                                                                <button class="btn btn-large btn-danger" data-href="../../Delete_prog1?deleteid=<%= id_prog %>&id_dept=<%=id_dept %>" data-toggle="confirmation" data-placement="left" data-btn-ok-label="Oui" data-btn-cancel-label="Non" data-original-title="Vous etes sur ?" title="">
                                                                                    <i class="fa fa-trash-o"></i>
                                                                                </button>
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                    }
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

