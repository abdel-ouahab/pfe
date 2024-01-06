<%-- 
    Document   : Delete_niv
    Created on : Jan 3, 2024, 3:58:27 PM
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
			Département  <small><%=nom_dept %></small>
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
						<a href="javascript:;">Supprimer niveau</a>
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
								<i class="fa fa-edit"></i>Supprimer niveau 
							</div>
							<div class="tools">
								<a href="javascript:;" class="collapse">
								</a>
								
							</div>
						</div>
						<div class="portlet-body">
							<div class="table-toolbar">
							<form  class="form-horizontal form-row-sepe" method="POST" action="../../Modifier_dept_del?id_dept=<%=id_dept %>">
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
                                                                            PreparedStatement ps_niv =null;
                                                                            ResultSet rs_niv =null;

                                                                            String id_niv ="";
                                                                            String nom_niv ="";
                                                                            try {
                                                                                Class.forName("com.mysql.cj.jdbc.Driver");
                                                                                Connection conn = DriverManager.getConnection(url, user, pwd);
                                                                                    ps_niv = conn.prepareStatement("SELECT * FROM `niveau` WHERE id_dept= ? ORDER BY nom_niv");
                                                                                    ps_niv.setString(1, id_dept);
                                                                                    rs_niv = ps_niv.executeQuery();
                                                                                   while (rs_niv.next()){
                                                                                        id_niv = rs_niv.getString("id_niv");
                                                                                        nom_niv = rs_niv.getString("nom_niv");

                                                                            %>

                                                                    <option value="<%=id_niv %>" ><%=nom_niv %></option>
                                                                        <%
                                                                            }
                                                                                } catch (Exception e) {
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

                                                                        <button type="submit" name="submit" class="btn btn-circle red">Supprimer</button>
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