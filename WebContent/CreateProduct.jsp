<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII" import="java.io.*,java.util.*, javax.servlet.*"%>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@ page import="book.Book" %>
<%@ page import="data.dbConnect.BookDatabase" %>
<%@ page import="java.lang.Math" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<style type="text/css">
	body {
		background-image: url('http://i.imgur.com/4K8qUHG.jpg'), url('http://i.imgur.com/EX0x72e.jpg');
		background-repeat: no-repeat, repeat;
		margin-left: 350px;
    	padding: 0;
	}
	h1 {
		font-size: 30px;
		font-family: 'Verdana', 'Geneva', sans-serif;
		color: #FFFFFF;
		margin-top: 250px;
	}
	
	h4
	{
		font-size: 15px;
		font-family: 'Verdana', 'Geneva', sans-serif;
		color: #FFFFFF;
	}
	
<title>Product Created</title>
</head>

<body>

	<h1>Product Created</h1>
<%
	Double price = 0.0;
	int year = 0;
	int quantity = 0;
	String isbn = "";
	String title = "";
	String author = "";
	String category = "";
	
	
	//Check that we have a file upload request
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	if (isMultipart) {
		// Configure a repository parameter
		ServletContext context = pageContext.getServletContext();
		String filePath = context.getInitParameter("file-upload");
		
		// Create a factory for disk-based file items
		DiskFileItemFactory factory = new DiskFileItemFactory();

		// Create a new file upload handler
		ServletFileUpload upload = new ServletFileUpload(factory);

		try{ 
			// Parse the request to get file items.
			List<FileItem> items = upload.parseRequest(request);

			// Process the uploaded file items
			Iterator<FileItem> iter = items.iterator();

			int indx = 1;
			while (iter.hasNext ()){
				FileItem fi = iter.next();
				if ( fi.isFormField () ){
					// Process a regular form field
	            	String otherFieldName = fi.getFieldName();
	            	String otherFieldValue = fi.getString();
	           	 
	            	switch (otherFieldName)
	            	{
	            		case "Isbn" :
	            			isbn = otherFieldValue;
	            			break;
	            		case "Title" : 
	            			title = otherFieldValue;
		            		break;
	            		case "Author" : 
	            			author = otherFieldValue;
		            		break;
	            		case "PublishYear" : 
	            			year = Integer.parseInt(otherFieldValue);
		            		break;
	            		case "Category" : 
	            			category = otherFieldValue;
		            		break;
	            		case "Quantity" : 
	            			quantity = Integer.parseInt(otherFieldValue);
		            		break;
	            		case "Price" : 
	            			price = Double.parseDouble(otherFieldValue);
		            		break;
	            	}
	            	%>
	            	
	            	<h3><%=otherFieldName %> : <%= otherFieldValue %></h3>
	            	
	            	
	            	<% 
	            }else{
	            	// Get the uploaded file parameters
					
					String fileName = fi.getName();
					String fieldName = fi.getFieldName();
					long sizeInBytes = fi.getSize();
					
					// Write the file
					File file = new File(filePath + File.separator + fileName) ;
	            	fi.write( file ) ;
	            	if(!fileName.equals("")){
	            		
	            	}
	            }
			}
		}catch(IOException ex) {
		}

	

		//Create book and add to database
		Book newBook = new Book(isbn, title, author, price, category, year, quantity);
		BookDatabase bDB = new BookDatabase();
		bDB.addBook(newBook);
		response.sendRedirect("adminCP.jsp");
	}
%>
</body>
</html>