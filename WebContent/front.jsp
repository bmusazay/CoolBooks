<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@ page import="data.dbConnect.BookDatabase" %>
<%@ page import="book.Book" %>
<%@ page import="java.util.*" %>

<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Insert title here</title>
<link rel="stylesheet" href="css/c06.css"/>
</head>
<body>
<%
BookDatabase bookDB = new BookDatabase();
ArrayList<String> categories = bookDB.selectCategories();

String category = request.getParameter("category");
String search = request.getParameter("search");
%>

	<form action="Search" method="post">
		<input type="submit" value="Search" id="submit"/>
		<div> 
			<input type="text"  name="search" id="search" 
			  <%
	  			if (search != null) {%>
	  			value="<%=search%>"
	  			<%}%>/>
		</div>
		
		<div> 
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
		</div>
		
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
</body>
</html>