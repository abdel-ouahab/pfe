<%-- 
    Document   : etudiant
    Created on : Dec 28, 2023, 8:20:56 PM
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
    if(request.getParameter("id_niv") != null){
        id_niv = request.getParameter("id_niv");
    }
    if(request.getParameter("id_spec") != null){
        id_spec = request.getParameter("id_spec");
    }
%>

<!-- BEGIN CONTENT -->
	<div class="page-content-wrapper">
		<div class="page-content">
			
		
			<!-- BEGIN PAGE HEADER-->
			<h3 class="page-title">
                            <%
                                Connection conn = null;
                                Statement stmt = null;
                                ResultSet res = null;
                                ResultSet ss = null;
                                
                                String nom_niv = "";
                                String nom_ss = "";
                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    conn = DriverManager.getConnection(url, user, pwd);
                                    stmt = conn.createStatement();
                                    String query1 = "SELECT * FROM niveau WHERE id_niv = " + id_niv;
                                    res = stmt.executeQuery(query1);
                                    if (res.next()) {
                                        nom_niv = res.getString("nom_niv");

                                        String query2 = "SELECT * FROM specialite WHERE id_spec = " + id_spec;
                                        ss = stmt.executeQuery(query2);

                                        if (ss.next()) {
                                            nom_ss = ss.getString("nom_spec");
                                        }
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            %>

			Tableau des etudiants  <small><% out.print(nom_niv +" "+nom_ss);%></small>
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
						<a href="javascript:;">Etudiants</a>
						<i class="fa fa-angle-right"></i>
					</li>
					<li>
						<a href="#"><%=nom_niv%></a>
						<i class="fa fa-angle-right"></i>
					</li>
					<li>
						<a href="#"><%=nom_ss%></a>
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
										<!--<a href="import.php?action=impt&id_dept=<?php echo $id_dept.'&id_niv='.$id_nivv.'&id_specc='.$id_specc; ?>">
										<div class="btn-group">
										<button type="button" name="age"  class="btn blue-madison">
										importer EXEL  <i class="fa fa-cloud-download"></i>
											</button>
										</div>
										</a>-->
										
									</div>

									

								</div>
							</div>
							
							<table class="table table-striped table-hover table-bordered" id="sample_editable_1" >
							<thead>
							<tr>
								<th>
								Numero d'inscription
								</th>
								<th>
									 Nom
								</th>
								<th>
									 Prenom
								</th>
								<th>
								     Date de naissance
								</th>
								<th>
									 E-mail
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
                                                            try {
                                                                stmt = conn.createStatement();
                                                                String query = "SELECT * FROM etudiant WHERE id_niv='" + id_niv + "' AND id_dept='" + id_dept + "' AND id_spec='" + id_spec + "' ORDER BY nom";
                                                                res = stmt.executeQuery(query);

                                                                while (res.next()) {
                                                                    int id = res.getInt("id_etud");
                                                                    String num = res.getString("num_inscri");
                                                                    String nom = res.getString("nom");
                                                                    String prenom = res.getString("prenom");
                                                                    String date = res.getString("date");
                                                                    String email = res.getString("email");
                                                                    String password = res.getString("password");
                                                                    int id_sec = res.getInt("id_sec");

                                                                    Statement stmt1 = conn.createStatement();
                                                                    String query1 = "SELECT sec FROM section WHERE id_sec=" + id_sec;
                                                                    ResultSet res1 = stmt1.executeQuery(query1);
                                                                    String sec = "";
                                                                    if (res1.next()) {
                                                                        sec = res1.getString("sec");
                                                                    %>
                                                                        <tr>
                                                                            <td><%= num %></td>
                                                                            <td><%= nom %></td>
                                                                            <td><%= prenom %></td>
                                                                            <td><%= date %></td>
                                                                            <td><%= email %></td>
                                                                            <td><%= sec %></td>
                                                                            <td>
                                                                                <a class="btn btn-info" href="javascript:;">
                                                                                    <i class="fa fa-pencil"></i>
                                                                                </a>
                                                                                <button class="btn btn-large btn-danger" data-href="delete.jsp?id_niv=<%= id_niv %>&deleteid=<%= id %>&id_dept=<%= id_dept %>&id_spec=<%= id_spec %>" data-toggle="confirmation" data-placement="left" data-btn-ok-label="Oui" data-btn-cancel-label="Non" data-original-title="Vous ete sur ?" title="">
                                                                                    <i class="fa fa-trash-o"></i>
                                                                                </button>
                                                                            </td>
                                                                        </tr>
                                                                    <%
                                                                        res1.close();
                                                                        stmt1.close();
                                                                    }
                                                                }
                                                            } catch (Exception e) {
                                                                e.printStackTrace();
                                                            }
                                                        %>

							</table>
							<div class="table-toolbar">
								<div class="row">
									<div class="col-md-6">
										
									<button class="btn btn-large btn-danger" data-href="dell.php?id_niv=<?php echo $id_nivv ?>&id_dept=<?php echo $id_dept ?>&id_spec=<?php echo $id_specc ?>" data-toggle="confirmation" data-placement="right" data-btn-ok-label="Oui" data-btn-cancel-label="Non" data-original-title="Vous ete sur ?" title=""><i class="fa fa-trash-o"></i></button>
										
									</div>
									
								</div>
							</div>
						</div>
						
					</div>
					<!-- END EXAMPLE TABLE PORTLET-->
			






		</div>
	</di    <h4 class="modal-title">Ajouter Etudiant </h4>
v>
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
    <h4 class="modal-title">Ajouter Etudiant </h4>
   </div>
   <div class="modal-body">
    <form method="post" id="insert_form" action="../../Ajouter_etudiant?id_niv=<%=id_niv%>&id_dept=<%=id_dept%>&id_spec=<%=id_spec%>" >
	<label>Numero d'inscription</label>
	<input type="text" name="num" class="form-control input-circle" placeholder="Enter numero d'inscription" autocomplete="off" required>
	<br />
     <label>Nom</label>
	 <input type="text" name="nom" id="nom" class="form-control input-circle" placeholder="Enter Nom de l'etudiant" autocomplete="off" required>
     <br />
     <label>Prenom</label>
     <input type="text" name="prenom" id="prenom" class="form-control input-circle" placeholder="Enter Prenom de l'etudiant" autocomplete="off" required>
     <br />
	 <label>Date de naissance</label>
	 <input type="date" name="date" class="form-control input-circle" placeholder="YYYY-MM-DD" required>
	 <br />
	 <label>Section</label>
     <select name="section" id="section" class="form-control">
	 <%

        try {
            String query = "SELECT * FROM section WHERE id_spec='" + id_spec + "' AND id_niv='" + id_niv + "'";
            stmt = conn.createStatement();
            res = stmt.executeQuery(query);

            while (res.next()) {
                int id = res.getInt("id_sec");
                String sec = res.getString("sec");
    %>
                <option value="<%= id %>"><%= sec %></option>
    <%
            }
        } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (res != null) res.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    %>

     </select>
	 <br />
	 <div class="form-group">
			<label></label>
			<div class="input-group">
				<div class="icheck-list">
                                    <%if(!nom_niv.equals("Licence 1")){}%>
				<label>
                                <input type="checkbox" class="icheck" name="dette" value="1"> Dette </label>	
                                
                                <label>
                                <input type="checkbox" class="icheck" name="ajourne" value="1"> Ajourné </label>
				</div>
			</div>
			</div>
	 
     <input type="submit" name="submit" id="insert" value="Insert" class="btn btn-success"/>
    </form>
   </div>
   <div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
   </div>
  </div>
 </div>
</div>
