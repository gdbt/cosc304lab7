<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body>
<div style = "margin: 0 auto;text-align:center;display:inline">
<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%
try{
	getConnection();	
	
	// TODO: Print Customer information
	PreparedStatement pst = con.prepareStatement("SELECT * FROM customer WHERE userid = ?");
	pst.setString(1,userName);
	ResultSet rst = pst.executeQuery();
	// display error message if attempt to access page and not logged in (+1)
	if (!authenticated) {
		String errorMessage = "Error. You need to login before accessing this page.";
		session.setAttribute("errorMessage", errorMessage);
		response.sendRedirect("login.jsp"); // redirect to login page
	}
	// retrieving customer information by id and displaying it (+4)
	out.println("<h3>Customer Profile</h3><table align=\"center\" class=table border=1>");
	if (rst.next()) {
		int customerid = rst.getInt(1);
		out.println("<tr><th>Id</th><td>"+customerid+"</td></tr>");
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
		session.setAttribute("custid", customerid);
	}
	else out.println("NOTHING");
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
<%
// Print prior error login message if present
if (session.getAttribute("createMessage") != null)
	out.println("<p>"+session.getAttribute("createMessage").toString()+"</p>");
%>
<h3 align="center"><a href="editcustomer.jsp">Edit Information</a></h3>
<h3 align="center"><a href="changepassword.jsp">Change Password</a></h3>
</div>
</body>
</html>

