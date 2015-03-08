package data.dbConnect;

import java.sql.*;
import java.util.*;
import book.Book;

import data.dbConnect.DBConnectionPool;

public class BookDatabase {
	final static String db_url = "jdbc:mysql://localhost:3306/CoolBooksDB";
	DBConnectionPool connPool = null;
	
	public BookDatabase(){
		this.connPool = setDBConnection();
	}
	
	public DBConnectionPool setDBConnection(){
		try{
			connPool = new DBConnectionPool(db_url);
		}catch (Exception et) {
			et.printStackTrace();
		}
		return connPool;
	}
	
	public int purchaseBook(Book book, int quantity)
	{
		
		Statement stmt = null;
		int resultNo = 0;
		Connection conn = null;
		try{

			conn = connPool.getConnection();
			if(conn != null){
				stmt = conn.createStatement();	
				String strQuery = "update Book set inventory_amount = inventory_amount - 1" +
						" where isbn = '"+ book.getIsbn() +"' and inventory_amount > 0"; 
				resultNo = stmt.executeUpdate(strQuery);
			}
		}catch(SQLException e){
			for(Throwable t: e){	
				t.printStackTrace();
			}
		} catch (Exception et) {
			et.printStackTrace();
		}finally {
		    try {
		    	if (stmt != null){
		            stmt.close();
		        }
		        if (conn != null) {
		            connPool.returnConnection(conn);
		        }
		    }catch(Exception e){
		    	 System.err.println(e);
		    }
		}
		return resultNo;
	}
	
	public Book getBook(String isbn)
	{
		Book curBook = new Book();
		Statement stmt = null;
		ResultSet rs = null;
		Connection conn = null;
		try{
			conn = connPool.getConnection();
			if(conn != null){
				stmt = conn.createStatement();		
				String strQuery = "select isbn, title, inventory_amount, price, category," +
				"author, publish_year from Book "+
						" where isbn = '"+isbn+"'";
				rs = stmt.executeQuery(strQuery);
				if(rs.next()){
					curBook.setIsbn(rs.getString(1));
					curBook.setTitle(rs.getString(2));
					curBook.setInventory(rs.getInt(3));
					curBook.setPrice(rs.getDouble(4));
					curBook.setCategory(rs.getString(5));
					curBook.setAuthor(rs.getString(6));
					curBook.setYear(rs.getInt(7));
				}
			}
		}catch(SQLException e){
			for(Throwable t: e){	
				t.printStackTrace();
			}
		}catch (Exception et) {
			et.printStackTrace();
		}finally {
		    try {
		    	if (rs != null){
		            rs.close();
		        }
		    	if (stmt != null){
		            stmt.close();
		        }
		        if (conn != null) {
		            connPool.returnConnection(conn);
		        }
		    }catch(Exception e){
		    	 System.err.println(e);
		    }
		}
		return curBook;
	}
	
	public ArrayList<Book> selectBooks(String search, String category){
		Statement stmt = null;
		ResultSet rs = null;
		Connection conn = null;
		ArrayList<Book> books = new ArrayList<>();
		
		try{
			conn = connPool.getConnection();
			
			if(conn != null){
				stmt = conn.createStatement();
				
				String strQuery = "";
				
				if (category.equals("all")) {
					strQuery = "select isbn, title, author, price, category from book "
					        + "where title like '%" + search + "%';";
				} else {
					strQuery = "select isbn, title, author, price, category from book "
					        + "where title like '%" + search + "%' and category = '" + category + "';";
				}
				
				rs = stmt.executeQuery(strQuery);
				while(rs.next()){
					Book book = new Book();
					book.setIsbn(rs.getString(1));
					book.setTitle(rs.getString(2));
					book.setAuthor(rs.getString(3));
					book.setPrice(Double.parseDouble(rs.getString(4)));
					book.setCategory(rs.getString(5));
					books.add(book);
				}
			}
		}catch(SQLException e){
			for(Throwable t: e){	
				t.printStackTrace();
			}
		} catch (Exception et) {
			et.printStackTrace();
		}finally {
		    try {
		    	if (rs != null){
		            rs.close();
		        }
		    	if (stmt != null){
		            stmt.close();
		        }
		        if (conn != null) {
		            connPool.returnConnection(conn);
		        }
		    }catch(Exception e){
		    	 System.err.println(e);
		    }
		}
		return books;
	}

	public ArrayList<String> selectCategories(){
		Statement stmt = null;
		ResultSet rs = null;
		Connection conn = null;
		ArrayList<String> categories = new ArrayList<>();
		
		try{
			conn = connPool.getConnection();
			
			if(conn != null){
				stmt = conn.createStatement();
				
				String strQuery = "select distinct category from book";
				rs = stmt.executeQuery(strQuery);
				while(rs.next()){
					categories.add((rs.getString(1)));
				}
			}
		}catch(SQLException e){
			for(Throwable t: e){	
				t.printStackTrace();
			}
		} catch (Exception et) {
			et.printStackTrace();
		}finally {
		    try {
		    	if (rs != null){
		            rs.close();
		        }
		    	if (stmt != null){
		            stmt.close();
		        }
		        if (conn != null) {
		            connPool.returnConnection(conn);
		        }
		    }catch(Exception e){
		    	 System.err.println(e);
		    }
		}
		return categories;
	}
}


