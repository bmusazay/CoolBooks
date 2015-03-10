<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@ page import="data.dbConnect.BookDatabase" %>
<%@ page import="book.Book" %>
<%@ page import="user.User" %>
<%@ page import="java.util.*" %>

<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
	<style type="text/css">
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
	  			<%  
ArrayList<Book> books = bookDB.selectBooks(search, category);
if (books.size() != 0) {
	  			%>
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

int pageNo;
if (request.getParameter("page") == null) {
	pageNo = 0;
} else {
	pageNo = Integer.parseInt((String)request.getParameter("page"));
}
int maxNo = books.size();
for(int i = pageNo * 20; i < pageNo * 20 + 20; i++){
	if (i < books.size()) {
		Book book = books.get(i);
%>
				<tr>
				<td><%=book.getTitle()%></td>
				<td><%=book.getAuthor() %></td>
				<td><%=book.getPrice() %></td>
				<td><%=book.getInventory() %></td>
				<td><a href="Product.jsp?isbn=<%=book.getIsbn()%>"><img src='./BookImages/<%=book.getIsbn() %>.jpg'/><br></a></td>
				</tr>
<% }
}%>
				</tbody>
			</table>
	
	<%if ((pageNo + 1) * 20 > maxNo) { %>
		<form action="front.jsp?search=<%=search%>&category=<%=category%>&page=<%=pageNo + 1%>" method="post">	
			<input type="submit" value="Next Page" id="next" disabled/>
		</form>
	<%} else { %>
		<form action="front.jsp?search=<%=search%>&category=<%=category%>&page=<%=pageNo + 1%>" method="post">	
			<input type="submit" value="Next Page" id="next"/>
		</form>
	<%}%>
	
	<h4> Page <%=pageNo + 1%> / <%=maxNo / 20 + 1%> </h4>
	
	<%if (pageNo < 1) { %>
		<form action="front.jsp?search=<%=search%>&category=<%=category%>&page=<%=pageNo - 1%>" method="post">		
			<input type="submit" value="Previous Page" id="next" disabled/>
		</form>
	<%} else { %>
	<form action="front.jsp?search=<%=search%>&category=<%=category%>&page=<%=pageNo - 1%>" method="post">	
			<input type="submit" value="Previous Page" id="next"/>
		</form>
	<%}
	
	if (session.getAttribute("userInstance") == null) {%>
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
	<%}
} else {%>
	<h2>Your search "<%=search%>" did not match any books in category "<%=category%>".</h2>
<%}%>
</body>
</html>