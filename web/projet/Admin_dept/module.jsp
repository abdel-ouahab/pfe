<%-- 
    Document   : module
    Created on : Dec 29, 2023, 10:29:09 PM
    Author     : Abd Elouahab
--%>
<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@include file="head.jsp" %>
<%
    String id_spec ="";
    String id_niv ="";
if (session.getAttribute("email")==null || session.getAttribute("admin") == null) {
        response.sendRedirect("../../index.jsp");
    }
%>
<!-- BEGIN CONTENT -->
	<div class="page-content-wrapper">
		<div class="page-content">
			
		
			<!-- BEGIN PAGE HEADER-->
			<h3 class="page-title">
			Tableau des Modules  <small></small>
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
						<a href="javascript:;">Module</a>
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
										
										<div class="btn-group">
										<button type="button" name="age" id="age" data-toggle="modal" data-target="#add_data_Modal" class="btn green">
										Ajouter  <i class="fa fa-plus"></i>
											</button>
										</div>
										
									</div>
									
								</div>
							</div>
							<table class="table table-striped table-hover table-bordered" id="sample_editable_1">
							<thead>
							<tr>
								<th>
									 Nom de module
								</th>
								<th>
									 niveau 
								</th>
								<th>
									 semestre
								</th>
								<th>
								     specialite
								</th>
								<th>
									 TP 
								</th>
								<th>
									 TD
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
                                                                String query = "SELECT * FROM module WHERE id_dept='" + id_dept + "' ORDER BY id_sem";
                                                                stmt = conn.createStatement();
                                                                rs = stmt.executeQuery(query);

                                                                while (rs.next()) {
                                                                    String id = rs.getString("id_mod");
                                                                    String nom = rs.getString("nom_mod");
                                                                    String id_sem = rs.getString("id_sem");
                                                                    String tp = rs.getString("TP");
                                                                    String td = rs.getString("TD");

                                                                    PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM semestre where id_sem=?");
                                                                    ps1.setString(1, id_sem);
                                                                    ResultSet rs1 = ps1.executeQuery();
                                                                    rs1.next();

                                                                    String sem = rs1.getString("sem");
                                                                    String id_nivv = rs1.getString("id_niv");
                                                                    String id_specc = rs1.getString("id_spec");

                                                                    PreparedStatement ps3 = conn.prepareStatement("SELECT * FROM specialite where id_spec=?");
                                                                    ps3.setString(1, id_specc);
                                                                    ResultSet rs3 = ps3.executeQuery();
                                                                    rs3.next();

                                                                    String nom_specc = (rs3 != null) ? rs3.getString("nom_spec") : "<i class='glyphicon glyphicon-remove'></i>";

                                                                    PreparedStatement ps2 = conn.prepareStatement("SELECT * FROM niveau where id_niv=?");
                                                                    ps2.setString(1, id_nivv);
                                                                    ResultSet rs2 = ps2.executeQuery();
                                                                    rs2.next();

                                                                    String niv = rs2.getString("nom_niv");
                                                                    String tp_i = (tp.equals("0")) ? "<i class='glyphicon glyphicon-remove'></i>" : "<i class='fa fa-check'></i>";
                                                                    String td_i = (td.equals("0")) ? "<i class='glyphicon glyphicon-remove'></i>" : "<i class='fa fa-check'></i>";

                                                                    out.println("<tr>");
                                                                    out.println("<td>" + nom + "</td>");
                                                                    out.println("<td>" + niv + "</td>");
                                                                    out.println("<td>" + sem + "</td>");
                                                                    out.println("<td>" + nom_specc + "</td>");
                                                                    out.println("<td>" + tp_i + "</td>");
                                                                    out.println("<td>" + td_i + "</td>");
                                                                    out.println("<td>");
                                                                    out.println("<a class='btn btn-info' href='javascript:;'>");
                                                                    out.println("<i class='fa fa-pencil'></i> </a>");
                                                                    out.println("<button class='btn btn-large btn-danger' data-href='../../Delete_module?deleteid=" + id + "&id_dept=" + id_dept + "' data-toggle='confirmation' data-placement='left' data-btn-ok-label='Oui' data-btn-cancel-label='Non' data-original-title='Vous ete sur ?' title=''>");
                                                                    out.println("<i class='fa fa-trash-o'></i></button>");
                                                                    out.println("</td>");
                                                                    out.println("</tr>");
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
<div id="add_data_Modal" class="modal fade">
 <div class="modal-dialog">
  <div class="modal-content">
   <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal">&times;</button>
    <h4 class="modal-title">Ajouter Module</h4>
   </div>
   <div class="modal-body">
    <form method="post" id="insert_form" action="../../Ajouter_module?id_dept=<%=id_dept%>">
     <label>Enter le nom de module</label>
     <input type="text" name="nom" id="nom" class="form-control" placeholder="Enter nom de module" autocomplete="off" required />
     <br />
     <label>Semestre</label>
     <select name="semestre" id="semestre" class="form-control" data-placeholder="choisir semestre" required>
	<%

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, pwd);

                String query = "SELECT * FROM semestre WHERE id_dept='" + id_dept + "'";
                stmt = conn.createStatement();
                rs = stmt.executeQuery(query);

                while (rs.next()) {
                    String id = rs.getString("id_sem");
                    String sem = rs.getString("sem");
                    String id_nivv = rs.getString("id_niv");
                    String id_spe = rs.getString("id_spec");

                    PreparedStatement ps2 = conn.prepareStatement("SELECT * FROM specialite WHERE id_spec=?");
                    ps2.setString(1, id_spe);
                    ResultSet rs2 = ps2.executeQuery();
                    rs2.next();

                    String nom_spec = (rs2 != null) ? rs2.getString("nom_spec") : null;

                    PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM niveau WHERE id_niv=?");
                    ps1.setString(1, id_nivv);
                    ResultSet rs1 = ps1.executeQuery();
                    rs1.next();

                    String nom_n = rs1.getString("nom_niv");

                    out.println("<option value='" + id + "'>" + sem + "-->" + nom_n);
                    if (nom_spec != null) {
                        out.println("-->" + nom_spec);
                    }
                    out.println("</option>");
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
  
     </select>
	 <br />
	 <div class="form-group">
			<div class="input-group">
				<div class="icheck-list">
					<label>
					<input type="checkbox" class="icheck" name="tp" value="1"> TP </label>
					<label>
					<input type="checkbox" class="icheck" name="td" value="1"> TD </label>
					<label>
				</div>
			</div>
			</div>
     <input type="submit" name="submit" id="submit" value="Insérer" class="btn btn-success" />

    </form>
   </div>
   <div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
   </div>
  </div>
 </div>
</div>