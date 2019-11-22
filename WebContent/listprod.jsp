<%@ page import= "java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<%-- +1 SQL server connection information and making successful connection --%>
<%-- +2 using product name parameter to filter products shown (must handle case where nothing is provided in which case all 
products are shown --%>
<%-- +2 displaying table of products --%>
<%-- +3 building web link URL to allow products to be added to cart --%>
<%-- +1 for closing connection (either explicitly or as part of try-catch with resources syntax) --%>

<!DOCTYPE html>
<html>
<head>
<title>Legal Future Technology Wholesaler</title>
</head>
<body>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for
String name = request.getParameter("productName");
boolean hasQuery = name!=null && !name.equals("");
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " + e);
}
// Make the connection
String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_narndt;";
String uid = "narndt";
String ps = "43873165";
ResultSet allprodrst = null, prodqueryrst = null;
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
//Variable name now contains the search string the user entered
//Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!
try (Connection con = DriverManager.getConnection(url,uid,ps);
){		
	
	if (!hasQuery){
		// prepared statement listing all products
		PreparedStatement allprodpst = con.prepareStatement("SELECT * FROM product,category WHERE product.categoryId = category.categoryId ORDER BY category.categoryId ASC");
		allprodrst = allprodpst.executeQuery();
		
		// print all products
		out.println("<h2>All Products</h2><table class=table border=1><tbody><tr><th></th><th>Product Name </th><th>Price </th><th>Category</th</tr>");
		while (allprodrst.next()) {
			//For each product create a link of the form
			// addcart.jsp?id=productId&name=productName&price=productPrice
			
			String produrl = "\"addcart.jsp?id="+allprodrst.getString(1)+"&name="+allprodrst.getString(2)+"&price="+allprodrst.getString("productPrice"); 
			String produrl2 = "\"product.jsp?id="+allprodrst.getString(1); 
			String namer = allprodrst.getString("productName");
			String catname = allprodrst.getString("categoryName");
			int catid = Integer.parseInt(allprodrst.getString("categoryId"));
			// Print out the ResultSet
			String catcolorcode = "#ff0080";
			if(catid == 2){
				catcolorcode = "#2929A3";
			}
			else if(catid == 3){
				catcolorcode = "#004D1A";
			}
			out.println("<tr><td><a href="+produrl+"\">Add to cart</a></td><td><a href="+produrl2+"\">"+namer+"</a></td><td>"+currFormat.format(allprodrst.getFloat("productPrice"))+"</td><td><font color=\""+catcolorcode+"\">"+catname+"</font></td></tr>");
		}
		out.println("</tbody></table>");	
	}
	else{
		// prepared statement listing queried products
		PreparedStatement prodquerypst = con.prepareStatement("SELECT * FROM product,category WHERE product.categoryId = category.categoryId and productName LIKE ? ORDER BY category.categoryId ASC");
		prodquerypst.setString(1, "%"+name+"%");
		prodqueryrst = prodquerypst.executeQuery();
		
		
		// print query resultset 
		out.println("<h2>Products containing '"+name+"'</h2><table><tr><th></th><th>Product Name </th><th>Price </th><th>Category</th></tr>");
		while (prodqueryrst.next()){
			String catnames = prodqueryrst.getString("categoryName");
			int catid = Integer.parseInt(prodqueryrst.getString("categoryId"));
			// Print out the ResultSet
			String catcolorcode = "#ff0080";
			if(catid == 2){
				catcolorcode = "#2929A3";
			}
			else if(catid == 3){
				catcolorcode = "#004D1A";
			}
			
			String produrl = "product.jsp?id="+prodqueryrst.getString(1)+"&name="+prodqueryrst.getString(2)+"&price="+prodqueryrst.getFloat(3);
			out.println("<tr><td><a href="+produrl+">Add to cart</a></td><td>"+prodqueryrst.getString(2)+"</td><td>"+currFormat.format(prodqueryrst.getFloat(3))+"</td><td><font color=\""+catcolorcode+"\">"+catnames+"</font></td></tr>");
		}
		out.println("</table>");
	}
	
	// close connection
	if (con!=null) con.close();
	
}
catch (SQLException e) {
	out.println("SQLException: " + e);
}
// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>

</body>
</html>
