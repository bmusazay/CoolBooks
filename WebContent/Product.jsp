<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%@ page import="data.dbConnect.BookDatabase" %>
<%@ page import="book.Book" %>
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
	
	out.println("<img src='./BookImages/" + book.getIsbn() + ".jpg'/><br>");
	
	
	out.println("<br><br>");
	out.println("<p> Inventory: "+book.getInventory()+ "</p>");
	out.println("<p> Publish year: "+book.getYear()+ "</p>");
	out.println("<p> Price: $"+book.getPrice()+ "</p>");

	
	
	%>
	
	
	
	
	<form action="Purchase" method="post">
		<input type="submit" value="Purchase" id="submit"/>
	</form>
	
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
	
</body>
</html>