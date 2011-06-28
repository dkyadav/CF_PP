<!--
*************************************************
SetExpressCheckout.cfm

	This page has necessary inputs to perform setExpressCheckout transaction.
	When clicking of submit button, action will submit reviewOrder.cfm page
	there retrieving all form values and pass into doHttppost function.

*************************************************
-->
<cfoutput>
<head>
<title>PayPal CF SDK - ExpressCheckout API</title>
<link href="sdk.css" rel="stylesheet" type="text/css" />
</head>
<body>
<CFFORM ACTION="ReviewOrder.cfm" METHOD="post" >
 		<center>
			<form action="ReviewOrder.cfm" method="POST">
			<input type="hidden" name="paymentType" value="#URL.paymentaction#">
				<span id="apiheader">Step 1: SetExpressCheckout</span>
				<table class="api">
					<tr>
						<td colspan="2">
							<br>
							<center>
								<center>
            You must be logged into <a href="https://developer.paypal.com" target="_blank">Developer
            Central</a> <br /> <br />
          </center>
							</center>
						</td>
					</tr>
		</table>
        	<table>
        	<th>Shopping cart Products:</th>	
        	<tr>
					<td class="field">
						CDs:</td>
					<td>
						<input type="text" size="30" maxlength="32" name="L_NAME1" id="L_NAME1" value="Path To Nirvana"></td>
		
		
				<td class="field"> Amount:  </td>
				<td>
					<input type="text" name="L_AMT1" size="5" maxlength="32" id="L_AMT1" value="39.00"> </td>
		
					 <td class="field">
					Quantity:   </td>
				<td>
					 <input type="text" size="3" maxlength="32" name="L_QTY1" id="L_QTY1" value="2"> </td>
		
			</tr>
			 <tr>
					<td class="field">
					Books:</td>
				<td>
					<input type="text" size="30" maxlength="32" name="L_NAME0" id="L_NAME0" value="Know Thyself"> </td>


			<td class="field">
				Amount: <br /> </td>
			<td>
				<input type="text" name="L_AMT0" size="5" maxlength="32" id="L_AMT0" value="9.00"> </td>

				 <td class="field">
				Quantity:   </td>
			   <td>  <input type="text" size="3" maxlength="32" name="L_QTY0" id="L_QTY0"  value="2"> </td>

		</tr>
		    <tr>
		       <td class="field">
				Currency: <br /> </td>
			<td>
		       <select name="currencyCodeType" id="currencyCodeType">
				<option value="USD">USD</option>
				<option value="GBP">GBP</option>
				<option value="EUR">EUR</option>
				<option value="JPY">JPY</option>
				<option value="CAD">CAD</option>
				<option value="AUD">AUD</option>
			</select>     </td>
	          </tr>
	  </table>
	  <br/><br/>
	  <table>
		<th>Ship To:</th>

	          <tr>
			<td class="field">
				 Name:</td>
			<td>
				<input type="text" size="30" maxlength="32" name="NAME" value="True Seeker" id="NAME"></td>
		</tr>
		<tr>
			<td class="field">
				Street:</td>
			<td>
				<input type="text" size="30" maxlength="32" name="SHIPTOSTREET" id="SHIPTOSTREET" value="111, Bliss Ave"></td>
		</tr>
		<tr>
			<td class="field">
				City:</td>
			<td>
				<input type="text" size="30" maxlength="32" name="SHIPTOCITY" id="SHIPTOCITY" value="San Jose"></td>
		</tr>
		<tr>
			<td class="field">
				State:</td>
			<td>
				<input type="text" size="30" maxlength="32" name="SHIPTOSTATE" id="SHIPTOSTATE" value="CA"></td>
		</tr>
		<tr>
			<td class="field">
				Country:</td>
			<td>
				<input type="text" size="30" maxlength="32" name="SHIPTOCOUNTRYCODE" id="SHIPTOCOUNTRYCODE" value="US"></td>
		</tr>
		<tr>
			<td class="field">
				Zip Code:</td>
			<td>
				<input type="text" size="30" maxlength="32" name="SHIPTOZIP" id="SHIPTOZIP" runat="server" value="95128"></td>
		            </tr>
		
					<tr>
						<td>
							<br>
							<br>
							<input type="image" name="submit" src="https://www.paypal.com/en_US/i/btn/btn_xpressCheckout.gif"
								id="submit" runat="server">
						</td>
						<td>
							<br>
							<br>
							Save time. Pay securely without sharing your financial information.
						</td>
					</tr>
				</table>
		</center>
 	<!--
		Using this hidden variable the system can identify whether it is Authorization, Sale or Order
		This paymentaction coming from Calls.html
	-->
  <CFINPUT TYPE="hidden" NAME="PAYMENTACTION" VALUE="#URL.paymentaction#">
  <a class="home" href="index.html">Home</a>
</CFFORM>
</body>
</html>
</cfoutput>