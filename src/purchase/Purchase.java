package purchase;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import book.Book;
import data.dbConnect.*;
import transaction.Transaction;
import user.User;

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
		User user = (User)ses.getAttribute("userInstance");
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		
		if (user == null)
		{
			//not logged in FIX
			response.sendRedirect("../CoolBooks/test.html");
		}
		Book book = (Book)ses.getAttribute("bookInstance");
		
		if( book.getInventory() > 0)
		{
			System.out.println(quantity);
			BookDatabase db = new BookDatabase();
			if (db.purchaseBook(book, quantity) > 0) 
			{
				Date dt = new Date();
				java.text.SimpleDateFormat sdf = 
				     new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String purchaseDate = sdf.format(dt);
				
				//Create transaction
				Transaction tr = new Transaction(user.getEmail(), book.getIsbn(),
													quantity, book.getPrice(), purchaseDate );
				
				//Upload transaction object to TransactionDB
				TransactionDB trDB = new TransactionDB();
				trDB.addTransaction(tr);
				tr.setTranNumber(trDB.getOrderNumber(tr));
				//Send transaction to confirmation page to display
				ses.setAttribute("transaction", tr);
				response.sendRedirect("../CoolBooks/Confirmation.jsp");
			} else 
			{
				HttpSession session = request.getSession();
				session.setAttribute("purchased", false);
				response.sendRedirect(request.getHeader("referer"));
			}
			
		} else 
		{
			HttpSession session = request.getSession();
			session.setAttribute("purchased", false);
			response.sendRedirect(request.getHeader("referer"));
		}
		
	}

}
