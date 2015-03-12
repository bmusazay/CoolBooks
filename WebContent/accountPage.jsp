<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ page import="java.sql.*,java.util.*" %>
<%@ page import="data.dbConnect.DBConnectionPool" %>
<%@ page import="user.User" %>
<%@ page import="data.dbConnect.UserDatabase" %>
<%@ page import="transaction.Transaction" %>
<%@ page import="data.dbConnect.TransactionDB" %>
<%@ page import="rating.Rating" %>
<%@ page import="data.dbConnect.RatingDB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<style type="text/css">
	
	body {
    	background-image: url('http://i.imgur.com/4K8qUHG.jpg'), url('http://i.imgur.com/EX0x72e.jpg');
    	background-repeat: no-repeat, repeat;
    	margin-left: 500px;
	    padding: 0;
	}
	
	h1 {
		font-family: 'Verdana', 'Geneva', sans-serif;
		color: #FFFFFF;
		font-size: 20px;
	}
		
	h2 {
		font-family: 'Verdana', 'Geneva', sans-serif;
		color: #FF0000;
		margin-top: 250px;
		margin-left: 100px;
	}
	
	h4 {
		font-family: 'Verdana', 'Geneva', sans-serif;
		color: #FFFFFF;
		font-size: 40px;
	}
	
	a {
    	color: #FFFFFF;
	}
	
	label {
		color: #FFFFFF;
		float: left;
		width: 10em;
		margin-right: 1em;
		font-family: 'Verdana', 'Geneva', sans-serif;
	  	font-size: 15px;
	}
	
	input[type='text'], input[type='password'], textarea {
	  background-color: #99CCFF;
	  color: #666;
	  font-family: 'Verdana', 'Geneva', sans-serif;
	  font-size: 25px;
	  padding: 4px 6px;
	  border: 1px solid #FFFFFF;
	  margin-bottom:5px;
	  border-radius: 3px;
	}
	
	input[type='submit'], a.add {
	  background-color: #0A193A;
	  color: #FFFFFF;
	  border: 1px solid #FFFFFF;
	  border-radius: 5px;
	  padding: 8px 30px;
	  float: left;
	  font-size: 18px;
	  text-decoration: none;
	  text-transform: uppercase;
	}
	
	input[type='submit']:hover, a.add:hover {
	  background-color: #1C459E;
	  cursor: pointer;
	}
	
	input[type='submit']:disabled, a.add:disabled {
   		background: #2A2E38;
   		color: #666;
   		cursor: default;
   		border: 1px solid #666;
	}
	
	#ratings {margin: 5px;}
	#transactions {margin: 5px;}
	#update {margin: 5px;}
	
	#loginout { float: right; margin-left: 600px; margin-bottom: 200px; margin-right: 75px;}

	
	</style>
	<title>Your Account</title>
</head>
<body>

	<form action="front.jsp" method="post">	
		<input type="submit" value="Return to Search Page" id="loginout"/>
	</form>
	<h4>Account Page:</h4>
<%
	String status = request.getParameter("status");
	User sessionUser = (User)session.getAttribute("userInstance");
	if (sessionUser != null) {
		UserDatabase userDB = new UserDatabase();
		User tempUser = userDB.selectUser(sessionUser.getEmail());%>
		
		<h1> Email: <%=tempUser.getEmail()%><h1>
		<h1> First Name: <%=tempUser.getFName()%><h1>
		<h1> Last Name: <%=tempUser.getLName()%><h1>

	<form action="ratings.jsp?email=<%=sessionUser.getEmail()%>" method="post">
		<input type="submit" value="View Ratings" id="ratings"/>
	</form>
	
	<form action="transactions.jsp?email=<%=sessionUser.getEmail()%>" method="post">
		<input type="submit" value="View Transactions" id="transactions"/>
	</form>
	
	<form action="updateCredentials.jsp" method="post">
		<input type="submit" value="Update Account" id="update"/>
	</form>
	<%} else {
		response.sendRedirect("loginForm.jsp");
	}%>
</body>
</html>