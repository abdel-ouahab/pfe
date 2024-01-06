<%-- 
    Document   : index
    Created on : Dec 23, 2023, 11:20:49 AM
    Author     : Abd Elouahab
--%>
<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@include file="head.jsp" %>
<%@ page import="java.sql.*" %>
<%

if (session.getAttribute("email")==null || session.getAttribute("etudiant") == null) {
        response.sendRedirect("../../index.jsp");
    }

    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    String nom_dept ="";
    int mod1 = 0;

    try {
        // Query to fetch data from `etudiant` table
        pstmt = conn.prepareStatement("SELECT * FROM etudiant WHERE id_etud=?");
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();

        // Retrieve data from the result set
        if (rs.next()) {

            // Query to fetch data from `dept` table based on `id_dept`
            pstmt = conn.prepareStatement("SELECT * FROM dept WHERE id_dept=?");
            pstmt.setString(1, id_dept);
            ResultSet deptRS = pstmt.executeQuery();

            if (deptRS.next()) {
                nom_dept = deptRS.getString("nom_dept");
                
            }
            deptRS.close();

            // Query to fetch data from `programmation2` table based on `id_etud`
            pstmt = conn.prepareStatement("SELECT DISTINCT id_mod FROM programmation2 WHERE id_etud=?");
            pstmt.setString(1, id);
            ResultSet modRS = pstmt.executeQuery();

            if (modRS.next()) {
                mod1 = modRS.getInt(1);
            }
            modRS.close();

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


			<!-- BEGIN DASHBOARD STATS -->
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
			<h1 class="page-title">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
				Université Hassiba Benbouali</h1>
			<br />
			<h4 class="page-title">
			&nbsp&nbsp&nbsp
				Faculté des Sciences Exactes et Informatique <small>&nbsp&nbsp&nbsp D`epartement <%=nom_dept %></small>
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
						<%=nom_niv %>
						</div>
						<div class="desc">
						<h4>Niveau</h4>
						</div>
					</div>
					</a>
				</div>

				<div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
					<a class="dashboard-stat dashboard-stat-light green-haze" href="javascript:;">
					<div class="visual">
						<i class="fa fa-group fa-graduation-cap"></i>
					</div>
					<div class="details">
						<div class="number">
						<%=nom_sec %>
						</div>
						<div class="desc">
						<h4>Section</h4>
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
						<%=mod1 %>
						</div>
						<div class="desc">
						<h4>
						Nombre de module</h4>
						</div>
					</div>
					</a>
				</div>
				
			</div>
			<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-6 col-xs-12 margin-bottom-10">
                                    <%
                                        int i =0;
                                        
                                           try {
                                            // Prepare and execute the SQL query
                                            PreparedStatement ps = conn.prepareStatement("SELECT distinct id_sec FROM programmation2 where id_etud= ? ORDER BY id_sec ");
                                            ps.setString(1, id);
                                            ResultSet rs1 = ps.executeQuery();

                                            while (rs1.next()) {
                                                int id_sec = rs1.getInt("id_sec");
                                                PreparedStatement ps_sec = conn.prepareStatement("SELECT * FROM section where id_sec= ?");
                                                ps_sec.setInt(1, id_sec);
                                                ResultSet rs_sec = ps_sec.executeQuery();
                                                while (rs_sec.next()){
                                                    int id_spec = rs_sec.getInt("id_spec");
                                                    String sec = rs_sec.getString("sec");
                                                    
                                                    PreparedStatement ps_sp = conn.prepareStatement("SELECT distinct id_niv FROM specialite where id_spec= ?");
                                                    ps_sp.setInt(1, id_spec);
                                                    ResultSet rs_sp = ps_sp.executeQuery();
                                                    if(rs_sp.next()){   
                                                        int id_niv = rs_sp.getInt("id_niv");
                                                        PreparedStatement ps_se = conn.prepareStatement("SELECT *  FROM semestre where id_niv= ?");
                                                        ps_se.setInt(1, id_niv);
                                                        ResultSet rs_se = ps_se.executeQuery();
                                                        while (rs_se.next()){
                                                            int id_sem = rs_se.getInt("id_sem");
                                                            String sem = rs_se.getString("sem");
                                                            PreparedStatement ps_prog = conn.prepareStatement("SELECT * FROM programmation2,semestre,module where programmation2.id_etud= ? AND programmation2.id_mod=module.id_mod AND module.id_sem=semestre.id_sem AND semestre.id_sem= ? AND programmation2.id_sec=? ");
                                                            ps_prog.setString(1, id);
                                                            ps_prog.setInt(2, id_sem);
                                                            ps_prog.setInt(3, id_sec);
                                                            ResultSet rs_prog = ps_prog.executeQuery();
                                                            if (rs_prog.next()){%>
                                                                <a class="dashboard-stat dashboard-stat-light <% if(i==0){  %> blue-madison <%} if(i==1){  %> green-haze <% } if(i==2){  %> red-intense <% }%> " href="semestre.jsp?id_niv=<%=id_niv %>&id_sec=<%=id_sec %>&id_sem=<%=id_sem %>">
                                                                    <div class="visual">
                                                                            <i class="fa fa-briefcase fa-icon-medium <% if(i==0){  %> fa-book<% } if(i==1){  %> fa-group fa-graduation-cap <% } if(i==2){  %> fa-briefcase fa-icon-medium <% }%> "></i>
                                                                    </div>
                                                                    <div class="details">
                                                                            <div class="number">
                                                                            <%=sem %>
                                                                            </div>
                                                                    </div>
                                                                </a>
                                                           <%
                                                               i++;
                                                                            }
                                                        }
                                                        }
                                                    }
                                                }
                                                } catch (Exception e) {
                                            // Handle any exceptions
                                            e.printStackTrace();
                                        }
                                            
                                        
                                    %>

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