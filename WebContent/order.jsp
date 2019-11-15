<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order Processing</title>
</head>
<body>

<% 
// Get customer id
String custId = request.getParameter("customerId");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
// Determine if valid customer id was entered
// Determine if there are products in the shopping cart
// If either are not true, display an error message
// Make connection
String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_narndt;";
String uid = "narndt";
String ps = "43873165";
// Save order information to database
try(Connection con = DriverManager.getConnection(url,uid,ps);){
	
	Boolean tester = false;
	String sql = "SELECT firstName, lastName, customerId  FROM customer";
	PreparedStatement pst = con.prepareStatement(sql);
	ResultSet rst = pst.executeQuery();
	while(rst.next() && tester == false){
		String cussy = rst.getString("customerId");
		if(cussy.equals(custId)){
			tester = true;
		}
	}
	
	if(tester == true){
		String fname = rst.getString("firstName");
		String lname = rst.getString("lastName");
		String fullname = (fname + " " + lname);
		
		if(productList.size() == 0){
			out.println("<body><h1>Your shopping cart is empty. Please go back and add something.</h1></body>");
		}
		else{
			//Use retrieval of auto-generated keys.

			String ssql ="SELECT orderId FROM ordersummary ";
			PreparedStatement derp = con.prepareStatement(ssql, Statement.RETURN_GENERATED_KEYS);
			derp.execute();
			ResultSet keys = derp.getGeneratedKeys();
			keys.next();
			int orderId = keys.getInt(1);
			
			String sql3 = "INSERT INTO ordersummary (totalAmount,customerId) VALUES (?,?)";
			PreparedStatement pstmt = con.prepareStatement(sql3);
			double tot = 0.0;
			pstmt.setDouble(1,tot);
			pstmt.setString(2,custId);
			pstmt.executeUpdate();
			System.out.println("Insert ordersummary successfull");
			

			

			// Insert each item into OrderProduct table using OrderId from previous INSERT
			// Update total amount for order record
			// Here is the code to traverse through a HashMap
			// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price
		
			Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
			while (iterator.hasNext())
			{ 
				Map.Entry<String, ArrayList<Object>> entry = iterator.next();
				ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
				String productId = (String) product.get(0);
	        	String price = (String) product.get(2);
				double pr = Double.parseDouble(price);
				int qty = ((Integer)product.get(3)).intValue();
				int prodid = Integer.parseInt(productId);
				
				System.out.println(productId);
				System.out.println(price);
				System.out.println(pr);
				System.out.println(qty);
				System.out.println("Order id = " + orderId);

				String sqlinpo = ("INSERT INTO orderproduct (productId, quantity, price) VALUES (ordersummary.orderId,?,?,?)");
				PreparedStatement pst4 = con.prepareStatement(sqlinpo);
				//pst4.setInt(1,orderId);
				pst4.setInt(1,prodid);
				pst4.setInt(2,qty);
				pst4.setDouble(3,pr);
				pst4.executeUpdate();
				double totitemprice = qty*pr;
            	tot += totitemprice;
			}
			System.out.println("We got here post insert"); //DOES NOT REACH THIS AREA
			String updatekeys = "UPDATE ordersummary SET totalAmount = ? WHERE orderId = ?";
			PreparedStatement pst5 = con.prepareStatement(updatekeys);
			pst5.setDouble(1,tot);
			pst5.setInt(2,orderId);
			
			//HTML time
			String productgrab = "SELECT productId, productName, quantity, price FROM product,orderproduct WHERE product.productId = orderproduct.productId AND orderId = ? ";
			PreparedStatement pst6 = con.prepareStatement(productgrab);
			pst6.setInt(1,orderId);
			ResultSet rstins = pst6.executeQuery();
			out.println("<h1>Your Order Summary</h1>");
			
			out.println("<table><tbody><tr><th>Product Id  </th><th>Product Name </th><th>Quantity </th><th>Price </th><th>Sub Total</th></tr>");
			while(rstins.next()){
				int quant = Integer.parseInt(rstins.getString("quantity"));
				double pric = Double.parseDouble(rstins.getString("price"));
				double subt = quant*pric;
				out.println("<tr><td>"+rstins.getString("productId")+"</td><td>"+rstins.getString("productName")+"</td><td>"+quant+"</td><td"+pric+"</td><td>"+subt+"</td></tr>");
				
			}
			
			out.println("<tr><td>Order Total</td><td>$"+tot+"</td></tr></tbody></table>");
			out.println("<h1>Order completed. Order will be shipped to your address</h1>");
			out.println("<h1>Your order number is: "+ orderId+"</h1>");
			out.println("<h1>Shipping to customer: "+custId+" Name: "+fullname+"</h1>");
			out.println("<h2><a href = shop.html>Return to shopping</a></h2>");
			productList.clear();
			
			
// Print out order summary
// Clear cart if order placed successfully
		}
	}
	else{
		out.println("<body><h1>Invalid cusotmer Id. Please go back to previous page and try again</h1></body>");
	}
	con.close();
	}catch(SQLException e){
		out.println("<body><h3>"+e+"</h3></body>");
	}
	
%>
</BODY>
</HTML>
