<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.ArrayList" 
import ="javax.servlet.http.HttpSession"
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="SnapShotInfo.css" >
<title>Snapshots</title>
</head>
<body>
<h1 style="margin-left: 50px;">Snapshots Table</h1>
<br>
<%
ArrayList<String> SnapshotName=(ArrayList<String>)request.getAttribute("SnapshotName");
int length=SnapshotName.size();
int[] Indices=(int[])request.getAttribute("Indices");
ArrayList<String> Time=(ArrayList<String>)request.getAttribute("Time");
String Repository=(String)request.getAttribute("Repository");
String DeleteSnapShot="";
String DeleteSnapshotName="";
if(session.getAttribute("snapshotDelete")!=null)
{
	DeleteSnapShot=(String) session.getAttribute("snapshotDelete");
	DeleteSnapshotName=(String) session.getAttribute("DeleteSnapshotName");
}

%>
<div class="Notification" id="popup-1">
  <div class="overlay"></div>
   <div class="content">
<%
	if(DeleteSnapShot=="True")
	{
		%>
		<div class="icon" onclick="popup()"><i class="fa-regular fa-circle-check"></i></div>   
		&emsp; &emsp; &emsp; &emsp; &emsp; &emsp; <%=DeleteSnapshotName %> Deleted Successfully <%
	}
	else if(DeleteSnapShot=="False")
	{
		%>
		<div class="icon" onclick="popup()"><i  class="fa-solid fa-circle-exclamation"></i></div>   
		&emsp; &emsp; &emsp; &emsp; &emsp; &emsp;Failed to Delete <%=DeleteSnapshotName%><%
	}

%>
  </div>
</div>

 <div id="confirmPopup">
      Are you want to delete <span id="confirmText"></span> ?<br><br>
      <button id="confirmYesBtn" onclick="Delete()">Yes</button>
      <button id="confirmNoBtn" onclick="closeConfirmPopup()">No</button>
 </div>
 <table  id="SnapshotTable">
	 <thead>
	  <tr>
         <th>Snapshot Name</th>
         <th>No of Indices</th>
         <th>Repository</th>
         <th style="width:25%">Created Time</th>
      </tr>
     </thead>
     <% 
       for(int i=0;i<length;++i)
       {
            %>
            <tdata>
              <tr id="row">
                <td class="snapShotName"><%= SnapshotName.get(i)%></td>
                <td><%= Indices[i]%></td>
                <td><%= Repository%></td>
                <td><%= Time.get(i)%>
                 <span class="deleteSnapshot"><i class="fa-solid fa-trash-can"></i></span></td>
             </tr>
            </tdata>
          <%
      }
     %>
</table>
</body>
<script src="https://kit.fontawesome.com/2993a05f53.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
   crossorigin="anonymous"></script>

<script>
const icon=document.getElementsByClassName("icon");
const cl= document.getElementsByClassName("content");
var $SnapshotName;
window.onload = function(){
    <%   
        if(DeleteSnapShot=="True"||DeleteSnapShot=="False")
      	{
		 %>
			 popup();
		     cl[0].style.transition="all 500ms ease-in-out";
		     setTimeout(popupClose, 3500);
		 <%
			 session.setAttribute("snapshotDelete","false"); 
		}
      if(DeleteSnapShot=="False")
      {
    	  %>icon[0].style.background= "#f95959";<%
      }
       %>
};
   $(".deleteSnapshot").click(function () {
      var $row = $(this).closest("tr");
      $SnapshotName = $row.find(".snapShotName").text();
      document.getElementById("confirmText").innerHTML =$SnapshotName;
      document.getElementById("confirmPopup").style.display = "block";
   });
   function Delete(){ 
      window.location.href="http://localhost:8080/maven/snapshot?DeleteSnapshot="+$SnapshotName;
   }
   function closeConfirmPopup(){
      document.getElementById("confirmPopup").style.display = "none";
   }
   function popup(){
       document.getElementById("popup-1").classList.toggle("activePopup");
    }
   function popupClose(){
   	const div = document.querySelector('div');
       if((div.classList.contains('activePopup')))
          popup();
   }
</script>

<style>
body{
 background: linear-gradient(91.3deg, rgb(135, 174, 220) 1.5%, rgb(255, 255, 255) 100.3%);
 font-family: Arial, Helvetica, sans-serif;
}
#confirmPopup {
      font-size: 160%;
      position: absolute;
      text-align: center;
      box-sizing: border-box;
      z-index: 2;
      margin-top: 100px;
      left: 420px;
      right: 420px;
      display: none;
      background-color: #e1f4f3;
      border: 2px solid black;
      border-radius: 5px;
      padding: 15px;
      box-shadow: 10px 10px 10px 10px black;
   }

   #confirmText {
      color: red;
   }

   #confirmYesBtn,
   #confirmNoBtn {
      font-size: 140%;
      text-align: center;
      width: 100px;
   }

   #confirmYesBtn {
      width: 49%;
      color: white;
      background-color: #42b883;
      opacity: 0.9;
      border: none;
      border-spacing: 10px;
      padding: 10px;
      border-radius: 5px;
   }

   #confirmNoBtn {
      width: 49%;
      color: white;
      background-color: #ff395e;
      opacity: 0.9;
      border: none;
      border-spacing: 10px;
      padding: 10px;
      border-radius: 5px;
   }

   #confirmYesBtn:hover {
      opacity: 1;
   }

   #confirmNoBtn:hover {
      opacity: 1;
   }
   .fa-trash-can {
      font-size: 25px;
   }

   .deleteSnapshot {
      position: absolute;
      right: 185px;
      cursor: pointer;
   }

   .deleteSnapshot:hover {
      color: red;
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
   width: 700px;
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
    border-top-left-radius: 3.5px;
    border-bottom-left-radius: 3.5px;
    top: 0px;
    left: 0px;
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
   #SnapshotTable{
      font-size: 110%;
      float: center;
      margin-left: 50px;
      border-collapse: collapse;
      width: 85%;
   }
th,td{
 text-align: center;
 text-align: left;
 padding: 12px;
 border-bottom: 1px solid #ddd;
}
th{
 background-color: #80c1ff;
}
#SnapshotTable tr:nth-child(even) {
  background-color: #BEF2F5
}
</style>
</html>