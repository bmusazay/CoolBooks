<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="data.dbConnect.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>


Maintain the aggregate sales and profit of the store weekly and monthly. 
Then, compare the value change (i.e. increase/decrease) of sales and profit with
 the previous week and month. 
 o Maintain weekly the top 10 bestsellers of the entire store and the top 
 5 bestsellers of each category. Also main the list of the most favorite 
 books bi-‐‐weekly.
 
 o Develop a direct marketing data; for each product category, a list of customers 
 that buy theproduct more than 2 times per month. 
 
 o Other interesting summary data that you will come up with. 
 
 <br><br><br>

<%
	TransactionDB trDB = new TransactionDB();
	out.println("Monthly sales: $" + trDB.getSales("30"));
	out.println("<br>Weekly sales: $" + trDB.getSales("7"));
	out.println("<br>Last Month sales: $" + trDB.getSales("lastmonth"));
	out.println("<br>Last Week sales: $" + trDB.getSales("lastweek"));
	out.println("<br>Weekly Top 10: <br>");
	ArrayList<String> topTen = trDB.topTenBestSellers();
	for (int i = 0; i < topTen.size(); i++)
	{
		out.println( topTen.get(i) );
		out.println("<br>");
	}
	
	out.println("<br><br><br>");
	
	out.println("<br>Top 5 popular: <br>");
	ArrayList<String> topFive = trDB.biweeklyPopular();
	for (int i = 0; i < topFive.size(); i++)
	{
		out.println(topFive.get(i));
		out.println("<br>");
	}
	
	
	
	BookDatabase bookDB = new BookDatabase();
	ArrayList<String> categories = bookDB.selectCategories();

	
	
	out.println("<br>5 Bestsellers by Category : <br>");
	String category = request.getParameter("category");

	if (category == null) {
		category = "all";
	}
%>
	
	<form action="Search" method="post">
	
		<select name="category">
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
	
		<input type="submit" value="Top 5" id="submit"/>
		<input type="text"  name="search" id="search" />
	  			
	</form>
	
	
	
	
</body>
</html>