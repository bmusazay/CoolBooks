package rating;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import rating.Rating;

import javax.servlet.http.HttpSession;

import book.Book;
import data.dbConnect.*;
import user.User;
import rating.Rating;


/**
 * Servlet implementation class addRating
 */
@WebServlet("/addRating")
public class addRating extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addRating() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession ses = request.getSession();
		User user = (User)ses.getAttribute("userInstance");
		if (user == null)
		{
			//not logged in FIX
			response.sendRedirect("../CoolBooks/test.html");
		} 
		
		else
		{
			Date dt = new Date();
			java.text.SimpleDateFormat sdf = 
			     new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String reviewDate = sdf.format(dt);
			Book book = (Book)ses.getAttribute("bookInstance");
			int ratingValue = Integer.parseInt(request.getParameter("rating"));
			String review = request.getParameter("review");
			Rating rating = new Rating(user.getEmail(), book.getIsbn(), ratingValue, review, reviewDate);
			RatingDB rDB = new RatingDB();
			
			if (rDB.alreadyRated(user.getEmail()))
			{
				rDB.addRating(rating);
			} 
			response.sendRedirect("../CoolBooks/Product.jsp?isbn=" + rating.getIsbn());
		}
		
	}

}
