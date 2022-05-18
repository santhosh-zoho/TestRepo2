package maven;

import java.util.LinkedHashMap;
import java.util.Map;

public class MappingClass {
	
	  Map<String, Object> Map = new LinkedHashMap<String, Object>();
	
		/*
		 * public static void main(String[] args) { String Data="Name : santhosh k\r\n"
		 * + "Working company : Zoho corporation\r\n" + "Team : IT security-log360\r\n"
		 * + "Mail Id : santhosh.kk@zohocorp.com\r\n" + "Mobile No : 6383873230";
		 * MappingClass Map=new MappingClass();
		 * System.out.println("map = "+Map.Mapping(Data)); }
		 */
	 
	@SuppressWarnings("rawtypes")
	public Map Mapping(String Data) {
		
		StringBuilder DataB = new StringBuilder(Data);
		int length=DataB.length();
		String FieldName="";
		String FieldData="";
		int i=0;
		int end=0;
		while(i-1<length)
		{
	     if(DataB.charAt(i)=='\r'||i==0)
		 {
		    if(i!=0)
		      i+=2;
		    end=DataB.indexOf(":",i);
		    FieldName = DataB.substring(i,end-1);
		    i=end;	
		 }
	     
	     if(DataB.charAt(i)==':')
	     {
	    	 i+=2;
	    	 end=DataB.indexOf("\r",i);
	    	 if(end<0)
	    		 end=length;
	    	 FieldData = DataB.substring(i,end);
	    	 i=end;
	    	 
	     }
	     Map.put(FieldName,FieldData);
	     if(DataB.indexOf("\r",i)<0)
	    	   break;
		}
		
		return Map;
	}

}
