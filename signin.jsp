<!DOCTYPE html>
<%@page pageEncoding="UTF-8" %>
<%@page import = "java.sql.*" %>
<%@page import = "oracle.jdbc.driver.*" %>
<%@page import = "oracle.sql.*" %>
<%@page import = "java.lang.*" %>
<%@page import="java.util.*" %>  
<%@page import="java.text.SimpleDateFormat" %>  
<%@page contentType = "text/html" %>
<html lang="en">
<head>
  <title>Sign in | PayZ</title>
  <meta charset="utf-8">
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
	{
		border: 3px solid #f1f1f1;
	}
	input[type=text], input[type=password] {
		width: 100%;
		padding: 12px 20px;
		margin: 8px 0;
		display: inline-block;
		border: 1px solid #ccc;
		box-sizing: border-box;
	}
	button {
		background-color: #1a237e;
		color: white;
		padding: 14px 20px;
		margin: 8px 0;
		border: none;
		cursor: pointer;
		width: 100%;
	}
	button:hover {
		opacity: 0.8;
	}
	.cancelbtn {
		width: auto;
		padding: 10px 18px;
		background-color: #f44336;
	}
	span.psw {
		float: right;
		padding-top: 16px;
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
        <li><a href="index.jsp">Home</a></li>
        <li><a href="mobile.jsp">Mobile Recharge</a></li>
        <li><a href="dth.jsp">DTH Recharge</a></li>
        <li><a href="send.jsp">Money Transfer</a></li>
        <li><a href="contact.jsp">Contact</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
	  <%
		if ((session.getAttribute("username") == null) || (session.getAttribute("username") == "")) {
	  %>
		<li class="active"><a href="signin.jsp"><span class="glyphicon glyphicon-user"></span> Signin</a></li>
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
  <h2> Sign in  </h2>
    <form method="post">
        <div class="container">
		<label><b>Mobile Number</b></label>
		<input type="text" placeholder="Enter Mobile Number" name="uname" required>

		<label><b>Password</b></label>
		<input type="password" placeholder="Enter Password" name="pass" required>
			
		<button type="submit" name="Login">Login</button>
		<input type="checkbox" checked="checked"> Remember me
	  </div>

	  <div class="container" style="background-color:#f1f1f1">
		<button type="reset" class="cancelbtn">Reset</button>
		<span class="psw">Don't have an account ? <a href="register.jsp"> Register Here</a></span>
	  </div>
    </form>
	<div class="container">
	<p style="color:red;">
	<%
		Connection con=null;
		ResultSet rs=null;
		Statement st=null;
		ResultSet bs=null;
		String loginst="";
		String balst="";
		try{
			DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","root");
			st=con.createStatement();   
		}
		catch(Exception e)
		{
			out.println(e);
		}
		try{
			if(request.getParameter("Login")!=null)
			{
				String username = request.getParameter("uname");    
				String password = request.getParameter("pass");
				loginst="select * from wallet_users where mobile="+username+" and password='"+password+"'";
				balst="select * from wallet_balance where mobile="+username;
				rs = st.executeQuery(loginst);
				if(rs.next())
				{
					session.setAttribute("username", username);
					bs=st.executeQuery(balst);
					if(bs.next())
					{
						String balance= bs.getString("balance");
						session.setAttribute("balance",balance);
						response.sendRedirect("index.jsp");
					}
				}
				else
				{
					out.println("Invalid password");
				}
			}
		}
		catch(Exception e)
		{
			out.print(e);
		}  
	%>
	</p>
	</div>
</div><br>
<footer class="container-fluid text-center">
  <p> © 2017 PayZ | All rights reserved.</p>  
</footer>

</body>
</html>
