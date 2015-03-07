package data.dbConnect;


import java.sql.*;
import java.util.Date;

import book.Book;
import data.dbConnect.DBConnectionPool;
import transaction.Transaction;


public class TransactionDB {
	final static String db_url = "jdbc:mysql://localhost:3306/CoolBooksDB";
	DBConnectionPool connPool = null;
	private String email;
	private String isbn;
	private int quantity;
	private double total;
	private int orderNumber;
	private String purchaseDate;
	
	public TransactionDB(Transaction tr){
		this.connPool = setDBConnection();
		this.email = tr.getEmail();
		this.isbn = tr.getIsbn();
		this.quantity = tr.getQuantity();
		this.total = tr.getTotal();
		orderNumber = 0;
		purchaseDate = "";
	}
	
	public DBConnectionPool setDBConnection(){
		try{
			connPool = new DBConnectionPool(db_url);
		}catch (Exception et) {
			et.printStackTrace();
		}
		return connPool;
	}
	
	//insert into Transactions(email, purchaseDate, isbn, quantity, total) 
	//values ("test2@gmail.com", current_timestamp(), '22-22-2', 5, 12.32);
	public int addTransaction(Book book)
	{
		Date dt = new java.util.Date();

		java.text.SimpleDateFormat sdf = 
		     new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		purchaseDate = sdf.format(dt);
		Statement stmt = null;
		int resultNo = 0;
		Connection conn = null;
		try{

			conn = connPool.getConnection();
			if(conn != null){
				stmt = conn.createStatement();	
				String strQuery = "insert into Transactions(email, purchaseDate, isbn,"
						+ "quantity, total) values ('" + this.email + "', '" + purchaseDate + "', "
								+ "'" + this.isbn +"', " + this.quantity + ", " + this.total +");"; 
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
	
	public int getOrderNumber()
	{
		Statement stmt = null;
		ResultSet rs = null;
		Connection conn = null;
		try{
			conn = connPool.getConnection();
			if(conn != null){
				stmt = conn.createStatement();		
				String strQuery = "select orderNumber from Transactions" +
						" where isbn = '"+isbn+"' and purchaseDate = '" + purchaseDate + "';";
				rs = stmt.executeQuery(strQuery);
				if(rs.next()){
					orderNumber = rs.getInt(1);
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
		return orderNumber;
	}
	
}
