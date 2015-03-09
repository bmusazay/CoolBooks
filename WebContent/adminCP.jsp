<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.User" %>

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
	<br><br><br>
	
	<form action="DeleteUser" name="form2" id="form2" method="post">
		 <h4>Delete User</h4>
		 User Email: <input type="text" name="email" /> <br>
		 <input type="submit" value="Remove User" />
	</form>
	<%} %>

</body>
</html>