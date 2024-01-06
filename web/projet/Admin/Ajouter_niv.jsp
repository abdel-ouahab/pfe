<%-- 
    Document   : Ajouter_niv
    Created on : Jan 3, 2024, 3:57:20 PM
    Author     : Abd Elouahab
--%>
<%@page import="java.util.ArrayList"%>
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
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url, user, pwd);
        pstmt = conn.prepareStatement("SELECT * FROM `dept` WHERE id_dept= ?");
        pstmt.setString(1, id_dept);
        rs = pstmt.executeQuery();
       if (rs.next()){
            nom_dept = rs.getString("nom_dept");
       }
    } catch (Exception e) {
    }
%>

<!-- BEGIN CONTENT -->
	<div class="page-content-wrapper">
		<div class="page-content">
			
		
			<!-- BEGIN PAGE HEADER-->
			<h3 class="page-title">
			Département   <small><%=nom_dept %></small>
			</h3>
			<div class="page-bar">
				<ul class="page-breadcrumb">
					<li>
						<i class="fa fa-home"></i>
						<a href="index.jsp">Accueil</a>
						<i class="fa fa-angle-right"></i>
					</li>
					<li>
						<a href="table_dept.jsp">Département</a>
						<i class="fa fa-angle-right"></i>
					</li>
					<li>
						<a href="modifier_dept.jsp?id_dept=<%=id_dept %>">Modifier</a>
						<i class="fa fa-angle-right"></i>
					</li>
					<li>
						<a href="javascript:;">Ajouter niveau</a>
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
								<i class="fa fa-edit"></i>Ajouter niveau
							</div>
							<div class="tools">
								<a href="javascript:;" class="collapse">
								</a>
								
							</div>
						</div>
						<div class="portlet-body">
							<div class="table-toolbar">
							<form  class="form-horizontal form-row-sepe" method="POST" action="../../Modifier_dept_add?id_dept=<%=id_dept %>">
								<div class="form-body">
									
											
												
							<div class="form-group">
						    	<div class="form-group">
								
							    </div>
												
								<label class="col-md-3 control-label"></label>
                                                                                        <div class="col-md-6">
												<div class="input-group">
													<span class="input-group-addon">
													<i class="fa fa-bars"></i>
													</span>
													<select class="form-control select2me" name="niv" id="Niveau" data-placeholder="choisir Niveau" required>
                                                                                                                <option></option>
                                                                                                                <%
                                                                                                                    ArrayList<String> data = new ArrayList<>();
                                                                                                                    PreparedStatement ps_niv = null;
                                                                                                                    ResultSet rs_niv = null;

                                                                                                                    try {
                                                                                                                        Class.forName("com.mysql.cj.jdbc.Driver");
                                                                                                                        Connection conn = DriverManager.getConnection(url, user, pwd);
                                                                                                                        ps_niv = conn.prepareStatement("SELECT * FROM `niveau` WHERE id_dept=?");
                                                                                                                        ps_niv.setString(1, id_dept);
                                                                                                                        rs_niv = ps_niv.executeQuery();
                                                                                                                        while (rs_niv.next()) {
                                                                                                                            String nom_niv = rs_niv.getString("nom_niv");
                                                                                                                            data.add(nom_niv);
                                                                                                                        }

                                                                                                                        if (!data.contains("Licence 1")) {
                                                                                                                %>
                                                                                                                        <option value="Licence 1">Licence 1</option>
                                                                                                                <%
                                                                                                                        }
                                                                                                                        if (!data.contains("Licence 2")) {
                                                                                                                %>
                                                                                                                        <option value="Licence 2">Licence 2</option>
                                                                                                                <%
                                                                                                                        }
                                                                                                                        if (!data.contains("Licence 3")) {
                                                                                                                %>
                                                                                                                        <option value="Licence 3">Licence 3</option>
                                                                                                                <%
                                                                                                                        }
                                                                                                                            if (!data.contains("Master 1")) {
                                                                                                                %>
                                                                                                                        <option value="Master 1">Master 1</option>
                                                                                                                <%
                                                                                                                        }
                                                                                                                        if (!data.contains("Master 2")) {
                                                                                                                %>
                                                                                                                        <option value="Master 2">Master 2</option>
                                                                                                                <%
                                                                                                                        }
                                                                                                                        // Repeat similar checks for other options (Licence 3, Master 1, Master 2)

                                                                                                                    } catch (SQLException e) {
                                                                                                                        e.printStackTrace();
                                                                                                                        // Handle SQL exception
                                                                                                                    } finally {
                                                                                                                        // Close resources in the finally block
                                                                                                                        if (rs != null) {
                                                                                                                            try {
                                                                                                                                rs.close();
                                                                                                                            } catch (SQLException e) {
                                                                                                                                e.printStackTrace();
                                                                                                                                // Handle exception
                                                                                                                            }
                                                                                                                        }
                                                                                                                        if (pstmt != null) {
                                                                                                                            try {
                                                                                                                                pstmt.close();
                                                                                                                            } catch (SQLException e) {
                                                                                                                                e.printStackTrace();
                                                                                                                                // Handle exception
                                                                                                                            }
                                                                                                                        }
                                                                                                                    }
                                                                                                                %>
                                                                                                            </select>

												</div>
												<!-- /input-group -->
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
					<!-- END EXAMPLE TABLE PORTLET-->
		</div>
	</div>
	<!-- END CONTENT -->
<!-- END CONTAINER -->

<%@include file="end.jsp" %>
</body>
<!-- END BODY -->
</html>