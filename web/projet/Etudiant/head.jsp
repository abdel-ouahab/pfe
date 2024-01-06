<%-- 
    Document   : head
    Created on : Jan 1, 2024, 4:24:35 PM
    Author     : Abd Elouahab
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
 <%
     String id ="";
     String email ="";
     String id_dept ="";
     String nom ="";
     String prenom ="";
     String dette ="";
     String ajourne ="";
     String num_inscri ="";
     String date ="";
     
     if(session.getAttribute("id") != null){
        id = session.getAttribute("id").toString();
    }
     if(session.getAttribute("email") != null){
        email = session.getAttribute("email").toString();
    }
     if(session.getAttribute("id_dept") != null){
        id_dept = session.getAttribute("id_dept").toString();
    }
     if(session.getAttribute("nom") != null){
        nom = session.getAttribute("nom").toString();
    }
     if(session.getAttribute("prenom") != null){
        prenom = session.getAttribute("prenom").toString();
    }
     if(session.getAttribute("num_inscri") != null){
        num_inscri = session.getAttribute("num_inscri").toString();
    }
     if(session.getAttribute("date") != null){
        date = session.getAttribute("date").toString();
    }
     if(session.getAttribute("dette") != null){
        dette = session.getAttribute("dette").toString();
    }
     if(session.getAttribute("ajourne") != null){
        ajourne = session.getAttribute("ajourne").toString();
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
<body class="page-header-fixed page-quick-sidebar-over-content page-full-width">
<!-- BEGIN HEADER -->
<div class="page-header navbar navbar-fixed-top">
	<!-- BEGIN HEADER INNER -->
	<div class="page-header-inner">
		<!-- BEGIN LOGO -->
		<div class="page-logo">
		</div>
		<!-- END LOGO -->
		<!-- BEGIN HORIZANTAL MENU -->
		<!-- DOC: Apply "hor-menu-light" class after the "hor-menu" class below to have a horizontal menu with white background -->
		<!-- DOC: This is desktop version of the horizontal menu. The mobile version is defined(duplicated) sidebar menu below. So the horizontal menu has 2 seperate versions -->
		<div class="hor-menu hor-menu-light hidden-sm hidden-xs">
                                <%
                                Connection conn = null;
                                String nom_niv ="";
                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pfe_bdd", "root", "");

                                        String sqlSec = "SELECT distinct id_sec FROM programmation2 where id_etud = ? ORDER BY id_sec";
                                        PreparedStatement pstmtSec = conn.prepareStatement(sqlSec);
                                        pstmtSec.setString(1, id);
                                        ResultSet rsSec = pstmtSec.executeQuery();

                                %>

			<ul class="nav navbar-nav">
				<!-- DOC: Remove data-hover="dropdown" and data-close-others="true" attributes below to disable the horizontal opening on mouse hover -->
				<li class="classic-menu-dropdown">
					<a href="index.jsp">
					<i class="fa fa-home"></i>
					<span class="title">Accueil</span>
					</a>

				</li>
                                <%
                                    while (rsSec.next()) {
                                        int id_sec = rsSec.getInt("id_sec");
                                        String sqlniv = "SELECT * FROM section where id_sec = ?";
                                        PreparedStatement pstmtNiv = conn.prepareStatement(sqlniv);
                                        pstmtNiv.setInt(1, id_sec);
                                        ResultSet resniv = pstmtNiv.executeQuery();

                                        while (resniv.next()) {
                                            int id_niv = resniv.getInt("id_niv");
                                            String nom_sec = resniv.getString("sec");
                                            String sqlnivn = "SELECT distinct nom_niv FROM niveau where id_niv = ?";
                                            PreparedStatement pstmtNivn = conn.prepareStatement(sqlnivn);
                                            pstmtNivn.setInt(1, id_niv);
                                            ResultSet resnivn = pstmtNivn.executeQuery();

                                            if (resnivn.next()) {
                                                nom_niv = resnivn.getString("nom_niv");
                                                
                                    %>
                                   
				<li class="classic-menu-dropdown">
					<a data-toggle="dropdown" href="javascript:;">
					<%=nom_niv %> <i class="fa fa-angle-down"></i>
					</a>
					<ul class="dropdown-menu pull-left">
                                            <%
                                            String sqlsem = "SELECT * FROM semestre where id_niv = ?";
                                            PreparedStatement pstmtSem = conn.prepareStatement(sqlsem);
                                            pstmtSem.setInt(1, id_niv);
                                            ResultSet ressem = pstmtSem.executeQuery();

                                            while (ressem.next()) {
                                                int id_sem = ressem.getInt("id_sem");
                                                String sem = ressem.getString("sem");

                                                String sqlmod = "SELECT * FROM programmation2,semestre,module WHERE programmation2.id_etud = ? AND programmation2.id_mod = module.id_mod AND module.id_sem = semestre.id_sem AND semestre.id_sem = ? AND programmation2.id_sec = ?";
                                                PreparedStatement pstmtMod = conn.prepareStatement(sqlmod);
                                                pstmtMod.setString(1, id);
                                                pstmtMod.setInt(2, id_sem);
                                                pstmtMod.setInt(3, id_sec);
                                                ResultSet resmod = pstmtMod.executeQuery();

                                                if (resmod.next()) {
                                            %>
                                  
							
				<li>
					<a href="semestre.jsp?id_niv=<%=id_niv %>&id_sec=<%=id_sec %>&id_sem=<%=id_sem %>">
					<i class="fa fa-graduation-cap"></i>
					<span class="title"><%=sem %></span>
					</a>
				</li>
				<%
                                            }
                                                resmod.close();
                                                pstmtMod.close();
                                            }
                                            ressem.close();
                                            pstmtSem.close();
                                            %>

                                            <%
                                            }
                                            resnivn.close();
                                            pstmtNivn.close();
                                %>

				</ul>
				</li>	
			<%
                                        }
                                        resniv.close();
                                        pstmtNiv.close();
                                    }
                                    rsSec.close();


                                } catch (Exception e) {
                                    e.printStackTrace();
                                }          
                        %>
			</ul>			
				
			
		</div>
		<!-- END HORIZANTAL MENU -->
		<!-- BEGIN HEADER SEARCH BOX -->
		
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
					<% out.print(nom+" "+prenom);%> </span>
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
   <label>Numero d'inscription : <%=num_inscri %></label>
    <br />
	<label>Nom : <%=nom %></label>
	<br />
    <label>Prenom : <%=prenom %> </label>
    
    <%
    String nom_sec ="";
    String niveau = "";
    try {
        // Query to fetch data from `etudiant` table
        PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM etudiant WHERE id_etud=?");
        pstmt.setString(1, id);
        ResultSet rs = pstmt.executeQuery();

        // Retrieve data from the result set
        if (rs.next()) {
            int id_niv = rs.getInt("id_niv");
            // Query to fetch data from `dept` table based on `id_dept`
            pstmt = conn.prepareStatement("SELECT * FROM niveau WHERE id_niv=?");
            pstmt.setInt(1, id_niv);
            ResultSet deptRS = pstmt.executeQuery();

            if (deptRS.next()) {
                niveau = deptRS.getString("nom_niv");
                
            }
            deptRS.close();


            // Query to fetch data from `section` table based on `id_sec`
            int id_sec = rs.getInt("id_sec");
            pstmt = conn.prepareStatement("SELECT * FROM section WHERE id_sec=?");
            pstmt.setInt(1, id_sec);
            ResultSet secRS = pstmt.executeQuery();

            if (secRS.next()) {
                nom_sec = secRS.getString("sec");
            }
            secRS.close();
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    %>
        <br />
            <label>Niveau : <%=niveau%> </label>
        <br />
	<label>Section : <%=nom_sec %> </label>
	<br />
	<label>date de naissance : <%=date %> </label>
    <br />
	<% if(dette=="1"){ %>
	<label> dette </label>
    <br />
	<% } if(ajourne =="1"){ %>
	<label> ajourne </label>
    <br />
	<% }%>
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