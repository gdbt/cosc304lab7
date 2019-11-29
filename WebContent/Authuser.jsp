<%
	boolean authenticated = session.getAttribute("authenticatedNewUser") == null ? false : true;

	if (!authenticated)
	{
		String createMessage = "Please fill out all the information below "+request.getRequestURL().toString();
        session.setAttribute("createMessage",createMessage);        
		response.sendRedirect("newuser.jsp");
	}
%>