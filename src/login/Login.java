package login;

import user.User;
import data.dbConnect.*;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
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
		String pass = request.getParameter("pass");
		
		if (email != null && pass != null) {			
			User user = new User(email, pass, "", "", false);
			UserDatabase dbConn = new UserDatabase();
			HttpSession session = request.getSession();
		
			if(dbConn.verifyCredentials(user))
			{
				if (dbConn.isAdmin(user.getEmail() ))
				{
					user.setAdmin(true);
					session.setAttribute("success", true);
					session.setAttribute("userInstance", user);
					response.sendRedirect("../CoolBooks/adminCP.jsp");
				} else 
				{
					session.setAttribute("login", true);
					session.setAttribute("userInstance", user);
					response.sendRedirect("../CoolBooks/front.jsp");
				}

			} else 
			{
				session.setAttribute("login", false);
				response.sendRedirect("../CoolBooks/loginForm.jsp");
			}
		}
	}
}
