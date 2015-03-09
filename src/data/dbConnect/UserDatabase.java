package data.dbConnect;

import java.sql.*;

import user.User;
import data.dbConnect.DBConnectionPool;

public class UserDatabase {
	//select one user
	final static String db_url = "jdbc:mysql://localhost:3306/CoolBooksDB";
	
	DBConnectionPool connPool = null;
	
	public UserDatabase(){
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
	
	public User selectUser(String email){
		Statement stmt = null;
		ResultSet rs = null;
		User user = new User();
		Connection conn = null;
		try{
			conn = connPool.getConnection();
			
			if(conn != null){
				stmt = conn.createStatement();
				
				String strQuery = "select email, first_name, last_name from account "+
						" where email = '"+ email +"'";
				rs = stmt.executeQuery(strQuery);
				if(rs.next()){
					user.setEmail(rs.getString(1));
					user.setFName(rs.getString(2));
					user.setLName(rs.getString(3));
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
	}
	
	//insert a new user
	public boolean registerUser(User user){
		
		boolean registered = true;
		Statement stmt = null;
		ResultSet rs = null;
		Connection conn = null;
		
		try{
			conn = connPool.getConnection();
			
			if(conn != null){
				stmt = conn.createStatement();
				
				String strQuery = "select email from Account where email = '"+ user.getEmail() +"'";
				
				rs = stmt.executeQuery(strQuery);
				while (rs.next()) {
					registered = !rs.getString(1).equals(user.getEmail());
				}
				
				if (registered) {
					strQuery = "insert Account(email, first_name, last_name, pass, isAdmin) values ('" + user.getEmail() + 
							"', '" + user.getFName() +"', '" + user.getLName() + "', '" + user.getPass() + "', false)";
							
					stmt.executeUpdate(strQuery);
				}
			}
		}catch(SQLException e){
			for(Throwable t: e){	
				t.printStackTrace();
			}
		}catch(Exception et) {
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
		return registered;
	}
	
	public boolean verifyCredentials(User user)
	{
		Statement stmt = null;
		ResultSet rs = null;
		Connection conn = null;
		String password = "";
		try{
			conn = connPool.getConnection();
			
			if(conn != null){
				stmt = conn.createStatement();
				
				String strQuery = "select pass from Account" +
						" where email = '"+ user.getEmail() +"'";
				rs = stmt.executeQuery(strQuery);
				if(rs.next()){
					password = rs.getString(1);
				}
			}
			return user.getPass().equals(password);
			
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
		return false;
	}
	
	public int deleteUser(String email)
	{
		Statement stmt = null;
		ResultSet rs = null;
		Connection conn = null;
		int resultNo = 0;
		try{
			conn = connPool.getConnection();
			
			if(conn != null){
				stmt = conn.createStatement();
				
				String strQuery = "delete from Account" +
						" where email = '"+ email +"'";
				resultNo = stmt.executeUpdate(strQuery);
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
		return resultNo;
	}
	
	
	public Boolean isAdmin(String email)
	{
		Boolean isAdmin = false;
		
		Statement stmt = null;
		ResultSet rs = null;
		Connection conn = null;
		try{
			conn = connPool.getConnection();
			
			if(conn != null){
				stmt = conn.createStatement();
				
				String strQuery = "select isAdmin from Account" +
						" where email = '"+ email +"'";
				rs = stmt.executeQuery(strQuery);
				if(rs.next()){
					isAdmin = rs.getBoolean(1);
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
		return isAdmin;
	}
}

