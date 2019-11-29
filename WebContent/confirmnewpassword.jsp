<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp"%>

<%
	String updatePassword = null;
	session = request.getSession(true);
	try
	{
		updatePassword = updatepassword(out,request,session);
	}
	catch(IOException e)
	{System.err.println(e); }

	if(updatePassword != null){
		response.sendRedirect("customer.jsp");// Successful insert
		session.setAttribute("createMessage","Password Updated");
	}
	else
		response.sendRedirect("changepassword.jsp");		// Failed insert - redirect back to new userpage with a message 
%>


<%!
	String updatepassword(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String retStr = null;
		String userName = (String) session.getAttribute("authenticatedUser");
		String oldpassword = request.getParameter("op");
		String newpassword = request.getParameter("np");
		String verifynewpassword = request.getParameter("cnp");
		try
		{
			getConnection();
			String getID = "SELECT password FROM customer WHERE userid = ?";
			PreparedStatement custpassword = con.prepareStatement(getID);
			custpassword.setString(1,userName);
			ResultSet rst = custpassword.executeQuery();
			rst.next();
			String getpassword = rst.getString(1);
			if((getpassword.equals(oldpassword)) && (newpassword.equals(verifynewpassword))){
				String sql = "UPDATE customer SET password = ? WHERE userid = ?";
				PreparedStatement pstmt = con.prepareStatement(sql);
				pstmt.setString(1, newpassword);
				pstmt.setString(2,userName);
				pstmt.executeUpdate();
				retStr = userName;
			}
			else{
				session.setAttribute("createMessage","Incorrect old password or new password does not match verification.");
				return null;
			}
			
		} 
		catch (SQLException ex) {
			session.setAttribute("createMessage",ex);
			return null;
		}
		finally
		{
			closeConnection();
		}	
		
		if(retStr == null)
			session.setAttribute("createMessage","Please make sure all the information if filled out.");
		

		return retStr;
	}
%>