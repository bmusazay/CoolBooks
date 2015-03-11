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
	<style type="text/css">
	
	body {
    	background-image: url('http://i.imgur.com/4K8qUHG.jpg'), url('http://i.imgur.com/EX0x72e.jpg');
    	background-repeat: no-repeat, repeat;
    	margin: 0;
	    padding-top: 250px;
	}
	
	h1 {
		font-family: 'Verdana', 'Geneva', sans-serif;
		color: #FFFFFF;
		font-size: 20px;
	}
		
	h2 {
		font-family: 'Verdana', 'Geneva', sans-serif;
		color: #FF0000;
	}
	
	h4 {
		font-family: 'Verdana', 'Geneva', sans-serif;
		color: #FFFFFF;
		font-size: 40px;
	}
	
	a, p { color: #FFFFFF; }
	
	
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
	
	#similar {margin-left: 200px;}
	
	#link {
	  color: #FFFFFF;
	  font-family: 'Verdana', 'Geneva', sans-serifS;
	  font-size: 15px;
	  margin: 80px;
	}
	
	#book {width: 90%; margin-left: 100px; }
	#mainBookPic { width: 25%;}
	#mainInfo { width: 75%; }
	#mainImage { width: 453px; height: 600px; margin: 25px;}
	
	#search { position: absolute; right: 20px; right: 150px; top: 75px; }
	
	
	#rating {
	  background-color: #99CCFF;
	  color: #666;
	  font-family: 'Verdana', 'Geneva', sans-serif;
	  font-size: 20px;
	  border: 1px solid #FFFFFF;
	  padding: 6px 4px;
	  border-radius: 3px;
	  float: left;
	  margin: 5px;
	}
	
	#rate { margin: 5px; float: left;}
	
	#review { float: left; margin: 8px; width: 330px}
	#reviewdiv { width: 100px;}
	#submitReview {float: right; margin-right: 90px;}
	
	#purchase { margin: 5px; float: left;}
	
	#searchbutton { margin-right: 10px; }
	#searchfield { margin-right: 5px; padding: 4px 20px; }
	
	#user { width: 100px; position: absolute; right: 20px; top: 75px;}
	#loginout { float: right; }
	#account { float: right; margin-top: 10px;}
	
	table, tr { color: #FFFFFF; border-collapse: collapse; border: 1px solid #FFFFFF;}
	
	#books { margin-top: 5px; margin-left: 200px; margin-bottom: 100px; width: 75%;} 
	#bookPic { width: 25%;}
	#info { width: 75%; }
	#image { width: 150px; height: 199px; margin: 25px;}
	
	#page { width: 500px; margin: 50px auto; margin-bottom: 150px;}
	#next { float: right; }
	#previous { float: right; margin-right: 15px; }
	#pageNumber { float: right; font-family: 'Verdana', 'Geneva', sans-serif; font-size: 15px; margin-right: 10px; margin-top: 10px;}
	
	</style>
<title>Insert title here</title>
</head>

<body>
	<% 

	
	String isbn = request.getParameter("isbn");
	BookDatabase bookDB = new BookDatabase();
	
	Book book = bookDB.getBook(isbn);
	
	session.setAttribute("bookInstance", book);
	
	%>
	
	<table id="book">
	<tbody>
	<tr>
	<td id="mainBookPic"><img id="mainImage" src='./BookImages/<%=book.getIsbn() %>.png'/><br></td>
	<td id="mainInfo"><h4><%=book.getTitle()%> 
					  <%if (book.getTitle().length() >= 49) { %>...<%} %></h4>
		<p><%=book.getAuthor() %></p>
		<p><%=book.getIsbn()%></p>
		<p><%=book.getCategory()%></p>
		<p><%=book.getYear()%></p>
		<p>$<%=book.getPrice() %></p>
		<p><%=book.getInventory()%> left in stock</p>
	
	<%
		User user = (User)session.getAttribute("userInstance");
	
	if (session.getAttribute("rated") != null && !(boolean)session.getAttribute("rated")) {
		session.removeAttribute("rated");%>
		<h2>You have already rated this book.</h2>
	<%}
	
	if (session.getAttribute("purchased") != null && !(boolean)session.getAttribute("purchased")) {
		session.removeAttribute("purchased");%>
		<h2>This book is now out of stock.</h2>
	<%}
	
	
	if (user == null) {
	%>
		<form action="loginForm.jsp" method="post">	
			<input type="submit" value="Login to rate and purchase" id="login"/>
		</form>
	<%} else {
		if (book.getInventory() > 0) {%>
			<form action="Purchase" method="post">
				<input type="submit" value="Purchase" id="purchase"/>
			</form>
		<%} else {%>
			<form action="Purchase" method="post">
				<input type="submit" value="Out of Stock" id="purchase" disabled/>
			</form>
		<%}
		
		RatingDB ratingDB = new RatingDB();
		boolean rated = ratingDB.alreadyRated(user.getEmail(), book.getIsbn());
		if (rated) {%>
		<form action="addRating" method="post">
			<input type="submit" value="Rate" id="rate"/>
			<select id="rating" name="rating">
			  <option value="1">1</option>
			  <option value="1">1</option>
			  <option value="2">2</option>
			  <option value="3">3</option>
			  <option value="4">4</option>
			  <option value="5">5</option>
			  <option value="6">6</option>
			  <option value="7">7</option>
			  <option value="8">8</option>
			  <option value="9">9</option>
			  <option value="10">10</option>
			</select>
			<div id="reviewdiv">
				<textarea name="review" id="review" required="required"></textarea> 
			</div>
		</form> 
		<%} else {%>
		<form action="addRating" method="post">
			<input type="submit" value="Rate" id="rate" disabled/>
		</form> 
	<% }
	}%>
	
		<form action="ratings.jsp" method="post">
			<input type="submit" value="View Ratings" id="rate"/>
		</form> </td>

	</tr>
	</tbody>
</table>

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


<% 

ArrayList<Book> books = bookDB.selectBooks("", book.getCategory());
if (books.size() != 0) { %>

		<h4 id="similar">Similar Books:</h4>
			<table id="books">
				<tbody>
<%

for(int i = 0; i < 6; i++){
	if (i < books.size()) {
		
		Book tempBook = books.get(i);
			if (!tempBook.getIsbn().equals(book.getIsbn())) {
%>
				<tr>
				<td id="bookPic"><a href="Product.jsp?isbn=<%=tempBook.getIsbn()%>"><img id="image" src='./BookImages/<%=tempBook.getIsbn() %>.png'/><br></a></td>
				<td id="info"><h1><a href="Product.jsp?isbn=<%=tempBook.getIsbn()%>"><%=tempBook.getTitle()%> 
															<%if (tempBook.getTitle().length() >= 49) { %>...<%} %></a></h1>
					<p><b><%=tempBook.getAuthor() %></b></p>
					<p>$<%=tempBook.getPrice() %></p>
					<p><%=tempBook.getInventory()%> left in stock</p></td>
				
				</tr>
<% 		}
	}
}%>
				</tbody>
			</table>
<% } else {%>
	<h2>There are no related books.</h2>
<%}%>

		
</body>
</html>