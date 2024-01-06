<%-- 
    Document   : Ajouter_cour
    Created on : Jan 1, 2024, 1:26:08 AM
    Author     : Abd Elouahab
--%>
<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@include file="head.jsp" %>
<%@ page import="java.sql.*" %>
<%
    String id_sem ="";
    String id_mod ="";
    
    String nom_mod = "";
    String nom = "";
    String prenom = "";
if (session.getAttribute("email")==null || session.getAttribute("enseignant") == null) {
        response.sendRedirect("../../index.jsp");
    }
    if(request.getParameter("id_niv") != null){
        id_niv = request.getParameter("id_niv");
    }
    if(request.getParameter("id_sec") != null){
        id_sec = request.getParameter("id_sec");
    }
    if(request.getParameter("id_sem") != null){
        id_sem = request.getParameter("id_sem");
    }
    if(request.getParameter("id_mod") != null){
        id_mod = request.getParameter("id_mod");
    }
    
    try {
        String sql = "SELECT * FROM enseignant WHERE email='" + email + "'";
        stmt = conn.createStatement();
        ResultSet res = stmt.executeQuery(sql);
        
        if (res.next()) {
            nom = res.getString("nom");
            prenom = res.getString("prenom");
        }

        String sqlmod = "SELECT * FROM module WHERE id_mod='" + id_mod + "'";
        ResultSet resmod = stmt.executeQuery(sqlmod);

        
        if (resmod.next()) {
            nom_mod = resmod.getString("nom_mod");
        }

        // Use id_ens, nom, prenom, nom_mod as needed
    } catch (Exception e) {
        e.printStackTrace();
    }
    
%>
<!-- BEGIN PAGE LEVEL STYLES -->
<link href="../../assets/global/plugins/jquery-file-upload/blueimp-gallery/blueimp-gallery.min.css" rel="stylesheet"/>
<link href="../../assets/global/plugins/jquery-file-upload/css/jquery.fileupload.css" rel="stylesheet"/>
<link href="../../assets/global/plugins/jquery-file-upload/css/jquery.fileupload-ui.css" rel="stylesheet"/>
<!-- END PAGE LEVEL STYLES -->
	
<div class="page-content-wrapper">
		<div class="page-content">
			
		
			<!-- BEGIN PAGE HEADER-->
			<h3 class="page-title">
			<%=nom_mod %><small>     Ajouter un cour</small>
			</h3>
			<div class="page-bar">
				<ul class="page-breadcrumb">
					<li>
						<i class="fa fa-home"></i>
						<a href="index.jsp">Accueil</a>
						<i class="fa fa-angle-right"></i>
					</li>
					<li>
						<a href="javascript:;">Ajouter un cour</a>
						</i>
					</li>
					
				</ul>
						
				
			</div>
			<!-- END PAGE HEADER-->
			<div class="tab-content">
							<div class="tab-pane active" id="tab_0">
								<div class="portlet box green">
									<div class="portlet-title">
										<div class="caption">
											<i class="fa fa-plus"></i>Ajouter un cour
										</div>
										<div class="tools">
											<a href="javascript:;" class="collapse">
											</a>
										</div>
									</div>
                                                                        <div class="portlet-body form">
										<!-- BEGIN FORM-->
										<form  class="form-horizontal" method="POST" enctype="multipart/form-data" action="../../Ajouter_cour?id_mod=<%=id_mod%>&id_niv=<%=id_niv%>&id_sec=<%=id_sec%>&id_sem=<%=id_sem%>">
											<div class="form-body">
                                                                                                <div class="form-group">
													<label class="col-md-3 control-label">nom_cour</label>
													<div class="col-md-4">
														<input type="text" name="nom_cour" class="form-control input-circle" placeholder="Enter Nom de cour" autocomplete="off" required>
														
													</div>
												</div>
                                                                                                <div class="form-group">
													<label class="col-md-3 control-label">descreption</label>
													<div class="col-md-4">
														<input type="text" name="descreption" class="form-control input-circle" placeholder="Enter le descreption" autocomplete="off" required>	
													</div>
												</div>
												
												<div class="form-group">
													<label class="col-md-3 control-label">Ajourter Fichier</label>
													<div class="col-md-4">
														<span class="btn green fileinput-button">
														<i class="fa fa-upload"></i>
														<span>
														Ajourter Fichier... </span>
														<input type="file" name="target_dir" accept=".doc,.pdf" required>
														</span>
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
										<!-- END FORM-->
										

			
		</div>
	</div>
	<!-- END CONTENT -->
<!-- END CONTAINER -->

<%@include file="end.jsp" %>
</body>
<!-- END BODY -->
</html>