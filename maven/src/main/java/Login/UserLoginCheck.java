package Login;

import javax.servlet.http.HttpServlet;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/UserLoginCheck")
public class UserLoginCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("UserName");
		String password = request.getParameter("Password");
		String Email    = request.getParameter("Email");
		String PhoneNo  = request.getParameter("PhoneNo");
		HttpSession session=request.getSession(true);
		loginDao dao=new loginDao();
		try {
			if(dao.signup(username,password,Email,PhoneNo))
			 {
			  session.setAttribute("SingUp","True");
			  response.sendRedirect("LoginHome.jsp");
			 }
			 else{
			  session.setAttribute("SingUp","False");
			  response.sendRedirect("LoginHome.jsp");
			 }
			
		 } catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("UserName");
		String password = request.getParameter("Password");
		HttpSession session=request.getSession(true);
		 loginDao dao=new loginDao();
		 String type="user";
		 if(dao.check(username,password,type))
		 {
		  session.setAttribute("UserLogin","True");
		  response.sendRedirect("UserWelcomePage.jsp");
		 }
		 else{
		  session.setAttribute("UserLogin","False");
		  response.sendRedirect("LoginHome.jsp");
		 }
		}
}
