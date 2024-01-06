<%-- 
    Document   : head
    Created on : Dec 31, 2023, 1:47:00 AM
    Author     : Abd Elouahab
--%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
 <%
     String id_ens ="";
     String email ="";
     String id_dept ="";
     if(session.getAttribute("id") != null){
        id_ens = session.getAttribute("id").toString();
    }
     if(session.getAttribute("email") != null){
        email = session.getAttribute("email").toString();
    }
     if(session.getAttribute("id_dept") != null){
        id_dept = session.getAttribute("id_dept").toString();
    }
     
     
 %>
<!DOCTYPE html>
<!-- 
Template Name: Metronic - Responsive Admin Dashboard Template build with Twitter Bootstrap 3.3.5
Version: 4.1.0
Author: KeenThemes
Website: http://www.keenthemes.com/
Contact: support@keenthemes.com
Follow: www.twitter.com/keenthemes
Like: www.facebook.com/keenthemes
Purchase: http://themeforest.net/item/metronic-responsive-admin-dashboard-template/4021469?ref=keenthemes
License: You must have a valid license purchased only from themeforest(the above link) in order to legally use the theme for your project.
-->
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
<meta charset="utf-8"/>
<title>Cours en ligne | UHBC </title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<meta content="" name="description"/>
<meta content="" name="author"/>
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css"/>
<link href="../../assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
<link href="../../assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css"/>
<link href="../../assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link href="../../assets/global/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css"/>
<link href="../../assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css"/>
<!-- END GLOBAL MANDATORY STYLES -->
<!-- BEGIN PAGE LEVEL STYLES -->
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/jquery-multi-select/css/multi-select.css"/>
<!-- BEGIN THEME STYLES -->
<!-- BEGIN THEME STYLES -->
<link href="../../assets/global/css/components.css" id="style_components" rel="stylesheet" type="text/css"/>
<link href="../../assets/global/css/plugins.css" rel="stylesheet" type="text/css"/>
<link href="../../assets/admin/layout/css/layout.css" rel="stylesheet" type="text/css"/>
<link id="style_color" href="../../assets/admin/layout/css/themes/darkblue.css" rel="stylesheet" type="text/css"/>
<link href="../../assets/admin/layout/css/custom.css" rel="stylesheet" type="text/css"/>
<!-- END THEME STYLES -->
<link rel="icon" type="image/png" href="../../assets/image/icon.jpg" />
<style>
.success {
    background: #c7efd9;
    border: #bbe2cd 1px solid;
        padding: 15px;
    margin-bottom: 20px;
    border: 1px solid transparent;
    font-size: large;
}

.error {
   
    border: #f3c6c7 1px solid;
    background-color: #f2dede;
    border-color: #ebccd1;
    color: #a94442;
    padding: 15px;
    margin-bottom: 20px;
    border: 1px solid transparent;
    font-size: large;
}

div#response.display-block {
    display: block;
}
</style>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<!-- DOC: Apply "page-header-fixed-mobile" and "page-footer-fixed-mobile" class to body element to force fixed header or footer in mobile devices -->
<!-- DOC: Apply "page-sidebar-closed" class to the body and "page-sidebar-menu-closed" class to the sidebar menu element to hide the sidebar by default -->
<!-- DOC: Apply "page-sidebar-hide" class to the body to make the sidebar completely hidden on toggle -->
<!-- DOC: Apply "page-sidebar-closed-hide-logo" class to the body element to make the logo hidden on sidebar toggle -->
<!-- DOC: Apply "page-sidebar-hide" class to body element to completely hide the sidebar on sidebar toggle -->
<!-- DOC: Apply "page-sidebar-fixed" class to have fixed sidebar -->
<!-- DOC: Apply "page-footer-fixed" class to the body element to have fixed footer -->
<!-- DOC: Apply "page-sidebar-reversed" class to put the sidebar on the right side -->
<!-- DOC: Apply "page-full-width" class to the body element to have full width page without the sidebar menu -->
<body class="page-header-fixed page-quick-sidebar-over-content page-sidebar-fixed page-sidebar-closed-hide-logo">
<!-- BEGIN HEADER -->
<div class="page-header navbar navbar-fixed-top">
	<!-- BEGIN HEADER INNER -->
	<div class="page-header-inner">
		<!-- BEGIN LOGO -->
		<div class="page-logo">
			<img src="../../assets/admin/layout/img/" alt="" class=""/>
			<div class="menu-toggler sidebar-toggler">
				<!-- DOC: Remove the above "hide" to enable the sidebar toggler button on header -->
			</div>
		</div>
		<!-- END LOGO -->
		<!-- BEGIN RESPONSIVE MENU TOGGLER -->
		<a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse">
		</a>
		<!-- END RESPONSIVE MENU TOGGLER -->
		<!-- BEGIN TOP NAVIGATION MENU -->
		<div class="top-menu">
			<ul class="nav navbar-nav pull-right">
				<!-- BEGIN NOTIFICATION DROPDOWN -->
				<!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
				<li class="dropdown dropdown-user">
					<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
					<img alt="" class="img-circle" src="../../assets/admin/layout/img/avatar.png"/>
					<span class="username username-hide-on-mobile">
					<% out.print(session.getAttribute("nom")+" "+session.getAttribute("prenom"));%> </span>
					<i class="fa fa-angle-down"></i>
					</a>
					<ul class="dropdown-menu dropdown-menu-default">
					<li>
							<a id="age" data-toggle="modal" data-target="#add_data">
							<i class="icon-user"></i> Mon Profil </a>
						</li>
						<li class="divider">
						</li>
						<li>
							<a href="../../Logout">
							<i class="icon-key"></i> Se déconnecter </a>
						</li>
					</ul>
				</li>
				
				
				<!-- END QUICK SIDEBAR TOGGLER -->
			</ul>
		</div>
		<!-- END TOP NAVIGATION MENU -->
	</div>
	<!-- END HEADER INNER -->
</div>
<!-- END HEADER -->
<div class="clearfix">
</div>
<!-- BEGIN CONTAINER -->
<div class="page-container">
	<!-- BEGIN SIDEBAR -->
	<div class="page-sidebar-wrapper">
		<!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
		<!-- DOC: Change data-auto-speed="200" to adjust the sub menu slide up/down speed -->
		<div class="page-sidebar navbar-collapse collapse">
			<!-- BEGIN SIDEBAR MENU -->
			<!-- DOC: Apply "page-sidebar-menu-light" class right after "page-sidebar-menu" to enable light sidebar menu style(without borders) -->
			<!-- DOC: Apply "page-sidebar-menu-hover-submenu" class right after "page-sidebar-menu" to enable hoverable(hover vs accordion) sub menu mode -->
			<!-- DOC: Apply "page-sidebar-menu-closed" class right after "page-sidebar-menu" to collapse("page-sidebar-closed" class must be applied to the body element) the sidebar sub menu mode -->
			<!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
			<!-- DOC: Set data-keep-expand="true" to keep the submenues expanded -->
			<!-- DOC: Set data-auto-speed="200" to adjust the sub menu slide up/down speed -->
			<ul class="page-sidebar-menu" data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200">
				<!-- DOC: To remove the search box from the sidebar you just need to completely remove the below "sidebar-search-wrapper" LI element -->
				<li class="sidebar-search-wrapper">
					<!-- BEGIN RESPONSIVE QUICK SEARCH FORM -->
					<!-- DOC: Apply "sidebar-search-bordered" class the below search form to have bordered search box -->
					<!-- DOC: Apply "sidebar-search-bordered sidebar-search-solid" class the below search form to have bordered & solid search box -->
					<form class="sidebar-search sidebar-search-bordered" action="extra_search.html" method="POST">
						<a href="javascript:;" class="remove">
						<i class="icon-close"></i>
						</a>
						<div class="input-group">
							<input type="text" class="form-control" placeholder="Search...">
							<span class="input-group-btn">
							<a href="javascript:;" class="btn submit"><i class="icon-magnifier"></i></a>
							</span>
						</div>
					</form>
					<!-- END RESPONSIVE QUICK SEARCH FORM -->
					<li class="start ">
					<a href="index.jsp">
					<i class="fa fa-home"></i>
					<span class="title">ACCUEIL</span>
					</a>
					
				</li><li>
        <% 
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            ResultSet rssec = null;
            ResultSet resniv = null;
            // ... Other variable declarations ...
            String nom_sec ="";
                                                String nom_niv ="";
                                                
                                                String id_niv ="";
                                                String id_sec ="";

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pfe_bdd", "root", "");

                String sql = "SELECT * FROM enseignant where email='" + email + "'";
                stmt = conn.createStatement();
                rs = stmt.executeQuery(sql);

                while (rs.next()) {
                    String nom = rs.getString("nom");
                    String prenom = rs.getString("prenom");}

                    String sqlsec = "SELECT distinct id_sec FROM programmation where id_ens=" + id_ens + " ORDER BY id_sec";
                    Statement stmtsec = conn.createStatement();
                    rssec = stmtsec.executeQuery(sqlsec);

                    while (rssec.next()) {
                        id_sec = rssec.getString("id_sec");
                        String sqlniv = "SELECT * FROM section where id_sec=" + id_sec;
                        Statement stmtniv = conn.createStatement();
                        resniv = stmtniv.executeQuery(sqlniv);

                        while (resniv.next()) {
                            id_niv = resniv.getString("id_niv");
                            nom_sec = resniv.getString("sec");
                            String sqlnivn = "SELECT distinct nom_niv FROM niveau where id_niv=" + id_niv;
                            Statement stmtnivn = conn.createStatement();
                            ResultSet resnivn = stmtnivn.executeQuery(sqlnivn);

                            while (resnivn.next()) {
                                nom_niv = resnivn.getString("nom_niv");
                    %>
                                <li>
                                    <a href="#">
                                        <i class="fa fa-graduation-cap"></i>
                                        <span class="title"><%= nom_niv %> -> section <%= nom_sec %></span>
                                        <span class="arrow"></span>
                                    </a>
                                    <ul class="sub-menu">
                                        <%
                                            String sqlsem = "SELECT * FROM semestre WHERE id_niv=" + id_niv;
                                            Statement stmtSem = conn.createStatement();
                                            ResultSet resSem = stmtSem.executeQuery(sqlsem);

                                            while (resSem.next()) {
                                                int id_sem = resSem.getInt("id_sem");
                                                String sem = resSem.getString("sem");

                                                Statement stmtResMod = conn.createStatement();
                                                ResultSet resMod = stmtResMod.executeQuery("SELECT * FROM programmation, semestre, module WHERE programmation.id_ens=" + id_ens + " AND programmation.id_mod=module.id_mod AND module.id_sem=semestre.id_sem AND semestre.id_sem=" + id_sem + " AND programmation.id_sec=" + id_sec);

                                                if (resMod.next()) {
                                        %>
                                                    <li>
                                                        <a href="enseignant.jsp?id_niv=<%= id_niv %>&id_sec=<%= id_sec %>&id_sem=<%= id_sem %>"><%= sem %></a>
                                                    </li>
                                        <%
                                                }
                                            }
                                        %>
                                    </ul>
                                </li>
                    <%
                            }
                        }
                    }
                
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // Close the resources in the finally block
                // ...
            }
        %>
			</ul>
			<!-- END SIDEBAR MENU -->
		</div>
	</div>
	<!-- END SIDEBAR -->
	</html>
<div id="add_data" class="modal fade">
 <div class="modal-dialog">
  <div class="modal-content">
   <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal">&times;</button>
    <h4 class="modal-title">Mon Profil </h4>
   </div>
   <div class="modal-body">
	<label>Nom : <%=session.getAttribute("nom")%></label>
	<br />
    <label>Prenom : <%=session.getAttribute("prenom")%></label>
    <br />
	<label>Type : <%=session.getAttribute("enseignant") %> </label>
    <br />
	<a href="modifier_password.jsp">
		<div class="btn-group">
		<button type="button" name="age"  class="btn green">
		Modifier le mot de passe  
			</button>
		</div>
		</a>
	      
	 
   </div>
   <div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
   </div>
  </div>
 </div>
</div>