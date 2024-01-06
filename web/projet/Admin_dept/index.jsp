<%-- 
    Document   : index
    Created on : Dec 23, 2023, 11:07:29 AM
    Author     : Abd Elouahab
--%>
<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@include file="head.jsp" %>
<%
if (session.getAttribute("email")==null || session.getAttribute("admin") == null) {
        response.sendRedirect("../../index.jsp");
    }

    
    
    int number_ens = 0;
    int number_etu = 0;
    int number_module = 0;
    int number_section = 0;
    int number_specialite = 0;
    int number_admin = 0;
    
    String nom_dept="";
    String nom_fac="";
    
    
    try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, user, pwd);
                //enseignant
                PreparedStatement pst_ens=con.prepareStatement("SELECT COUNT(*) FROM enseignant where id_dept=?");
                pst_ens.setString(1, id_dept);
		ResultSet rs_ens = pst_ens.executeQuery();
		rs_ens.next();
		number_ens = rs_ens.getInt(1);
		rs_ens.close();
		pst_ens.close();
                //etudiant
                PreparedStatement pst_etu=con.prepareStatement("SELECT COUNT(*) FROM etudiant where id_dept=?");
                pst_etu.setString(1, id_dept);
		ResultSet rs_etu = pst_etu.executeQuery();
		rs_etu.next();
		number_etu = rs_etu.getInt(1);
		rs_etu.close();
		pst_etu.close();
                //module
                PreparedStatement pst_module=con.prepareStatement("SELECT COUNT(*) FROM module where id_dept=?");
                pst_module.setString(1, id_dept);
		ResultSet rs_module = pst_module.executeQuery();
		rs_module.next();
		number_module = rs_module.getInt(1);
		rs_module.close();
		pst_module.close();
                //section
		PreparedStatement pst=con.prepareStatement("SELECT COUNT(*) FROM section where id_dept=?");
                pst.setString(1, id_dept);
		ResultSet rs = pst.executeQuery();
		rs.next();
		number_section = rs.getInt(1);
		rs.close();
		pst.close();
                //section
		PreparedStatement pst_sp=con.prepareStatement("SELECT COUNT(*) FROM specialite where id_dept=?");
                pst_sp.setString(1, id_dept);
		ResultSet rs_sp = pst_sp.executeQuery();
		rs_sp.next();
		number_specialite = rs_sp.getInt(1);
		rs_sp.close();
		pst_sp.close();
                //section
		PreparedStatement pst_adm=con.prepareStatement("SELECT COUNT(*) FROM admin where id_dept=?");
                pst_adm.setString(1, id_dept);
		ResultSet rs_adm = pst_adm.executeQuery();
		rs_adm.next();
		number_admin = rs_adm.getInt(1);
		rs_adm.close();
		pst_adm.close();
                
                
                PreparedStatement ps11 = con.prepareStatement("SELECT * FROM dept WHERE id_dept=?");
                ps11.setString(1, id_dept);
                ResultSet rs11 = ps11.executeQuery();
                if (rs11.next()) {
                     nom_dept = rs11.getString("nom_dept");
                }
                rs11.close();
                ps11.close();

                PreparedStatement ps12 = con.prepareStatement("SELECT * FROM faculte");
                ResultSet rs12 = ps12.executeQuery();
                if (rs12.next()) {
                     nom_fac = rs12.getString("nom_fac");
                }
                rs12.close();
                ps12.close();

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
			<%=nom_fac%><small>&nbsp&nbsp&nbspD`epartement <%=nom_dept%></small>
			</h4>
			<br />
			<!-- END PAGE HEADER-->
			<!-- BEGIN DASHBOARD STATS -->
			<div class="row">
				<div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 margin-bottom-10">
					<a class="dashboard-stat dashboard-stat-light red-intense" href="admin.jsp">
					<div class="visual">
						<i class="fa fa-user fa-icon-medium"></i>
					</div>
					<div class="details">
						<div class="number">
						<%=number_admin%>
						</div>
						<div class="desc">
							<h4>
							Nombre des administrateurs
						</h4>
						</div>
					</div>
					</a>
				</div>

				<div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
					<a class="dashboard-stat dashboard-stat-light blue-madison" href="enseignant.jsp">
					<div class="visual">
						<i class="fa fa-briefcase fa-icon-medium"></i>
					</div>
					<div class="details">
						<div class="number">
						<%=number_ens%>
						</div>
						<div class="desc">
						<h4>
						Nombre des enseignants
						</h4>
						</div>
					</div>
					</a>
				</div>

				<div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
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
				
			</div>
			<div class="row">
				<div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 margin-bottom-10">
					<a class="dashboard-stat dashboard-stat-light green-haze " href="section.jsp">
					<div class="visual">
						<i class="fa fa-eraser fa-icon-medium"></i>
					</div>
					<div class="details">
						<div class="number">
						<%=number_section%>
						</div>
						<div class="desc">
							<h4>
						Nombre des sections</h4>
						</div>
					</div>
					</a>
				</div>

				<div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
					<a class="dashboard-stat dashboard-stat-light red-intense " href="specialite.jsp">
					<div class="visual">
						<i class="fa fa-th-large fa-icon-medium"></i>
					</div>
					<div class="details">
						<div class="number">
						<%=number_specialite%>
						</div>
						<div class="desc">
						<h4>
						Nombre des spécialités
					    </h4>
						</div>
					</div>
					</a>
				</div>

				<div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
					<a class="dashboard-stat dashboard-stat-light blue-madison" href="module.jsp">
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
				
			</div>
			
			
		</div>
	</div>
	<!-- END CONTENT -->
<!-- END CONTAINER -->
<%@include file="end.jsp" %>
</body>
<!-- END BODY -->
</html>