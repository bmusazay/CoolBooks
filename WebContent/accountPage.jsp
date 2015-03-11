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
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Your Account</title>
<link rel="stylesheet" href="css/c06.css"/>
</head>
<body>

<%
	String status = request.getParameter("status");
	User sessionUser = (User)session.getAttribute("userInstance");
	if (sessionUser != null) {
		UserDatabase userDB = new UserDatabase();
		User tempUser = userDB.selectUser(sessionUser.getEmail());
		out.println("<h1> Email:"+tempUser.getEmail()+"<h1>");
		out.println("<h1> First Name:"+tempUser.getFName()+"<h1>");
		out.println("<h1> Last Name:"+tempUser.getLName()+"<h1>");
		%>
		<form action="UpdateUser" name="form1" id="form1" method="post">
		
		<h1>Update Credentials</h1>
		<%
			if (status!= null)
			{
				%>
				<font color="green">Successfully changed.</font>
				<% 
			}
		%>
		
		<%if (session.getAttribute("signup") != null && !(boolean)session.getAttribute("signup")) {
			session.removeAttribute("signup");%>
			<h2>This email is already associated with an account. Please select a different email.</h2>
		<%}%>
		
		<input type="hidden" name="oldEmail" value="<%=tempUser.getEmail()%>">
		<div>
			<label> Password : </label>
			<input type="password" name="pass" id="pass" required="required"/>
		</div>
		
		<div> 
			<label> Confirm Password : </label>
			<input type="password" name="repass" id="repass" required="required"/>
		</div>
			<div> <label> First Name : </label>
			<input type="text" value="<%= tempUser.getFName() %>"name="fname" id="fname" required="required"/>
		</div>
			<div> <label> Last Name : </label>
			<input type="text" value="<%= tempUser.getLName() %>"name="lname" id="lname" required="required"/>
		</div>
		
		<input type="submit" value="Update Account" id="submit"/>
	
	</form>
		
	<br>
	
	
	<table>
		<thead>
			<tr>
				<th>Order Number </th>
				<th>Date</th>
				<th>ISBN</th>
				<th>Quantity</th>
				<th>Total</th>
			</tr>
		</thead>
		<tbody>
<%
	
	TransactionDB transactionDB = new TransactionDB();
	ArrayList<Transaction> transactions = transactionDB.getTransactions(tempUser.getEmail());
	for(int i = 0; i < transactions.size(); i++){
		out.println("<tr>");
		out.println("<td>"+transactions.get(i).getTranNumber()+"</td>");
		out.println("<td>"+transactions.get(i).getTranDate()+"</td>");
		out.println("<td>"+transactions.get(i).getIsbn()+"</td>");
		out.println("<td>"+transactions.get(i).getQuantity()+"</td>");
		out.println("<td>"+transactions.get(i).getTotal()+"</td>");
		out.println("</tr>");
	}
%>
		<form action="ratings.jsp?email=<%=sessionUser.getEmail()%>" method="post">
			<input type="submit" value="View Ratings" id="rate"/>
		</form>
	<%} else {
		response.sendRedirect("loginForm.jsp");
	}%>
</body>
</html>