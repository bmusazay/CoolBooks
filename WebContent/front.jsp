<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@ page import="data.dbConnect.BookDatabase" %>
<%@ page import="book.Book" %>
<%@ page import="user.User" %>
<%@ page import="java.util.*" %>

<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
	<meta charset="UTF-8">
	<style type="text/css">
	
	body {
	    background-color: #0099FF;
    	margin: 0;
	    padding: 0;
	}
	
	h1 {
		font-family: 'Verdana', 'Geneva', sans-serif;
		color: #FFFFFF;
	}
		
	h2 {
		font-family: 'Verdana', 'Geneva', sans-serif;
		color: #FF0000;
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
	  border: 1px solid #FFFFFF;
	  border-radius: 3px;
	}
	
	input[type='submit'], a.add {
	  background-color: #0000FF;
	  color: #f3dad1;
	  border: none;
	  border-radius: 5px;
	  float: left;
	  font-size: 18px;
	  text-decoration: none;
	  text-transform: uppercase;
	}
	
	input[type='submit']:hover, a.add:hover {
	  background-color: #0066FF;
	  color: #f3dad1;
	  cursor: pointer;
	}
	
	input[type='submit']:disabled, a.add:disabled {
   		background: #3399FF;
   		cursor: default;
   		border: 1px solid #FFFFFF;
	}
	
	#link {
	  color: #FFFFFF;
	  font-family: 'Verdana', 'Geneva', sans-serifS;
	  font-size: 15px;
	  margin: 80px;
	}
	
	
	#search { position: absolute; left: 20px; }
	
	#category {
	  background-color: #99CCFF;
	  color: #666;
	  font-family: 'Verdana', 'Geneva', sans-serif;
	  font-size: 20px;
	  border: 1px solid #FFFFFF;
	  border-radius: 3px;
	}
	
	#searchbutton { }
	#searchfield { }
	
	#user { width: 400px; position: absolute; right: 20px;}
	#loginout { float: right; }
	#account { float: left;}
	
	#books { padding-top: 50px; }
	
	#page { width: 450px; margin: 0 auto; padding-bottom: 50px}
	#next { float: right; }
	#previous { float: left; }
	#pageNumber { float: right; font-family: 'Verdana', 'Geneva', sans-serif; font-size: 15px; margin: 15px;}
	
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
	<form action="Search" method="post" id="search">
	
		<select name="category" id="category">
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
	
		<input type="submit" value="Search" id="searchbutton"/>
			<input type="text"  name="search" id="searchfield" 
			  <%
	  			if (search != null) {%>
	  			value="<%=search%>"
	  			<%}%>/>
	  			<%  
ArrayList<Book> books = bookDB.selectBooks(search, category);
if (books.size() != 0) {
	  			%>
	</form>
	
	 <selection id="user">
	<%
	if (session.getAttribute("userInstance") == null) {%>
		<form action="loginForm.jsp" method="post">	
			<input type="submit" value="Login" id="loginout"/>
		</form>
	<%} else {%>
		<form action="Logout" method="post">	
			<input type="submit" value="Logout" id="loginout"/>
		</form>
		<%User user = (User)session.getAttribute("userInstance");
		  String email = user.getEmail();%>
		<form action="accountPage.jsp" method="post">	
			<input type="submit" value="Logged in as <%=email%>" id="account"/>
		</form>
	<%} %>
	</selection>
	
			<table id="books">
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
	pageNo = 1;
} else {
	pageNo = Integer.parseInt((String)request.getParameter("page"));
}
int maxNo = books.size();
for(int i = (pageNo - 1) * 20; i < (pageNo - 1) * 20 + 20; i++){
	if (i < books.size()) {
		Book book = books.get(i);
%>
				<tr>
				<td><%=book.getTitle()%></td>
				<td><%=book.getAuthor() %></td>
				<td><%=book.getPrice() %></td>
				<td><%=book.getInventory() %></td>
				<td><a href="Product.jsp?isbn=<%=book.getIsbn()%>"><img src='./BookImages/<%=book.getIsbn() %>.png'/><br></a></td>
				</tr>
<% }
}%>
				</tbody>
			</table>
<section id="page">
	<%if (pageNo * 20 > maxNo) { %>
		<form action="front.jsp?search=<%=search%>&category=<%=category%>&page=<%=pageNo + 1%>" method="post">	
			<input type="submit" value="Next Page" id="next" disabled/>
		</form>
	<%} else { %>
		<form action="front.jsp?search=<%=search%>&category=<%=category%>&page=<%=pageNo + 1%>" method="post">	
			<input type="submit" value="Next Page" id="next"/>
		</form>
	<%}%>
	
	<h4 id="pageNumber"> Page <%=pageNo%> / <%=maxNo / 20 + 1%> </h4>
	
	<%if (pageNo - 1 < 1) { %>
		<form action="front.jsp?search=<%=search%>&category=<%=category%>&page=<%=pageNo - 1%>" method="post">		
			<input type="submit" value="Previous Page" id="previous" disabled/>
		</form>
	<%} else { %>
		<form action="front.jsp?search=<%=search%>&category=<%=category%>&page=<%=pageNo - 1%>" method="post">	
			<input type="submit" value="Previous Page" id="previous"/>
		</form>
	<%}
} else {%>
	<h2>Your search "<%=search%>" did not match any books in category "<%=category%>".</h2>
<%}%>

</section>
</body>
</html>