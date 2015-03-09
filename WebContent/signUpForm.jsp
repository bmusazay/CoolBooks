<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
	<meta charset="UTF-8">
	<style type="text/css">
	
	body {
	    background-color: #0099FF;
	}
	
	form {
	    padding-top: 0px;
	    padding-right: 400px;
	    padding-bottom: 25px;
	    padding-left: 200px;
	}
	
	h1 {
		font-family: 'Verdana', 'Geneva', sans-serif;
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
	  color: #FFFFFF;
	  font-family: 'Verdana', 'Geneva', sans-serif;
	  font-size: 25px;
	  padding: 4px 6px;
	  border: 1px solid #FFFFFF;
	  margin-bottom:5px;
	  border-radius: 3px;
	}
	
	input[type='submit'], a.add {
	  background-color: #0000FF;
	  color: #f3dad1;
	  border: none;
	  border-radius: 5px;
	  padding: 8px 10px;
	  float: left;
	  margin-top: 10px;
	  margin-left: 9em;
	  font-size: 18px;
	  text-decoration: none;
	  text-transform: uppercase;
	}
	
	input[type='submit']:hover, a.add:hover {
	  background-color: #0066FF;
	  color: #f3dad1;
	  cursor: pointer;
	  top: 1px;
	}
	
	</style>
	
	<title>Insert title here</title>
</head>
<body>
	<form action="SignUp" name="form1" id="form1" method="post">
		
		<h1>Create a new account</h1>
		
		<%if (session.getAttribute("signup") != null && !(boolean)session.getAttribute("signup")) {
			session.removeAttribute("signup");%>
			<h2>This email is already associated with an account. Please select a different email.</h2>
		<%}%>
		
		<div> 
			<label> Email : </label>
			<input type="text" name="email" id="email" required="required"/>
		</div>
		
		<div>
			<label> Password : </label>
			<input type="text" name="pass" id="pass" required="required"/>
		</div>
		
		<div> 
			<label> Confirm Password : </label>
			<input type="text" name="repass" id="repass" required="required"/>
		</div>
			<div> <label> First Name : </label>
			<input type="text" name="fname" id="fname" required="required"/>
		</div>
			<div> <label> Last Name : </label>
			<input type="text" name="lname" id="lname" required="required"/>
		</div>
		
		<input type="submit" value="Sign Up" id="submit"/>
	
	</form>
</body>
</html>