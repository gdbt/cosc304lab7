<%@ page language="java" import="java.io.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Update Warehouse Page</title>
</head>

<body>
<%@include file="auth.jsp"%>
<%@include file="jdbc.jsp"%>
<%
	try{		
			getConnection();
			
			boolean updateWarehouseSuccessful=false;
			
			// updating warehouse name
			String oldWhName=request.getParameter("oldName");
			String newWhName=request.getParameter("newName");
			
			String updateWhSql = "UPDATE warehouse SET warehouseName = ? WHERE warehouseName = ?";
			PreparedStatement updateWhPst = con.prepareStatement(updateWhSql,Statement.RETURN_GENERATED_KEYS);
			updateWhPst.setString(1,newWhName);
			updateWhPst.setString(2,oldWhName);
			updateWhPst.executeUpdate();
			updateWarehouseSuccessful=true;
			
			if(updateWarehouseSuccessful){
				out.println(oldWhName+" was successfully renamed to" + newWhName);
				
				// display newly updated table
				String updateWhResultSql = "SELECT * FROM warehouse";
				PreparedStatement updateWhResultPst = con.prepareStatement(updateWhResultSql,Statement.RETURN_GENERATED_KEYS);
				ResultSet updateWhResultRst = updateWhResultPst.executeQuery();
				out.println("<h3>Updated Warehouse List</h3><table class=table border=1>");
				out.println("<tr><th>Warehouse ID</th><th>Warehouse Name</th></tr>");
				while (updateWhResultRst.next()){
					out.println("<tr><td>"+updateWhResultRst.getString(1)+"</td><td>"+updateWhResultRst.getString(2)+"</td></tr>");
				}
				
				updateWarehouseSuccessful=false;	// reset
			}
		
	} catch (Exception e) {
		out.println("Exception occurred: "+ e);
	}
%>
</body>
</html>