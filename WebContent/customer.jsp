<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%
try {
	// prep
	NumberFormat numberFormat = NumberFormat.getInstance();
	getConnection();
	
	// statements
	String query = "SELECT * FROM customer WHERE userid = ?";
	String id = "SELECT customerId FROM customer WHERE userid = ?";
	PreparedStatement querypst = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
	PreparedStatement idpst = con.prepareStatement(id);
	
	// TODO: Print Customer information	
	// getting query results
	querypst.setString(1,userName);
	idpst.setString(1,userName);
	ResultSet rst = querypst.executeQuery();
	ResultSet idrst = idpst.executeQuery();
	
	String custId = "";
	while (idrst.next()) custId = idrst.getString("customerId");
	
	// display error message if attempt to access page and not logged in 
	if (!authenticated) {
		String errorMessage = "Error. You need to login before accessing this page.";
		session.setAttribute("errorMessage", errorMessage);
		response.sendRedirect("login.jsp"); // redirect to login page
	}
	
	// retrieving customer information by id and displaying it 
	out.println("<h3>Customer Profile</h3><table class=table border=1>");
	while (rst.next()) {
		out.println("<tr><th>Id</th><td>"+rst.getString("customerId")+"</td></tr>");
		out.println("<tr><th>First Name</th><td>"+rst.getString(2)+"</td></tr>");
		out.println("<tr><th>Last Name</th><td>"+rst.getString(3)+"</td></tr>");
		out.println("<tr><th>Email</th><td>"+rst.getString(4)+"</td></tr>");
		out.println("<tr><th>Phone Number</th><td>"+rst.getString(5)+"</td></tr>");
		out.println("<tr><th>Address</th><td>"+rst.getString(6)+"</td></tr>");
		out.println("<tr><th>City</th><td>"+rst.getString(7)+"</td></tr>");
		out.println("<tr><th>State</th><td>"+rst.getString(8)+"</td></tr>");
		out.println("<tr><th>Postal Code</th><td>"+rst.getString(9)+"</td></tr>");
		out.println("<tr><th>Country</th><td>"+rst.getString(10)+"</td></tr>");
		out.println("<tr><th>Username</th><td>"+rst.getString(11)+"</td></tr>");
	}
	out.println("</table>");
	
}
catch (Exception e){
	out.println("EXCEPTION: " + e);
}
finally {
	// Make sure to close connection
	closeConnection();
}
%>

</body>
</html>

