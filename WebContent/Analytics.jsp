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
<style type="text/css">
	
	body {
    	background-image: url('http://i.imgur.com/4K8qUHG.jpg'), url('http://i.imgur.com/EX0x72e.jpg');
    	background-repeat: no-repeat, repeat;
    	margin: 0;
	    padding-top: 250px;
	    padding-bottom: 100px;
	}
	
	h1 {
		font-family: 'Verdana', 'Geneva', sans-serif;
		color: #FFFFFF;
		font-size: 20px;
	}
		
	h2 {
		font-family: 'Verdana', 'Geneva', sans-serif;
		color: #FF0000;
		margin-top: 250px;
		margin-left: 100px;
	}
	
	h3 {
		font-family: 'Verdana', 'Geneva', sans-serif;
		color: #FFFFFF;
		font-size: 30px;
		margin-left: 50px;
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
	  margin-left: 100px;
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
	
	#search { position: absolute; right: 20px; right: 350px; top: 200px; }
	
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
	  margin-left: 10px;
	}
	
	#searchbutton { float:right;  margin-right: 10px; }
	#searchfield { margin-right: 20px; padding: 4px 20px; }
	
	#user { width: 100px; position: absolute; right: 200px; top: 200px;}
	#loginout { float: right; }
	#account { float: right; margin-top: 10px;}
	
	table, tr { color: #FFFFFF; border-collapse: collapse; border: 1px solid #FFFFFF;}
	
	#books { margin-top: 5px; margin-left: 100px; margin-bottom: 20px; width: 75%;} 
	#bookPic { width: 25%;}
	#info { width: 75%; }
	#image { width: 113px; height: 150px; margin: 25px;}
	
	#page { width: 500px; margin: 50px auto; margin-bottom: 150px;}
	#next { float: right; }
	#previous { float: right; margin-right: 15px; }
	#pageNumber { float: right; font-family: 'Verdana', 'Geneva', sans-serif; font-size: 15px; margin-right: 10px; margin-top: 10px;}
	#loginout { float: right; margin-top: 20px; margin-bottom: 20px; margin-right: 75px;}
	
	</style>
	<title>Analytics</title>
</head>
<body>

	<form action="adminCP.jsp" method="post">	
		<input type="submit" value="Return to Admin Panel" id="loginout"/>
	</form>
 
<h3>Analytics</h3>

<%
	TransactionDB trDB = new TransactionDB();
	BookDatabase bDB = new BookDatabase();
	%>
	
	<table id="books">
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
	out.println("<br><br><h3>Weekly Top 10 Bestsellers: </h3><br>");
	ArrayList<String> topTen = trDB.topTenBestSellers();
	%>
	
	<table id="books">
				<tbody>
	
	<% 
	for (int i = 0; i < topTen.size(); i++)
	{
		Book book = bDB.getBook(topTen.get(i));
		%>
		<tr>
				<td id="bookPic"><a href="Product.jsp?isbn=<%=book.getIsbn()%>">
				<img id="image" src='./BookImages/<%=book.getIsbn() %>.png'/><br></a></td>
				<td><%=book.getTitle()%></td>
				<td><%=book.getIsbn() %></td>
		</tr>
	<% } %>
	
	</tbody>
	</table>
	<% 
	out.println("<br><br><br>");
	
	out.println("<br><h3>Top 5 Most Popular (biweekly): </h3><br>");
	ArrayList<String> topFive = trDB.biweeklyPopular();
	%>
	
	<table id="books">
			<tbody>
	<% 
	for (int i = 0; i < topFive.size(); i++)
	{
		Book book = bDB.getBook(topFive.get(i));
		%>
		<tr>
				<td id="bookPic"><a href="Product.jsp?isbn=<%=book.getIsbn()%>">
				<img id="image" src='./BookImages/<%=book.getIsbn() %>.png'/><br></a></td>
				<td><%=book.getTitle()%></td>
				<td><%=book.getIsbn() %></td>
		</tr>
	<% } %>
	
	</tbody>
	</table>
	<%
	ArrayList<String> categories = bDB.selectCategories();

	out.println("<br><h3>Top 5 Bestsellers by Category : </h3><br>");
	String category = request.getParameter("category");

	if (category == null) {
		category = "all";
	}
%>
	<form action="TopFive" method="post">
	
		<select id="category" name="category">
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
		<table id="books">
				<tbody>


		<%
		for (int i = 0; i < isbnTopFive.size(); i++)
		{
			
			Book book = bDB.getBook(isbnTopFive.get(i));	
		%>
				<tr>	
				<td id="bookPic"><a href="Product.jsp?isbn=<%=book.getIsbn()%>">
				<img id="image" src='./BookImages/<%=book.getIsbn() %>.png'/><br></a></td>
				<td><%=book.getTitle()%></td>
				<td><%=book.getIsbn() %></td>
				</tr>
		<% }
		} %>
				</tbody>
			</table>
	<%} %>
	
	
	<br><br>
	
	<h3>Loyal Customers of selected category: </h3>
	
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