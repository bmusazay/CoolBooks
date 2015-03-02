package data.dbConnect;

import java.sql.*;
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
	/*public User selectUser(String username){
		Statement stmt = null;
		ResultSet rs = null;
		User user = new User();
		Connection conn = null;
		try{
			conn = connPool.getConnection();
			
			if(conn != null){
				stmt = conn.createStatement();
				
				String strQuery = "select username, u_name, email, signUpDate, lastLogin from user "+
						" where username = '"+username+"'";
				rs = stmt.executeQuery(strQuery);
				if(rs.next()){
					user.setUsername(rs.getString(1));
					user.setName(rs.getString(2));
					user.setEmail(rs.getString(3));
					user.setSignDate(rs.getString(4));
					user.setLastDate(rs.getString(5));
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
		return user;
	}*/
	
}

