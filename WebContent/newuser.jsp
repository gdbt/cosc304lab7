
<!DOCTYPE html>
<html>
<head>
<title>Create New User</title>
</head>
<body>
<div style="margin:0 auto;text-align:center;display:inline">
<h1>Please Fill In The Information Below</h1>
<%
// Print prior error login message if present
if (session.getAttribute("createMessage") != null)
	out.println("<p>"+session.getAttribute("createMessage").toString()+"</p>");
%>
<br>
<form name="MyForm" method=post action="validatenewuser.jsp">
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">First Name:</font></div></td>
	<td><input type="text" name="firstname"  size=20 maxlength="20"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Last Name:</font></div></td>
	<td><input type="text" name="lastname" size=20 maxlength="20"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Email Address:</font></div></td>
	<td><input type="text" name="emailaddress" size=20 maxlength="30"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Phone Number:</font></div></td>
	<td><input type="text" name="phonum" size=20 maxlength="20"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Address:</font></div></td>
	<td><input type="text" name="address" size=20 maxlength="50"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">City:</font></div></td>
	<td><input type="text" name="city" size=20 maxlength="20"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">State:</font></div></td>
	<td><input type="text" name="state" size=20 maxlength="20"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Postal Code:</font></div></td>
	<td><input type="text" name="postalcode" size=20 maxlength="20"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Country:</font></div></td>
	<td><input type="text" name="country" size=20 maxlength="20"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">User Id:</font></div></td>
	<td><input type="text" name="userid" size=20 maxlength="20"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
	<td><input type="password" name="password" size=20 maxlength="20"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password Again:</font></div></td>
	<td><input type="password" name="validatepassword" size=20 maxlength="20"></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit3" value="Submit">
</form>

</div>
</body>
</html>