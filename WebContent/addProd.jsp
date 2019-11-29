<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.io.*,java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<title>Add Product Page</title>
</head>
<body>
<%@ page import="java.text.NumberFormat" %>
<%@include file="auth.jsp"%>
<%@ include file="jdbc.jsp" %>

<%
	getConnection();
	boolean addProductSuccessful=false;
	NumberFormat toNum = NumberFormat.getInstance();

	try{
		// adding new product 
		String productName = (String)request.getParameter("productName");
		String categoryId = (String)request.getParameter("categoryId");
		String productDesc = (String)request.getParameter("productDesc");
		String productPrice = (String)request.getParameter("productPrice");
		
		String insertProdSql = "INSERT product (productName,categoryId,productDesc,productPrice) VALUES (?,?,?,?)";
		PreparedStatement insertProdPst = con.prepareStatement(insertProdSql);
		insertProdPst.setString(1,productName);
		insertProdPst.setInt(2,Integer.parseInt(categoryId));
		insertProdPst.setString(3,productDesc);
		insertProdPst.setFloat(4,Float.parseFloat(productPrice));
		insertProdPst.executeUpdate();
		addProductSuccessful = true;
		
		if(addProductSuccessful){
			out.println(productName +" was successfully added to the product list.");

			String insertProdResultSql = "SELECT productName,categoryId,productDesc,productPrice FROM product";
			PreparedStatement insertProdResultPst = con.prepareStatement(insertProdResultSql);
			ResultSet insertProdResultRst = insertProdResultPst.executeQuery();
			out.println("<h3>Updated Product List</h3><table class=table border=1>");
			out.println("<tr><th>Product Name</th><th>Category ID</th><th>Product Description</th><th>Product Price</th></tr>");
			while (insertProdResultRst.next()){
				out.println("<tr><td>"+insertProdResultRst.getString(1)+"</td><td>"+insertProdResultRst.getString(2)+"</td><td>"+insertProdResultRst.getString(3)+"</td><td>"+insertProdResultRst.getString(4)+"</td></tr>");
			}
			
			addProductSuccessful=false; // reset
		}

	} catch(Exception e) {
		out.println("Exception occurred: " + e);
	}
%>

</body>
</html>