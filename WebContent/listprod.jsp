<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order List</title>
</head>
<body>

<h1>Order List</h1>

<%
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
 NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00 

// Make connection
String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_narndt;";
String uid = "narndt";
String ps = "43873165";
try(Connection con = DriverManager.getConnection(url,uid,ps);Statement stmt = con.createStatement();){
	String sql = "SELECT * FROM ordersummary,customer WHERE ordersummary.customerId = customer.customerId "; 
	ResultSet rst = stmt.executeQuery(sql);
	out.println("<h2>Orders<h2><table border=1><tr><th>OrderId  </th><th>Order Date </th><th>CustomerId </th><th>Customer Name </th><th>Total Amount </th></tr>");
	while(rst.next()){
		out.println("<tr><td>"+rst.getString("orderId")+"</td><td>"+rst.getDate("orderDate")+"</td><td>"+rst.getString("customerId")+"</td><td>"+rst.getString("firstName")+" "+rst.getString("lastName")+"</td><td>"+currFormat.format(rst.getFloat("totalAmount"))+"</td></tr>");
		String ord = rst.getString("orderId");
		String sql2 = "SELECT productId, quantity, price FROM orderproduct WHERE orderId = ?";
		PreparedStatement pstmt = con.prepareStatement(sql2);
		pstmt.setString(1,ord);
		ResultSet rst2 = pstmt.executeQuery();
		out.println("<tr align=right><td colspan=5><table border=1><td><th>Product Id  </th><th>Quantity  </th><th>Price  </th></tr>");

		while(rst2.next()){
			out.println("<tr><td>"+rst2.getString("productId")+"</td><td>"+rst2.getString("quantity")+"</td><td>"+currFormat.format(rst2.getFloat("price"))+"</td></tr></table>");
		}
	}
	
	out.println("</table>");

con.close();
}
// Write query to retrieve all order summary records

// For each order in the ResultSet

	// Print out the order summary information
	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	// For each product in the order
		// Write out product information 

// Close connection
%>

</body>
</html>

