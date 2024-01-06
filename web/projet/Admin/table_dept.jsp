<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@include file="head.jsp" %>
<%
if (session.getAttribute("email")==null || session.getAttribute("admin") == null || session.getAttribute("admin_p") == null) {
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
			Tableau des Dépatements
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
						<a href="javascript:;">Dépatements</a>
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
										
										<div class="btn-group">
											<button type="button" name="age" id="age" data-toggle="modal" data-target="#add_data_Modal" class="btn green">
											Ajouter <i class="fa fa-plus"></i>
											</button>
										</div>
										
									</div>
									
								</div>
							</div>
							<table class="table table-striped table-hover table-bordered" id="sample_editable_1">
							<thead>
							<tr>
								<th>
                                                                        faculte
								</th>
								<th>
                                                                        D`epartement
								</th>
								<th>
                                                                        E-mail
								</th>
								<th>
                                                                        Telephone
								</th>
								<th>
								</th>
							</tr>
							</thead>
							<tbody>
							<%
                                                            try {
                                                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                                                    Connection con = DriverManager.getConnection(url, user, pwd);
                                                                    PreparedStatement pst=con.prepareStatement("SELECT * FROM `dept` ORDER BY id_fac");
                                                                    ResultSet rs = pst.executeQuery();
                                                                    while(rs.next()){
                                                                        String id_dept = rs.getString(1); // id_dept
                                                                        String id_fac =rs.getString(2); // id_fact
                                                                        String nom_dept = rs.getString(3); // nom_dept
                                                                        String email = rs.getString(4); //email
                                                                        String telephone = rs.getString(5); //telephone
                                                                        PreparedStatement pst_fac=con.prepareStatement("SELECT * FROM faculte WHERE id_fac="+id_fac);
                                                                        ResultSet rs_fac = pst_fac.executeQuery();
                                                                        rs_fac.next();
                                                                        String nom_fac =rs_fac.getString(3); // nom_fac
                                                                        
                                                                        
                                                        %>
                                                        <tr>
								  <td>
                                                                        <%=nom_fac%>
								  </td>
								  <td>
                                                                        <%=nom_dept%>
								  </td>
								  <td>
                                                                        <%=email%>
								  </td>
								  <td>
                                                                        <%=telephone%>
								  </td>
								  <td>
									  
									  <a class="btn btn-info"  href="modifier_dept.jsp?id_dept=<%=id_dept %>">
                  						<i class="fa fa-pencil"></i> </a>
									  
									 
									  
                                                                <button class="btn btn-large btn-danger" data-href="../../Delete_dept?id_dept=<%=id_dept %>" data-toggle="confirmation" data-placement="left" data-btn-ok-label="Oui" data-btn-cancel-label="Non" data-original-title="Vous ete sur ?" title=""><i class="fa fa-trash-o"></i></button>
								  </td>
							  </tr>
                                                        <%
                                                            }
                                                            con.close();
                                                            }catch(Exception e) {
                                                            System.out.print(e);
                                                            out.print(e);
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
<script>
function Supprimer() {
	confirm("êtes-vous sur ?");
}
</script>
<%@include file="end.jsp" %>
</body>
<!-- END BODY -->
</html>
<div id="add_data_Modal" class="modal fade">
 <div class="modal-dialog">
  <div class="modal-content">
   <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal"></button>
    <h4 class="modal-title">Ajouter D`epartement</h4>
   </div>
   <div class="modal-body">
    <form method="post" id="insert_form" action="../../Ajouter_dept" >
	<div class="input-group">
		<span class="input-group-addon">
		<i class="fa fa-book"></i>
		</span>
     <select name="faculte" id="section" class="form-control" data-placeholder="choisir faculte">
	 <%
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection(url, user, pwd);
                PreparedStatement pst_fac=con.prepareStatement("SELECT * FROM `faculte`");
                ResultSet rs_fac = pst_fac.executeQuery();
                while(rs_fac.next()){
                    String nom_fac = rs_fac.getString(3); // nom_fac
                    String id_fac =rs_fac.getString(1); // id_fact
         %>
            <option value="<%=id_fac %>" ><%=nom_fac %></option>
         <%
            }
            rs_fac.close();
            pst_fac.close();
            con.close();
            
         %>
     </select>
	</div>
	 <br />
     <label>Nom de dept</label>
	 <input type="text" name="nom" id="nom" class="form-control input-circle" placeholder="Enter Nom de d?epartement" autocomplete="off" required>
     <br />
     <label>E-mail</label>
     <input type="email" name="email" id="prenom" class="form-control input-circle" placeholder="Enter Prenom de l'enseignant" autocomplete="off"  required>
     <br />
	 <label>Telephone</label>
     <input type="number" name="telephone" id="prenom" class="form-control input-circle" placeholder="enter numéro telephone" autocomplete="off" required>
     <br />
	 <label>Address</label>
     <input type="text" name="add" id="prenom" class="form-control input-circle" placeholder="enter l'address" autocomplete="off" required>
     <br />
	 <div class="input-group">
		<span class="input-group-addon">
		<i class="fa fa-book"></i>
		</span>
		<select name="niv" class="form-control select2me"  data-placeholder="choisir niveau" multiple="multiple" multiple required>
			
		<option value="Licence 1" >Licence 1</option>
		<option value="Licence 2" >Licence 2</option>
		<option value="Licence 3" >Licence 3</option>
		<option value="Master 1" >Master 1</option>
		<option value="Master 2" >Master 2</option>	
		</select>
</div><br />
     <input type="submit" name="submit" id="insert" value="Insérer" class="btn btn-success"/>

    </form>
   </div>
   <div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
   </div>
  </div>
 </div>
</div>

