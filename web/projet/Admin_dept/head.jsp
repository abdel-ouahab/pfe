
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%
    String id_dept ="";
    String id_adm ="";
    if(session.getAttribute("id_dept") != null){
        id_dept = session.getAttribute("id_dept").toString();
    }
    if(session.getAttribute("id") != null){
        id_dept = session.getAttribute("id").toString();
    }
    if(request.getParameter("id_dept") != null){
        id_dept = request.getParameter("id_dept");
    }
    if(session.getAttribute("id_adm") != null){
        id_adm = session.getAttribute("id_adm").toString();
    }
    
String url  = "jdbc:mysql://localhost:3306/pfe_bdd";
String user = "root";
String pwd  = "";
    
    
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
<link href="../../assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.css" rel="stylesheet" type="text/css"/>

<!-- BEGIN THEME STYLES -->
<!-- BEGIN THEME STYLES -->
<link href="../../assets/global/css/components.css" id="style_components" rel="stylesheet" type="text/css"/>
<link href="../../assets/global/css/plugins.css" rel="stylesheet" type="text/css"/>
<link href="../../assets/admin/layout/css/layout.css" rel="stylesheet" type="text/css"/>
<link id="style_color" href="../../assets/admin/layout/css/themes/darkblue.css" rel="stylesheet" type="text/css"/>
<link href="../../assets/admin/layout/css/custom.css" rel="stylesheet" type="text/css"/>
<!-- END THEME STYLES -->
<link rel="icon" type="image/png" href="../../assets/image/icon.jpg" />

</head>

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
<script type="text/javascript">
$(document).ready(function() {
    $("#frmCSVImport").on("submit", function () {

	    $("#response").attr("class", "");
        $("#response").html("");
        var fileType = ".xlsx";
        var regex = new RegExp("([a-zA-Z0-9\s_\\.\-:])+(" + fileType + ")$");
        if (!regex.test($("#file").val().toLowerCase())) {
        	    $("#response").addClass("error");
        	    $("#response").addClass("display-block");
            $("#response").html("Fichier non valide T�l�charger: <b>" + fileType + "</b>  fichiers.");
            return false;
        }
        return true;
    });
});
</script>
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
			<a href="index.html">
			<img src="../../assets/admin/layout/img/" alt="" class=""/>
			</a>
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
                                        <% out.print(session.getAttribute("nom")+" "+session.getAttribute("prenom"));%></span>
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
							<i class="icon-key"></i> Se d�connecter </a>
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
				</li>
                                <%
                                if (session.getAttribute("id_dept") != null){
                                %>
				<li class="start ">
					<a href="../Admin/index.jsp">
					<i class="fa fa-mail-reply "></i>
					<span class="title">FACULT�</span>
					</a>
					
				</li>
				
				<li class="start ">
					<a href="index.jsp?id_dept=<%=id_dept%>">
					<i class="fa fa-home"></i>
					<span class="title">ACCUEIL</span>
					</a>
					
				</li>
                                <li class="start ">
					<a href="admin.jsp?id_dept=<%=id_dept%>">
					<i class="fa fa-user"></i>
					<span class="title">ADMINISTRATEURS</span>
					</a>
					
				</li>
				<li>
					<a href="specialite.jsp?id_dept=<%=id_dept%>">
					<i class="fa fa-th-large"></i>
					<span class="title">SP�CIALIT�S</span>
					</a>
					
				</li>
				<li>
					<a href="section.jsp?id_dept=<%=id_dept%>">
					<i class="fa fa-eraser"></i>
					<span class="title">SECTION</span>
					</a>
					
				</li>
				<li>
					<a href="javascript:;">
					<i class="fa fa-graduation-cap"></i>
					<span class="title">�TUDIANTS</span>
					<span class="arrow "></span>
					</a>
					<ul class="sub-menu">
                                        <%
                                        try {
                                            Class.forName("com.mysql.jdbc.Driver");
                                            Connection conn = DriverManager.getConnection(url, user, pwd);

                                            PreparedStatement ps = conn.prepareStatement("SELECT * FROM niveau WHERE id_dept=? ORDER BY nom_niv");
                                            ps.setString(1, id_dept);
                                            ResultSet rs = ps.executeQuery();

                                            while (rs.next()) {
                                                String id_niv = rs.getString("id_niv");
                                                String nom_niv = rs.getString("nom_niv");

                                                PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM specialite WHERE id_niv=?");
                                                ps1.setString(1, id_niv);
                                                ResultSet rs1 = ps1.executeQuery();

                                                if (!rs1.next()) {
                                        %>
                                        <li>
                                            <a href="#"><%= nom_niv %></a>
                                        </li>
                                        <%
                                                } else {
                                                String id_spec = rs1.getString("id_spec");
                                                String nom_spec = rs1.getString("nom_spec");
                                        %>
                                        <li>
                                            <a href="javascript:;">
                                                <span class="title"><%= nom_niv %></span>
                                                <span class="arrow "></span>
                                            </a>
                                            <ul class="sub-menu">
                                                <li>
                                                    <a href="etudiant.jsp?id_dept=<%=id_dept%>&id_niv=<%= id_niv %>&id_spec=<%= id_spec %>"><%= nom_spec %></a>
                                                </li>
                                        <%
                                                    while (rs1.next()) {
                                                         id_spec = rs1.getString("id_spec");
                                                         nom_spec = rs1.getString("nom_spec");
                                        %>
                                                <li>
                                                    <a href="etudiant.jsp?id_dept=<%=id_dept%>&id_niv=<%= id_niv %>&id_spec=<%= id_spec %>"><%= nom_spec %></a>
                                                </li>
                                        <%
                                                    }
                                        %>
                                            </ul>
                                        </li>
                                        <%
                                                }
                                                rs1.close();
                                                ps1.close();
                                            }
                                            rs.close();
                                            ps.close();
                                            conn.close();
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                        }
                                        %>
                                    </ul>

					
				</li>
				<li>
					<a href="enseignant.jsp?id_dept=<%=id_dept%>">
					<i class="fa fa-briefcase"></i>
					<span class="title">ENSEIGNANTS</span>
					</a>
					
				</li>
				<li>
					<a href="module.jsp?id_dept=<%=id_dept%>">
					<i class="fa fa-book"></i>
					<span class="title">MODULES</span>
					</a>
					
				</li>
				<li>
				    <a href="javascript:;">
					<i class="fa  fa-cube"></i>
					<span class="title">AFFICTATION</span>
					<span class="arrow "></span>
					</a>
					
					<ul class="sub-menu">
				<li>
					<a href="affectation_enseignant.jsp?id_dept=<%=id_dept%>">
					
					<span class="title">MODULES <i class="fa fa-angle-right"></i> ENSEIGNANT</span>
					</a>
					
				</li>
				<li>
					<a href="affectation_etudiant.jsp?id_dept=<%=id_dept%>">
					
					<span class="title"> ETUDIANTS <i class="fa fa-angle-right"></i> MODULES</span>
					</a>
					
				</li>
				     </ul>
				</li>
				<%}%>
				
                                <%
                                if(session.getAttribute("id") != null){
                                %>
				<li class="start ">
					<a href="index.jsp">
					<i class="fa fa-home"></i>
					<span class="title">ACCUEIL</span>
					</a>
					
				</li>
                                <li class="start ">
					<a href="admin.jsp">
					<i class="fa fa-user"></i>
					<span class="title">ADMINISTRATEURS</span>
					</a>
					
				</li>
				<li>
					<a href="specialite.jsp">
					<i class="fa fa-th-large"></i>
					<span class="title">SP�CIALIT�S</span>
					</a>
					
				</li>
				<li>
					<a href="section.jsp">
					<i class="fa fa-eraser"></i>
					<span class="title">SECTION</span>
					</a>
					
				</li>
				<li>
					<a href="javascript:;">
					<i class="fa fa-graduation-cap"></i>
					<span class="title">�TUDIANTS</span>
					<span class="arrow "></span>
					</a>
					<ul class="sub-menu">
                                        <%
                                        try {
                                            Class.forName("com.mysql.jdbc.Driver");
                                            Connection conn = DriverManager.getConnection(url, user, pwd);

                                            PreparedStatement ps = conn.prepareStatement("SELECT * FROM niveau WHERE id_dept=? ORDER BY nom_niv");
                                            ps.setString(1, id_dept);
                                            ResultSet rs = ps.executeQuery();

                                            while (rs.next()) {
                                                String id_niv = rs.getString("id_niv");
                                                String nom_niv = rs.getString("nom_niv");

                                                PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM specialite WHERE id_niv=?");
                                                ps1.setString(1, id_niv);
                                                ResultSet rs1 = ps1.executeQuery();

                                                if (!rs1.next()) {
                                        %>
                                        <li>
                                            <a href="#"><%= nom_niv %></a>
                                        </li>
                                        <%
                                                } else {
                                                String id_spec = rs1.getString("id_spec");
                                                String nom_spec = rs1.getString("nom_spec");
                                        %>
                                        <li>
                                            <a href="javascript:;">
                                                <span class="title"><%= nom_niv %></span>
                                                <span class="arrow "></span>
                                            </a>
                                            <ul class="sub-menu">
                                                <li>
                                                    <a href="etudiant.jsp?id_niv=<%= id_niv %>&id_spec=<%= id_spec %>"><%= nom_spec %></a>
                                                </li>
                                        <%
                                                    while (rs1.next()) {
                                                         id_spec = rs1.getString("id_spec");
                                                         nom_spec = rs1.getString("nom_spec");
                                        %>
                                                <li>
                                                    <a href="etudiant.jsp?id_niv=<%= id_niv %>&id_spec=<%= id_spec %>"><%= nom_spec %></a>
                                                </li>
                                        <%
                                                    }
                                        %>
                                            </ul>
                                        </li>
                                        <%
                                                }
                                                rs1.close();
                                                ps1.close();
                                            }
                                            rs.close();
                                            ps.close();
                                            conn.close();
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                        }
                                        %>
                                    </ul>

					
				</li>
				<li>
					<a href="enseignant.jsp">
					<i class="fa fa-briefcase"></i>
					<span class="title">ENSEIGNANTS</span>
					</a>
					
				</li>
				<li>
					<a href="module.jsp">
					<i class="fa fa-book"></i>
					<span class="title">MODULES</span>
					</a>
					
				</li>
				<li>
				    <a href="javascript:;">
					<i class="fa  fa-cube"></i>
					<span class="title">AFFICTATION</span>
					<span class="arrow "></span>
					</a>
					
					<ul class="sub-menu">
				<li>
					<a href="affectation_enseignant.jsp">
					
					<span class="title">MODULES <i class="fa fa-angle-right"></i> ENSEIGNANT</span>
					</a>
					
				</li>
				<li>
					<a href="affectation_etudiant.jsp">
					
					<span class="title"> ETUDIANTS <i class="fa fa-angle-right"></i> MODULES</span>
					</a>
					
				</li>
				     </ul>
				</li>
				<%}%>
				
				
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
	<label>Type : <%=session.getAttribute("admin") %> </label>
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