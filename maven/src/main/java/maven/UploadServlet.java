package maven;
import java.util.*;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;


@MultipartConfig
public class UploadServlet extends HttpServlet {
	
	BulkProcessorClass BulkProcessor=new BulkProcessorClass();
	
    private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	   response.setContentType("text/html;charset=UTF-8");
	   int i=0;
	   List<String> IdList=new ArrayList<String>();
	   HttpSession session=request.getSession(true);
		try {
			 DiskFileItemFactory factory = new DiskFileItemFactory();
			 ServletFileUpload sf = new ServletFileUpload(factory); 
			 List<FileItem> multifiles =sf.parseRequest(request);
			 int length=multifiles.size();
			 String DataArray[]=new String[length];
			 String PathArray[]=new String[length];
			 String FileNameArray[]=new String[length];
			 String Data=null;
			 StringBuffer FileName =new StringBuffer();
			 GetDataCpp cpp=new GetDataCpp();
			 for (FileItem item : multifiles) 
			 {
			  // Data=item.getString();  
			   FileName=FileName.append(item.getName());
			   int index2=FileName.indexOf("/");
			   FileName = FileName.replace(0,index2+1 ,""); 
			   File file = new File(request.getServletContext().getAttribute("file")+File.separator+item.getName());
			  // String RealFilePath=file.getAbsolutePath();
			   StringBuffer RealFilePath =new StringBuffer();
			   RealFilePath=RealFilePath.append(file.getAbsolutePath());
			   int index=RealFilePath.indexOf("null");
			   RealFilePath = RealFilePath.replace(index,index+5,"");
			   PathArray[i]=RealFilePath.toString();
			   DataArray[i]= cpp.fun(PathArray[i]);
			   FileNameArray[i]=FileName.toString();
			   ++i;
			 }
			 
			 IdList=BulkProcessor.BulkProcessorUpload(DataArray);
			 i=0;
			 session.setAttribute("FileUpload","True");
			 while(length>i)
			 {
			    try 
		        {
					UploadFileInfo(FileNameArray[i],PathArray[i],IdList.get(i));
				} 
			    catch (SQLException e) 
				{
					e.printStackTrace();
					System.out.println("error in uploading file Info in MySql : "+FileNameArray[i]+", exception : "+e);
					session.setAttribute("FileUpload","Error");
				}
			    ++i;
			 }
			 
			}
		    catch (Exception e) 
		    { 
				System.out.println(e);
				System.out.println("error in file management");
				session.setAttribute("FileUpload","Error");
		    }
		 
		 response.sendRedirect("FileUploadPage.jsp");
	  
	}

	
	public boolean UploadFileInfo(String filename,String filepath,String Id) throws SQLException 
	{
	 String sql="insert into fileUpload values (?, ?, ?, ?)";
	 String url="jdbc:mysql://localhost:3306/santhosh";
	 String username="root";
	 String password="ms.dhoni07";
	 String Driver ="com.mysql.cj.jdbc.Driver";
	  try 
	  {
	   Class.forName(Driver);
	   Connection con = DriverManager.getConnection(url,username,password);
	   PreparedStatement st = con.prepareStatement(sql);
	   SimpleDateFormat sd = new SimpleDateFormat("yyyy.MM.dd  HH:mm:ss ");
	   Date date = new Date();
	   sd.setTimeZone(TimeZone.getTimeZone("IST"));
	   String Time= sd.format(date);
	   st.setString(1,filename);
	   st.setString(2,filepath);
	   st.setString(3,Time);
	   st.setString(4,Id);
	   st.executeUpdate();
	  } 
	  catch (ClassNotFoundException e) 
	  {
			e.printStackTrace();
			System.out.println("error in Mysql");
			return false;
			

	  } 
      return true;
    }
	
}
