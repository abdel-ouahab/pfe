<%-- 
    Document   : semestre
    Created on : Jan 2, 2024, 12:56:06 AM
    Author     : Abd Elouahab
--%>
<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@include file="head.jsp" %>
<%@ page import="java.sql.*" %>
<% 
if (session.getAttribute("email")==null || session.getAttribute("etudiant") == null) {
        response.sendRedirect("../../index.jsp");
    }
    String id_niv ="";
    String id_sec ="";
    String id_sem ="";
if(request.getParameter("id_niv") != null){
        id_niv = request.getParameter("id_niv");
    }
if(request.getParameter("id_sec") != null){
        id_sec = request.getParameter("id_sec");
    }
if(request.getParameter("id_sem") != null){
        id_sem = request.getParameter("id_sem");
    }
%>

<div class="page-content-wrapper">
		<div class="page-content">
			
		
			<!-- BEGIN PAGE HEADER-->
			<h3 class="page-title">
			Etudiant<small><% out.print(" "+nom +" " + prenom);%></small>
			</h3>
			<div class="page-bar">
				<ul class="page-breadcrumb">
					<li>
						<i class="fa fa-home"></i>
						<a href="index.jsp">Accueil</a>
						<i class="fa fa-angle-right"></i>
					</li>
					<li>
						<a href="javascript:;">Etudiant</a>
						</i>
					</li>
					
				</ul>
						
				
			</div>
			<!-- END PAGE HEADER-->
			<!-- BEGIN PAGE CONTENT-->
			<div class="row">
				<div class="col-md-12">
                                    <%
                                        int id_mod =0;
                                        int id_cour =0;
                                        int id_cc =0;
                                        int id_ens =0;
                                        
                                        String nom_mod = "";
                                        String tp ="";
                                        String td ="";
                                        
                                        String nom_cour = "";
                                        String descreption ="";
                                        String cours ="";
                                        
                                        String nmr_cc = "";
                                        String type ="";
                                        String target_dir ="";
                                        
                                        String email_ens ="";
                                        
                                        PreparedStatement pstmt =null;
                                        PreparedStatement pstmt_mod =null;
                                        PreparedStatement ps_cour =null;
                                        PreparedStatement ps_nc =null;
                                        PreparedStatement ps_cc =null;
                                        PreparedStatement ps_ncc =null;
                                        PreparedStatement ps_ccc =null;
                                        PreparedStatement ps_nccc =null;
                                        
                                        ResultSet rs =null;
                                        ResultSet rs_mod =null;
                                        ResultSet rs_cour =null;
                                        ResultSet rs_nc =null;
                                        ResultSet rs_cc =null;
                                        ResultSet rs_ncc =null;
                                        ResultSet rs_ccc =null;
                                        ResultSet rs_nccc =null;
                                        
                                        try {
                                     pstmt = conn.prepareStatement("SELECT * FROM programmation2,semestre,module where programmation2.id_etud="+id+" AND programmation2.id_mod=module.id_mod AND module.id_sem=semestre.id_sem AND semestre.id_sem="+id_sem+" AND programmation2.id_sec="+id_sec);
                                    
                                     rs = pstmt.executeQuery();
                                    while (rs.next()){
                                        id_mod = rs.getInt("id_mod");
                                         pstmt_mod = conn.prepareStatement("SELECT * FROM module where id_mod= ?");
                                        pstmt_mod.setInt(1, id_mod);
                                         rs_mod = pstmt_mod.executeQuery();
                                        if (rs_mod.next()){
                                             nom_mod = rs_mod.getString("nom_mod");
                                             tp = rs_mod.getString("TP");
                                             td = rs_mod.getString("TD");}
                                        
                                    %>
					<div class="portlet box blue">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-book"></i><%=nom_mod %>
							</div>
							<div class="tools">
								<a href="javascript:;" class="collapse">
								</a>
								
							</div>
							
						</div>
						
						<div class="portlet-body">
							<div class="table-toolbar">

								<div class="row">
									<div class="col-md-12">
										<h3>  Les cours </h3><br>
                                                                                <%
                                                                                 ps_cour = conn.prepareStatement("SELECT * FROM cour where id_mod= ?");
                                                                                ps_cour.setInt(1, id_mod);
                                                                                 rs_cour = ps_cour.executeQuery();
                                                                                while(rs_cour.next()){ 
                                                                                     id_cour =rs_cour.getInt("id_cour");
                                                                                     ps_nc = conn.prepareStatement("SELECT * FROM cour where id_cour= ?");
                                                                                    ps_nc.setInt(1, id_cour);
                                                                                     rs_nc = ps_nc.executeQuery();
                                                                                    if (rs_nc.next()){
                                                                                         nom_cour = rs_nc.getString("nom_cour");
                                                                                         descreption = rs_nc.getString("descreption");
                                                                                         cours = rs_nc.getString("target_dir");
                                                                                    
                                                                                %>
                                                                <div class="col-sm-6 col-md-3">
									<div class="thumbnail">
										<div class="caption">
											<h3><%=nom_cour %></h3>
											<p><%=descreption %> </p>
											<p>
											<a href="../Admin_dept/cours/<%=cours %>" target="_blanck" class="btn btn-sm green">
												<i class="fa fa-eye"></i></a>
											</p>
										</div>
									</div>
								</div>
								
									<% } } %>
								</div>

								<% if(("1".equals(td))||("1".equals(td))){ %>
								<div class="col-md-12">
									<h3>  Les conroles (<%if("1".equals(td)){  out.print("TD");} if(("1".equals(td))){  out.print("TP");} %>)</h3><br>
                                                                        <%
                                                                         ps_cc = conn.prepareStatement("SELECT * FROM `controle continu` where id_mod= ?");
                                                                        ps_cc.setInt(1, id_mod);
                                                                         rs_cc = ps_cc.executeQuery();
                                                                        while (rs_cc.next()){
                                                                             id_cc = rs_cc.getInt("id_cc");
                                                                             ps_ncc = conn.prepareStatement("SELECT * FROM `controle continu` where id_cc= ?");
                                                                            ps_ncc.setInt(1, id_cc);
                                                                             rs_ncc = ps_ncc.executeQuery();
                                                                            if(rs_ncc.next()){
                                                                                 nmr_cc = rs_ncc.getString("nmr_cc");
                                                                                 type = rs_ncc.getString("type");
                                                                                 target_dir = rs_ncc.getString("target_dir");
                                                                            
                                                                        %>
                                                                        <div class="col-sm-6 col-md-3">
									<div class="thumbnail">
										<div class="caption">
											<h3><%=type %> <%=nmr_cc %> </h3>
											<p>
											<a href="../Admin_dept/controle_continu/<%=target_dir %>" target="_blanck" class="btn btn-sm green">
												<i class="fa fa-eye"></i></a>
											</p>
										</div>
									</div>
								</div>
								
									<% } } %>
								</div>
								<% } %>
						</div>
                                                <form method="post" id="insert_form" action="commentaire.jsp">
							<input type="text" name="commentaire" id="nom" class="form-control" placeholder="envoyer email a enseignant" required  autocomplete="off"/>
							<br />
							<input type="submit" name="submit" id="submit" value="envoyer" class="btn btn-success" />
                                                        <%
                                                        
                                                         ps_ccc = conn.prepareStatement("SELECT id_ens FROM `programmation` where id_mod= ?");
                                                        ps_ccc.setInt(1, id_mod);
                                                         rs_ccc = ps_ccc.executeQuery();
                                                        if (rs_ccc.next()){
                                                             id_ens = rs_ccc.getInt("id_ens");
                                                             ps_nccc = conn.prepareStatement("SELECT email FROM `enseignant` where id_ens= ?");
                                                            ps_nccc.setInt(1, id_ens);
                                                             rs_nccc = ps_nccc.executeQuery();
                                                            if(rs_nccc.next()){
                                                                email_ens = rs_nccc.getString("email");}}
                                                                
                                                        %>
							<input type="hidden" name="email" value="<%=email_ens %>" >
						</form>
						 
					</div>
				</div>
			</div>
			<% }
                            } catch (Exception e) {
                                    e.printStackTrace();
                                } 
                        %>
			<!-- END EXAMPLE TABLE PORTLET-->
		</div>
	</div>
	<!-- END CONTENT -->
<!-- END CONTAINER -->

<%@include file="end.jsp" %>
</body>
<!-- END BODY -->
</html>