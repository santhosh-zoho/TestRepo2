  <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		    pageEncoding="ISO-8859-1"%>
		<%@page import ="maven.GetDataById" %>
		<!DOCTYPE html>
		<html>
		<head>
		<meta charset="ISO-8859-1">
		<title>Data Page</title>
		</head>
		<body onLoad="javascript:highlight()">
		 <div class='data'>
		  <%
		  String Id = (String)session.getAttribute("Id");
		  String SearchedData=(String)session.getAttribute("Search"); 
		  String SearchMethod=(String) session.getAttribute("SearchMethods");
		  if(SearchedData!=null)
		    {
		  	  %>
		  	  Searched Data : <div id="search"><%=SearchedData %></div><br>
		  	  <div  id="SearchMethods" hidden><%=SearchMethod%></div>
		  	  <% 
		    }
		   else
		    {%>
		  	  <h1 class='head'> Data in Selected File</h1>
		  	  <% 
		    }
		 
		  GetDataById dataGet=new GetDataById();
		  
		  %> 
		  
		  Document Id : <%= Id %>
		  <br><br>
		  <div id="paragraph">
		  <%
		  String Result = dataGet.GetData(Id);
		  int Resultlenth=Result.length();

		    
		   for(int i=0;i<Resultlenth;++i)
			 {
			    out.print(Result.charAt(i));
			    if(Result.charAt(i)=='{')
			      	 %><br><%
			    if(Result.charAt(i)==',')
			      	 %><br><%
			    if(i+1<Resultlenth && Result.charAt(i+1)=='}')
			         %><br><%
			 }
		  %>
		  </div>
		  </div>
		</body>
		<script>
		function highlight() 
		{
			  var opar = document.getElementById('paragraph').innerHTML;
			  var paragraph = document.getElementById('paragraph');
			  var search = document.getElementById('search').innerHTML;
			  var SearchMethod=document.getElementById('SearchMethods').innerHTML;
			  if(SearchMethod.localeCompare("contained")==0)
			   var re = new RegExp(search,'gi');
			  else
			   var re = new RegExp(search,'g');
			  var replaced =opar.replace(re, `<mark>$&</mark>`);
			  paragraph.innerHTML = replaced ;
		}
		</script>
		<style>
		body{
		  background: linear-gradient(120deg, #e0c3fc 0%, #8ec5fc 100%);
		}
		.data{
		 font-size: 150%;
		}
		mark {
		  background-color:#ff3333;
		}
		</style>
		</html>