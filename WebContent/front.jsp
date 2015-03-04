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
%>
<select>
<%
for(int i = 0; i < categories.size(); i++){
%>

  <option value="category"><%=categories.get(i)%></option>
<%}%>
</select>

			<table>
				<thead>
					<tr>
						<th>Title</th>
						<th>Author</th>
						<th>Price</th>
						<th>Inventory</th>
					</tr>
				</thead>
				<tbody>
<%

ArrayList<Book> books = bookDB.selectBooks();
for(int i = 0; i < books.size(); i++){
	Book book = books.get(i);
%>
				<tr>
				<td><%=book.getTitle()%></td>
				<td><%=book.getAuthor() %></td>
				<td><%=book.getPrice() %></td>
				<td><%=book.getInventory() %></td>
				</tr>
<%}
%>
				</tbody>
			</table>
</body>
</html>