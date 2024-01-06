<%-- 
    Document   : index
    Created on : Dec 23, 2023, 11:07:57 AM
    Author     : Abd Elouahab
--%>
<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@include file="head.jsp" %>
<%@ page import="java.sql.*" %>
<%
if (session.getAttribute("email")==null || session.getAttribute("enseignant") == null) {
        response.sendRedirect("../../index.jsp");
    }
    ResultSet res11 = null;
    ResultSet res5 = null;
    ResultSet mod = null;
    ResultSet sec = null;
    ResultSet res14 = null;
    
    String nom_fac ="";
    String nom_dept ="";
    int mod1 = 0;
    int sec1 = 0;
    int a = 0;
    try {
            res5 = stmt.executeQuery("SELECT * FROM `dept` WHERE id_dept=" + id_dept);
            if (res5.next()) {
                nom_dept = res5.getString("nom_dept");

                stmt = conn.createStatement();
                mod = stmt.executeQuery("SELECT DISTINCT id_mod FROM `programmation` WHERE id_ens=" + id_ens);
                while (mod.next()) {
                    mod1++;
                }
                
                stmt = conn.createStatement();
                sec = stmt.executeQuery("SELECT DISTINCT id_sec FROM `programmation` WHERE id_ens=" + id_ens);
                while (sec.next()) {
                    sec1++;
                }                
                
                while (sec.next()) {
                    int id_se = sec.getInt("id_sec");
                    res14 = stmt.executeQuery("SELECT DISTINCT id_niv FROM `section` WHERE id_sec=" + id_se);
                    while (res14.next()) {
                        a++;
                    }      
                }
                // Use retrieved data in your HTML or further processing
            }
            
            PreparedStatement ps12 = conn.prepareStatement("SELECT * FROM faculte");
                ResultSet rs12 = ps12.executeQuery();
                if (rs12.next()) {
                     nom_fac = rs12.getString("nom_fac");
                }
                rs12.close();
                ps12.close();
        
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (res11 != null) res11.close();
            if (res5 != null) res5.close();
            if (mod != null) mod.close();
            if (sec != null) sec.close();
            if (res14 != null) res14.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

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
					<a class="dashboard-stat dashboard-stat-light blue-madison" href="javascript:;">
					<div class="visual">
						<i class="fa fa-briefcase fa-icon-medium"></i>
					</div>
					<div class="details">
						<div class="number">
						<% //a%>2
						</div>
						<div class="desc">
							<h4>
							Nombre de niveau</h4>
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
						<%=sec1%>
						</div>
						<div class="desc">
						<h4>
						Nombre des sections </h4>
						</div>
					</div>
					</a>
				</div>

				<div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
					<a class="dashboard-stat dashboard-stat-light red-intense" href="javascript:;">
					<div class="visual">
						<i class="fa fa-book"></i>
					</div>
					<div class="details">
						<div class="number">
						<%=mod1%>
						</div>
						<div class="desc">
						<h4>
						Nombre des modules</h4>
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