<%-- 
    Document   : modifier_password
    Created on : Jan 5, 2024, 12:23:47 AM
    Author     : Abd Elouahab
--%>
<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@include file="head.jsp" %>
<%
if (session.getAttribute("email")==null || session.getAttribute("etudiant") == null) {
        response.sendRedirect("../../index.jsp");
    }
%>

<!-- BEGIN CONTENT -->
	<div class="page-content-wrapper">
		<div class="page-content">
            <!-- BEGIN PAGE HEADER-->
        <h3 class="page-title">
		Modifier etudiant 
			</h3>
                        <div id="response" class="<% if(request.getParameter("type") != null) {
                            out.print(request.getParameter("type") +" display-block");}%>">
                             <%if(request.getParameter("message") != null) { out.print(request.getParameter("message"));}%></div>
                        
			<div class="page-bar">
				<ul class="page-breadcrumb">
					<li>
						<i class="fa fa-home"></i>
                                                <a href="index.jsp">Accueil</a>
					</li>
					
					
				</ul>
                                </div>
                                                    <div class="tab-content">
							<div class="tab-pane active" id="tab_0">
								<div class="portlet box green">
									<div class="portlet-title">
										<div class="caption">
											<i class="fa fa-edit "></i>Modifier le mot de passe
										</div>
										<div class="tools">
											<a href="javascript:;" class="collapse">
											</a>
										</div>
									</div>
                                                                            <div class="portlet-body form">
										<!-- BEGIN FORM-->
										<form  class="form-horizontal" method="POST" action="../../modifier_password_etu?id=<%=id %>">
											<div class="form-body">
                                                                                                <div class="form-group">
													<label class="col-md-3 control-label">Ancien mot de passe</label>
													<div class="col-md-4">
														<input type="password" name="expass" class="form-control input-circle" placeholder="Enter l'ancien mot de passe"  required>
														
													</div>
												</div>
                                                                                                <div class="form-group">
													<label class="col-md-3 control-label">Nouvel mot de passe</label>
													<div class="col-md-4">
														<input type="password" name="newpass1" class="form-control input-circle" placeholder="Enter le nouvel mot de passe "  required>	
													</div>
												</div>
												 <div class="form-group">
													<label class="col-md-3 control-label">Confirmer le mot de passe</label>
													<div class="col-md-4">
														<input type="password" name="newpass2" class="form-control input-circle" placeholder="Confirmer le nouvel mot de passe "  required>	
													</div>
												</div>
												
											</div>
											<div class="form-actions">
												<div class="row">
													<div class="col-md-offset-3 col-md-9">
														<button type="submit" name="submit" class="btn btn-circle blue">Modifer</button>
													</div>
												</div>
											</div>
										</form>
										<!-- END FORM-->
			
		</div>
	</div>
	<!-- END CONTENT -->
<!-- END CONTAINER -->
<%@include file="end.jsp" %>
</body>
<!-- END BODY -->
</html>
