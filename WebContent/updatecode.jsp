<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@ include file="jdbc.jsp" %>

<%

String prodid = (String)  request.getParameter("ProductId");
String prodesc = (String)  request.getParameter("ProductDesc");
String catid = (String)  request.getParameter("CategoryId");
String price = (String)  request.getParameter("Price");
String prodname = (String)  request.getParameter("ProductName");
%>
<%
try{
	getConnection();
	String sqlup = "UPDATE product SET productName= ?, categoryId = ?, productDesc = ?, productPrice = ? WHERE productId = ?";
	PreparedStatement pstmt = con.prepareStatement(sqlup);
	pstmt.setString(1,prodname);
	pstmt.setString(2,catid);
	pstmt.setString(3,prodesc);
	pstmt.setString(4,price);
	pstmt.setString(5,prodid);
	pstmt.executeUpdate();
	out.println("<header><h1>Update Successful</h1></header>");
}catch(Exception e){
}
finally{
	closeConnection();
}

%>
</body>
</html>