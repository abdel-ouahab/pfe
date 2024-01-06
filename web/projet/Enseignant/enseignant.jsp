<%-- 
    Document   : enseignant
    Created on : Dec 31, 2023, 11:49:21 PM
    Author     : Abd Elouahab
--%>
<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@include file="head.jsp" %>
<%@ page import="java.sql.*" %>
<%
    String id_sem ="";
if (session.getAttribute("email")==null || session.getAttribute("enseignant") == null) {
        response.sendRedirect("../../index.jsp");
    }
    if(session.getAttribute("id_dept") != null){
        id_dept = session.getAttribute("id_dept").toString();
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

    ResultSet res = null;
    ResultSet res1 = null;
    ResultSet res12 = null;
    ResultSet res13 = null;
    
    String nom = "";
    String prenom = "";
    String nom_s = "";
    String nom_v = "";
    String nom_n = "";

    try {
        

        String sql = "SELECT * FROM enseignant WHERE email='" + email + "'";
        stmt = conn.createStatement();
        res = stmt.executeQuery(sql);

        if (res.next()) {
            nom = res.getString("nom");
            prenom = res.getString("prenom");
        }

        String sql1 = "SELECT * FROM semestre WHERE id_sem=" + id_sem;
        res1 = stmt.executeQuery(sql1);
        
        if (res1.next()) {
            nom_s = res1.getString("sem");
        }

        String sql12 = "SELECT * FROM section WHERE id_sec=" + id_sec;
        res12 = stmt.executeQuery(sql12);
        if (res12.next()) {
            nom_v = res12.getString("sec");
        }

        String sql13 = "SELECT * FROM niveau WHERE id_niv=" + id_niv;
        res13 = stmt.executeQuery(sql13);
        
        if (res13.next()) {
            nom_n = res13.getString("nom_niv");
        }

    } catch (Exception e) {
        e.printStackTrace();
    } 

%>

<div class="page-content-wrapper">
		<div class="page-content">
			
		
			<!-- BEGIN PAGE HEADER-->
			<h3 class="page-title">
			<%=nom_n%><small><% out.print(" "+nom_s+" -->Section "+nom_v);%></small>
			</h3>
                        <div id="response" class="<% if(request.getParameter("type") != null) {
                            out.print(request.getParameter("type") +" display-block");}%>">
                             <%if(request.getParameter("message") != null) { out.print(request.getParameter("message"));}%></div>
                        
			<div class="page-bar">
				<ul class="page-breadcrumb">
					<li>
						<i class="fa fa-home"></i>
						<a href="index.jsp">Accueil</a>
						<i class="fa fa-angle-right"></i>
					</li>
					<li>
						<a href="javascript:;"></a>
						</i>
					</li>
					
				</ul>
						
				
			</div>
			<!-- END PAGE HEADER-->
			<!-- BEGIN PAGE CONTENT-->
			<div class="row">
				<div class="col-md-12">

					<!-- BEGIN EXAMPLE TABLE PORTLET-->
					<%
                                                
                                                String nom_mod = "";
                                                int tp = 0;
                                                int td = 0;
                                                try {

                                                    String sqlmod = "SELECT * FROM programmation,semestre,module WHERE programmation.id_ens=" + id_ens + " AND programmation.id_mod=module.id_mod AND module.id_sem=semestre.id_sem AND semestre.id_sem=" + id_sem + " AND programmation.id_sec=" + id_sec;
                                                    Statement stmt1 = conn.createStatement();
                                                    ResultSet resmod = stmt1.executeQuery(sqlmod);

                                                    while (resmod.next()) {
                                                        int id_mod = resmod.getInt("id_mod");
                                                        String sqlmod_nom = "SELECT * FROM module WHERE id_mod=" + id_mod;
                                                        Statement stmt_mod = conn.createStatement();
                                                        ResultSet resmod_nom = stmt_mod.executeQuery(sqlmod_nom);

                                                        
                                                        if (resmod_nom.next()) {
                                                            nom_mod = resmod_nom.getString("nom_mod");
                                                            tp = resmod_nom.getInt("TP");
                                                            td = resmod_nom.getInt("TD");
                                                        }
                                            %>

                                        <div class="portlet box blue">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-book"></i><%=nom_mod%>
							</div>
							<div class="tools">
								<a href="javascript:;" class="collapse">
								</a>
								
							</div>
						</div>
						
						<div class="portlet-body">
							<div class="table-toolbar">
							<div class="col-md-6">
										<a href="Ajouter_cour.jsp?id_mod=<%=id_mod %>&id_niv=<%=id_niv %>&id_sec=<%=id_sec %>&id_sem=<%=id_sem %>">
										<div class="btn-group">
										<button type="button" name="age"  class="btn green">
										Ajouter Cour  <i class="fa fa-plus"></i>
											</button>
										</div>
										</a>
                                                                                <% if((td==1)||(tp==1)){%>
										<a href="Ajouter_controle_continu.jsp?id_mod=<%=id_mod %>&id_niv=<%=id_niv %>&id_sec=<%=id_sec %>&id_sem=<%=id_sem %>">
										<div class="btn-group">
										<button type="button" name="age"  class="btn green">
										Ajouter controle continu  <i class="fa fa-plus"></i>
											</button>
										</div>
										</a>
										<% }%>
									</div>

								<div class="row">
									<div class="col-md-12">
										<h3>  Les cours </h3><br>

                                                                                <%
                                                                                String sqlcour = "SELECT * FROM cour WHERE id_mod=" + id_mod;
                                                                                Statement stmt_cour = conn.createStatement();
                                                                                ResultSet rescour = stmt_cour.executeQuery(sqlcour);

                                                                                while (rescour.next()) {
                                                                                    int id_cour = rescour.getInt("id_cour");
                                                                                    String sqlcour_nom = "SELECT * FROM cour WHERE id_cour=" + id_cour;
                                                                                    Statement stmt_c = conn.createStatement();
                                                                                    ResultSet rescour_nom = stmt_c.executeQuery(sqlcour_nom);

                                                                                    String nom_cour = "";
                                                                                    String description = "";
                                                                                    String cours = "";
                                                                                    if (rescour_nom.next()) {
                                                                                        nom_cour = rescour_nom.getString("nom_cour");
                                                                                        description = rescour_nom.getString("descreption");
                                                                                        cours = rescour_nom.getString("target_dir");
                                                                                    }
                                                                                %>
									
									
									<div class="col-sm-6 col-md-3">
									<div class="thumbnail">
										<div class="caption">
											<h3><%=nom_cour%></h3>
											<p><%=description%> </p>
											<p>
												<a href="../../Delete_cour?id_cour=<%=id_cour %>&id_niv=<%=id_niv %>&id_sec=<%=id_sec %>&id_sem=<%=id_sem %>" class="btn btn-sm red">
												<i class="fa fa-trash-o"></i></a>
												<a href="../Admin_dept/cours/<%=cours %>" target="_blanck" class="btn btn-sm green">
												<i class="fa fa-eye"></i></a>
												<a href="javascript:;" class="btn btn-sm blue">
												<i class="fa fa-edit"></i></a>
												
											</p>
										</div>
									</div>
								</div>
								
									<% }%>
								</div>

								<% if((td==1)||(tp==1)){ %>
								<div class="col-md-12">
									<h3>  Les conroles (<% if(td==1){  out.print("TD");}%>  <% if(tp==1){  out.print("TP");}%>) </h3><br>
									<%
                                                                                    String sqlcc = "SELECT * FROM `controle continu` WHERE id_mod=" + id_mod;
                                                                                    Statement stmt_cc = conn.createStatement();
                                                                                    ResultSet rescc = stmt_cc.executeQuery(sqlcc);

                                                                                    while (rescc.next()) {
                                                                                        int id_cc = rescc.getInt("id_cc");
                                                                                        String sqlcc_nom = "SELECT * FROM `controle continu` WHERE id_cc=" + id_cc;
                                                                                        Statement stmt_ccc = conn.createStatement();
                                                                                        ResultSet rescc_nom = stmt_ccc.executeQuery(sqlcc_nom);

                                                                                        String nmr_cc = "";
                                                                                        String type_cc = "";
                                                                                        String cc = "";
                                                                                        if (rescc_nom.next()) {
                                                                                            nmr_cc = rescc_nom.getString("nmr_cc");
                                                                                            type_cc = rescc_nom.getString("type");
                                                                                            cc = rescc_nom.getString("target_dir");
                                                                                        }
                                                                            
											%>
									
									
									<div class="col-sm-6 col-md-3">
									<div class="thumbnail">
										<div class="caption">
											<h3><% out.print("La fiche "+ type_cc);%> <%=nmr_cc%> </h3>
											<p>
												<a href="../../Delete_control_continu?id_cc=<%=id_cc %>&id_niv=<%=id_niv %>&id_sec=<%=id_sec %>&id_sem=<%=id_sem %>" class="btn btn-sm red">
												<i class="fa fa-trash-o"></i></a>
												<a href="../Admin_dept/controle_continu/<?php echo $cc; ?>" target="_blanck" class="btn btn-sm green">
												<i class="fa fa-eye"></i></a>
												<a href="javascript:;"  class="btn btn-sm blue">
												<i class="fa fa-edit"></i></a>
												
											</p>
								
										</div>
									</div>
								</div>
								
									<% }%>
									
								</div>
								<% }%>



									

						</div>
					</div>
				</div>
			</div>
			<%
                        }
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