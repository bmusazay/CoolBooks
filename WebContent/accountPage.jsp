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
<title>Insert title here</title>
<link rel="stylesheet" href="css/c06.css"/>
</head>
<body>

<%
		
	User sessionUser = (User)session.getAttribute("userInstance");
	if (sessionUser != null) {
		UserDatabase userDB = new UserDatabase();
		User tempUser = userDB.selectUser(sessionUser.getEmail());
		out.println("<h1> Email:"+tempUser.getEmail()+"<h1>");
		out.println("<h1> First Name:"+tempUser.getFName()+"<h1>");
		out.println("<h1> Last Name:"+tempUser.getLName()+"<h1>");		
%>
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
		</tbody>
	</table>
	
	<table>
		<thead>
			<tr>
				<th>Review Date</th>
				<th>ISBN</th>
				<th>Review</th>
				<th>Rating</th>
			</tr>
		</thead>
		<tbody>
<%
	RatingDB ratingDB = new RatingDB();
	
	ArrayList<Rating> ratings = ratingDB.getUserRatings(tempUser.getEmail());
	
	
	for(int i = 0; i < ratings.size(); i++){
		out.println("<tr>");
		out.println("<td>"+ratings.get(i).getReviewDate()+"</td>");
		out.println("<td>"+ratings.get(i).getIsbn()+"</td>");
		out.println("<td>"+ratings.get(i).getReview()+"</td>");
		out.println("<td>"+ratings.get(i).getRating()+"</td>");
		out.println("</tr>");
	}
%>
		</tbody>
	</table>
	<%} else {
		response.sendRedirect("loginForm.jsp");
	}%>
</body>
</html>