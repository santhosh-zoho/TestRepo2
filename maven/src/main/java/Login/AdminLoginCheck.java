package Login;

import javax.servlet.http.HttpServlet;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AdminLoginCheck")
public class AdminLoginCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("UserName");
		String password = request.getParameter("Password");
		HttpSession session=request.getSession(true);
		loginDao dao=new loginDao();
		String type="admin";
		if(dao.check(username,password,type))
		{
		  session.setAttribute("AdminLogin","True");
		  response.sendRedirect("FileUploadPage.jsp");
		}
		else{ 
		  session.setAttribute("AdminLogin","False");
		  response.sendRedirect("LoginHome.jsp");
		}
	}

	
}
