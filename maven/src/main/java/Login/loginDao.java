package Login;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpSession;

public class loginDao{
	String sql;
	String url="jdbc:mysql://localhost:3306/santhosh";
	String username="root";
	String password="ms.dhoni07";
	String Driver ="com.mysql.cj.jdbc.Driver";
	public boolean check(String uname,String pass,String type) 
	{
		    sql="select * from loginadmin where Username=? and Password=?";
		    if(type.equals("user")) 
		    {
		    	sql="select * from loginuser where Username=? and Password=?";
		    }
			try 
			{
				Class.forName(Driver);
				Connection con = DriverManager.getConnection(url,username,password);
				PreparedStatement st = con.prepareStatement(sql);
				st.setString(1,uname);
				st.setString(2,pass);
				ResultSet rs = st.executeQuery();
				if(rs.next())
				{
					return true;
				}
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
			}
		return false;
	}
	public boolean signup(String uname,String pass,String email,String phone) throws SQLException 
	{
	  sql="insert into loginuser values (?, ?, ?, ?)";
	  if(uname.isEmpty() || pass.isEmpty() || email.isEmpty() || phone.isEmpty() ){
			return false;
	  }
	  try 
	  {
	   Class.forName(Driver);
	   Connection con = DriverManager.getConnection(url,username,password);
	   PreparedStatement st = con.prepareStatement(sql);
	   st.setString(1,uname);
	   st.setString(2,pass);
	   st.setString(3,email);
	   st.setString(4,phone);
	   st.executeUpdate();
	  } 
	  catch (Exception e) 
	  {
			e.printStackTrace();
			return false;

	  } 
	  
      return true;
    }
}
