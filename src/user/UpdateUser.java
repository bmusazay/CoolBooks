package user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.dbConnect.*;
import user.User;

/**
 * Servlet implementation class UpdateUser
 */
@WebServlet("/UpdateUser")
public class UpdateUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateUser() {
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
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		User sessionUser = (User)session.getAttribute("userInstance");
		
		String oldEmail = sessionUser.getEmail();
		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		String passw = request.getParameter("npass");
		UserDatabase uDB = new UserDatabase();
		int val = 0;
		User curUser = uDB.selectUser(oldEmail);
		
		if (fname != null)
		{
			val = uDB.updateField("first_name", fname, oldEmail);
		}
		
		if (lname != null)
		{
			val = uDB.updateField("last_name", lname, oldEmail);
		}
		if (passw != null)
		{
			val = uDB.updateField("pass", passw, oldEmail);
		}
		
		if (val > 0)
			response.sendRedirect("accountPage.jsp?status=success");
		else
			response.sendRedirect("accountPage.jsp");
	}
}
