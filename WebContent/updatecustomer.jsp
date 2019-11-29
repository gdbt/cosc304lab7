<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp"%>
<%
	String updateUser = null;
	session = request.getSession(true);
	try
	{
		updateUser = updateuser(out,request,session);
	}
	catch(IOException e)
	{System.err.println(e); }

	if(updateUser != null)
		response.sendRedirect("customer.jsp");		// Successful insert
	else
		response.sendRedirect("editcustomer.jsp");		// Failed insert - redirect back to new userpage with a message 
%>


<%!
	String updateuser(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String retStr = null;
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		String email = request.getParameter("emailaddress");
		String phonnum = request.getParameter("phonum");
		String address = request.getParameter("address");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String postalcode = request.getParameter("postalcode");
		String country = request.getParameter("country");
		String userName = (String) session.getAttribute("authenticatedUser");
		int customerId;
	
		if(firstname == null || lastname == null || email == null || phonnum == null || address == null || city == null || state == null || postalcode == null || country == null){
			return null;
		}
		if((firstname.length() ==0) || (lastname.length() == 0) || (email.length() == 0) || (phonnum.length() == 0) || (address.length() == 0) || (city.length() == 0) || (state.length() == 0) || (postalcode.length() == 0) || (country.length() == 0)){
			return null;
		}

		try
		{
			getConnection();
			String getID = "SELECT customerId FROM customer WHERE userid = ?";
			PreparedStatement custid = con.prepareStatement(getID);
			custid.setString(1, userName);
			ResultSet rst = custid.executeQuery();
			rst.next();
			customerId = rst.getInt(1);
			String sql = "UPDATE customer SET firstName = ?, lastName = ?, email = ?, phonenum = ?, address = ?, city = ?, state = ?, postalCode = ?, country = ? WHERE customerId = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, firstname);
			pstmt.setString(2, lastname);
			pstmt.setString(3, email);
			pstmt.setString(4, phonnum);
			pstmt.setString(5, address);
			pstmt.setString(6, city);
			pstmt.setString(7, state);
			pstmt.setString(8, postalcode);
			pstmt.setString(9, country);
			pstmt.setInt(10,customerId);
			pstmt.executeUpdate();
			retStr = userName;
		} 
		catch (SQLException ex) {
			session.setAttribute("createMessage",ex);
			return null;
		}
		finally
		{
			closeConnection();
		}	
		
		if(retStr != null)
			session.removeAttribute("createMessage");
		
		else
			session.setAttribute("createMessage","Please make sure all the information if filled out.");
		

		return retStr;
	}
%>