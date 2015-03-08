package data.dbConnect;


import java.sql.*;
import java.util.ArrayList;

import data.dbConnect.DBConnectionPool;
import transaction.Transaction;


public class TransactionDB {
	final static String db_url = "jdbc:mysql://localhost:3306/CoolBooksDB";
	DBConnectionPool connPool = null;
	
	public TransactionDB(){
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
	
	//insert into Transactions(email, purchaseDate, isbn, quantity, total) 
	//values ("test2@gmail.com", current_timestamp(), '22-22-2', 5, 12.32);
	public int addTransaction(Transaction tr)
	{
		Statement stmt = null;
		int resultNo = 0;
		Connection conn = null;
		try{

			conn = connPool.getConnection();
			if(conn != null){
				stmt = conn.createStatement();	
				String strQuery = "insert into Transactions(email, purchaseDate, isbn,"
						+ "quantity, total) values ('" + tr.getEmail() + "', '" + tr.getTranDate() + "', "
								+ "'" + tr.getIsbn() +"', " + tr.getQuantity() + ", " + tr.getTotal() +");"; 
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
	
	public int getOrderNumber(Transaction tr)
	{
		int orderNumber = 0;
		Statement stmt = null;
		ResultSet rs = null;
		Connection conn = null;
		try{
			conn = connPool.getConnection();
			if(conn != null){
				stmt = conn.createStatement();		
				String strQuery = "select orderNumber from Transactions" +
						" where isbn = '"+ tr.getIsbn() +"' and purchaseDate = '" + tr.getTranDate() + "';";
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
	

	public ArrayList<Transaction> getTransactions(String email) {
		Statement stmt = null;
		ResultSet rs = null;
		Connection conn = null;
		ArrayList<Transaction> transactions = new ArrayList<>();
		
		try{
			conn = connPool.getConnection();
			
			if(conn != null){
				stmt = conn.createStatement();
				
				String strQuery = "select orderNumber, purchaseDate, isbn, "
						        + "quantity, total from transactions where email = '" + email + "';";
				rs = stmt.executeQuery(strQuery);
				while(rs.next()){
					Transaction transaction = new Transaction();
					transaction.setTranNumber(Integer.parseInt(rs.getString(1)));
					transaction.setTranDate(rs.getString(2));
					transaction.setIsbn(rs.getString(3));
					transaction.setQuantity(Integer.parseInt(rs.getString(4)));
					transaction.setTotal(Double.parseDouble(rs.getString(5)));
					transactions.add(transaction);
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
		return transactions;
	}
}
	
	
	/*
	 * 2
		o Maintain the aggregate sales and profit of the store weekly and monthly.
		 Then, compare the value change (i.e. increase/decrease) of sales and profit 
		 with the previous week and month. 
		 o Maintain weekly the top 10 bestsellers of the entire store and the top 5
		  bestsellers of each category. Also main the list of the most favorite books bi-‐‐weekly. 
		 o Develop a direct marketing data; for each product category, a list of customers 
		 that buy theproduct more than 2 times per month. 
		 o Other interesting summary data that you will come up with. 
	 * */
	 
	
	


