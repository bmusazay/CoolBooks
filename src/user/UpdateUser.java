package user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		String oldEmail = request.getParameter("oldEmail");
		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		String password = request.getParameter("password");
		UserDatabase uDB = new UserDatabase();
		int val = 0;
		User curUser = uDB.selectUser(oldEmail);
		
		if (fname != null && !curUser.getFName().equals(fname))
		{
			val = uDB.updateField("first_name", fname, oldEmail);
		}
		
		if (lname != null && !curUser.getLName().equals(lname))
		{
			val = uDB.updateField("last_name", lname, oldEmail);
		}
		if (password != null && !curUser.getPass().equals(password))
		{
			val = uDB.updateField("pass", password, oldEmail);
		}
		
		if (val > 0)
			response.sendRedirect("accountPage.jsp?status=success");
		else
			response.sendRedirect("accountPage.jsp");
	}

}
