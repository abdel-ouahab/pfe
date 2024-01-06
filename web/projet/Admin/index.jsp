<%-- 
    Document   : index
    Created on : Dec 23, 2023, 11:07:19 AM
    Author     : Abd Elouahab
--%>
<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@include file="head.jsp" %>
<%
if (session.getAttribute("email")==null || session.getAttribute("admin") == null || session.getAttribute("admin_p") == null) {
        response.sendRedirect("../../index.jsp");
    }
   	int number_dept = 0;
        int number_ens = 0;
        int number_etu = 0;
        int number_module = 0;
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, user, pwd);
                //dept
		PreparedStatement pst=con.prepareStatement("SELECT COUNT(*) FROM dept");
		ResultSet rs = pst.executeQuery();
		rs.next();
		number_dept = rs.getInt(1);
		rs.close();
		pst.close();
                //enseignant
                PreparedStatement pst_ens=con.prepareStatement("SELECT COUNT(*) FROM enseignant");
		ResultSet rs_ens = pst_ens.executeQuery();
		rs_ens.next();
		number_ens = rs_ens.getInt(1);
		rs_ens.close();
		pst_ens.close();
                //etudiant
                PreparedStatement pst_etu=con.prepareStatement("SELECT COUNT(*) FROM etudiant");
		ResultSet rs_etu = pst_etu.executeQuery();
		rs_etu.next();
		number_etu = rs_etu.getInt(1);
		rs_etu.close();
		pst_etu.close();
                //module
                PreparedStatement pst_module=con.prepareStatement("SELECT COUNT(*) FROM module");
		ResultSet rs_module = pst_module.executeQuery();
		rs_module.next();
		number_module = rs_module.getInt(1);
		rs_module.close();
		pst_module.close();
		con.close();
	}catch(Exception e) {
		System.out.print(e);
                out.print(e);
	}
	%>
	<!-- BEGIN CONTENT -->
	<div class="page-content-wrapper">
		<div class="page-content">
		<div class="page-bar">
				<ul class="page-breadcrumb">
					<li>
						<i class="fa fa-home"></i>
						<a href="javascript:;">Accueil</a>
						<i class="fa fa-angle-right"></i>
					</li>
					<li>
						<a href="javascript:;"></a>
					</li>
				</ul>
			</div>
			<h1 class="page-title">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
				Université Hassiba Benbouali</h1>
			<br />
			<h4 class="page-title">
			</h4>
			<br />
			<!-- END PAGE HEADER-->
			<!-- BEGIN DASHBOARD STATS -->
			<div class="row">
				<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 margin-bottom-10">
					<a class="dashboard-stat dashboard-stat-light purple-plum" href="table_dept.jsp">
					<div class="visual">
						<i class="fa fa-cubes fa-icon-medium"></i>
					</div>
					<div class="details">
						<div class="number">
						<%=number_dept%>
						</div>
						<div class="desc">
							<h4>
						Nombre des dept</h4>
						</div>
					</div>
					</a>
				</div>

				<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
					<a class="dashboard-stat dashboard-stat-light green-haze" href="javascript:;">
					<div class="visual">
						<i class="fa fa-group fa-icon-medium"></i>
					</div>
					<div class="details">
						<div class="number">
						<%=number_etu%>
						</div>
						<div class="desc">
						<h4>
						Nombre d'étudiants</h4>
						</div>
					</div>
					</a>
				</div>

				<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
					<a class="dashboard-stat dashboard-stat-light red-intense" href="javascript:;">
					<div class="visual">
						<i class="fa fa-book"></i>
					</div>
					<div class="details">
						<div class="number">
						<%=number_module%>
						</div>
						<div class="desc">
						<h4>
						Nombre de module</h4>
						</div>
					</div>
					</a>
				</div>

				<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 margin-bottom-10">
					<a class="dashboard-stat dashboard-stat-light blue-madison" href="javascript:;">
					<div class="visual">
						<i class="fa fa-briefcase fa-icon-medium"></i>
					</div>
					<div class="details">
						<div class="number">
						<%=number_ens%>
						</div>
						<div class="desc">
							<h4>
						Nombre des enseignants</h4>
						</div>
					</div>
					</a>
				</div>
				
			</div>
			
			
		</div>
	</div>
	<!-- END CONTENT -->
<!-- END CONTAINER -->

<%@include file="end.jsp" %>
</body>
<!-- END BODY -->
</html>