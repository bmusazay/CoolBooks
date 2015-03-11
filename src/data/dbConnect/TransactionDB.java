package data.dbConnect;


import java.sql.*;
import java.util.ArrayList;

import java.math.*;
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


	public double getSales(String period)
	{
		Boolean previousTotalFlag = false;
		String dateFrom = "";
		String dateTo = "";
		if (period.equals("lastweek"))
		{
			previousTotalFlag = true;
			dateFrom = "14";
			dateTo = "7";
		} else if(period.equals("lastmonth"))
		{
			previousTotalFlag = true;
			dateFrom = "60";
			dateTo = "30";
		}
		double total = 0.0;
		
		Statement stmt = null;
		ResultSet rs = null;
		Connection conn = null;
		try{
			conn = connPool.getConnection();
			if(conn != null){
				stmt = conn.createStatement();		
				String strQuery;
				if (previousTotalFlag)
				{
					strQuery= "select total from Transactions where purchaseDate BETWEEN " +
							"date_sub( now( ) , INTERVAL " + dateFrom + " DAY ) AND " +
							"date_sub( now( ) , INTERVAL " + dateTo + " DAY )";
				} else 
				{
					strQuery= "select total from Transactions where purchaseDate BETWEEN " +
							"date_sub( now( ) , INTERVAL " + period + " DAY ) AND NOW( )";
				}
				rs = stmt.executeQuery(strQuery);
				while(rs.next()){
					total += rs.getDouble(1);
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
		};
		BigDecimal bd = new BigDecimal(total).setScale(2, RoundingMode.HALF_EVEN);
		total = bd.doubleValue();
		return total;
	}
	
	//Top ten best sellers
	public ArrayList<String> topTenBestSellers()
	{
		Statement stmt = null;
		ResultSet rs = null;
		Connection conn = null;
		ArrayList<String> topTen = new ArrayList<>();
		try{
			conn = connPool.getConnection();
			
			if(conn != null){
				stmt = conn.createStatement();
				
				String strQuery = "select isbn from (select isbn, COUNT(*) as count FROM" + 
							"Transactions GROUP BY isbn ORDER BY count DESC) AS TopTen ORDER BY " +
							"count DESC LIMIT 10;";
				
				rs = stmt.executeQuery(strQuery);
				while(rs.next()){
					topTen.add(rs.getString(1));
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
		return topTen;
	}
	
	//top 5 per category
	public ArrayList<String> topFive(String category)
	{
		Statement stmt = null;
		ResultSet rs = null;
		Connection conn = null;
		ArrayList<String> topTen = new ArrayList<>();
		try{
			conn = connPool.getConnection();
			
			if(conn != null){
				stmt = conn.createStatement();
				
				String strQuery = "select isbn from (select Transactions.isbn, COUNT(*) as" + 
				" count FROM Transactions, Book WHERE category = '" + category + "' and Transactions.isbn" + 
						" = Book.isbn GROUP BY isbn ORDER BY count DESC) AS TopTen ORDER BY count DESC LIMIT 5;";
				rs = stmt.executeQuery(strQuery);
				while(rs.next()){
					topTen.add(rs.getString(1));
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
		return topTen;
	}
	
	
	public ArrayList<String> biweeklyPopular()
	{
		ArrayList<String> popular = new ArrayList<>();
		Statement stmt = null;
		ResultSet rs = null;
		Connection conn = null;
		
		try{
			conn = connPool.getConnection();
			
			if(conn != null){
				stmt = conn.createStatement();
				
				String strQuery = "select isbn from (select total as biweek from Transactions where purchaseDate BETWEEN " +
						"date_sub( now( ) , INTERVAL 14 DAY ) AND NOW( )) AS TopFive ORDER BY count DESC LIMIT 5";
				rs = stmt.executeQuery(strQuery);
				while(rs.next()){
					popular.add(rs.getString(1));
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
		
		return popular;
	}
	
	// returns customers that purchased more than 1 product from category in a month
	public ArrayList<String[]> customersByCategory(String category)
	{
		ArrayList<String[]> customer = new ArrayList<String[]>();
		
		Statement stmt = null;
		ResultSet rs = null;
		Connection conn = null;
		
		try{
			conn = connPool.getConnection();
			
			if(conn != null){
				stmt = conn.createStatement();
				
				String strQuery = "select * from (select email, COUNT(*) as count from Transactions,Book where " + 
				"Transactions.isbn = Book.isbn AND purchaseDate BETWEEN date_sub( now( ) , INTERVAL 30 DAY ) " + 
						"AND NOW( ) and category = '" + category + "' ORDER BY count) as customers where count > 2";
				rs = stmt.executeQuery(strQuery);
				while(rs.next()){
					String[] values = new String[2];
					values[0] = rs.getString(1);
					values[1] = Integer.toString(rs.getInt(1));
					customer.add(values);
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
		return customer;
	}
}
