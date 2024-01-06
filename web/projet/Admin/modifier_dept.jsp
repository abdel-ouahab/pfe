<%-- 
    Document   : modifier_dept
    Created on : Jan 3, 2024, 3:32:45 PM
    Author     : Abd Elouahab
--%>
<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@include file="head.jsp" %>
<%
    String id_dept ="";
if (session.getAttribute("email")==null || session.getAttribute("admin") == null || session.getAttribute("admin_p") == null) {
        response.sendRedirect("../../index.jsp");
    }
if(request.getParameter("id_dept") != null){
        id_dept = request.getParameter("id_dept");
    }
PreparedStatement pstmt =null;
ResultSet rs =null;

String nom_dept ="";
String telephone ="";
String email ="";
String add_dept ="";
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url, user, pwd);
        pstmt = conn.prepareStatement("SELECT * FROM `dept` WHERE id_dept= ?");
        pstmt.setString(1, id_dept);
        rs = pstmt.executeQuery();
       if (rs.next()){
            nom_dept = rs.getString("nom_dept");
            telephone = rs.getString("telephone");
            email = rs.getString("email");
            add_dept = rs.getString("add_dept");
           
       }
    } catch (Exception e) {
    }
%>
<!-- BEGIN CONTENT -->
	<div class="page-content-wrapper">
		<div class="page-content">
			
		
			<!-- BEGIN PAGE HEADER-->
			<h3 class="page-title">
			Dépatement  <small><%=nom_dept %></small>
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
						<a href="table_dept.jsp">Dépatements</a>
						<i class="fa fa-angle-right"></i>
					</li>
					<li>
						<a href="javascript:;">Modifier</a>
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
								<i class="fa fa-edit"></i>Modifier Dépatement <%=nom_dept %>
							</div>
							<div class="tools">
								<a href="javascript:;" class="collapse">
								</a>
								
							</div>
						</div>
						<div class="portlet-body">
							<div class="table-toolbar">
							<form  class="form-horizontal form-row-sepe" method="POST" action="../../Modifier_dept?id_dept=<%=id_dept %>">
								<div class="form-body">
									
											
												
							<div class="form-group">
						    	<div class="form-group">
								
								<h3 class="col-md-5 control-label text-primary">  </h3>
								</div>
							</div>	
                                                                <%
                                                                PreparedStatement ps_niv =null;
                                                                ResultSet rs_niv =null;

                                                                String nom_niv ="";
                                                                try {
                                                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                                                    Connection conn = DriverManager.getConnection(url, user, pwd);
                                                                        ps_niv = conn.prepareStatement("SELECT nom_niv FROM `niveau` WHERE id_dept="+id_dept+" ORDER BY nom_niv");
                                                                        
                                                                        rs_niv = ps_niv.executeQuery();
                                                                       while (rs_niv.next()){
                                                                            nom_niv = rs_niv.getString("nom_niv");

                                                                     
                                                                %>
							<div class="form-group">
								<div class="form-group">
								
								<h3 class="col-md-5 control-label"> <%=nom_niv %> </h3>
								</div>
							</div>
							<%
                                                                }
                                                                    } catch (Exception e) {
                                                                    }
                                                        %>
												
											
							     	<div class="form-group">
								    	<div class="form-group">
                                                                                                <label class="col-md-3 control-label">Nom de Département </label>
												<div class="col-md-4">
												<input type="text" name="nom" class="form-control input-circle" placeholder="enter nom de section" value="<%=nom_dept %>" autocomplete="off"  required>
												</div>
											</div>										
								        
                                                                                        <div class="form-group">
                                                                                                <label class="col-md-3 control-label">Telephone</label>
												<div class="col-md-4">
												<input type="number" name="telephone" class="form-control input-circle" placeholder="Telephone" value="<%=telephone %>" autocomplete="off"  required>
												</div>
											</div>	
                                                                                                <div class="form-group">
                                                                                                <label class="col-md-3 control-label">email</label>
												<div class="col-md-4">
												<input type="email" name="email" class="form-control input-circle" placeholder="Telephone" value="<%=email %>" autocomplete="off"  required>
												</div>
											</div>	
                                                                                                <div class="form-group">
                                                                                                <label class="col-md-3 control-label">Address</label>
												<div class="col-md-4">
												<input type="text" name="add_dept" class="form-control input-circle" placeholder="Telephone" value="<%=add_dept %>" autocomplete="off"  required>
												</div>
											</div>	
                                                                                </div>
								        </div>
                                    </div>
									
									
							<div class="form-actions">
                                <div class="row">
                                    <div class="col-md-offset-3 col-md-9">
									    <label> &nbsp&nbsp </label>
										<a href="Ajouter_niv.jsp?id_dept=<%=id_dept %>">
										<div class="btn-group">
										<button type="button" name="age"  class="btn btn-success">
										Ajouter niveau  <i class="fa fa-plus"></i>
											</button>
										</div>
										</a>
										<label> &nbsp&nbsp&nbsp </label>
										<a href="Delete_niv.jsp?id_dept=<%=id_dept %>">
										<div class="btn-group">
										<button type="button" name="age"  class="btn red">
										Supprimer niveau  <i class="fa fa-minus"></i>
											</button>
										</div>
										</a>
										<br />
										<br />
										<button type="submit" name="submit" class="btn btn-circle blue">Modifier</button>
                                    </div>
                                </div>
                            </div>
							
						</form>
							
							
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