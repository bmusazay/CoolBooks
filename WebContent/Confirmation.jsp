<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="book.Book" %>
 <%@ page import="transaction.Transaction" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
<%
	Book book = (Book)session.getAttribute("bookInstance");
	Transaction tr = (Transaction)session.getAttribute("transaction");
	out.println("<h1>Order number: " + tr.getTranNumber() + "</h1>");
	out.println("<h1> Thank you for your purchase of:</h1>");
	out.println("<h2>" + book.getTitle() + "</h2>");
	
%>

	<form action="front.jsp" method="post">	
		<input type="submit" value="Return to shopping" id="return"/>
	</form>

</body>
</html>