package data.dbConnect;
//insert into Transactions(email, purchaseDate, isbn, quantity, total) 
//values ("test2@gmail.com", current_timestamp(), '22-22-2', 5, 12.32);

import java.sql.*;

import book.Book;
import data.dbConnect.DBConnectionPool;


public class TransactionDB {
	final static String db_url = "jdbc:mysql://localhost:3306/CoolBooksDB";
	DBConnectionPool connPool = null;
	private String email;
	private String isbn;
	private int quantity;
	private double total;
	
	
	public TransactionDB(String email, String isbn, int quantity, double total){
		this.connPool = setDBConnection();
		this.email = email;
		
	}
	
	public DBConnectionPool setDBConnection(){
		try{
			connPool = new DBConnectionPool(db_url);
		}catch (Exception et) {
			et.printStackTrace();
		}
		return connPool;
	}
	
	public int addTransaction(Book book)
	{
		Statement stmt = null;
		int resultNo = 0;
		Connection conn = null;
		try{

			conn = connPool.getConnection();
			if(conn != null){
				stmt = conn.createStatement();	
				String strQuery = ""; 
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
	
}
