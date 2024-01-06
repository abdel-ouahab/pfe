<%-- 
    Document   : modifier_admin
    Created on : Jan 3, 2024, 8:06:21 PM
    Author     : Abd Elouahab
--%>
<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@include file="head.jsp" %>
<%
if (session.getAttribute("email")==null || session.getAttribute("admin") == null) {
        response.sendRedirect("../../index.jsp");
    }

PreparedStatement pstmt =null;
ResultSet rs =null;
String nom ="";
String prenom ="";
String email ="";
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url, user, pwd);
        pstmt = conn.prepareStatement("SELECT * FROM `admin` WHERE id_adm=?");
        pstmt.setString(1, id_adm);
        rs = pstmt.executeQuery();
       if (rs.next()){
            nom = rs.getString("nom");
            prenom = rs.getString("prenom");
            email = rs.getString("email");
       }
    } catch (Exception e) { 
        
    }
%>

<!-- BEGIN CONTENT -->
	<div class="page-content-wrapper">
		<div class="page-content">
            <!-- BEGIN PAGE HEADER-->
        <h3 class="page-title">
			Modifier administrateur <small></small>
			</h3>
			<div class="page-bar">
				<ul class="page-breadcrumb">
					<li>
						<i class="fa fa-home"></i>
						<%if (session.getAttribute("admin_p") != null) { %>
						<a href="index.jsp?id_dept=<%=id_dept%>">Accueil</a>
						<% } %>
                                                <%if (session.getAttribute("admin_p") == null) {%>
						<a href="index.jsp">Accueil</a>
						<% } %>
						<i class="fa fa-angle-right"></i>
					</li>
					<li>
                                                <%if (session.getAttribute("admin_p") != null) { %>
						<a href="admin.jsp?id_dept=<%=id_dept%>">administrateurs</a>
						<% } %>
                                                <%if (session.getAttribute("admin_p") == null) {%>
						<a href="admin.jsp">administrateurs</a>
						<% } %>
						<i class="fa fa-angle-right"></i>
					</li>
					<li>
						<a href="javascript:;"> Modifier</a>
					</li>
				</ul>
                        </div>
                        <div class="tab-content">
                                <div class="tab-pane active" id="tab_0">
                                        <div class="portlet box green">
                                                <div class="portlet-title">
                                                        <div class="caption">
                                                                <i class="fa fa-edit "></i>Modifier administrateur
                                                        </div>
                                                        <div class="tools">
                                                                <a href="javascript:;" class="collapse">
                                                                </a>
                                                        </div>
                                                </div>
                                                    <div class="portlet-body form">
                                                        <!-- BEGIN FORM-->
                                                        <form  class="form-horizontal" method="POST" action="../../Modifier_admin?id_dept=<%=id_dept%>">
                                                                <div class="form-body">
                                                                         <div class="form-group">
                                                                                <label class="col-md-3 control-label">Nom</label>
                                                                                <div class="col-md-4">
                                                                                        <input type="text" name="nom" class="form-control input-circle" placeholder="enter nom de l'administrateur"  value="<%=nom %>" autocomplete="off" required>

                                                                                </div>
                                                                        </div>
                                                                         <div class="form-group">
                                                                                <label class="col-md-3 control-label">Prenom</label>
                                                                                <div class="col-md-4">
                                                                                        <input type="text" name="prenom" class="form-control input-circle" placeholder="enter prenom de l'administrateur "  value="<%=prenom %>" autocomplete="off" required>	
                                                                                </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                                <label class="col-md-3 control-label">E-mail</label>
                                                                                <div class="col-md-4">
                                                                                        <input type="email" name="email" class="form-control input-circle" placeholder="enter eamil de l'administrateur "  value="<%=email %>" autocomplete="off"  required>	
                                                                                </div>
                                                                        </div>
                                                                                <input type="hidden" name="id_adm" value="<%=id_adm %>" >


                                                                </div>
                                                                <div class="form-actions">
                                                                        <div class="row">
                                                                                <div class="col-md-offset-3 col-md-9">
                                                                                        <button type="submit" name="submit" class="btn btn-circle blue">Modifer</button>
                                                                                </div>
                                                                        </div>
                                                                </div>
                                                        </form>
                                                        <!-- END FORM-->

		</div>
	</div>
	<!-- END CONTENT -->
<!-- END CONTAINER -->

<%@include file="end.jsp" %>
</body>
<!-- END BODY -->
</html>