<%@ page language="java" import="java.io.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Update Product Page</title>
</head>

<body>
<%@include file="auth.jsp"%>
<%@include file="jdbc.jsp"%>
<%
	try{		
			getConnection();
			
			boolean deleteProdSuccessful=false;
			
			// get product id
			String prodID = request.getParameter("productId");
			
			// updating product details
			String sql = "DELETE FROM product WHERE productId=?";
			PreparedStatement pst = con.prepareStatement(sql);
			pst.setInt(1,Integer.parseInt(prodID));
			deleteProdSuccessful=true;
			
			if(deleteProdSuccessful){
				out.println("Product ID"+ prodID +" was successfully deleted.");
				
				// display newly updated table
				String deleteProdResultSql = "SELECT productName,categoryId,productDesc,productPrice FROM product";
				PreparedStatement deleteProdResultPst = con.prepareStatement(deleteProdResultSql);
				ResultSet deleteProdResultRst = deleteProdResultPst.executeQuery();
				out.println("<h3>Updated Product List</h3><table class=table border=1>");
				out.println("<tr><th>Product Name</th><th>Category ID</th><th>Product Description</th><th>Product Price</th></tr>");
				while (deleteProdResultRst.next()){
					out.println("<tr><td>"+deleteProdResultRst.getString(1)+"</td><td>"+deleteProdResultRst.getString(2)+"</td><td>"+deleteProdResultRst.getString(3)+"</td><td>"+deleteProdResultRst.getString(4)+"</td></tr>");
				}
				
				deleteProdSuccessful=false;	// reset
			}
		
	} catch (Exception e) {
		out.println("Exception occurred: "+ e);
	}
%>
</body>
</html>