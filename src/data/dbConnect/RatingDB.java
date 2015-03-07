package data.dbConnect;

import java.sql.*;

import data.dbConnect.DBConnectionPool;
import rating.Rating;

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

}
