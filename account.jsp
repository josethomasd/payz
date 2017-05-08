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
  <title>My Account | PayZ</title>
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
		<script>
			alert("You are not logged in");
			window.location ="signin.jsp";
		</script>
      <%
		} 
		else{
	  %>
		<% 
		%>
		<li class="active"><a href="account.jsp"><span class="glyphicon glyphicon-cog"></span> My Account</a></li>
		<li><a href="signout.jsp"><span class="glyphicon glyphicon-user"></span> Sign out</a></li>
		<%
		}
		String balance =(String) session.getAttribute("balance"); 
		String mobile = (String) session.getAttribute("username");
	  %>
		</ul>
    </div>
  </div>
</nav>

<div class="container">    
  <h2> My Account </h2><br>
    	<%
		Connection con=null;
		ResultSet rs=null;
		Statement st=null;
		Statement st1=null;
		Statement st2=null;
		String loginst="";
		String name="";
		String email="";
		try{
			DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","root");
			st=con.createStatement(); 
			st1=con.createStatement();			
			st2=con.createStatement();
		}
		catch(Exception e)
		{
			out.println(e);
		}
		try{
				loginst="select * from wallet_users where mobile="+mobile;
				rs = st.executeQuery(loginst);
				if(rs.next())
				{
					name=rs.getString("name");
					email=rs.getString("email");
				}

		}
		catch(Exception e)
		{
			out.print(e);
		}  
	%>
	<br><h4>Welcome <b> <% out.print(name); %> </b> <br> <br>
	Your wallet balance: <label> Rs. <% out.print(balance); %> </label> <br> <br>
	Your email: <% out.print(email); %> <br> <br>
	Your mobile: <% out.print(mobile); %> <br> </h4>
	</div>
	<div class="container">
	<h3> Transaction History </h3>
	<% 
		ResultSet ts=null;
		String transst="";
		try{
			transst="select * from wallet_history where mobile="+mobile+" order by id desc";
			ts = st2.executeQuery(transst);
			if(ts!=null)
			{	
				%>
				<div class="table-responsive">
				<table class="table">
				<thead>
				<tr>
					<th>Transaction ID</th>
					<th>Date</th>
					<th>Description</th>
					<th>Amount</th>
				<tr>
				</thead>
				<tbody>
				<%
				while(ts.next()){
					String id = ts.getString("id");
					String trans_date = ts.getString("trans_date");
					String details = ts.getString("details");
					String t_amount = ts.getString("amount");
				%>
				<tr>
					<td><%=id %></td>
					<td><%=trans_date %></td>
					<td><%=details %></td>
					<td><%=t_amount %></td>
				
				</tr>			
				<%			
				}
			}
			else{
				out.print("No transactions yet!");
			}
		}
		catch (Exception a){
			out.print(a);
		}
	%>
		</tbody>
		</table>
		</div>
	</div>
	<div class="container">
		<form method="post">
			<button type="submit" name="del" class="cancelbtn">Deactivate my account</button>
		</form>
		<%
		String deactst="";
		ResultSet ds=null;
		try{
			if(request.getParameter("del")!=null)
			{
				deactst = "delete from wallet_users where mobile="+mobile;
				ds = st1.executeQuery(deactst);
				if(ds.next())
				{
				%>
					<script>
						alert("Account deactivated");
						window.location ="signout.jsp";
					</script>
				<%
				}
			}
		}
		catch(Exception b)
		{
			out.print(b);
		}  
		%>
	</div>
</div><br>
<footer class="container-fluid text-center">
  <p> © 2017 PayZ | All rights reserved.</p>  
</footer>

</body>
</html>
