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
    	background-image: url('http://i.imgur.com/4K8qUHG.jpg'), url('http://i.imgur.com/EX0x72e.jpg');
    	background-repeat: no-repeat, repeat;
    	margin: 0;
	    padding: 0;
	    padding-top: 200px;
	}
	
	form {
	 	width: 450px;	
		margin: 0 auto;
	}
	
	h1 {
		font-family: 'Verdana', 'Geneva', sans-serif;
		color: #FFFFFF;
	}
		
	h2 {
		font-size: 15px;
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
	
	#link {
	  color: #FFFFFF;
	  font-family: 'Verdana', 'Geneva', sans-serifS;
	  font-size: 15px;
	  padding-left: 80px;
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
			<input type="password" name="pass" id="pass" required="required"/>
		</div>
		
		<div> 
			<label> Confirm Password : </label>
			<input type="password" name="repass" id="repass" required="required"/>
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