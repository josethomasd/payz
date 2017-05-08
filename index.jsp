<!DOCTYPE html>
<%@page pageEncoding="UTF-8" %>
<html lang="en">
<head>
  <title>PayZ | Mobile & DTH Recharge, Money Transfer </title>
  <meta charset="UTF-8">
  <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
  <link rel="icon" href="/favicon.ico" type="image/x-icon">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
    /* Remove the navbar's default rounded borders and increase the bottom margin */ 
    .navbar {
      margin-bottom: 50px;
      border-radius: 0;
    }
    
    /* Remove the jumbotron's default bottom margin */ 
     .jumbotron {
      margin-bottom: 0;
    }
   
    /* Add a gray background color and some padding to the footer */
    footer {
      background-color: #1a237e;
      padding: 25px;
	  color: white;
    }
	.jumbotron{
		background-color: #1a237e;
		color: white;
	}
	.img-responsive{
		margin:auto;
	}
	.logo{
		height: 48px;
		width: 85px;
	}
  </style>
</head>
<body>

<div class="jumbotron">
  <div class="container text-center">
    <h1>PayZ</h1>      
    <p>Go Cashless!</p>
  </div>
</div>

<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a href="/payz"><img class="logo" src="images/logo.png"></a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="#">Home</a></li>
        <li><a href="mobile.jsp">Mobile Recharge</a></li>
        <li><a href="dth.jsp">DTH Recharge</a></li>
        <li><a href="send.jsp">Money Transfer</a></li>
        <li><a href="contact.jsp">Contact</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
	  <%
		if ((session.getAttribute("username") == null) || (session.getAttribute("username") == "")) {
	  %>
		<li><a href="signin.jsp"><span class="glyphicon glyphicon-user"></span> Signin</a></li>
	  <%
		} 
		else{
	  %>
		<% 
			//String n= (String) session.getAttribute("balance");
			//out.println(n);
		%>
		<li><a href="account.jsp"><span class="glyphicon glyphicon-cog"></span> My Account</a></li>
		<li><a href="signout.jsp"><span class="glyphicon glyphicon-user"></span> Sign out</a></li>
		<%
		}
	  %>
		</ul>
    </div>
  </div>
</nav>

<div class="container">    
  <div class="row">
    <div class="col-sm-4">
      <div class="panel panel-primary">
        <div class="panel-heading">Recharge</div>
        <div class="panel-body"><a href="recharge.jsp">
		<img src="images/dth.png" class="img-responsive" style="width:60%" alt="Image"></div>
        <div class="panel-footer">Mobile and DTH Recharge</div></a>
      </div>
    </div>
    <div class="col-sm-4"> 
      <div class="panel panel-primary">
        <div class="panel-heading">Add money</div>
        <div class="panel-body"><a href="addmoney.jsp">
		<img src="images/mob.png" class="img-responsive" style="width:60%" alt="Image"></div>
        <div class="panel-footer">Topup your wallet</div></a>
      </div>
    </div>
    <div class="col-sm-4"> 
	  <div class="panel panel-primary">
        <div class="panel-heading">Send Money</div>
        <div class="panel-body"><a href="send.jsp">
		<img src="images/money.png" class="img-responsive" style="width:60%" align="center" alt="Image"></div>
        <div class="panel-footer">Transfer money instantly</div></a>
      </div> 
    </div>
  </div>
</div><br>

<footer class="container-fluid text-center">
<p>© 2017 PayZ | All rights reserved.</p>  
  <form class="form-inline">Get special offers:
    <input type="email" class="form-control" size="50" placeholder="Email Address">
    <button type="button" class="btn btn-danger" onclick="success()">Sign Up</button>
	<script>
		function success()
		{
			window.alert("Subscription success");
		}
	</script>
  </form>
</footer>

</body>
</html>
