<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="data.dbConnect.TransactionDB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	TransactionDB trDB = new TransactionDB();
	out.println("Monthly sales: $" + trDB.getSales("30"));
	out.println("<br>Weekly sales: $" + trDB.getSales("7"));
	out.println("<br>Last Month sales: $" + trDB.getSales("lastmonth"));
	out.println("<br>Last Week sales: $" + trDB.getSales("lastweek"));


%>

</body>
</html>