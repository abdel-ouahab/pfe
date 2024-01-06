<%-- 
    Document   : Ajouter_controle_continu
    Created on : Jan 1, 2024, 1:28:41 PM
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
    
    int td = 0;
    int tp = 0;
    
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
            tp = resmod.getInt("TP");
            td = resmod.getInt("TD");
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
			<%=nom_mod %><small>   Ajouter (<% if(td==1){  out.print("TD");}%>  <% if(tp==1){  out.print("TP");}%>)</small>
			</h3>
			<div class="page-bar">
				<ul class="page-breadcrumb">
					<li>
						<i class="fa fa-home"></i>
						<a href="ens.php">ACCUEIL</a>
						<i class="fa fa-angle-right"></i>
					</li>
					<li>
						<a href="javascript:;">Ajouter (<% if(td==1){  out.print("TD");}%>  <% if(tp==1){  out.print("TP");}%>)</a>
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
											<i class="fa fa-plus"></i>Ajouter (<% if(td==1){  out.print("TD");}%>  <% if(tp==1){  out.print("TP");}%>)
										</div>
										<div class="tools">
											<a href="javascript:;" class="collapse">
											</a>
										</div>
									</div>
                                                                        <div class="portlet-body form">
										<!-- BEGIN FORM-->
										<form  class="form-horizontal" method="POST" enctype="multipart/form-data" action="../../Ajouter_control_continu?id_mod=<%=id_mod%>&id_niv=<%=id_niv%>&id_sec=<%=id_sec%>&id_sem=<%=id_sem%>">
											<div class="form-body">
                                                                                                <div class="form-group">
													<label class="col-md-3 control-label">numéro controle continu</label>
													<div class="col-md-4">
														<input type="number" name="nmr_cc" class="form-control input-circle" placeholder="Enter numéro de controle continu" autocomplete="off" required>
														
													</div>
												</div>
                                                                                                <div class="form-group">
													<label class="col-md-4 control-label">Type de controle continu</label>
													<div class="col-md-4">
                                                                                                        <div class="form-group form-md-radios">
                                                                                                        <label></label>
                                                                                                                                                            <% if(td==1){ %>
                                                                                                                <div class="md-radio-list">
                                                                                                                    <div class="md-radio has-success">
                                                                                                                        <input type="radio" id="radio9" name="type" value="TD"   class="md-radiobtn">
                                                                                                                        <label for="radio9">
                                                                                                                        <span></span>
                                                                                                                        <span class="check"></span>
                                                                                                                        <span class="box"></span>
                                                                                                                        TD</label>
                                                                                                                    </div>
                                                                                                                                                                                    <% }%>
                                                                                                                                                                                    <% if(tp==1){%>
                                                                                                                    <div class="md-radio has-error">
                                                                                                                        <input type="radio" id="radio10" name="type" value="TP"   class="md-radiobtn" >
                                                                                                                        <label for="radio10">
                                                                                                                        <span></span>
                                                                                                                        <span class="check"></span>
                                                                                                                        <span class="box"></span>
                                                                                                                        TP </label>
                                                                                                                    </div>
                                                                                                                                                                                    <% }%>
                                                                                                                </div>
                                                                                                            </div>
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