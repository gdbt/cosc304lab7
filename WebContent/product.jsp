<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Ray's Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<%
// Get product name to search for
// TODO: Retrieve and display info for the product

		String productId = request.getParameter("id");
		System.out.println(productId);
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_narndt;";
		String uid = "narndt";
		String ps = "43873165";
		// Save order information to database
		try(Connection con = DriverManager.getConnection(url,uid,ps);){
		
			String sql = "SELECT * FROM product WHERE productId = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1,productId);
			ResultSet rst = pstmt.executeQuery(); //executes query to get information relative to product id.
			
			rst.next(); //grabbing info
			String imgurl = rst.getString("productImageURL");
			String pname = rst.getString("productName");
			String price = rst.getString("productPrice");
			String desc = rst.getString("productDesc");
			//printing out the html words
			out.println("<h1>Legal Future Technology</h1>");
			out.println("<h2>"+pname+"</h2>");
			System.out.println(pname);
			System.out.println(price);
			System.out.println(imgurl);
			if(imgurl.length() > 0){
				out.println("<img src=\""+imgurl+"\">"); //Image location may need quotations, so i put them anyways.
				
				out.println("<img src=\"displayImage.jsp?id="+productId+"\">"); //checks the product id if there is one there
			}
			else{
				//if there is no imgurl
			}
			out.println("<table><tbody><tr><th>Id</th><td>"+productId+"</td></tr>"); //making the mini table
			out.println("<tr><th>Price</th><td>$"+price+"</td></tr></tbody></table>");
			out.println("<h4>Description!</h4>");
			out.println("<h5>"+desc+"</h5>");
			String produrl = ("\"addcart.jsp?id="+productId+"&name="+pname+"&price="+price);
			out.println("<h3><a href="+produrl+"\">Add to cart</a></h3>"); //add it to cart
			
			out.println("<h3><a href = listprod.jsp>Return to shopping</a></h3>"); //goes back to shopping
		}catch(SQLException e){
			System.out.println(e);
		}


// TODO: If there is a productImageURL, display using IMG tag
		
// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
		
// TODO: Add links to Add to Cart and Continue Shopping
%>

</body>
</html>

