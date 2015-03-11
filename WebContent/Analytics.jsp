<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="data.dbConnect.*" %>
<%@ page import="java.util.*" %>
<%@ page import="book.Book" %>
<%@ page import="user.User" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Analytics</title>
</head>
<body>

 
<h1>Analytics</h1>

<%
	TransactionDB trDB = new TransactionDB();
	BookDatabase bDB = new BookDatabase();
	%>
	
	<table>
	<thead>
		<tr>
			<th></th>
			<th></th>

		</tr>
	</thead>
	<tbody>
	<tr>
	<td>Current Month Sales:   </td>
	<td>$<%=trDB.getSales("30")%></td>
	</tr>
	<tr>
	<td>Previous Month Sales:  </td>
	<td>$<%=trDB.getSales("lastmonth")%></td>
	</tr>
	<tr>
	<td>Current Week Sales:    </td>
	<td>$<%=trDB.getSales("7")%></td>
	</tr>
	<tr>
	<td>Previous Week Sales:   </td>
	<td>$<%=trDB.getSales("lastweek")%></td>
	</tr>
	</tbody>
</table>
	
	<% 
	out.println("<br><br><h2>Weekly Top 10 Bestsellers: </h2><br>");
	ArrayList<String> topTen = trDB.topTenBestSellers();
	%>
	
	<table>
				<thead>
					<tr>
						<th>Title</th>
						<th>Isbn</th>
						<th>Image</th>
					</tr>
				</thead>
				<tbody>
	
	<% 
	for (int i = 0; i < topTen.size(); i++)
	{
		Book book = bDB.getBook(topTen.get(i));
		%>
		<tr>
			<td><%=book.getTitle()%></td>
			<td><%=book.getIsbn() %></td>
			<td><%=book.getInventory() %></td>
			<td><a href="Product.jsp?isbn=<%=book.getIsbn()%>"><img src='./BookImages/<%=book.getIsbn() %>.png'/><br></a></td>
		</tr>
	<% } %>
	
	</tbody>
	</table>
	<% 
	out.println("<br><br><br>");
	
	out.println("<br><h2>Top 5 Most Popular (biweekly): </h2><br>");
	ArrayList<String> topFive = trDB.biweeklyPopular();
	%>
	
	<table>
			<thead>
				<tr>
					<th>Title</th>
					<th>Isbn</th>
					<th>Image</th>
				</tr>
			</thead>
			<tbody>
	<% 
	for (int i = 0; i < topFive.size(); i++)
	{
		Book book = bDB.getBook(topFive.get(i));
		%>
		<tr>
			<td><%=book.getTitle()%></td>
			<td><%=book.getIsbn() %></td>
			<td><%=book.getInventory() %></td>
			<td><a href="Product.jsp?isbn=<%=book.getIsbn()%>"><img src='./BookImages/<%=book.getIsbn() %>.png'/><br></a></td>
		</tr>
	<% } %>
	
	</tbody>
	</table>
	<%
	ArrayList<String> categories = bDB.selectCategories();

	out.println("<br><h2>Top 5 Bestsellers by Category : </h2><br>");
	String category = request.getParameter("category");

	if (category == null) {
		category = "all";
	}
%>
	<form action="TopFive" method="post">
	
		<select name="category">
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
	
		<input type="submit" value="Top 5" id="submit"/>
	  			
	</form>
	
	<% 
		if (!category.equals("all")) {
			ArrayList<String> isbnTopFive = trDB.topFive(category);
			if (isbnTopFive.size() != 0) 
			{
	%>
		<table>
				<thead>
					<tr>
						<th>Title</th>
						<th>Isbn</th>
						<th>Inventory</th>
						<th>Image</th>
					</tr>
				</thead>
				<tbody>


		<%
		for (int i = 0; i < isbnTopFive.size(); i++)
		{
			
			Book book = bDB.getBook(isbnTopFive.get(i));	
		%>
				<tr>
				<td><%=book.getTitle()%></td>
				<td><%=book.getIsbn() %></td>
				<td><%=book.getInventory() %></td>
				<td><a href="Product.jsp?isbn=<%=book.getIsbn()%>"><img src='./BookImages/<%=book.getIsbn() %>.png'/><br></a></td>
				</tr>
		<% }
		} %>
				</tbody>
			</table>
	<%} %>
	
	
	<br><br>
	
	<h2>Loyal Customers of selected category: </h2>
	
	<% 
	if (!category.equals("all")) {
			ArrayList<String[]> users = trDB.customersByCategory(category);
			if (users.size() != 0) 
			{
	%>
		<table>
				<thead>
					<tr>
						<th>Email</th>
						<th>Purchases</th>
					</tr>
				</thead>
				<tbody>


		<%
		UserDatabase uDB = new UserDatabase();
		for (int i = 0; i < users.size(); i++)
		{
			
			User customer = uDB.selectUser(users.get(i)[0]);	
		%>
				<tr>
				<td><%=customer.getEmail()%></td>
				<td><%= users.get(i)[1] %></td>
				</tr>
		<% }
		 %>
		 <%}
			}%>
				</tbody>
			</table>

	
	
	
	
	
</body>
</html>