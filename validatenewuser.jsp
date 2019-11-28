<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
	String authenticatedNewUser = null;
	session = request.getSession(true);
	System.out.println("here1");
	try
	{
		authenticatedNewUser = validatenewuser(out,request,session);
	}
	catch(IOException e)
	{System.err.println(e); }

	if(authenticatedNewUser != null)
		response.sendRedirect("login.jsp");		// Successful insert
	else
		response.sendRedirect("newuser.jsp");		// Failed insert - redirect back to new userpage with a message 
%>


<%!
	String validatenewuser(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
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
		String username = request.getParameter("userid");
		String password = request.getParameter("password");
		String passwordval = request.getParameter("validatepassword");
		System.out.println(firstname +lastname +email + phonnum + address + city + username + password);

		if(username == null || password == null || passwordval == null || firstname == null || lastname == null || email == null || phonnum == null || address == null || city == null || postalcode == null){
			return null;
		}
		if((username.length() == 0) || (password.length() == 0) ||  (passwordval.length() == 0) || (firstname.length() ==0) || (lastname.length() == 0) || (email.length() == 0) || (phonnum.length() == 0) || (address.length() == 0) || (city.length() == 0) || (postalcode.length() == 0)){
			return null;
	}
		try
		{
			getConnection();
			String sql = "INSERT INTO customer(firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
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
			pstmt.setString(10, username);
			pstmt.setString(11, password);
			
			if(password.equals(passwordval)){
				pstmt.executeUpdate();
				retStr = username;
			}
			else
				session.setAttribute("createMessage", "Passwords do not match.");
			
			
			
		} 
		catch (SQLException ex) {
			session.setAttribute("createMessage","SQL error");
		}
		finally
		{
			closeConnection();
		}	
		
		if(retStr != null)
		{	session.removeAttribute("createMessage");
		}
		else
			session.setAttribute("createMessage","Invalid information below.");
		

		return retStr;
	}
%>