package data.dbConnect;

import java.sql.*;
import java.util.ArrayList;

import data.dbConnect.DBConnectionPool;
import rating.Rating;
import transaction.Transaction;

public class RatingDB {
	final static String db_url = "jdbc:mysql://localhost:3306/CoolBooksDB";
	DBConnectionPool connPool = null;
	
	public RatingDB(){
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
	
	public boolean alreadyRated(String email)
	{
		Statement stmt = null;
		Connection conn = null;
		ResultSet rs;
		boolean rated = true;
		
		try{
			//insert into Ratings(email, isbn, rating, time_reviewed, review)
			//values ('test@gmail.com', '11-32-3323', '4', current_date(), 'This book sucks');
			conn = connPool.getConnection();
			if(conn != null){
				stmt = conn.createStatement();
				
				String strQuery = "select email from ratings where email = '"+ email +"'";
				
				rs = stmt.executeQuery(strQuery);
				while (rs.next()) {
					rated = !rs.getString(1).equals(email);
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
		return rated;
	}
	
	public int addRating(Rating rating)
	{
		Statement stmt = null;
		int resultNo = 0;
		Connection conn = null;
		try{
			//insert into Ratings(email, isbn, rating, time_reviewed, review)
			//values ('test@gmail.com', '11-32-3323', '4', current_date(), 'This book sucks');
			conn = connPool.getConnection();
			if(conn != null){
				stmt = conn.createStatement();	
				String strQuery = "insert into Ratings(email, isbn, rating, time_reviewed, review)"
						+ " values ('" + rating.getEmail() + "', '" + rating.getIsbn() + "', "
								 + rating.getRating() +", '" + rating.getReviewDate() + "', '" + rating.getReview() +"');"; 
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

	public ArrayList<Rating> getUserRatings(String email){
		Statement stmt = null;
		ResultSet rs = null;
		Connection conn = null;
		ArrayList<Rating> ratings = new ArrayList<>();
		
		try{
			conn = connPool.getConnection();
			
			if(conn != null){
				stmt = conn.createStatement();
				
				String strQuery = "select isbn, rating, "
								+ "time_reviewed, review from ratings where email = '" + email + "';";
				
				rs = stmt.executeQuery(strQuery);
<<<<<<< HEAD
				while(rs.next()){
=======
				while(rs.next()) {
>>>>>>> mhsaleh2
					Rating rating = new Rating();
					rating.setIsbn(rs.getString(1));
					rating.setRating(Integer.parseInt(rs.getString(2)));
					rating.setReveiwDate(rs.getString(3));
					rating.setReview(rs.getString(4));
					ratings.add(rating);
<<<<<<< HEAD
				}			
=======
				}
>>>>>>> mhsaleh2
			}
		} catch(SQLException e){
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
		return ratings;
	}
<<<<<<< HEAD
<<<<<<< HEAD
}

=======
}
>>>>>>> mhsaleh2
=======
	
	public ArrayList<Rating> getBookRatings(String isbn){
		Statement stmt = null;
		ResultSet rs = null;
		Connection conn = null;
		ArrayList<Rating> ratings = new ArrayList<>();
		
		try{
			conn = connPool.getConnection();
			
			if(conn != null){
				stmt = conn.createStatement();
				
				String strQuery = "select email, rating, "
								+ "time_reviewed, review from ratings where isbn = '" + isbn + "';";
				
				rs = stmt.executeQuery(strQuery);
				while(rs.next()) {
					Rating rating = new Rating();
					rating.setEmail(rs.getString(1));
					rating.setRating(Integer.parseInt(rs.getString(2)));
					rating.setReveiwDate(rs.getString(3));
					rating.setReview(rs.getString(4));
					ratings.add(rating);
				}
			}
		} catch(SQLException e){
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
		return ratings;
	}
}
>>>>>>> ahmed-branch
