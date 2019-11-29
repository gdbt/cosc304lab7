<!DOCTYPE html>
<html>
<head>
<title>Create New User</title>
</head>
<body>
<div style="margin:0 auto;text-align:center;display:inline">
<h1>Edit Information Below</h1>
<%
// Print prior error login message if present
if (session.getAttribute("createMessage") != null)
	out.println("<p>"+session.getAttribute("createMessage").toString()+"</p>");
%>
<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp" %>
<%String userName = (String) session.getAttribute("authenticatedUser");%>

<%
String firstname = null;
String lastname = null;
String email = null;
String phonnum = null;
String address = null;
String city = null;
String state = null;
String postalcode = null;
String country = null;
try{
	getConnection();	
	
	// TODO: Print Customer information
	PreparedStatement pst = con.prepareStatement("SELECT * FROM customer WHERE userid = ?");
	pst.setString(1,userName);
	ResultSet rst = pst.executeQuery();
	// retrieving customer information by id and displaying it (+4)
	rst.next();
	firstname = rst.getString(2);
	lastname = rst.getString(3);
	email = rst.getString(4);	
	phonnum = rst.getString(5);
	address = rst.getString(6);
	city = rst.getString(7);
	state = rst.getString(8);
	postalcode = rst.getString(9);
	country = rst.getString(10);	
}
catch (Exception e){
	out.println("EXCEPTION: " + e);
}
finally {
	// Make sure to close connection
	closeConnection();
}
%>
<br>
<form name="MyForm" method=post action="updatecustomer.jsp">
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">First Name:</font></div></td>
	<td><input type="text" name="firstname" size=20 maxlength="20" value= <%=firstname %>></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Last Name:</font></div></td>
	<td><input type="text" name="lastname" size=20 maxlength="20" value= <%=lastname %>></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Email Address:</font></div></td>
	<td><input type="text" name="emailaddress" size=20 maxlength="30" value= <%=email %>></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Phone Number:</font></div></td>
	<td><input type="text" name="phonum" size=20 maxlength="20" value= <%=phonnum %>></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Address:</font></div></td>
	<td><input type="text" name="address" size=20 maxlength="50" value= <%=address %>></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">City:</font></div></td>
	<td><input type="text" name="city" size=20 maxlength="20" value= <%=city %>></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">State:</font></div></td>
	<td><input type="text" name="state" size=20 maxlength="20" value= <%=state %>></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Postal Code:</font></div></td>
	<td><input type="text" name="postalcode" size=20 maxlength="20" value= <%=postalcode%>></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Country:</font></div></td>
	<td><input type="text" name="country" size=20 maxlength="20" value= <%=country%>></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit4" value="Update">
</form>

</div>
</body>
</html>