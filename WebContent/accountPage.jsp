<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ page import="java.sql.*,java.util.*" %>
<%@ page import="data.dbConnect.DBConnectionPool" %>
<%@ page import="user.User" %>
<%@ page import="data.dbConnect.UserDatabase" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Insert title here</title>
<link rel="stylesheet" href="css/c06.css"/>
</head>
<body>

<%
		
	Enumeration en = session.getAttributeNames();
	String name = (String) en.nextElement();
	String email = (String) session.getAttribute(name);

	UserDatabase userDB = new UserDatabase();
	User tempUser = userDB.selectUser(email);
	out.println("<h1> Email:"+tempUser.getEmail()+"<h1>");
	out.println("<h1> First Name:"+tempUser.getFName()+"<h1>");
	out.println("<h1> Last Name:"+tempUser.getLName()+"<h1>");		
%>
</body>
</html>