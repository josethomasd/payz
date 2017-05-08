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
  <title>Add Money | PayZ</title>
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
		width: 60%;
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
		width: 60%;
		padding: 12px 20px;
		margin: 8px 0;
		display: inline-block;
		border: 1px solid #ccc;
		box-sizing: border-box;
	}
	.carddetails {
		width: 30%;
		padding: 12px 20px;
		margin: 8px 0;
		display: inline-block;
		border: 1px solid #ccc;
		box-sizing: border-box;
	}
	.cardno{
		width: 70%;
		border-style: solid;
		border-width: 1px;
		border-color: #cdcdcd;
		padding: 2pc;
	}
	.net{
		width: 60%;
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
  <h2> Add Money  </h2><br>
  	<h4>Your wallet balance:
	<% String balance = (String) session.getAttribute("balance"); %>
	<% String mobile = (String) session.getAttribute("username"); %>
	<b>Rs. <% out.print(balance); %> </b> (Wallet limit: Rs.20000) </h4> <br>
	<h4>Pay with</h4>	
    <form method="post">
	<input type="text" placeholder="Enter Amount" name="uname" required>
		<select name="paymentType" id="paymentType" class="paymentmethod" required>
			<option value="" disabled="" selected="">Choose Type</option> 
			<option value="1">Credit / Debit card</option>
			<option value="2">Netbanking</option>
		</select>
	<div class="card" id="card" style="display:none;">
		<input type="text" id="cardno" name="cardno" placeholder="Card Number" ><br>
		<select class="carddetails" id="card-month" name="card-month">
			<option value="" disabled="" selected="">Month</option>
			<option value="01">01</option>
			<option value="02">02</option>
			<option value="03">03</option>
			<option value="04">04</option>
			<option value="05">05</option>
			<option value="06">06</option>
			<option value="07">07</option>
			<option value="08">08</option>
			<option value="09">09</option>
			<option value="10">10</option>
			<option value="11">11</option>
			<option value="12">12</option>
		</select>
		<select class="carddetails" id="card-year" name="card-year">
			<option value="" disabled="" selected="">Year</option> 
			<option value="2017">2017</option>
			<option value="2018">2018</option>
			<option value="2019">2019</option>
			<option value="2020">2020</option>
			<option value="2021">2021</option>
			<option value="2022">2022</option>
			<option value="2023">2023</option>
			<option value="2024">2024</option>
			<option value="2025">2025</option>
			<option value="2026">2026</option>
			<option value="2027">2027</option>
			<option value="2028">2028</option>
			<option value="2029">2029</option>
			<option value="2030">2030</option>
			<option value="2031">2031</option>
			<option value="2032">2032</option>
			<option value="2033">2033</option>
			<option value="2034">2034</option>
			<option value="2035">2035</option>
		</select>
		<input type="password" class="cardno" maxlength="4" placeholder="CVV" name="card-cvv">
	</div>
	<div id="net" style="display:none;">
		<select id="net-bank" name="net-bank" class="paymentmethod">
			<option value="" disabled="" selected="">Select Bank</option>
			<optgroup label="---- POPULAR BANKS ----"></optgroup>
			<option value="HDFC">HDFC Bank</option>
			<option value="ICIC">ICICI Bank</option>
			<option value="AXIS">AXIS Bank</option>
			<option value="CITA">CITI Bank</option>
			<optgroup label="---- ALL BANKS ----">
			</optgroup><option value="ANDB">Andhra Bank</option>
			<option value="BAHK">Bank of Bahrain and Kuwait</option>
			<option value="BOBC">Bank of Baroda - Coporate</option>
			<option value="BOBR">Bank of Baroda - Retail</option>
			<option value="BOI">Bank of India</option>
			<option value="MAHB">Bank of Maharastra</option>
			<option value="CANB">Canara Bank</option>
			<option value="CSYB">Catholic Syrian Bank</option>
			<option value="CITU">City Union Bank</option>
			<option value="CORB">Corporation Bank</option>
			<option value="DEUB">Deutche Bank</option>
			<option value="DECB">Development Credit Bank</option>
			<option value="FEDB">Federal Bank</option>
			<option value="INDB">Indian Bank</option>
			<option value="IOB">Indian Overseas Bank</option>
			<option value="INIB">IndusInd Bank</option>
			<option value="JNKB">Jammu and Kashmir Bank</option>
			<option value="KRTB">Karnataka Bank Ltd</option>
			<option value="KARB">Karur Vyasa Bank</option>
			<option value="KOBK">KOTAK Bank</option>
			<option value="LXCB">Laxmi Vilas Bank - Corporate Net Banking</option>
			<option value="LXRB">Laxmi Vilas Bank - Retail Net Banking</option>
			<option value="ORTB">Oriental Bank of Commerce</option>
			<option value="PJSB">Punjab and Sind Bank</option>
			<option value="PJRB">Punjab National Bank</option>
			<option value="PJRB">Punjab National Bank - Retail Banking</option>
			<option value="RATB">RBL Bank Limited</option>
			<option value="SHVB">Shamrao Vittal Cooperative Bank</option>
			<option value="SINB">South Indian Bank</option>
			<option value="STCB">Standard Chartered Bank</option>
			<option value="SBJB">State Bank of Bikaner and Jaipur</option>
			<option value="SHYB">State Bank of Hyderabad</option>
			<option value="SMYB">State Bank of Mysore</option>
			<option value="SPTB">State Bank of Patiala</option>
			<option value="STVB">State Bank of Travancore</option>
			<option value="SYNB">Syndicate Bank</option>
			<option value="TMEB">Tamilnadu Mercentile Bank</option>
			<option value="UCOB">UCO Bank</option>
			<option value="UBI">Union Bank of India</option>
			<option value="UNIB">United Bank of India</option>
			<option value="VIJB">Vijaya Bank</option>
			<option value="YEBK">YES Bank</option>
		</select>
	</div>
	<script>
	$('#paymentType').change(function(){
	   selection = $(this).val();    
	   switch(selection)
	   { 
			case '1':
			   $('#card').show();
			   $('#net').hide();
			   break;
			case '2':
				$('#net').show();
				$('#card').hide();
				break;
			default:
			   $('#net').hide();
			   $('#card').hide();
			   break;
	   }
	});
	</script><br>
	<button type="submit" class="cancelbtn" name="Submit">Add</button>
	<button type="reset" class="cancelbtn">Reset</button>
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
				String amount=request.getParameter("uname");
				String method=request.getParameter("paymentType");
				int methodtype=Integer.parseInt(method);
				if(methodtype==1){
					method="Add money using Card";
				}
				else{
					method="Add money using Netbanking";
				}
				try{
					int amt=Integer.parseInt(amount);
					int finaltotal=Integer.parseInt(balance)+amt;
					if (amt<=0 || amt>20000 ||finaltotal>20000){
						if(finaltotal>20000){
							out.print("Amount exceeds wallet limit");
						}
						else{
							out.print("Amount should be between 1 and 20000");
						}
					}
					else{
						loginst="update wallet_balance set balance=balance+"+amt+" where mobile="+mobile;
						String timeStamp = new SimpleDateFormat("MMM dd, YYYY HH:mma").format(Calendar.getInstance().getTime());
						transst="insert into wallet_history(id, mobile, trans_date, details, amount) values(seq_wallet.nextval,"+mobile+", '"+timeStamp+"', '"+method+"', "+amt+")";
						rs = st.executeQuery(loginst);
						if(rs.next())
						{
							ts = st2.executeQuery(transst);
							int balint=Integer.parseInt(balance)+amt;
							balance=Integer.toString(balint);
							session.setAttribute("balance",balance);
							%>
							<script>
								alert("Money added");
								window.location ="addmoney.jsp";
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
