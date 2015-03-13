<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="book.Book" %>
 <%@ page import="transaction.Transaction" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
	
	body {
    	background-image: url('http://i.imgur.com/4K8qUHG.jpg'), url('http://i.imgur.com/EX0x72e.jpg');
    	background-repeat: no-repeat, repeat;
    	margin: 0;
	    padding: 0;
	}
	
	#body {	width: 600px; margin: 200px auto; margin-top: 300px; font-family: 'Verdana', 'Geneva', sans-serif; color: #FFFFFF;}
	
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


 </style>
<title>Thank you for your purchase.</title>


</head>
<body>
	
<%
	Book book = (Book)session.getAttribute("bookInstance");
	Transaction tr = (Transaction)session.getAttribute("transaction");
%>
	<section id="body">
		<h1>Order number: <%=tr.getTranNumber()%></h1>
		<h1>Thank you for your purchase of:</h1>
		<h2><%=book.getTitle()%><%if (book.getTitle().length() >= 49) { %>...<%} %></h2>
		<h2>Quantity: <%=tr.getQuantity()%>     Total: $<%=tr.getTotal()%></h2>

		<form action="front.jsp" method="post">	
			<input type="submit" value="Return to shopping" id="return"/>
		</form>
	
	</section>

</body>
</html>