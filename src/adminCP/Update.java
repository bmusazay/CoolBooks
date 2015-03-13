package adminCP;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import data.dbConnect.*;
import user.User;
import book.Book;

/**
 * Servlet implementation class Update
 */
@WebServlet("/Update")
public class Update extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Update() {
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
		String email = request.getParameter("email");
		String book = request.getParameter("isbn");
		
		UserDatabase uDB = new UserDatabase();
		BookDatabase bDB = new BookDatabase();
		if (email != null){
			User u = uDB.selectUser(email);
			if(u.getFName() == null)
			{
				email = "notfound";
			} 
		}
		if (book != null){
			Book b = bDB.getBook(book);
			if(b.getCategory() == null)
			{
				book = "notfound";
			}
		}
		
		response.sendRedirect("../CoolBooks/adminCP.jsp?user=" + email + "&book=" + book);
	}

}
