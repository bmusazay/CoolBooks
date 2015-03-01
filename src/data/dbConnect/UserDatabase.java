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
	
	//insert a new user
	
	public int registerUser(User user){
		Statement stmt = null;
		ResultSet rs = null;
		int resultNo = 0;
		Connection conn = null;
		try{
			conn = connPool.getConnection();
			
			if(conn != null){
				stmt = conn.createStatement();
				
				String strQuery = "insert Account(email, first_name, last_name, pass) values ('" + user.getEmail() + 
						"', '" + user.getFName() +"', '" + user.getLName() + "', '" + user.getPass() + "')";
						
						
				resultNo = stmt.executeUpdate(strQuery);
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
		return resultNo;
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
				
				String strQuery = "select pass from Account"+
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
	
}

