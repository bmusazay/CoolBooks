<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.User" %>
<%@ page import="data.dbConnect.*" %>
<%@ page import="book.Book" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
	<meta charset="UTF-8">
	<style type="text/css">
	
	body {
    	background-image: url('http://i.imgur.com/4K8qUHG.jpg'), url('http://i.imgur.com/EX0x72e.jpg');
    	background-repeat: no-repeat, repeat;
    	margin: 0;
    	padding-top: 200px;
	    padding-bottom: 100px;
	}
	
	form {
	 	width: 450px;	
		margin: 0 auto;
	}
	h1 {
		font-family: 'Verdana', 'Geneva', sans-serif;
		color: #FFFFFF;
		margin-left: 550px;	
	}
	h2 {
		margin-top: 50px;
		margin-left: 630px;
		font-family: 'Verdana', 'Geneva', sans-serif;
		color: #FF0000;
	}
	h4
	{
		font-family: 'Verdana', 'Geneva', sans-serif;
		color: #FFFFFF;
	}
	table, tr { width:10%; margin-left: 150px; color: #FFFFFF; border-collapse: collapse; border: 1px solid #FFFFFF; }
	
	#sizeT2 {width: 25%;}
	#userTable{margin-left: 350px;}
	#analyt { float: left; margin-right: 100px;}
	#loginout {float: left;}
	
	fileup {
		color: #FFFFFF;
	}
	label {
		color: #FFFFFF;
		float: left;
		width: 10em;
		font-family: 'Verdana', 'Geneva', sans-serif;
	  	font-size: 15px;
	}
	input[type='text'], input[type='password'], textarea {
	  background-color: #99CCFF;
	  color: #666;
	  font-family: 'Verdana', 'Geneva', sans-serif;
	  font-size: 25px;
	  padding: 4px 30px;
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
	  margin-bottom: 10px;
	  margin-top: 5px;
	}
	
	input[type='file'], a.add {
	  background-color: #0A193A;
	  color: #FFFFFF;
	  border: 1px solid #FFFFFF;
	  border-radius: 5px;
	  text-transform: uppercase;
	}
	
	
	input[type='submit']:hover, a.add:hover {
	  background-color: #1C459E;
	  cursor: pointer;
	}	
	
	
	
	</style>
	
	
<title>Admin Control Panel</title>
</head>
<body>

	<h1>Admin Control Panel</h1>

<%
	User sessionUser = (User)session.getAttribute("userInstance");
	
	if (sessionUser == null)
	{
		%><h2>Access Denied</h2> <%
	} else if (!sessionUser.isAdmin())
	{
		%><h2>Access Denied</h2> <%
	} else
	{
	
	%>


	<form action="front.jsp" method="post">	
		<input type="submit" value="Return to Search Page" id="loginout"/>
	</form>
	
	
	
	<form action="Analytics.jsp" name="formA" id="formA" method="post">
		 <input type="submit" id="analyt" value="Analytics Page" />
	</form>

	<form action="CreateProduct.jsp" method = "post" enctype="multipart/form-data"> 
	 <label>Isbn: </label> <input type="text" name="isbn" /> <br>
	 <label>Title: </label><input type="text" name="Title" /> <br>
	 <label>Author: </label><input type="text" name="Author" /> <br>
	<label> Publish Year: </label><input type="text" name="PublishYear" /> <br>
	 <label>Category: </label><input type="text" name="Category" /> <br>
	 <label>Quantity: </label><input type="text" name="Quantity" /> <br>
	 <label>Price: </label><input type="text" name="Price" /> <br>
	 <label>Upload Image: </label>
	 <div class="fileup">
	 	<input type="file" name="file" />  
 	</div>
	 <input type="submit" value="Create Product" />
	</form>
	<br><br><br>
	
	
	
	<% 
	String email = request.getParameter("user");
	String isbn = request.getParameter("book");
	
	if (email == null) {
		email = "";
	}

	if (isbn == null) {
		isbn = "";
	}
	%>
	
	<br><br>
	<form action="Update" name="form2" id="form2" method="post">
		 <h4>Delete User</h4>
		 <label> User Email: </label><input type="text" name="email" /> 
		  <%
		if (email.equals("notfound"))
		{
			%>  
			<font color="red">User not found.</font>
			<% 
		} 
		
		%>
		 <br>
		 <input type="submit" value="Update User" />
	</form>
	<br><br><br>
	<%
	if (!email.equals("") && !email.equals("null") && !email.equals("notfound") )
	{
		UserDatabase uDB = new UserDatabase();
		User user = uDB.selectUser(email);
		%>
		<table id="userTable">
				<thead>
					<tr>
						<th>Email</th>
						<th>First Name</th>
						<th>Last Name</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><%=user.getEmail()%></td>
						<td><%=user.getFName() %></td>
						<td><%=user.getLName() %></td>
						<td class="sizeT"> 
							<form action="DeleteUser" name="formD" id="formD" method="post">
							 <input type="hidden" name="email" value="<%=user.getEmail()%>">
							 <input type="submit" value="Delete User" />
							</form>
						
						</td>
					</tr>
				
				</tbody>
		</table>
		
	<% 	
	}
	%>
	
	
	<form action="Update" name="form3" id="form3" method="post">
		 <h4>Update Book</h4>
		 <label> Book ISBN: </label><input type="text" name="isbn" />
		 <% 
		 if (isbn.equals("notfound"))
		{
			%>  
			<font color="red">Book not found.</font>
			<% 
		}
		
		%>
		  <br>
		 <input type="submit" value="Remove Book" />
	</form>
	
	<%
	if (!isbn.equals("null") && !isbn.equals("") && !isbn.equals("notfound") )
	{
		BookDatabase bDB = new BookDatabase();
		Book book = bDB.getBook(isbn);
		%>
		<table>
				<thead>
					<tr>
						<th>Title</th>
						<th>Isbn</th>
						<th>Quantity</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><%=book.getTitle()%></td>
						<td><%=book.getIsbn() %></td>
						<td>
							<form action="ChangeQuantity" name="formB" id="formB" method="post">
							 <input type="text" name="qty" value="<%=book.getInventory()%>" style="width: 30px;">
							 <input type="hidden" name="isbn" value="<%=book.getIsbn()%>">
							 <input type="submit" value="Update Quantity" />
							</form>
						</td>
						<td id="sizeT2"> 
							<form action="DeleteBook" name="formDB" id="formDB" method="post">
							 <input type="hidden" name="isbn" value="<%=book.getIsbn()%>">
							 <input type="submit" value="Delete Book" />
							</form>
						
						</td>
					</tr>
				
				</tbody>
		</table>
		<br><br><br><br><br>
	<% 	
	}
	%>
	
	
	<%} %>

</body>
</html>