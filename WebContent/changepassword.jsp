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

<br>
<form name="MyForm" method=post action="confirmnewpassword.jsp">
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Old Password:</font></div></td>
	<td><input type="password" name="op" size=20 maxlength="20" ></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">New Password:</font></div></td>
	<td><input type="password" name="np" size=20 maxlength="20" ></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Confirm New Password:</font></div></td>
	<td><input type="password" name="cnp" size=20 maxlength="20" ></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit4" value="Update">
</form>

</div>
</body>
</html>