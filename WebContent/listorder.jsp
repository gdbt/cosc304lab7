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
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection
String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_narndt;";
String uid = "narndt";
String ps = "43873165";
Connection con = DriverManager.getConnection(url,uid,ps);
Statement stmt = con.createStatement();
String sql = "SELECT * FROM ordersummary"; 
ResultSet rst = stmt.executeQuery(sql);
while(rst.next()){
	out.println(rst.getString("orderID")+","+rst.getString("orderDate")+rst.getString("totalAmount")+rst.getString("shiptoAddress")+rst.getString("shiptoCity")+rst.getString("shiptoState")+rst.getString("shiptoPostalCode")+rst.getString("shiptoCountry")+rst.getString("customerId"));
	
}
con.close();
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

