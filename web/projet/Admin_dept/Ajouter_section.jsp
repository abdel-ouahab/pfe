<%-- 
    Document   : Ajouter_section
    Created on : Dec 28, 2023, 3:31:45 PM
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
			Section  <small></small>
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
						<% } %>
						<i class="fa fa-angle-right"></i>
					</li>
					<li>
						<a href="#">Section</a>
                                                <%if (session.getAttribute("admin_p") != null) { %>
						<a href="section.jsp?id_dept=<%=id_dept%>">Section</a>
						<% } %>
                                                <%if (session.getAttribute("admin_p") == null) {%>
						<a href="section.jsp">Section</a>
						<% } %>
						<i class="fa fa-angle-right"></i>
					</li>
					<li>
						<a href="#">Ajouter</a>
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
								<i class="fa fa-edit"></i>Section
							</div>
							<div class="tools">
								<a href="javascript:;" class="collapse">
								</a>
								
							</div>
						</div>
						<div class="portlet-body">
							<div class="table-toolbar">
							<form action="../../Ajouter_section?id_dept=<%=id_dept%>" class="form-horizontal form-row-sepe" method="POST">
								<div class="form-body">
											<div class="form-group">
											<label class="control-label col-md-3">Niveau</label>
											<div class="col-md-6">
												<div class="input-group">
													<span class="input-group-addon">
													<i class="fa fa-bars"></i>
													</span>
													<select class="form-control select2me" name="id_niv" id="Niveau" data-placeholder="choisir Niveau" required>
														<option></option>
                                                                                                                <%Connection conn = null;
                                                                                                                
                                                                                                                try {
                                                                                                                    Class.forName("com.mysql.jdbc.Driver");
                                                                                                                    conn = DriverManager.getConnection(url, user, pwd);
                                                                                                                    String query = "SELECT * FROM niveau WHERE id_dept=?";
                                                                                                                    PreparedStatement pstmt = conn.prepareStatement(query);
                                                                                                                    pstmt.setString(1, id_dept);
                                                                                                                    ResultSet rs = pstmt.executeQuery();

                                                                                                                    while (rs.next()) {
                                                                                                                        String id_niv = rs.getString("id_niv");
                                                                                                                        String nom_niv = rs.getString("nom_niv");
                                                                                                                        %>
												
														<option value="<%=id_niv%>" > <%=nom_niv%> </option>
                                                                                                                    <%}
                                                                                                                    } catch (Exception e) {
                                                                                                                            e.printStackTrace();
                                                                                                                        }%>
													</select>
												</div>
												<!-- /input-group -->
											</div>
										</div>

										<div class="form-group">
											<label class="control-label col-md-3">specialite</label>
											<div class="col-md-6 " id="specialite">
												<div class="input-group">
													<span class="input-group-addon">
													<i class="fa fa-adjust"></i>
													</span>
													<select  class="form-control select2me" data-placeholder="choisir specialite" required>
													<option value=""></option>		
													</select>
												</div>
												
												<!-- /input-group -->
											</div>
										</div>
										<div class="form-group">
													<label class="col-md-3 control-label">Nom de section</label>
													<div class="col-md-4">
														<input type="text" name="sec" class="form-control input-circle" placeholder="enter nom de section" autocomplete="off"  required>
														
													</div>
												</div>
										

										
                                                                                </div>
                                                                                <div class="form-actions">
												<div class="row">
													<div class="col-md-offset-3 col-md-9">
														<button type="submit" name="submit" class="btn btn-circle blue">Insérer</button>
													</div>
												</div>
											</div>
							</form>
							</div>
							
						</div>
					</div>
				
		</div>
	</div>
	<!-- END CONTENT -->
<!-- END CONTAINER -->


<%@include file="end.jsp" %>
<script>
	$(document).ready(function(){
		$(document).on("change","#Niveau", function(){
var id = this.value;
			$('#specialite').load( "ajax/get_spec.jsp?id="+id, function() {
});	
		
  });
});
</script>
</body>
<!-- END BODY -->
</html>