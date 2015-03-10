<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta charset="UTF-8">
	<style type="text/css">
	
	body {
	    background-color: #0099FF;
    	margin: 0;
	    padding: 0;
	}
	
	form {
	 	width: 400px;	
		margin: 0 auto;
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
	  color: #666;
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
	
	#link {
	  color: #FFFFFF;
	  font-family: 'Verdana', 'Geneva', sans-serifS;
	  font-size: 15px;
	}
	
	</style>
	
	<title>Login to your account</title>
</head>

<body>
	<form action="login" method="post">
	
		<h1>Login to your account</h1>
		
		<%if (session.getAttribute("login") != null && !(boolean)session.getAttribute("login")) {
			session.removeAttribute("login");
		%>
			<h2>Invalid username or password. Please try again.</h2>
		<%}%>
		
		<div> 
			<label> Email : </label>
			<input type = "text"  name="email" id="email" required="required"/>
		</div>
		
		<div>
			<label> Password : </label>
			<input type = "password"  name="pass" id="pass" required="required"/>
		</div>
		
		<input type="submit" value="Login" id="submit"/>
		
		<a href="signUpForm.jsp" id="link"> Register an account </a>
	
	</form>
</body>
</html>
</body>
</html>