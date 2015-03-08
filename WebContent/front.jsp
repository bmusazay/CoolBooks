<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@ page import="data.dbConnect.BookDatabase" %>
<%@ page import="book.Book" %>
<%@ page import="user.User" %>
<%@ page import="java.util.*" %>

<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
	<style type="text/css">
	
	body {
	    background-color: #0099FF;
	}
	
	form {

	}
	
	h1 {
		font-family: 'Verdana', 'Geneva', sans-serif;
		color: #FFFFFF;
	}
	
	input[type='text'], textarea {
	  background-color: #99CCFF;
	  color: #FFFFFF;
	  font-family: 'Verdana', 'Geneva', sans-serif;
	  font-size: 25px;
	  padding: 4px 6px;
	  border: 1px solid #FFFFFF;
	  margin-bottom:5px;
	  border-radius: 3px;
	}
	
	input[type='submit'], a.add {
	  background-color: #0000FF;
	  color: #f3dad1;
	  border: none;
	  border-radius: 5px;
	  padding: 8px 10px;
	  float: right;
	  margin-top: 2px;
	  font-size: 18px;
	  text-decoration: none;
	  text-transform: uppercase;
	}
	
	input[type='submit']:hover, a.add:hover {
	  background-color: #0066FF;
	  color: #f3dad1;
	  cursor: pointer;
	  top: 1px;
	}
	
	select {
	  background-color: #0000FF;
	  color: #f3dad1;
	  border: none;
	  border-radius: 5px;
	  padding: 8px 10px;
	  font-size: 18px;
	  text-decoration: none;
	  text-transform: uppercase;
	}
	
	</style>
	
	<title>Welcome to CoolBooks</title>
</head>
<body>
<%
BookDatabase bookDB = new BookDatabase();
ArrayList<String> categories = bookDB.selectCategories();

String category = request.getParameter("category");
String search = request.getParameter("search");

if (category == null) {
	category = "all";
}

if (search == null) {
	search = "";
}
%>

	<form action="Search" method="post">
	
		<select name="category">
			<option value="all">All</option>
			<%
			for(int i = 0; i < categories.size(); i++) {
			%>
  			<option value="<%=categories.get(i)%>"
  			<%
	  			if (category != null 
	  			&& category.equals(categories.get(i))) {%>
	  			 	selected
	  			<%}%>
  			><%=categories.get(i)%></option>
			<%}%>
		</select>
	
		<input type="submit" value="Search" id="submit"/>
			<input type="text"  name="search" id="search" 
			  <%
	  			if (search != null) {%>
	  			value="<%=search%>"
	  			<%}%>/>
		
	</form>
			<table>
				<thead>
					<tr>
						<th>Title</th>
						<th>Author</th>
						<th>Price</th>
						<th>Inventory</th>
						<th>Image</th>
					</tr>
				</thead>
				<tbody>
<%
ArrayList<Book> books = bookDB.selectBooks(search, category);
for(int i = 0; i < books.size(); i++){
	Book book = books.get(i);
%>
				<tr>
				<td><%=book.getTitle()%></td>
				<td><%=book.getAuthor() %></td>
				<td><%=book.getPrice() %></td>
				<td><%=book.getInventory() %></td>
				<td><a href="Product.jsp?isbn=<%=book.getIsbn()%>"><img src='./BookImages/<%=book.getIsbn() %>.jpg'/><br></a></td>
				</tr>
<%}
%>
				</tbody>
			</table>
		
	<%if (session.getAttribute("userInstance") == null) {%>
		<form action="loginForm.jsp" method="post">	
			<input type="submit" value="Login" id="login"/>
		</form>
	<%} else {%>
		<form action="Logout" method="post">	
			<input type="submit" value="Logout" id="logout"/>
		</form>
		<%User user = (User)session.getAttribute("userInstance");
		  String email = user.getEmail();%>
		<form action="accountPage.jsp" method="post">	
			<input type="submit" value="Logged in as <%=email%>" id="account"/>
		</form>
	<%}%>
	
</body>
</html>