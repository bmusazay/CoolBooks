package signUp;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.User;
import data.dbConnect.*;

/**
 * Servlet implementation class SignUp
 */

@WebServlet("/SignUp")
public class SignUp extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignUp() {
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
		
		String email= request.getParameter("email");
		String passwd= request.getParameter("pass");
		String fname= request.getParameter("fname");
		String lname = request.getParameter("lname");
		
		User user = new User(email, passwd, fname, lname, false);
		UserDatabase dbConn = new UserDatabase();
		boolean registered = dbConn.registerUser(user);
		HttpSession session = request.getSession();
		
		if (registered) {
			session.setAttribute("signup", true);
			response.sendRedirect("../CoolBooks/loginForm.jsp");
		} else {
			session.setAttribute("signup", false);
			response.sendRedirect("../CoolBooks/signUpForm.jsp");
		}
	}

}
