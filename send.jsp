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
  <title>Money Transfer | PayZ</title>
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
		width: 25%;
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
        <li><a href="dth.jsp">DTH Recharge</a></li>
        <li class="active"><a href="send.jsp">Money Transfer</a></li>
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
  <h2> Send Money</h2><br>
    <form method="post" novalidate>
	<h4>Your wallet balance:
	<% String balance = (String) session.getAttribute("balance"); %>
	<% String mobile = (String) session.getAttribute("username"); %>
	<b>Rs. <% out.print(balance); %> </b> </h4> <br>

	<input type="radio" name="radiobtn" id="r1" value="1" checked> Send to Wallet &nbsp;
	<input type="radio" name="radiobtn" id="r2" value="2"> Send to Bank<br>
	
	<div class="card" id="card" style="display:none;">
	<input type="text" id="cardno" name="uname" placeholder="Enter Mobile Number" required/><br>
	<input type="text" id="cardno" name="amount" placeholder="Enter Amount" required/><br>
	</div>
	<script>
		$(function () {
			$('#card').show();
		});
	</script>
	<div id="net" style="display:none;">
		<input type="text" id="cardno" name="net_name" placeholder="Name on Bank Account" required/><br>
		<input type="text" id="cardno" name="net_uname" placeholder="Account Number" required/><br>
		<input type="text" id="cardno" name="net_ifsc" placeholder="IFSC Code" required/><br>
		<input type="text" id="cardno" name="net_amount" placeholder="Amount" required/><br>
	</div>
	<script>
	$('#r1').change(function(){
		$('#net').hide();
		$('#card').show();
	});
	$('#r2').change(function(){
		$('#card').hide();
		$('#net').show();
	});
	</script>
</div>

<div class="container">
	<button type="submit" class="cancelbtn" name="Submit" >Send</button>
	<button type="reset" class="cancelbtn" >Reset</button>
</div>
</form>	
<div class="container">
<p style="color:red;">
	<%
		Connection con=null;
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet cs=null;
		ResultSet ts1=null;	
		ResultSet ts2=null;					
		Statement st=null;
		Statement ct=null;
		Statement st2=null;
		String checkst="";
		String loginst="";
		String loginst1="";
		String transst1="";
		String transst2="";
		try{
			DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","root");
			st=con.createStatement();   
			st2=con.createStatement();  
			ct=con.createStatement();
		}
		catch(Exception e)
		{
			out.println(e);
		}
		try{
			if(request.getParameter("Submit")!=null)
			{
				String test=request.getParameter("radiobtn");
				String amount="";
				String uname="";
				int testoption=Integer.parseInt(test);
				if(testoption==1){
					amount=request.getParameter("amount");
					uname=request.getParameter("uname");
				}
				else{
					amount=request.getParameter("net_amount");
					uname=request.getParameter("net_uname");
				}
				int amt=Integer.parseInt(amount);
				String method1="Money transfer to mobile "+uname; 
				String method2="Money transfer to bank account "+uname;
				String method3="Money received from "+mobile;
				try{					
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
						if(testoption==1){
							if(mobile.equals(uname)){
								out.print("Sender and receiver can not be the same person");
							}
							else{
								checkst="select * from wallet_users where mobile="+uname;
								cs = ct.executeQuery(checkst);
								if(cs.next()){
									loginst="update wallet_balance set balance=balance-"+amt+" where mobile="+mobile;
									loginst1="update wallet_balance set balance=balance+"+amt+" where mobile="+uname;
									String timeStamp = new SimpleDateFormat("MMM dd, YYYY HH:mma").format(Calendar.getInstance().getTime());
									transst1="insert into wallet_history(id, mobile, trans_date, details, amount) values(seq_wallet.nextval,"+mobile+", '"+timeStamp+"', '"+method1+"', "+amt+")";
									transst2="insert into wallet_history(id, mobile, trans_date, details, amount) values(seq_wallet.currval,"+uname+", '"+timeStamp+"', '"+method3+"', "+amt+")";

									rs = st.executeQuery(loginst);
									if(rs.next()){
										ts1 = st2.executeQuery(transst1);
										ts2 = st2.executeQuery(transst2);
										rs1 = st2.executeQuery(loginst1);
										int balint=Integer.parseInt(balance)-amt;
										balance=Integer.toString(balint);
										session.setAttribute("balance",balance);
										%>
										<script>
											alert("Transfer successful");
											window.location ="send.jsp";
										</script>
										<%
											//response.sendRedirect("addmoney.jsp");
									}
								}
								else{
									out.print("User does not exist");
								}
							}
						}
						else{
							loginst="update wallet_balance set balance=balance-"+amt+" where mobile="+mobile;
							String timeStamp = new SimpleDateFormat("MMM dd, YYYY HH:mma").format(Calendar.getInstance().getTime());
							transst1="insert into wallet_history(id, mobile, trans_date, details, amount) values(seq_wallet.nextval,"+mobile+", '"+timeStamp+"', '"+method2+"', "+amt+")";
							rs = st.executeQuery(loginst);
							if(rs.next()){
								ts1 = st2.executeQuery(transst1);
								int balint=Integer.parseInt(balance)-amt;
								balance=Integer.toString(balint);
								session.setAttribute("balance",balance);
								%>
								<script>
									alert("Transfer successful");
									window.location ="send.jsp";
								</script>
								<%
							}
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
