package purchase;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import book.Book;
import data.dbConnect.*;

/**
 * Servlet implementation class Purchase
 */
@WebServlet("/Purchase")
public class Purchase extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Purchase() {
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
		
		//Book book = (Book)request.getAttribute("book");
		HttpSession ses = request.getSession();
		
		Book book = (Book)ses.getAttribute("bookInstance");
		
		if( book.getInventory() > 0)
		{
			BookDatabase db = new BookDatabase();
			if (db.purchaseBook(book, 1) > 0) 
			{
				response.sendRedirect("../CoolBooks/Confirmation.jsp");
			} else 
			{
				// error page something went wrong
			}
			
		} else 
		{
			//not in stock
		}
		
	}

}
