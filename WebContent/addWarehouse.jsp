<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.io.*,java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<title>Add Warehouse Page</title>
</head>
<body>
<%@ page import="java.text.NumberFormat" %>
<%@include file="auth.jsp"%>
<%@ include file="jdbc.jsp" %>

<%
	getConnection();
	boolean addWarehouseSuccessful=false;
	//NumberFormat toNum = NumberFormat.getInstance();

	try{
		// adding new warehouse
		String warehouseName = (String)request.getParameter("warehouseName");
		
		String insertWarehouseSql = "INSERT warehouse (warehouseName) VALUES (?)";
		PreparedStatement insertWarehousePst = con.prepareStatement(insertWarehouseSql, Statement.RETURN_GENERATED_KEYS);
		insertWarehousePst.setString(1,warehouseName);
		insertWarehousePst.executeUpdate();
		addWarehouseSuccessful = true;
		
		if(addWarehouseSuccessful){
			out.println(warehouseName +" was successfully added to the warehouse list.");

			String insertWarehouseResultSql = "SELECT * FROM warehouse";
			PreparedStatement insertWarehouseResultPst = con.prepareStatement(insertWarehouseResultSql,Statement.RETURN_GENERATED_KEYS);
			ResultSet insertWarehouseResultRst = insertWarehouseResultPst.executeQuery();
			out.println("<h3>Updated Warehouse List</h3><table class=table border=1>");
			out.println("<tr><th>Warehouse ID</th><th>Warehouse Name</th></tr>");
			while (insertWarehouseResultRst.next()){
				out.println("<tr><td>"+insertWarehouseResultRst.getString(1)+"</td><td>"+insertWarehouseResultRst.getString(2)+"</td></tr>");
			}
			
			addWarehouseSuccessful=false; // reset
		}

	} catch(Exception e) {
		out.println("Exception occurred: " + e);
	}
%>

</body>
</html>