<%-- 
    Document   : section
    Created on : Dec 28, 2023, 2:42:51 PM
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
			Tableau des Sections
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
						<a href="javascript:;">Sections</a>
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
										
									<a href="Ajouter_section.jsp">
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
								Niveau
								</th>
								<th>
								Spécialité
								</th>
								<th>
                                                                Section
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
                                                                
                                                                PreparedStatement stmt = conn.prepareStatement("SELECT * FROM section WHERE id_dept="+id_dept);
                                                                ResultSet res1 = stmt.executeQuery( );

                                                                while (res1.next()) {
                                                                    int id_sec = res1.getInt("id_sec");
                                                                    int id_spec = res1.getInt("id_spec");
                                                                    int id_niv = res1.getInt("id_niv");
                                                                    String sec = res1.getString("sec");

                                                                    PreparedStatement stmt1 = conn.prepareStatement("SELECT * FROM niveau WHERE id_niv="+id_niv);
                                                                    ResultSet res2 = stmt1.executeQuery();
                                                                    if (res2.next()) {
                                                                        String nom_niv = res2.getString("nom_niv");
                                                                        PreparedStatement stmt2 = conn.prepareStatement("SELECT * FROM specialite WHERE id_spec="+id_spec);
                                                                            ResultSet res = stmt2.executeQuery();
                                                                            while (res.next()) {
                                                                                String nom_spec = res.getString("nom_spec");
                                                                                    %>
                                                                                <tr>
                                                                                <td><%=nom_niv%></td>
                                                                                <td><%=nom_spec%></td>
                                                                                <td><%=sec%></td>
                                                                                <td>
                                                                                <a class='btn btn-info' href="javascript:;">
                                                                                <i class='fa fa-pencil'></i> </a>
                                                                                <button class='btn btn-large btn-danger' data-href="../../Delete_section?deleteid=<%=id_sec%>&id_dept=<%=id_dept%>" data-toggle='confirmation' data-placement='left' data-btn-ok-label='Oui' data-btn-cancel-label='Non' data-original-title='Vous ete sur ?' title=''><i class='fa fa-trash-o'></i></button>
                                                                                </td>
                                                                                </tr>
                                                                        <%    }
                                                                                        }
                                                                    }
                                                                
                                                            } catch (Exception e) {
                                                                e.printStackTrace();
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