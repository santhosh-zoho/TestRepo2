<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.ArrayList" 
 import ="java.sql.Connection"
import ="java.sql.DriverManager"
import ="javax.servlet.http.HttpSession"
import ="java.sql.PreparedStatement"
import ="java.sql.ResultSet" 
import ="java.sql.SQLException"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="SearchResults.css" >
<title>Searched Files</title>
</head>
<body>

    <form action="searchClass" method="post">
        <div class="search-bar">
            <input type="search" name="search" placeholder="search the word in uploaded files" pattern=".*\S.*"
                required>
            <button class="search-btn" value="Search" type="submit">
                <span>Search</span>
            </button>
        </div>

        <br><br><br>
          <div id="SearchMethods">
            <select name="SearchMethods" id="options" onclick="hideOption()">
                <option class="SearchItems" id="hideOption" value="Exactly">Search Method &emsp;</option>
                <option class="SearchItems" value="Exactly">Exactly</option>
                <option class="SearchItems" value="Starts with">Starts with</option>
                <option class="SearchItems" value="Ends with">Ends with</option>
                <option class="SearchItems" value="contained">contained</option>
            </select>
        </div>
    </form>
    <br>
    <br><br><br>
    <%
    ArrayList<String> DocId=new ArrayList<String>();
    DocId = (ArrayList<String>)session.getAttribute("IdList");
    String SearchedData=(String)session.getAttribute("SearchedData");
    String SearchMethod=(String) session.getAttribute("SearchMethods");
    String Data="false";
    Data=(String) session.getAttribute("DocData");

if(Data.charAt(0)!='{' && ( DocId==null || DocId.isEmpty() ) ) 
{
 %><h1 id="NoRec">Sorry no Records Found !!</h1><% 
}
else
{
	int NoResult=DocId.size();
%><h1 style="margin-left: 15px;">Files Matched with <span id="search"><%=SearchedData%></span> : </h1>
  <span  id="SearchMethod" hidden><%=SearchMethod%></span>
 <div id="Data">
        <h2 style="text-align: center;">Data inside Document</h2> <i class="fa-solid fa-circle-xmark" id="closeDataBtn" onclick="ShowData()"></i>
        <br>
        <span id="DataText"> 
        <%
        for(int i=0; Data!=null && i<Data.length();++i)
   	    {
   	     out.print(Data.charAt(i));
   	     if(Data.charAt(i)=='{')
   	      	 %><br><%
   	     if(Data.charAt(i)==',')
   	      	 %><br><%
   	     if(i+1<Data.length() && Data.charAt(i+1)=='}')
   	    	%><br><%
   	    } 
        %>
        </span>
</div>


<%

try
{
	 Class.forName("com.mysql.cj.jdbc.Driver");
     Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/santhosh","root","ms.dhoni07");
     String sql = "select * from fileupload";
     PreparedStatement st = con.prepareStatement(sql);
	 %>
	 <br>
	 <div class="container">
        <h2>Select Number Of Rows</h2>
        <div class="form-group">
            <!--		Show Numbers Of Rows 		-->
            <select class="form-control" name="state" id="maxRows">
                <option value="10">10</option>
                <option value="15">15</option>
                <option value="20">20</option>
                <option value="50">50</option>
                <option value="75">75</option>
                <option value="100">100</option>
                <option value="5000">Show ALL Rows</option>
            </select>
        </div>
    
	 
	 <table class="table table-striped table-class"  id="SearchedTable">
	 <thead>
	  <tr>
	     <th>File No</th>
         <th>File Name</th>
         <th>File path</th>
         <th>File Uploaded Time</th>
          <th style="display: none;">ID</th>
      </tr>
     </thead>
       <% 
       int FileNo=0;
       for(String id : DocId)
       {
           ResultSet rs = st.executeQuery();
       	   while(rs.next())
           {
            if(id.equals(rs.getString("Doc id")))
            {
            	++FileNo;
            %>
              
              <tr class="SearchRow">
                <td><%= FileNo%></td>
                <td><%= rs.getString("filename")%></td>
                <td><%= rs.getString("path")%></td>
                <td><%= rs.getString("time")%></td>
                <td  style="display: none;" class="ID"><%= id%></td>
             </tr>
          <%}
           }
       	
       }
   }   
  
catch(Exception e)


{
    System.out.println(e.getMessage());
    out.println(e.getMessage());
    e.getStackTrace();
}
%>
</table>

	
    <div class='pagination-container'>
            <nav>
            <% 
            if(NoResult>10)
            { %>
                <ul class="pagination" style="display: inline;">
                    <li data-page="prev">
                        <span> < <span class="sr-only">
                        </span></span>
                    </li>
                    
                    <li data-page="next" id="prev" style="display: inline;">
                        <span> > <span class="sr-only"></span></span>
                    </li>
                </ul>
                <%} %>
            </nav>
        </div>
        <div id="FileNo">
            <div id="CurrentRow">1</div> / <div id="TotalRows" >0</div>
        </div>
    </div>
 <% 
}%>
</body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/2993a05f53.js" crossorigin="anonymous"></script>
<script>

    window.onload =  function(){
      getPagination();
       <%
   	   if(Data.charAt(0)=='{')
   	   {
   		  %>ShowData();
   		  highlight();
   		  <%
   		  
   	   }
       %>
   };
  $(".SearchRow").click(function() {
    var $row = $(this).closest("tr");  
    var $DocId = $row.find(".ID").text(); 
    window.location.href="http://localhost:8080/maven/ShowDocData?Id="+$DocId+"&page=search";
  });
  function ShowData() {
    $("#Data").slideToggle();
    <% session.setAttribute("DocData","false");
    Data="false";
    %>
  }
  
  function highlight() 
  {
  	  var opar = document.getElementById('DataText').innerHTML;
  	  var DataText = document.getElementById('DataText');
  	  var search = document.getElementById('search').innerHTML;
  	  var SearchMethod=document.getElementById('SearchMethod').innerHTML;
  	  if(SearchMethod.localeCompare("contained")==0)
  	   var re = new RegExp(search,'gi');
  	  else
  	   var re = new RegExp(search,'g');
  	  var replaced =opar.replace(re, `<mark>$&</mark>`);
   	  DataText.innerHTML = replaced ;
  }
        
        document.addEventListener("DOMContentLoaded", () => {
            const rows = document.querySelectorAll("tr[data-href]");

            rows.forEach(row => {
                row.addEventListener("click", () => {
                    window.open(row.dataset.href, '_blank');
                });
            });

        });
        getPagination('#SearchedTable');

        function getPagination(table) {
            var table = "#SearchedTable";
            var lastPage = 1;
            $('#maxRows')
                .on('change', function (evt) {

                    lastPage = 1;
                    $('.pagination')
                        .find('li')
                        .slice(1, -1)
                        .remove();
                    var trnum = 0; 
                    var maxRows = parseInt($('#maxRows').val());
                    var TotRows = $(table + ' tbody tr').length;
                    document.getElementById('TotalRows').innerHTML = TotRows;
                    if (maxRows == 5000) {
                        $('.pagination').hide();
                    } else {
                        $('.pagination').show();
                    }

                    var totalRows = $(table + ' tbody tr').length;
                    $(table + ' tr:gt(0)').each(function () {
                        trnum++; 
                        if (trnum > maxRows) {
                            $(this).hide();
                        }

                        if (trnum <= maxRows) {
                            $(this).show();
                        } 
                    }); 
                    if (totalRows > maxRows) {
                        var pagenum = Math.ceil(totalRows / maxRows);

                        for (var i = 1; i <= pagenum;) {
                            $('.pagination #prev')
                                .before('<li data-page="' + i + '"> \ <span>' + i++ + '<span class="sr-only"> </span> </span>\</li>').show();
                        } 
                    }
                    $('.pagination [data-page="1"]').addClass('active');
                    $('.pagination li').on('click', function (evt) {
                        evt.stopImmediatePropagation();
                        evt.preventDefault();
                        var pageNum = $(this).attr('data-page');
                        var maxRows = parseInt($('#maxRows').val()); 

                        if (pageNum == 'prev') {
                            if (lastPage == 1) {
                                return;
                            }
                            pageNum = --lastPage;
                        }
                        if (pageNum == 'next') {
                            if (lastPage == $('.pagination li').length - 2) {
                                return;
                            }
                            pageNum = ++lastPage;
                        }

                        lastPage = pageNum;
                        var trIndex = 0;
                        $('.pagination li').removeClass('active');
                        $('.pagination [data-page="' + lastPage + '"]').addClass('active'); 
                        limitPagging();

                        $(table + ' tr:gt(0)').each(function () {
                            // each tr in table not the header
                            trIndex++; // tr index counter
                            document.getElementById('CurrentRow').innerHTML = (pageNum - 1) * (parseInt($('#maxRows').val())) + 1;
                   
                            if (
                                trIndex > maxRows * pageNum ||
                                trIndex <= maxRows * pageNum - maxRows
                            ) {
                                $(this).hide();
                            } else {
                                $(this).show();
                            } 
                        }); 
                    });

                    limitPagging();
                })
                .val(10)
                .change();
        }

        function limitPagging() {
            if ($('.pagination li').length > 7) {
                if ($('.pagination li.active').attr('data-page') <= 3) {
                    $('.pagination li:gt(5)').hide();
                    $('.pagination li:lt(5)').show();
                    $('.pagination [data-page="next"]').show();
                } if ($('.pagination li.active').attr('data-page') > 3) {
                    $('.pagination li:gt(0)').hide();
                    $('.pagination [data-page="next"]').show();
                    for (let i = (parseInt($('.pagination li.active').attr('data-page')) - 2); i <= (parseInt($('.pagination li.active').attr('data-page')) + 2); i++) {
                        $('.pagination [data-page="' + i + '"]').show();

                    }

                }
            }
        }

    </script>

</html>