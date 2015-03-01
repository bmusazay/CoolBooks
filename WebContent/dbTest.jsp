<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ page import="data.dbConnect.DBConnectionPool" %>
<%@ page import="java.sql.Connection" %>
<%

	

	String driver = "org.gjt.mm.mysql.Driver";
	String url = "jdbc:mysql://localhost:3306/CoolBooksDB";
	String username = "root";
	String passwd = "";
	
	DBConnectionPool connPool = new DBConnectionPool(url);
	Connection conn = connPool.getConnection();
	
	if(conn != null) 
	{
		out.println("Success");
		
	} else {
		out.println("Failed");
	}
%>
</body>
</html>