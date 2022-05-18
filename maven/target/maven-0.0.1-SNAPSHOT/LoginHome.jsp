<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" Type="text/css" href="LoginHomePage.css" >

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">  
<meta charset="ISO-8859-1">
<title>Home</title>
</head>
<body>
<div class="Notification" id="popup-1">
  <div class="overlay"></div>
   <div class="content" id="popupSize">
    
<% 
if((String)session.getAttribute("UserLogin")=="False")
{
	%>
	<div class="icon"> <i  class="fa-solid fa-circle-exclamation"></i></div> 
	&emsp; &emsp; &emsp; &emsp; Login Failed, Please check your Username and Password  
	<%	
}
else if((String)session.getAttribute("SingUp")=="True")
{
	%>
	<div class="icon">  <i class="fa-regular fa-circle-check"></i></div> 
	&emsp; &emsp; &emsp; &emsp; &emsp; Account created successfully , please Login <%
}
else if((String)session.getAttribute("SingUp")=="False")
{
	%>
	<div class="icon">   <i  class="fa-solid fa-circle-exclamation"></i></div> 
	&emsp; &emsp; &emsp; &emsp; &ensp; Sign up Failed, Please Retry <%
}
else if((String)session.getAttribute("AdminLogin")=="False")
{
	%>
	<div class="icon"> <i  class="fa-solid fa-circle-exclamation"></i></div> 
	&emsp; &emsp; &emsp; &emsp; Login Failed, Please check your Username and Password <%
}
%>
</div>
</div>

  <h1 class="bluredThings mt-5" id="choice">Please select your login</h1>
  <div id="ChoiceBtns" class="bluredThings">
    <button id="adminButton" onclick="AdminOpenLogin()"> Admin </button>
    <button id="userButton" onclick="UserOpenLogin()"> user </button>
  </div>
  
  <!-- Admin Login Form  -->
  
   <div class="container align-self-center  ">
    <div class="row justify-content-center ">
      <div class="col-md-3  ">
        <div id="AdminLoginForm">
          <form action="AdminLoginCheck" method="Get">
            <span onclick="AdminCloseLogin()" class="close"><i class="fa-solid fa-circle-xmark"></i></span>
            <img src="https://www.w3schools.com/howto/img_avatar2.png" alt="Avatar" class="avatar">
            <div class="LoginField">Admin Login</div>
            <br><i class="fa-solid fa-user-large"></i> &ensp; <input type="text" name="UserName" placeholder="Username"
              required><br><br>
            <i class="fa-solid fa-key"></i> &ensp; <input type="password" name="Password" placeholder="Password"
              required><br><br>
            <div id="adminBtn">
              <button type="submit" value="login" class="LoginBtn" required>login</button>
              <button type="button" class="closeBtn" onclick="AdminCloseLogin()">close</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
  
  <!-- User Login Form  -->
 <div class="container align-self-center  ">
    <div class="row justify-content-center ">
      <div class="col-md-3  ">
        <div id="UserLoginForm">
          <form action="UserLoginCheck" method="Get">
            <span onclick="UserCloseLogin()" class="close"><i class="fa-solid fa-circle-xmark"></i></span>
            <img src="https://ritecaremedicalofficepc.com/wp-content/uploads/2019/09/img_avatar.png" alt="Avatar"
              class="avatar">
            <div class="LoginField">User Login</div>
            <br><i class="fa-solid fa-user-large"></i> &ensp; <input type="text" name="UserName" placeholder="Username"
              required><br><br>
            <i class="fa-solid fa-key"></i> &ensp; <input type="password" name="Password" placeholder="Password"
              required><br><br>
            <div id="UserBtn">
              <button type="submit" value="login" class="LoginBtn" required>login</button>
              <button type="button" class="closeBtn" onclick="UserCloseLogin()">close</button>
              <br>
              <span id="SignUpLink">
                Don't have a account? <span id="SignUpBtn" onclick="UserOpenSignUp()">Sign Up</span>
              </span>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
  
  <!-- User Signup Form  -->
  
   <div class="container align-self-center  ">
    <div class="row justify-content-center ">
      <div class="col-md-3  ">
        <div id="UserSignUpForm">
          <form action="UserLoginCheck" method="Get">
            <span onclick="UserCloseSignUp()" class="close"><i class="fa-solid fa-circle-xmark"></i></span>
            <img src="https://www.w3schools.com/w3images/avatar5.png" alt="Avatar"  class="SignUpAvatar">
            <div class="LoginField">User SignUp</div><br>
            <i class="fa-solid fa-user-large"></i> &ensp; <input type="text" name="UserName" placeholder="Username"
              required><br><br>
            <i class="fa-solid fa-key"></i> &ensp; <input type="password" name="Password" placeholder="Password"
              required><br><br>
            <i class="fa-solid fa-envelope"></i> &ensp; <input type="email" name="Email" placeholder="Email"
              minlength="8" maxlength="30" required><br><br>
            <i class="fa-solid fa-phone"></i> &ensp; <input type="number" name="PhoneNo" placeholder="Mobile Number"
              minlength="10" maxlength="16" required><br><br>
            <div id="UserBtn">
              <button type="submit" value="SignUp" class="LoginBtn" required>login</button>
              <button class="closeBtn" onclick="UserCloseSignUp()">close</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</body>

<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" 
   crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/2993a05f53.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
  integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
  integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
<script src="https://code.iconify.design/2/2.2.0/iconify.min.js"></script>
<script>
const icon=document.getElementsByClassName("icon");
const cl= document.getElementsByClassName("content");
<%
   if((String)session.getAttribute("AdminLogin")=="False")
   {
	   %>
	   window.onload =  function(){
	   popup();
	   AdminOpenLogin();
	   };
	   cl[0].style.transition="all 500ms ease-in-out";
	   setTimeout(popupClose, 3500);
	   <%
	 session.setAttribute("AdminLogin", "false");
   }
  else if((String)session.getAttribute("UserLogin")=="False")
  {
	%>
	window.onload =  function(){
	 popup();
	 UserOpenLogin();
	};
	cl[0].style.transition="all 500ms ease-in-out";
	setTimeout(popupClose, 3500);
	<%
	session.setAttribute("UserLogin", "false");
  }
  else if((String)session.getAttribute("SingUp")=="False")
  {
	  %>
	  document.getElementById("popupSize").style.width="550px";
	  window.onload =  function(){
		popup();
		UserOpenSignUp2();
	  };
	  cl[0].style.transition="all 500ms ease-in-out";
	  setTimeout(popupClose, 3500);
	 <%
	 session.setAttribute("SingUp", "false");
  }
  else if((String)session.getAttribute("SingUp")=="True")
  {
	  %>
	    icon[0].style.background= "#1ee494";
	    window.onload =  function(){
		popup();
		UserOpenLogin();
		};
		cl[0].style.transition="all 500ms ease-in-out";
	    setTimeout(popupClose, 3500);
	   <%
	 session.setAttribute("SingUp", "false");
  }
  
%>
  function popup()
  {
   document.getElementById("popup-1").classList.toggle("activePopup");
  }
  function popupClose(){
      const div = document.querySelector('div');
      if((div.classList.contains('activePopup')))
         popup();
  }
  var AdminLogin = document.getElementById("AdminLoginForm");
  var UserLogin = document.getElementById("UserLoginForm");
  var UserSignUp = document.getElementById("UserSignUpForm");
  const blur = document.getElementsByClassName("bluredThings");
  function AdminOpenLogin() {
    AdminLogin.style.display = "block";
    for (var i = 0; i < blur.length; ++i)
      blur[i].classList.toggle("active");
  }
  function UserOpenLogin() {
    UserLogin.style.display = "block";
    for (var i = 0; i < blur.length; ++i)
      blur[i].classList.toggle("active");
  }
  function UserOpenSignUp() {
    UserCloseLogin();
    console.log(UserSignUp.style.display);
    UserSignUp.style.display = "block";
    console.log(UserSignUp.style.display);
    for (var i = 0; i < blur.length; ++i)
      blur[i].classList.toggle("active");
  }
  function UserOpenSignUp2() {
	   document.getElementById("UserSignUpForm").style.marginTop="-182px";
	    UserSignUp.style.display = "block";
	    for (var i = 0; i < blur.length; ++i)
	      blur[i].classList.toggle("active");
	  }
  function AdminCloseLogin() {
    AdminLogin.style.display = "none";
    for (var i = 0; i < blur.length; ++i)
      blur[i].classList.toggle("active");
  }
  function UserCloseLogin() {
    UserLogin.style.display = "none";
    for (var i = 0; i < blur.length; ++i)
      blur[i].classList.toggle("active");
  }
  function UserCloseSignUp() {
    UserSignUp.style.display = "none";
    for (var i = 0; i < blur.length; ++i)
      blur[i].classList.toggle("active");
  }
</script>
<style>
  body {
    background-image: url("https://cdn.wallpapersafari.com/95/73/iykvK2.jpg");
    font-family: Arial, Helvetica, sans-serif;
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
   width: 800px;
   height: 50px;
   z-index: 2;
   text-align: center;
   box-sizing: border-box;
   align-items: center;
  }
  .Notification .icon{
    cursor: pointer;
    display: inline;
    height: 50px;
    position: absolute;
    width: 10%;
    border-top-left-radius: 3.5px;
    border-bottom-left-radius: 3.5px;
    top: 0px;
    left: 0px;
    font-size: 182%;
    text-align: center;
    background-color:#f95959;
    font-weight: bolder;
  }
  .Notification.activePopup .overlay{
    display: block;
  }
  .Notification.activePopup .content{
    transition: all 300ms ease-in-out;
    transform: translate(-50%,-50%) scale(1);
  }

  #adminButton {
    font-size: 100px;
    border-radius: 10px;
    padding: 2px 5px 2px 5px;
    background-color: #f95959;
    cursor: pointer;
  }

  #userButton {
    color: #fefefe;
    font-size: 100px;
    border-radius: 10px;
    padding: 0px 5px 2px 5px;
    background-color: #00cccc;
    cursor: pointer;

  }

  #ChoiceBtns.active {
    filter: blur(10px);
  }

  .bluredThings.active {
    filter: blur(10px);
  }

  #adminBtn,
  #UserBtn {
    padding: 14px;
    background-color: rgba(0, 0, 0, 0.4);
    border-bottom-left-radius: 5px;
    border-bottom-right-radius: 5px;
  }

  #SignUpBtn {
    text-decoration: underline;
    cursor: pointer;
  }

  #SignUpLink {
    font-size: 130%;
    font-weight: 125%;
  }

  .close {
    position: absolute;
    right: 10px;
    top: 3px;
    color: black;
    font-size: 30px;
    font-weight: bold;
  }

  .close:hover {
    cursor: pointer;
    color: red;
  }

  .fa-circle-exclamation,.fa-circle-check {
      position: absolute;
      text-align: center;
      bottom:5px;
      right:20px;
      color: white;
      font-size: 40px;
  }

  .fa-user-large,
  .fa-key,
  .fa-phone,
  .fa-envelope {
    top: 20px;
    font-size: 30px;
    display: inline;
  }

  img.avatar {
    width: 50%;
    border-radius: 50%;
  }
    img.SignUpAvatar{
    width: 45%;
    border-radius: 50%;
  }
  input {
    display: inline;
    border: 1.5px solid black;
    border-radius: 4px;
    width: 70%;
    height: 1.8em;
    box-sizing: border-box;
  }
  .LoginField {
    font-size: 250%;
    color: white;
  }

  #AdminLoginForm,
  #UserLoginForm,
  #UserSignUpForm {
    z-index: 1;
    position: absolute;
    box-shadow: 10px 10px 10px 10px black;
    font-size: 125%;
    text-align: center;
    color: black;
    width: 390px;
    padding-top: 20px;
    border: 4px;
    border-radius: 5px;
    background-color: #7c73e6;
    display: none;
  }

  #AdminLoginForm
 {
    margin-top: -240px;
  }
  #UserLoginForm {
    margin-top: -268px;
  }
  #UserSignUpForm {
    margin-top: -325px;
  }


  .LoginBtn {
    display: inline;
    font-size: large;
    background-color: #42b883;
    width: 49%;
    color: white;
    border: none;
    border-spacing: 10px;
    padding: 10px;
    border-radius: 5px;
    opacity: 0.9;
    cursor: pointer;
  }

  .closeBtn {
    display: inline;
    font-size: large;
    background-color: #ff395e;
    width: 49%;
    color: white;
    border: none;
    border-spacing: 10px;
    padding: 10px;
    border-radius: 5px;
    opacity: 0.9;
  }

  .closeBtn:hover {
    opacity: 1;
  }

  .LoginBtn:hover {
    opacity: 1;
  }

  #AdminLoginForm,
  #UserLoginForm,
  #UserSignUpForm {
    animation: animatezoom 0.6s
  }

  @keyframes animatezoom {
    from {
      transform: scale(0)
    }

    to {
      transform: scale(1)
    }
  }

  #ChoiceBtns {
    margin: 5em 14em 0em 14em;
    display: flex;
    justify-content: center;
    justify-content: space-around;

  }

  #choice {
    text-align: center;
  }
</style>
</html>
