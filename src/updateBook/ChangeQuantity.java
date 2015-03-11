package updateBook;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data.dbConnect.BookDatabase;

/**
 * Servlet implementation class ChangeQuantity
 */
@WebServlet("/ChangeQuantity")
public class ChangeQuantity extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangeQuantity() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int qty = Integer.parseInt(request.getParameter("qty"));
		String isbn = request.getParameter("isbn");
		BookDatabase bookDB = new BookDatabase();
		int i = bookDB.updateQuantity(isbn, qty);
		if (i > 0)
		{
			response.sendRedirect("../CoolBooks/adminCP.jsp");
			
		} else 
		{
			//error
		}
	}

}
