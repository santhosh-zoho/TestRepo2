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
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"> 
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<title>Files uploading Page</title>
<link rel="stylesheet" href="Fileuploadpage.css" >
</head>
<body>
<%
String AdminLogin=(String) session.getAttribute("AdminLogin");
String FileUpload=(String) session.getAttribute("FileUpload");
String SnapShot=(String) session.getAttribute("snapshot");
String Data="false";
if(session.getAttribute("DocData")!=null)
 Data=(String) session.getAttribute("DocData");
%>
<div class="Notification" id="popup-1">
  <div class="overlay"></div>
   <div class="content">
<%  
    
	if(AdminLogin=="True")
	{
		%>
		<div class="icon" onclick="popup()"><i class="fa-regular fa-circle-check"></i></div>   
		&emsp; &emsp; &emsp; &emsp; &emsp; &emsp; Welcome Admin  <%
	}
	else if(FileUpload=="True")
	{
		%>
		<div class="icon" onclick="popup()"><i class="fa-solid fa-file-circle-check"></i></div>  
		&emsp; &emsp;&emsp; &emsp;Files uploaded Successfully  <%
	}
	else if(FileUpload=="Error")
	{
		%>
		<div class="icon" onclick="popup()">&nbsp;<i class="fa-solid fa-file-circle-exclamation"></i></div>
		&emsp; &emsp;&emsp;&emsp;&emsp; Files uploading Failed <%
	}
	else if(SnapShot=="True")
	{
		%>
		<div class="icon" onclick="popup()">&nbsp;<i class="fa-regular fa-circle-check"></i></div>
		&emsp; &emsp; &emsp; &emsp;Snapshot created Successfully<%
	}
	else if(SnapShot=="Error")
	{
		%>
		<div class="icon" onclick="popup()"><i  class="fa-solid fa-circle-exclamation"></i></div>
		&emsp;&emsp;&emsp;&emsp; Snapshot name already exist  <%
	} 
%>
  </div>
</div>
    <form id="Uploadform" action="UploadServlet" method="post" enctype="multipart/form-data">
        <label for="fileUpload">
            <i class="fa-solid fa-arrow-up-from-bracket"></i>&emsp;&ensp;<button id="UploadBtn" type="button">&ensp;&ensp;Upload </button>
        </label>
        <input type="file" id="fileUpload" name="file" accept=".txt,.DOCX,.RTF,.LOG,.WPD" webkitdirectory multiple  onchange="form.submit()">
        
    </form>
    <form action="searchClass" method="post" style="display: inline;">
        <div class="search-bar">
            <input type="search" name="search" placeholder="search the word in uploaded files" pattern=".*\S.*"
                required>
            <button class="search-btn" value="Search" type="submit">
                <span>Search</span>
            </button>
        </div>

        <br><br><br>
        <div id="SearchMethods">
            
            <select name="SearchMethods" id="options" >
                <option class="SearchItems" id="hideOption" value="Exactly">Search Method &emsp;</option>
                <option class="SearchItems" value="Exactly">Exactly</option>
                <option class="SearchItems" value="Starts with">Starts with</option>
                <option class="SearchItems" value="Ends with">Ends with</option>
                <option class="SearchItems" value="contained">contained</option>
            </select>
        </div>
    </form>
    <br><br>
    <button id="createSB" type="submit" onclick="toggleSnapshotForm()">Create Snapshots <span class="iconify-inline"
            data-icon="logos:elasticsearch"></span></button>
    <br><br>
    <div class="form-popup" id="myForm">
        <form action="snapshot" method="post" class="form-container">
            <label for="Name"><b>Snapshot Name</b></label>
            <input type="text" placeholder="Enter Snapshot Name" name="SnapshotName" required>
            <button type="submit" class="btn">Create</button>
            <button type="button" class="btn cancel" onclick="toggleSnapshotForm()">Close</button>
        </form>
    </div>
    
    <form action="snapshot" method="get">
        <button id="viewSI"  type="submit"> View Snapshots <span class="iconify-inline"
                data-icon="logos:elasticsearch"></span></button>
    </form>
 <div id="Data">
        <h2 style="text-align: center;">Data inside Document</h2> <i class="fa-solid fa-circle-xmark" id="closeDataBtn" onclick="ShowData()"></i>
        <br>
        <span class="DataText"> 
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
	 ResultSet rs = st.executeQuery();
	 %>
	 <h2 style="text-align: center;">Uploaded Files</h2>
	 <br>
	 <div class="TableContainer">
        <h3>Select Number Of Rows</h3>
        <div class="form-group">
            <!--		Show Numbers Of Rows 		-->
            <select class="form-control" name="state" id="maxRows">
                <option value="5000">Show ALL Rows</option>
                <option value="5">5</option>
                <option value="10">10</option>
                <option value="15">15</option>
                <option value="20">20</option>
                <option value="50">50</option>
                <option value="75">75</option>
                <option value="100">100</option>
            </select>
        </div>
    
	 
	 <table class="table table-striped table-class" id="FileTable">
	 <thead>
	  <tr>
	     <th>File No</th>
         <th>File Name</th>
         <th>File path</th>
         <th>File Uploaded Time</th>
         <th style="display: none;">ID</th>
      </tr>
     </thead>
       <% int FileNo=0;
        while(rs.next())
        {
        	++FileNo;
        %>
               <tr class="FileRow" > 
                 <td><%= FileNo%></td>
                 <td><%= rs.getString("filename")%></td>
                 <td><%= rs.getString("path")%></td>
                 <td><%= rs.getString("time")%></td>
                 <td  style="display: none;" class="ID"><%= rs.getString("Doc id")%></td>
               </tr>
         <%} 
   }   
catch(Exception e)
{
    System.out.println(e.getMessage());
    e.getStackTrace();
}
%>
</table>
    <div class='pagination-container'>
            <nav>
                <ul class="pagination" style="display: inline;">
                    <li data-page="prev">
                        <span> &lt; <span class="sr-only">
                        </span></span>
                    </li>
                    
                    <li data-page="next" id="prev" style="display: inline;">
                        <span> &gt; <span class="sr-only"></span></span>
                    </li>
                </ul>
            </nav>
        </div>
        <div id="FileNo">
            <div id="CurrentRow" style="display: inline;">1</div> / <div id="TotalRows" style="display: inline;">0</div>
        </div>
    </div>
</body>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
  crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/2993a05f53.js" crossorigin="anonymous"></script>
<script src="https://code.iconify.design/2/2.2.0/iconify.min.js"></script>
<script>
const icon=document.getElementsByClassName("icon");
const cl= document.getElementsByClassName("content");
    window.onload =  function(){
        getPagination();
        <%   
            if(AdminLogin=="True"||FileUpload=="True"||FileUpload=="Error"||SnapShot=="True"||SnapShot=="Error"||FileUpload=="Error"||SnapShot=="Error")
	      	{
			 %>
				 popup();
			     cl[0].style.transition="all 500ms ease-in-out";
			     setTimeout(popupClose, 3500);
			 <%
				 session.setAttribute("AdminLogin", "false");
				 session.setAttribute("FileUpload", "false");
				 session.setAttribute("snapshot", "false");
				 session.setAttribute("SearchData", null);
			}
       	   if(FileUpload=="Error"||SnapShot=="Error" )
           {
		   %>
            icon[0].style.background= "#f95959";
          <%
          session.setAttribute("FileUpload", "false");
		  session.setAttribute("snapshot", "false");
          } 
       	   if(Data.charAt(0)=='{')
       	   {
       		  %>ShowData();<%
       	   }
           %>
    };
    $(".FileRow").click(function() {
        var $row = $(this).closest("tr");  
        var $DocId = $row.find(".ID").text(); 
        window.location.href="http://localhost:8080/maven/ShowDocData?Id="+$DocId;
    });
    function ShowData() {
        $("#Data").slideToggle();
        <% session.setAttribute("DocData","false");
        Data="false";
        %>
    }
    function popup(){
    	document.getElementById("popup-1").classList.toggle("activePopup")
    	
     }
    function popupClose(){
    	const div = document.querySelector('div');
        if((div.classList.contains('activePopup')))
           popup();
    }
    function toggleSnapshotForm(){
        $("#myForm").slideToggle();
    }
 
        document.addEventListener("DOMContentLoaded", () => {
            const rows = document.querySelectorAll("tr[data-href]");

            rows.forEach(row => {
                row.addEventListener("click", () => {
                    window.open(row.dataset.href, '_blank');
                });
            });

        });
        getPagination('#FileTable');

        function getPagination(table) {
            var table = "#FileTable";
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

<style>

    body {
        background: linear-gradient(91.3deg, rgb(135, 174, 220) 1.5%, rgb(255, 255, 255) 100.3%);
        font-family: Arial, Helvetica, sans-serif;
    }
     #Data{
         position: absolute;
        box-sizing: border-box;
        z-index: 2;
        margin-top: -140px;
        left: 350px;
        right: 350px;
        display: none;
        box-shadow: 10px 10px 10px 10px black;
        border: #141010 solid 1px;
        padding: 10px 30px 30px 30px;
        background-color: #e3e3e3;
        border-radius: 10px;
        
    }
    .DataText{
        text-align: center;
        font-size: 125%;
    }
    
    #closeDataBtn{
        cursor: pointer;
        position: relative;
        float: right;
        font-size: 35px;
        top: -25px;
        right: -11px;
    }
    .fa-circle-check,.fa-circle-exclamation{
      position: absolute;
      text-align: center;
      bottom:5px;
      right:10px;
      font-size:40px; 
    }
    .fa-file-circle-check,.fa-file-circle-exclamation{
      position: absolute;
      text-align: center;
      bottom:5px;
      right:10px;
      font-size:36px;
    }

    .Notification .overlay{
    position: fixed;
    top: 0px;
    left: 0px;
    width: 100vw;
    height: 100vh;
    z-index: 1;
    display: none;
  }
  .Notification .content{
   position: absolute;
   display: flex;
   font-size: 150%;
   top: 7%;
   left: 50%;
   transform: translate(-50%,-50%) scale(0);
   border-radius: 5px;
   background-color:black;
   color: white;
   width: 500px;
   height: 50px;
   z-index: 2;
   text-align: center;
   box-sizing: border-box;
   align-items: center;
  }
  .Notification .icon{
    cursor: pointer;
    display: inline;
    position: absolute;
    width: 15%;
    height: 50px;
    border-top-left-radius: 3.5px;
    border-bottom-left-radius: 3.5px;
    font-size: 182%;
    text-align: center;
    background-color:#1ee494;
    font-weight: bolder;
  }

  .Notification.activePopup .overlay{
    display: block;
  }
  .Notification.activePopup .content{
    transition: all 300ms ease-in-out;
    transform: translate(-50%,-50%) scale(1);
  }

    body#blur.active {
        filter: blur(20px);
    }

    #name:hover {
        cursor: pointer;
        visibility: hidden;
    }

    #createSB {
        display: inline;
        background-color: transparent;
        float : right;
        margin-right: 15px ;
        font-size: 150%;
        font-weight: bolder;
    }

    #viewSI{
        display: inline;
        float : right;
        margin-right: 18px ;
        background-color: transparent;
        font-size: 150%;
        font-weight: bolder;
    }

    #createSB:hover {
        cursor: pointer;
        text-decoration: underline;
    }

    #viewSI:hover {
        cursor: pointer;
        text-decoration: underline;
    }
    .form-popup {
        font-size: 125%;
        background-color: lightblue;
        margin-left: 46em;
        margin-right: 2em;
        display: none;
        bottom: 0;
        right: 15px;
        border: 5px solid black;
        border-radius: 10px;
        z-index: 9;
    }

    .form-container {
        display: inline;
        padding: 10px;
    }

    .form-container input[type=text] {
        width: 50%;
        color : black;
        border-radius: 3px;
        padding: 15px;
        margin: 5px 0 22px 0;
        border: none;
        background: #f1f1f1;
    }

    .form-container input[type=text]:focus {
        background-color: #ddd;
        outline: none;
    }

    .form-container .btn {
        background-color: #04AA6D;
        color: white;
        display: inline;
        padding: 16px 20px;
        border: none;
        border-radius: 3px;
        cursor: pointer;
        margin-left: 11px;
        width: 45%;
        margin-bottom: 10px;
        opacity: 0.8;
    }

    .form-container .cancel {
        display: inline;
        background-color: red;
    }

    .form-container .btn:hover,
    .open-button:hover {
        opacity: 1;
    }

    #info{
      display: inline;
      color : #009933;
    }
    .TableContainer {
        margin-left: 40px;
    }

    .pagination {
        display: inline-block;
        padding-left: 0;

        border-radius: 4px
    }

    .pagination>li {
        display: inline
    }

    .pagination>li>a,
    .pagination>li>span {
        position: relative;
        float: left;
        padding: 6px 12px;

        line-height: 1.42857143;
        color: #337ab7;
        text-decoration: none;
        background-color: #fff;
        border: 1px solid #ddd
    }

    .pagination>li:first-child>a,
    .pagination>li:first-child>span {

        border-top-left-radius: 4px;
        border-bottom-left-radius: 4px
    }

    .pagination>li:last-child>a,
    .pagination>li:last-child>span {
        border-top-right-radius: 4px;
        border-bottom-right-radius: 4px
    }

    .pagination>li>a:focus,
    .pagination>li>a:hover,
    .pagination>li>span:focus,
    .pagination>li>span:hover {
        z-index: 2;
        color: #23527c;
        background-color: lightblue;
        border-color: #ddd
    }

    .pagination>.active>a,
    .pagination>.active>a:focus,
    .pagination>.active>a:hover,
    .pagination>.active>span,
    .pagination>.active>span:focus,
    .pagination>.active>span:hover {
        z-index: 3;
        color: #fff;
        cursor: default;
        background-color: #337ab7;
        border-color: #337ab7
    }

    .form-control {
        display: block;
        width: 97%;
        height: 34px;
        padding: 6px 12px;
        font-size: 14px;
        line-height: 1.42857143;
        color: #555;
        background-color: #fff;
        background-image: none;
        border: 1px solid #ccc;
        border-radius: 4px;
        -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
        box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
        -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
        -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
        transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s
    }



    .pagination-container {
        display: inline-block;
        padding: 8px 16px;
        text-decoration: none;
    }
    #hideOption{
        display: none;
    }
   #SearchMethods {
        float: left;
        margin-left: 15px;
        position: relative;
        min-width: 160px;
        border-radius: 5px;
        padding-right: 3px;
        padding: 8px;
        background-color: DodgerBlue;
        cursor: pointer;
        border: 1px solid transparent;
        border-color: transparent transparent rgba(0, 0, 0, 0.1) transparent;
    }
    #SearchMethods select{
        font-size: 20px;
        background-color: transparent;   
    }
    .SearchItems{
        background-color: DodgerBlue;
    }
    #options {
        color: #171717;

    }

    #FileNo {
        display: inline;
        margin-left: 270px;
        font-size: 140%;
        font-family: sans-serif;
        font-weight: bolder;
    }
    #NoRec {
        text-align: center;
    }
    #Uploadform input[type=file]{
        display: none;
    }
    .fa-arrow-up-from-bracket{
        font-size: 200%;
        position: absolute;
        cursor: pointer;
        font-weight: bolder;
    }
    #Uploadform {
        cursor: pointer;
        text-align: center;
        display: inline;
        width: 180px;
        height: 60px;
        margin-top: 10px;
        margin-right: 30px;
        font-size: 125%;
        float: right;
        padding: 10px;
        border: 4px;
        border-radius: 50px;
        background-color: #3333ff;
        box-shadow: 2px 4px 8px 2px rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
        float: right;
    }

    #UploadBtn {
        display: inline;
        font-size: 135%;
        margin-top: 7px;
        font-weight: bolder;
        text-align: center;
        background-color: #3333ff ;
    }
      #Uploadform:hover{
        cursor: pointer;
        width: 185px;
        height: 62.5px;
        box-shadow: 3px 5px 9px 3px rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
    }

    a {
        text-decoration: none;
        color: rgb(53, 48, 48);
    }

    #FileTable {
        font-size: 100%;
        margin-top: 10px;
        border-collapse: collapse;
        width: 97%;
    }

    th,
    td {
        text-align: left;
        padding: 12px;
    }

    .TableContainer th {
        background-color: rgb(32, 190, 243);
        border : none;
    }

    tr:nth-child(even) {
        background-color: #f2f2f2;
    }


    th,
    td {
        border-bottom: 1px solid #ddd;
    }

    .FileRow:hover {
        cursor: pointer;
        background-color: #f2f2f2;
    }


    * {
        border: 0;
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }

    button,
    input {
        font: 0.65em Hind, sans-serif;
        line-height: 1em;
    }

    input {
        color: #171717;
    }

    .search-bar {
        font-size: 145%;
        display: flex;
        float: left;
    }

    .search-bar input,
    .search-btn,
    .search-btn:before,
    .search-btn:after {
        transition: all 0.25s ease-out;
    }

    .search-bar input,
    .search-btn {
        width: 3em;
        height: 3em;
    }

    .search-bar input:invalid:not(:focus),
    .search-btn {
        cursor: pointer;
    }

    .search-bar,
    .search-bar input:focus,
    .search-bar input:valid {
        width: 100%;
    }

    .search-bar input:focus,
    .search-bar input:not(:focus)+.search-btn:focus {
        outline: transparent;
    }

    .search-bar {
        margin-top: 5px;
        margin-left: 15px;
        padding: 0px;
        justify-content: left;
        max-width: 30em;
    }

    .search-bar input {
        background: transparent;
        border-radius: 1.5em;
        box-shadow: 0 0 0 0.4em #171717 inset;
        padding: 0.75em;
        transform: translate(0.5em, 0.5em) scale(0.5);
        transform-origin: 100% 0;
        -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
    }

    .search-bar input::-webkit-search-decoration {
        -webkit-appearance: none;
    }

    .search-bar input:focus,
    .search-bar input:valid {
        background: #fff;
        border-radius: 0.375em 0 0 0.375em;
        box-shadow: 0 0 0 0.1em #d9d9d9 inset;
        transform: scale(1);
    }

    .search-btn {
        background: #171717;
        border-radius: 0 0.75em 0.75em 0 / 0 1.5em 1.5em 0;
        padding: 0.75em;
        position: relative;
        transform: translate(0.25em, 0.25em) rotate(45deg) scale(0.25, 0.125);
        transform-origin: 0 50%;
    }

    .search-btn:before,
    .search-btn:after {
        content: "";
        display: block;
        opacity: 0;
        position: absolute;
    }

    .search-btn:before {
        border-radius: 50%;
        box-shadow: 0 0 0 0.2em #f1f1f1 inset;
        top: 0.75em;
        left: 0.75em;
        width: 1.2em;
        height: 1.2em;
    }

    .search-btn:after {
        background: #f1f1f1;
        border-radius: 0 0.25em 0.25em 0;
        top: 51%;
        left: 51%;
        width: 0.75em;
        height: 0.25em;
        transform: translate(0.2em, 0) rotate(45deg);
        transform-origin: 0 50%;
    }

    .search-btn span {
        display: inline-block;
        overflow: hidden;
        width: 1px;
        height: 1px;
    }

    /* Active state */
    .search-bar input:focus+.search-btn,
    .search-bar input:valid+.search-btn {
        background: #2762f3;
        border-radius: 0 0.375em 0.375em 0;
        transform: scale(1);
    }

    .search-bar input:focus+.search-btn:before,
    .search-bar input:focus+.search-btn:after,
    .search-bar input:valid+.search-btn:before,
    .search-bar input:valid+.search-btn:after {
        opacity: 1;
    }

    .search-bar input:focus+.search-btn:hover,
    .search-bar input:valid+.search-btn:hover,
    .search-bar input:valid:not(:focus)+.search-btn:focus {
        background: #0c48db;
    }

    .search-bar input:focus+.search-btn:active,
    .search-bar input:valid+.search-btn:active {
        transform: translateY(1px);
    }

    @media screen and (prefers-color-scheme: dark) {
        input {
            color: #f1f1f1;
        }

        .search-bar input {
            box-shadow: 0 0 0 0.4em black inset;
        }

        .search-bar input:focus,
        .search-bar input:valid {
            background: #3d3d3d;
            box-shadow: 0 0 0 0.1em #3d3d3d inset;
        }

        .search-btn {
            background: black;
        }
    }
    table th,
    table td {
        text-align: center;
    }

    table tr:nth-child(even) {
        background-color: #BEF2F5
    }

    .pagination li:hover {
        cursor: pointer;
    }

    
</style>
</html>