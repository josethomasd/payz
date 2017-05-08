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
  <title>DTH Recharge | PayZ </title>
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
		width: 50%;
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
	.paymentmethod {
		width: 80%;
		padding: 12px 20px;
		margin: 8px 0;
		display: inline-block;
		border: 1px solid #ccc;
		box-sizing: border-box;
	}
	.carddetails {
		width:50%;
		padding: 12px 20px;
		margin: 8px 0;
		display: inline-block;
		border: 1px solid #ccc;
		box-sizing: border-box;
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
        <li class="active"><a href="dth.jsp">DTH Recharge</a></li>
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
  <h2> DTH Recharge  </h2><br>
    <form method="post">
	<h4>Your wallet balance:
	<% String balance = (String) session.getAttribute("balance"); %>
	<% String mobile = (String) session.getAttribute("username"); %>
	<b>Rs. <% out.print(balance); %> </b> </h4> <br>
	<select name="paymentType" id="paymentType" class="carddetails" required>
			<option value="" disabled="" selected="">DTH Operator</option>
			<option value="1">Airtel Digital TV</option>
			<option value="2">Dish TV</option>
			<option value="3">Reliance Digital TV</option>
			<option value="4">Sun Direct</option>
			<option value="5">Tata Sky</option>
			<option value="6">Videocon D2H</option>
	</select><br>
	<input type="text" placeholder="Enter Subscriber ID" name="uname" required> <br>
	<input type="text" placeholder="Enter Amount" name="amount" required>
</div>

</div>
<div class="container">
	<button type="submit" class="cancelbtn" name="Submit" >Recharge</button>
	<button type="reset" class="cancelbtn" >Reset</button>
</div>
</form>	
<div class="container">
<p style="color:red;">
	<%
		Connection con=null;
		ResultSet rs=null;
		ResultSet ts=null;		
		Statement st=null;
		Statement st2=null;
		String loginst="";
		String transst="";
		try{
			DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","root");
			st=con.createStatement();   
			st2=con.createStatement();   
		}
		catch(Exception e)
		{
			out.println(e);
		}
		try{
			if(request.getParameter("Submit")!=null)
			{
				String amount=request.getParameter("amount");
				String recdth=request.getParameter("uname");
				String method="DTH recharge of "+recdth; 
				try{
					int amt=Integer.parseInt(amount);		
					int finaltotal=Integer.parseInt(balance);					
					if (amt<=0 || amt>20000 ||amt>finaltotal){
						if(amt>20000){
							out.print("Amount should be between 1 and 20000");
						}
						else if(amt>finaltotal){
							out.print("Insufficient wallet balance");
						}
						else{
							out.print("Amount should be between 1 and 20000");
						}
					}
					else{
						loginst="update wallet_balance set balance=balance-"+amt+" where mobile="+mobile;
						String timeStamp = new SimpleDateFormat("MMM dd, YYYY HH:mma").format(Calendar.getInstance().getTime());
						transst="insert into wallet_history(id, mobile, trans_date, details, amount) values(seq_wallet.nextval,"+mobile+", '"+timeStamp+"', '"+method+"', "+amt+")";
						rs = st.executeQuery(loginst);
						if(rs.next())
						{
							ts = st2.executeQuery(transst);
							int balint=Integer.parseInt(balance)-amt;
							balance=Integer.toString(balint);
							session.setAttribute("balance",balance);
							%>
							<script>
								alert("Recharge successful");
								window.location ="dth.jsp";
							</script>
							<%
							//response.sendRedirect("addmoney.jsp");
						}
					}
				}
				catch(Exception a){
					out.print(a);
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
<br>
<footer class="container-fluid text-center">
  <p> © 2017 PayZ | All rights reserved.</p>  
</footer>
</body>
</html>
