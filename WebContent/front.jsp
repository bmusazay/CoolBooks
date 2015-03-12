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
    	background-image: url('http://i.imgur.com/4K8qUHG.jpg'), url('http://i.imgur.com/EX0x72e.jpg');
    	background-repeat: no-repeat, repeat;
    	margin: 0;
	    padding: 0;
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
	  margin-right: 10px;
	}
	
	#searchbutton { float:right;  margin-right: 10px; }
	#searchfield { margin-right: 20px; padding: 4px 20px; }
	
	#user { width: 100px; position: absolute; right: 200px; top: 200px;}
	#loginout { float: right; }
	#account { float: right; margin-top: 10px;}
	
	table, tr { color: #FFFFFF; border-collapse: collapse; border: 1px solid #FFFFFF; }

	
	#books { margin-top: 325px; margin-left: 200px; width: 75%;} 
	#bookPic { width: 25%;}
	#info { width: 75%; }
	#image { width: 150px; height: 199px; margin: 25px;}
	
	#page { width: 500px; margin: 50px auto; margin-bottom: 150px;}
	#next { float: right; }
	#previous { float: right; margin-right: 15px; }
	#pageNumber { float: right; font-family: 'Verdana', 'Geneva', sans-serif; font-size: 15px; margin-right: 10px; margin-top: 10px;}
	
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
	<%}%>
	</selection>
	<%
	ArrayList<Book> books = bookDB.selectBooks(search, category);
	if (books.size() != 0) {
	%>
			<table id="books">
				<tbody>
<%

int pageNo;
if (request.getParameter("page") == null) {
	pageNo = 1;
} else {
	pageNo = Integer.parseInt((String)request.getParameter("page"));
}
int maxNo = books.size();
int maxPerPage = 10;
for(int i = (pageNo - 1) * maxPerPage; i < (pageNo - 1) * maxPerPage + maxPerPage; i++){
	if (i < books.size()) {
		Book book = books.get(i);
%>
				<tr>
				<td id="bookPic"><a href="Product.jsp?isbn=<%=book.getIsbn()%>"><img id="image" src='./BookImages/<%=book.getIsbn() %>.png'/><br></a></td>
				<td id="info"><h1><a href="Product.jsp?isbn=<%=book.getIsbn()%>"><%=book.getTitle()%> 
															<%if (book.getTitle().length() >= 49) { %>...<%} %></a></h1>
					<p><b><%=book.getAuthor() %></b></p>
					<p>$<%=book.getPrice() %></p>
					<p><%=book.getInventory()%> left in stock</p>
					<p><%=bookDB.getRatings(book.getIsbn())%> / 10</p></td>
				
				</tr>
<% }
}%>
				</tbody>
			</table>
<section id="page">
	<%if (pageNo * maxPerPage > maxNo) { %>
		<form action="front.jsp?search=<%=search%>&category=<%=category%>&page=<%=pageNo + 1%>" method="post">	
			<input type="submit" value="Next Page" id="next" disabled/>
		</form>
	<%} else { %>
		<form action="front.jsp?search=<%=search%>&category=<%=category%>&page=<%=pageNo + 1%>" method="post">	
			<input type="submit" value="Next Page" id="next"/>
		</form>
	<%}%>
	
	<h4 id="pageNumber"> Page <%=pageNo%> / <%=maxNo / maxPerPage + 1%> </h4>
	
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