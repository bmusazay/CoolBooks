<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@ page import="data.dbConnect.RatingDB" %>
<%@ page import="data.dbConnect.BookDatabase" %>
<%@ page import="rating.Rating" %>
<%@ page import="book.Book" %>
<%@ page import="user.User" %>
<%@ page import="java.util.*" %>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<style type="text/css">
	
	body {
    	background-image: url('http://i.imgur.com/4K8qUHG.jpg'), url('http://i.imgur.com/EX0x72e.jpg');
    	background-repeat: no-repeat, repeat;
    	margin-top: 250px;
    	margin-left: 100px;
    	margin-right: 100px;
	    padding: 0;
	}
	
	h1 {
		font-family: 'Verdana', 'Geneva', sans-serif;
		color: #FFFFFF;
		font-size: 20px;
		margin-bottom: 30px;
	}
		
	h2 {
		font-family: 'Verdana', 'Geneva', sans-serif;
		color: #FF0000;
	}
	
	h3 {
		font-family: 'Verdana', 'Geneva', sans-serif;
		color: #FFFFFF;
		font-size: 40px;
	}
	
	h4 {
		font-family: 'Verdana', 'Geneva', sans-serif;
		color: #FFFFFF;
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
	
	#link {
	  color: #FFFFFF;
	  font-family: 'Verdana', 'Geneva', sans-serifS;
	  font-size: 15px;
	  margin: 80px;
	}
	
	
	#search { position: absolute; right: 20px; right: 150px; top: 75px; }
	
	#category {
	  display: inline-block;
      vertical-align: top;
	  background-color: #99CCFF;
	  color: #666;
	  font-family: 'Verdana', 'Geneva', sans-serif;
	  font-size: 20px;
	  border: 1px solid #FFFFFF;
	  padding: 6px 4px;
	  border-radius: 3px;
	  margin-right: 10px;
	}
	
	#searchbutton { margin-right: 10px; }
	#searchfield { margin-right: 20px; padding: 4px 20px; }
	
	#user { width: 100px; position: absolute; right: 20px; top: 75px;}
	#loginout { float: right; }
	#account { float: right; margin-top: 10px;}
	
	table, th, td { color: #FFFFFF; border-collapse: collapse; border: 1px solid #FFFFFF; }

	
	#books { width: 95%;} 
	#bookPic { width: 25%;}
	#info { width: 75%; }
	#image { width: 150px; height: 199px; margin: 25px;}
	
	#page { width: 500px; margin: 50px auto; margin-bottom: 150px;}
	#next { float: right; }
	#previous { float: right; margin-right: 15px; }
	#pageNumber { float: right; font-family: 'Verdana', 'Geneva', sans-serif; font-size: 15px; margin-right: 10px; margin-top: 10px;}
	
	</style>
	<title>Ratings</title>
</head>
<body>


<% 
RatingDB ratingDB = new RatingDB();

String email = (String)request.getParameter("email");
String isbn = (String)request.getParameter("isbn");
		
ArrayList<Rating> ratings;

if (email != null && email.length() != 0) {
	isbn = "";
	%><form action="accountPage.jsp" method="post">	
		<input type="submit" value="Return to Account Page" id="loginout"/>
	</form><%
	%><h3>Ratings for user: <%=email%></h3> <%
	ratings = ratingDB.getUserRatings(email);
} else if (isbn != null && isbn.length() != 0) {
	email = "";
	BookDatabase bookDB = new BookDatabase();
	ratings = ratingDB.getBookRatings(isbn);
	%><form action="Product.jsp?isbn=<%=isbn%>" method="post">	
	<input type="submit" value="Return to Book Page" id="loginout"/>
</form><%
	
	%><h3>Ratings for book: <%=bookDB.getBook(isbn).getTitle()%> <%if (bookDB.getBook(isbn).getTitle().length() >= 49) { %>...<%} %></h3> <%
	%><h1>Average rating: <%=bookDB.getRatings(isbn)%> / 10</h1><%
} else {
	isbn = "";
	email = "";
	%><h3>All ratings: <%=isbn%></h3> <%
	ratings = ratingDB.getAllRatings();
}

if (ratings.size() != 0) { %>
	<table id="books">
		<thead>
			<tr>
				<th>Date</th>
						<% if (email.length() == 0) {%>
							<th>Email</th>
						<%}%>
						<% if (isbn.length() == 0) {%>
							<th>ISBN</th>
						<%}%>
				<th>Rating</th>
				<th>Review</th>
			</tr>
		</thead>
		<tbody>
  <%int pageNo;
	if (request.getParameter("page") == null) {
		pageNo = 1;
	} else {
		pageNo = Integer.parseInt((String)request.getParameter("page"));
	}
	int maxNo = ratings.size() - 1;
	int maxPerPage = 20;
	for(int i = (pageNo - 1) * maxPerPage; i < (pageNo - 1) * maxPerPage + maxPerPage; i++){
		if (i < ratings.size()) {
			Rating rating = ratings.get(i);
	%>
					<tr>
						<td><%=ratings.get(i).getReviewDate()%></td>
						<% if (email.length() == 0) {%>
							<td><%=ratings.get(i).getEmail()%></td>
						<%}%>
						<% if (isbn.length() == 0) {%>
							<td><%=ratings.get(i).getIsbn()%></td>
						<%}%>
						<td><%=ratings.get(i).getRating()%></td>
						<td><%=ratings.get(i).getReview()%></td>
					</tr>
	<% }
	}%>
				</tbody>
			</table>
<section id="page">
	<%if (pageNo * maxPerPage > maxNo) { %>
		<form action="ratings.jsp?email=<%=email%>&isbn=<%=isbn%>&page=<%=pageNo + 1%>" method="post">	
			<input type="submit" value="Next Page" id="next" disabled/>
		</form>
	<%} else { %>
		<form action="ratings.jsp?email=<%=email%>&isbn=<%=isbn%>&page=<%=pageNo + 1%>" method="post">	
			<input type="submit" value="Next Page" id="next"/>
		</form>
	<%}%>
	
	<h4 id="pageNumber"> Page <%=pageNo%> / <%=maxNo / maxPerPage + 1%> </h4>
	
	<%if (pageNo - 1 < 1) { %>
		<form action="ratings.jsp?email=<%=email%>&isbn=<%=isbn%>&page=<%=pageNo - 1%>" method="post">		
			<input type="submit" value="Previous Page" id="previous" disabled/>
		</form>
	<%} else { %>
		<form action="ratings.jsp?email=<%=email%>&isbn=<%=isbn%>&page=<%=pageNo - 1%>" method="post">	
			<input type="submit" value="Previous Page" id="previous"/>
		</form>
	<%}
} else {%>
	<h2>No ratings.</h2>
<%}%>

</section>


</body>
</html>