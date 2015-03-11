<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@ page import="data.dbConnect.TransactionDB" %>
<%@ page import="transaction.Transaction" %>
<%@ page import="book.Book" %>
<%@ page import="user.User" %>
<%@ page import="java.util.*" %>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<style type="text/css">
	
	body {
    	background-image: url('http://i.imgur.com/4K8qUHG.jpg'), url('http://i.imgur.com/EX0x72e.jpg');
    	background-repeat: no-repeat, repeat;
    	margin-top: 250px;
    	margin-left: 100px;
	    padding: 0;
	}
	
	h1 {
		font-family: 'Verdana', 'Geneva', sans-serif;
		color: #FFFFFF;
		font-size: 20px;
	}
		
	h2 {
		font-family: 'Verdana', 'Geneva', sans-serif;
		color: #FF0000;
	}
	
	h3 {
		font-family: 'Verdana', 'Geneva', sans-serif;
		color: #FFFFFF;
		font-size: 40px;
	}
	
	a {
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
	
	input[type='submit']:disabled, a.add:disabled {
   		background: #2A2E38;
   		color: #666;
   		cursor: default;
   		border: 1px solid #666;
	}
	
	#link {
	  color: #FFFFFF;
	  font-family: 'Verdana', 'Geneva', sans-serifS;
	  font-size: 15px;
	  margin: 80px;
	}
	
	
	#search { position: absolute; right: 20px; right: 150px; top: 75px; }
	
	#category {
	  display: inline-block;
      vertical-align: top;
	  background-color: #99CCFF;
	  color: #666;
	  font-family: 'Verdana', 'Geneva', sans-serif;
	  font-size: 20px;
	  border: 1px solid #FFFFFF;
	  padding: 6px 4px;
	  border-radius: 3px;
	  margin-right: 10px;
	}
	
	#searchbutton { margin-right: 10px; }
	#searchfield { margin-right: 20px; padding: 4px 20px; }
	
	#user { width: 100px; position: absolute; right: 20px; top: 75px;}
	#loginout { float: right; }
	#account { float: right; margin-top: 10px;}
	
	table, th, td { color: #FFFFFF; border-collapse: collapse; border: 1px solid #FFFFFF; }

	
	#books { width: 95%;} 
	#bookPic { width: 25%;}
	#info { width: 75%; }
	#image { width: 150px; height: 199px; margin: 25px;}
	
	#page { width: 500px; margin: 50px auto; margin-bottom: 150px;}
	#next { float: right; }
	#previous { float: right; margin-right: 15px; }
	#pageNumber { float: right; font-family: 'Verdana', 'Geneva', sans-serif; font-size: 15px; margin-right: 10px; margin-top: 10px;}
	
	</style>
	<title>Transactions</title>
</head>
<body>

<% 
TransactionDB transactionDB = new TransactionDB();

String email = (String)request.getParameter("email");

ArrayList<Transaction> transactions;

if (email != null && email.length() != 0) {
	%><h3>Transactions for user: <%=email%></h3> <%
	transactions = transactionDB.getTransactions(email);
} else {
	email = "";
	%><h3>All transactions: </h3>
	<%
	transactions = transactionDB.getAllTransactions();
}

if (transactions.size() != 0) { %>
	<table id="books">
		<thead>
			<tr>
				<th>Number</th>
				<th>Date</th>
						<% if (email.length() == 0) {%>
							<th>Email</th>
						<%}%>
							<th>ISBN</th>
				<th>Quantity</th>
				<th>Total</th>
			</tr>
		</thead>
		<tbody>
  <%int pageNo;
	if (request.getParameter("page") == null) {
		pageNo = 1;
	} else {
		pageNo = Integer.parseInt((String)request.getParameter("page"));
	}
	int maxNo = transactions.size() - 1;
	int maxPerPage = 20;
	for(int i = (pageNo - 1) * maxPerPage; i < (pageNo - 1) * maxPerPage + maxPerPage; i++){
		if (i < transactions.size()) {
			Transaction transaction = transactions.get(i);
	%>
					<tr>
						<td><%=transactions.get(i).getTranNumber()%></td>
						<td><%=transactions.get(i).getTranDate()%></td>
						<% if (email.length() == 0) {%>
							<td><%=transactions.get(i).getEmail()%></td>
						<%}%>
						<td><%=transactions.get(i).getIsbn()%></td>
						<td><%=transactions.get(i).getQuantity()%></td>
						<td><%=transactions.get(i).getTotal()%></td>
					</tr>
	<% }
	}%>
				</tbody>
			</table>
<section id="page">
	<%if (pageNo * maxPerPage > maxNo) { %>
		<form action="transactions.jsp?email=<%=email%>&page=<%=pageNo + 1%>" method="post">	
			<input type="submit" value="Next Page" id="next" disabled/>
		</form>
	<%} else { %>
		<form action="transactions.jsp?email=<%=email%>&page=<%=pageNo + 1%>" method="post">	
			<input type="submit" value="Next Page" id="next"/>
		</form>
	<%}%>
	
	<h4 id="pageNumber"> Page <%=pageNo%> / <%=maxNo / maxPerPage + 1%> </h4>
	
	<%if (pageNo - 1 < 1) { %>
		<form action="transactions.jsp?email=<%=email%>&page=<%=pageNo - 1%>" method="post">		
			<input type="submit" value="Previous Page" id="previous" disabled/>
		</form>
	<%} else { %>
		<form action="transactions.jsp?email=<%=email%>&page=<%=pageNo - 1%>" method="post">	
			<input type="submit" value="Previous Page" id="previous"/>
		</form>
	<%}
} else {%>
	<h2>No transactions.</h2>
<%}%>

</section>

</body>
</html>