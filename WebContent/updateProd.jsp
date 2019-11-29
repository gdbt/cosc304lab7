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
			
			boolean updateProdSuccessful=false;
			
			// updating product details
			String[] productDetails = new String[5];
			productDetails[0]=request.getParameter("productId");
			productDetails[1]=request.getParameter("productName");
			String oldProdName=productDetails[1];
			productDetails[2]=request.getParameter("categoryId");
			productDetails[3]=request.getParameter("productDesc");
			productDetails[4]=request.getParameter("productPrice");
			
			String[] productAttributes = new String[5];
			productAttributes[0]="productId";
			productAttributes[1]="productName";
			productAttributes[2]="categoryId";
			productAttributes[3]="productDesc";
			productAttributes[4]="productPrice";
			
				// generating and executing statements
			for (int i=1; i<productDetails.length; i++){
				if (productDetails[i] != null && !productDetails[i].isEmpty()) {
					String sql = "UPDATE product SET ? = ? WHERE productId=?";
					PreparedStatement pst = con.prepareStatement(sql);
					pst.setString(1,productAttributes[i]);
					if (i==2) pst.setInt(2, Integer.parseInt(productDetails[i]));
					if (i==4) pst.setFloat(2, Float.parseFloat(productDetails[i]));
					else pst.setString(2,"'"+ productDetails[i]+"'");
					pst.setInt(3,Integer.parseInt(productDetails[0]));
					
					pst.executeUpdate();
				}
				else continue;
			}
			
			updateProdSuccessful=true;
			
			if(updateProdSuccessful){
				out.println(productDetails[1]+" was successfully updated.");
				
				// display newly updated table
				String updateProdResultSql = "SELECT productName,categoryId,productDesc,productPrice FROM product";
				PreparedStatement updateProdResultPst = con.prepareStatement(updateProdResultSql);
				ResultSet updateProdResultRst = updateProdResultPst.executeQuery();
				out.println("<h3>Updated Product List</h3><table class=table border=1>");
				out.println("<tr><th>Product Name</th><th>Category ID</th><th>Product Description</th><th>Product Price</th></tr>");
				while (updateProdResultRst.next()){
					out.println("<tr><td>"+updateProdResultRst.getString(1)+"</td><td>"+updateProdResultRst.getString(2)+"</td><td>"+updateProdResultRst.getString(3)+"</td><td>"+updateProdResultRst.getString(4)+"</td></tr>");
				}
				
				updateProdSuccessful=false;	// reset
			}
		
	} catch (Exception e) {
		out.println("Exception occurred: "+ e);
	}
%>
</body>
</html>