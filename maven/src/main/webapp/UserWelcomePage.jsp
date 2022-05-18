<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>welcome page</title>
</head>
<body>
<div class="Notification" id="popup-1">
  <div class="overlay"></div>
   <div class="content">
<%
if((String)session.getAttribute("UserLogin")=="True")
{
	%>
	<div class="icon" onclick="popup()"><i class="fa-regular fa-circle-check"></i></div>
	&emsp; &emsp; &emsp; &emsp;Sign in successfully <%
}
%>
</div>
</div>

 <h1>Welcome User</h1> 
</body>
<script src="https://kit.fontawesome.com/2993a05f53.js" crossorigin="anonymous"></script>
<script>
const icon=document.getElementsByClassName("icon");
const cl= document.getElementsByClassName("content");
<%
	if((String)session.getAttribute("UserLogin")=="True")
	{
	  %>window.onload=popup;
	  cl[0].style.transition="all 500ms ease-in-out";
	  setTimeout(popupClose, 3500);
	  <%
	  session.setAttribute("UserLogin", "false");
	}
%>
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
   background: radial-gradient(circle at 10% 20%, rgb(239, 246, 249) 0%, rgb(206, 239, 253) 90%);
   font-family: Arial, Helvetica, sans-serif;
}
i{
    font-size:40px; 
    padding-left: 8px;
    padding-right: 8px;
  }
h1{
 text-align : center;
 font-size : 350%;
 margin-top : 5em;
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
   width: 400px;
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
</style>
</html>

