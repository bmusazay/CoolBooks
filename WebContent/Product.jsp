<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.*" %>   
<%@ page import="data.dbConnect.BookDatabase" %>
<%@ page import="data.dbConnect.RatingDB" %>
<%@ page import="book.Book" %>
<%@ page import="user.User" %>
<%@ page import="rating.Rating" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% 

	
	String isbn = request.getParameter("isbn");
	BookDatabase bookDB = new BookDatabase();
	
	Book book = bookDB.getBook(isbn);
	
	session.setAttribute("bookInstance", book);
	
	
	out.println("<h1> Product information: </h1>" );
	out.println("<h2> " + book.getTitle() + " </h2>");
	out.println("<p> " + book.getAuthor() + "</p>");
	out.println("<p> "+book.getIsbn()+ "</p>");
	out.println("<p> "+book.getCategory()+ "</p>");
	
	out.println("<img src='./BookImages/" + book.getIsbn() + ".png'/><br>");
	
	
	out.println("<br><br>");
	out.println("<p> Inventory: "+book.getInventory()+ "</p>");
	out.println("<p> Publish year: "+book.getYear()+ "</p>");
	out.println("<p> Price: $"+book.getPrice()+ "</p>");

	User user = (User)session.getAttribute("userInstance");
	
	if (session.getAttribute("rated") != null && !(boolean)session.getAttribute("rated")) {
		session.removeAttribute("rated");%>
		<h2>You have already rated this book.</h2>
	<%}
	
	
	if (user == null) {
		session.setAttribute("referer", "Product.jsp?isbn=" + book.getIsbn());
	%>
		<form action="loginForm.jsp" method="post">	
			<input type="submit" value="Login to buy and rate." id="login"/>
		</form>
	<%} else {
		if (book.getInventory() > 1) {%>
			<form action="Purchase" method="post">
				<input type="submit" value="Purchase" id="submit"/>
			</form>
		<%} else {%>
			<form action="Purchase" method="post">
				<input type="submit" value="Out of Stock" id="submit" disabled/>
			</form>
		<%}
		
		RatingDB ratingDB = new RatingDB();
		boolean rated = ratingDB.alreadyRated(user.getEmail());
		
		if (rated) {%>
			<form action="addRating" method="post">
				<input type="radio" name="rating" value="1">
				<input type="radio" name="rating" value="2">
				<input type="radio" name="rating" value="3">
				<input type="radio" name="rating" value="4">
				<input type="radio" name="rating" value="5">
				<br>
				<textarea name="review" cols="25" rows="7"></textarea> 
		        <br />
				<input type="submit" value="Add Review" id="submitReview"/>
			</form>
		<%}
	}%>
	
	<table>
	<thead>
		<tr>
			<th>Review Date</th>
			<th>User</th>
			<th>Review</th>
			<th>Rating</th>
		</tr>
	</thead>
	<tbody>
<%
	RatingDB ratingDB = new RatingDB();
	ArrayList<Rating> ratings = ratingDB.getBookRatings(book.getIsbn());
	
	for(int i = 0; i < ratings.size(); i++){
		out.println("<tr>");
		out.println("<td>"+ratings.get(i).getReviewDate()+"</td>");
		out.println("<td>"+ratings.get(i).getEmail()+"</td>");
		out.println("<td>"+ratings.get(i).getReview()+"</td>");
		out.println("<td>"+ratings.get(i).getRating()+"</td>");
		out.println("</tr>");
	}
%>
	</tbody>
</table>
		
</body>
</html>