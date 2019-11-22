
<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>

<%@include file="auth.jsp"%>
<%@ include file="jdbc.jsp" %>

<%
// TODO: Write SQL query that prints out total order amount by day

try{
	String userName = (String) session.getAttribute("authenticatedUser");
	getConnection();
	
	String getcustId = "SELECT customerid FROM customer WHERE userid = ? ";
	PreparedStatement pstmt = con.prepareStatement(getcustId);
	pstmt.setString(1,userName);
	ResultSet rst = pstmt.executeQuery();
	rst.next();
	int custid = Integer.parseInt(rst.getString(1));
	String sql = "SELECT DISTINCT orderDate, SUM(totalamount) FROM ordersummary WHERE customerid = ? GROUP BY orderDate";
	PreparedStatement pstmt2 = con.prepareStatement(sql);
	pstmt2.setInt(1, custid);
	ResultSet rst2 = pstmt2.executeQuery();
	
	out.println("<h2>Administrator Sales Report by Day</h2>");
	out.println("<table class=table border=1><tbody><tr><th>Date </th><th> Total Order Amount </th></tr>");
	while(rst2.next()){
		Date date = rst2.getDate(1);
		double orderTotal = Double.parseDouble(rst2.getString(2));
		out.println("<tr><td>"+date+"</td><td>$"+orderTotal+"</td></tr>");
	}
	
	out.println("</tbody></table>");
	
	
	
}
catch(SQLException e){
	out.println(e);
}
%>

</body>
</html>

