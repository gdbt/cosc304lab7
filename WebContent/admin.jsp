<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>
<%@include file="auth.jsp"%>
<%@include file="jdbc.jsp"%>
<%@ page import="java.util.*,java.sql.*,java.io.*,java.nio.*" %>
<%
try {
	// prep
	getConnection();
	
 	// secured by login
	if (!authenticated) {
		String errorMessage = "Error. You need to login before accessing this page.";
		session.setAttribute("errorMessage", errorMessage);
		out.println(errorMessage);
		response.sendRedirect("login.jsp"); // redirect to login page
	}  
	
 	out.println("<h1>Administrator</h1>");
	// TODO: Write SQL query that prints out total order amount by day
	String ordersSql = "SELECT DISTINCT orderDate, SUM(totalAmount) FROM ordersummary GROUP BY orderDate";
	PreparedStatement ordersPst = con.prepareStatement(ordersSql);
	ResultSet ordersRst = ordersPst.executeQuery();
	
	out.println("<h2>Sales Report by Day</h2>");
	out.println("<table class=table border=1><tr><th>Date</th><th>Total Order Amount</th></tr>");
	while(ordersRst.next()){
		out.println("<tr><td>"+ordersRst.getDate(1)+"</td><td>$"+ordersRst.getString(2)+"</td></tr>");
	}
	out.println("</table>");
	
	// list all customers
	String getallcustSql = "SELECT * FROM customer";
	PreparedStatement getallcustpst = con.prepareStatement(getallcustSql,Statement.RETURN_GENERATED_KEYS);
	
	ResultSet getallcustrst = getallcustpst.executeQuery();
	out.println("<h2>Customer List</h2>");
	out.println("<table class=table border=1>");
	out.println("<tr><th>Id</th><th>First Name</th><th>Last Name</th><th>Email</th><th>Phone Number</th><th>Address</th><th>City</th><th>State</th><th>Postal Code</th><th>Country Code</th>");
	while (getallcustrst.next()){
		out.println("<tr><td>"+getallcustrst.getString(1)+"</td>"+
					"<td>"+getallcustrst.getString(2)+"</td>"+
					"<td>"+getallcustrst.getString(3)+"</td>"+
					"<td>"+getallcustrst.getString(4)+"</td>"+
					"<td>"+getallcustrst.getString(5)+"</td>"+
					"<td>"+getallcustrst.getString(6)+"</td>"+
					"<td>"+getallcustrst.getString(7)+"</td>"+
					"<td>"+getallcustrst.getString(8)+"</td>"+
					"<td>"+getallcustrst.getString(9)+"</td>"+
					"<td>"+getallcustrst.getString(10)+
					"</td></tr>"
		);
	}
	out.println("</table>");
	
}
catch (Exception e){
	out.println("Exception: " + e);
}
%>

<div>
	<h2 align="left">Add New Product</h2>
	
	<form name="MyForm" method=post action="addProd.jsp">
	<table style="display:inline">
	<tr>
		<td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Product Name:</font></div></td>
		<td><input type="text" name="productName" size=10 maxlength="40"></td>
	</tr>
	<tr>
		<td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Category ID:</font></div></td>
		<td><input type="number" name="categoryId" size=10 maxlength="5"></td>
	</tr>
	<tr>
		<td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Product Description:</font></div></td>
		<td><input type="text" name="productDesc" size=10 maxlength="50"></td>
	</tr>
	<tr>
		<td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Product Price:</font></div></td>
		<td><input type="text" name="productPrice" size=10 maxlength="12"></td>
	</tr>
	</table>
	
	<input class="submit" type="submit" value="Add this product">
	
	</form>
	
</div>
<div>
	<h2 align="left">Update a Product</h2>
	<form name="MyForm" method="get" action="updateProd.jsp">
	<table style="display:inline">
	<tr>
		<td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Enter product ID (do not leave empty):</font></div></td>
		<td><input type="text" name="productId" size=10 maxlength="5"></td>
	</tr>
	<tr>
		<td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Enter a new name:</font></div></td>
		<td><input type="text" name="productName" size=10 maxlength="40"></td>
	</tr>
	<tr>
		<td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Enter new category id:</font></div></td>
		<td><input type="text" name="categoryId" size=10 maxlength="5"></td>
	</tr>
	<tr>
		<td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Enter new product description:</font></div></td>
		<td><input type="text" name="productDesc" size=10 maxlength="50"></td>
	</tr>
	<tr>
		<td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Enter new product price:</font></div></td>
		<td><input type="text" name="productPrice" size=10 maxlength="12"></td>
	</tr>
	</table>
	<input class="submit" type= "submit" value="Submit details">
	</form>
</div>
<div>
	<h2 align="left">Delete a Product</h2>
	<form name="MyForm" method="get" action="deleteProd.jsp">
	<table style="display:inline">
	<tr>
		<td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Enter product ID:</font></div></td>
		<td><input type="text" name="warehouseName" size=10 maxlength="5"></td>
	</tr>
	</table>
	<input class="submit" type= "submit" value="Delete this product">
	</form>
</div>
<div>
	<h2 align="left">Add New Warehouse</h2>
	
	<form name="MyForm" method=post action="addWarehouse.jsp">
	<table style="display:inline">
	<tr>
		<td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Warehouse Name:</font></div></td>
		<td><input type="text" name="warehouseName" size=10 maxlength="40"></td>
	</tr>
	</table>
	
	<input class="submit" type="submit" value="Add new warehouse">
	
	</form>
</div>
<div>
	<h2 align="left">Update a Warehouse</h2>
	
	<form name="MyForm" method=post action="updateWarehouse.jsp">
	<table style="display:inline">
	<tr>
		<td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Old Warehouse Name:</font></div></td>
		<td><input type="text" name="oldName" size=10 maxlength="30"></td>
	</tr>
		<tr>
		<td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">New Warehouse Name:</font></div></td>
		<td><input type="text" name="newName" size=10 maxlength="30"></td>
	</tr>
	</table>
	
	<input class="submit" type="submit" value="Change warehouse name">
	
	</form>
</div>
</body>
</html>
