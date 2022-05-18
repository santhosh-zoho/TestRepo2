package maven;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ShowDocData
 */
@WebServlet("/ShowDocData")
public class ShowDocData extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  HttpSession session=request.getSession(true);
		  String Id=request.getParameter("Id");
		  String page=request.getParameter("page");
		  GetDataById dataGet=new GetDataById(); 
		  String Result = dataGet.GetData(Id);
		  session.setAttribute("DocData",Result );
		  if(page !=null && page.equals("search")) 
			  response.sendRedirect("ShowSearchedData.jsp");
		  else   
		    response.sendRedirect("FileUploadPage.jsp");
	}

}
