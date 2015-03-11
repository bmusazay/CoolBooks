<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.User" %>
<%@ page import="data.dbConnect.*" %>
<%@ page import="book.Book" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin Control Panel</title>
</head>
<body>
<%
	User sessionUser = (User)session.getAttribute("userInstance");
	
	if (sessionUser == null)
	{
		out.println("Access Denied");
	} else if (!sessionUser.isAdmin())
	{
		out.println("Access Denied");
	} else
	{
	
	%>
	
	
	
	<h1>Admin Control Panel</h1>
	<form action="Analytics.jsp" name="formA" id="formA" method="post">
		 <input type="submit" value="Analytics Page" />
	</form>
	<br>
	<form action="CreateProduct.jsp" method = "post" enctype="multipart/form-data"> 
	 Isbn: <input type="text" name="isbn" /> <br>
	 Title: <input type="text" name="Title" /> <br>
	 Author: <input type="text" name="Author" /> <br>
	 Publish Year: <input type="text" name="PublishYear" /> <br>
	 Category: <input type="text" name="Category" /> <br>
	 Quantity: <input type="text" name="Quantity" /> <br>
	 Price: <input type="text" name="Price" /> <br>
	 <input type="file" name="file" />  <br>
	 <input type="submit" value="Create Product" />
	</form>
	<br>
	
	
	
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
	<form action="Update" name="form2" id="form2" method="post">
		 <h4>Delete User</h4>
		 User Email: <input type="text" name="email" /> 
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
	
	<%
	if (!email.equals("") && !email.equals("null") && !email.equals("notfound") )
	{
		UserDatabase uDB = new UserDatabase();
		User user = uDB.selectUser(email);
		%>
		<table>
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
						<td> 
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
		 Book ISBN: <input type="text" name="isbn" />
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
						<td> 
							<form action="DeleteBook" name="formDB" id="formDB" method="post">
							 <input type="hidden" name="isbn" value="<%=book.getIsbn()%>">
							 <input type="submit" value="Update Book" />
							</form>
						
						</td>
					</tr>
				
				</tbody>
		</table>
		
	<% 	
	}
	%>
	
	
	<%} %>

</body>
</html>