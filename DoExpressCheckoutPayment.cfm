<!--
*************************************************
DoExpressCheckoutPayment.cfm

This page takes necessary parameter from GetExpressCheckoutDetails page
and pssing into doHttppost function to perform doExpressCheckout
This page will show the response value coming from the Server. If any error occurs,
the page will redirect to APIError.cfm to show exact error details

*************************************************
-->

<cfoutput>
<head>
    <title>PayPal CF SDK - DoExpressCheckoutPayment API</title>
    <link href="sdk.css" rel="stylesheet" type="text/css" />
</head>


<body>
    <center>

	<!--
		The cfobject tag is creating object for Credentialinfo component.
		This component returns credential information.Retrieving form values
		from getExpresscheckoutdetails.cfm page and setting into appropriate variable
	-->
	<cfobject component="CallerService" name="caller">

<CFTRY>
<cfset StructClear(Session)>
<!--
	Passing necessary parameter to perform DoExpressCheckoutPayment transaction in the CFHTTP Tag
-->

<CFSET requestData = StructNew()>
<CFSET requestData.METHOD = "DoExpressCheckoutPayment">
<cfif #USERNAME# neq ""><CFSET requestData.USER = "#USERNAME#"></cfif>
<cfif #PASSWORD# neq ""><CFSET requestData.PWD = "#PASSWORD#"></cfif>
<cfif #SIGNATURE# neq ""><CFSET requestData.SIGNATURE = "#SIGNATURE#"></cfif>
<cfif #UNIPAYSUBJECT# neq ""><CFSET requestData.SUBJECT = "#UNIPAYSUBJECT#"></cfif>
<CFSET requestData.VERSION = "#version#">
<CFSET requestData.TOKEN = "#Form.token#">
<CFSET requestData.PAYERID = "#Form.payerId#">
<CFSET requestData.PAYMENTACTION = "#Form.paymentaction#">
<CFSET requestData.AMT = "#Form.totalAmt#">
<CFSET requestData.CURRENCYCODE = "#Form.currencycode#">


<!---
	Make the call to PayPal to finalize payment
    If an error occured, show the resulting errors
--->
<cfinvoke component="CallerService" method="doHttppost" returnvariable="response">

	<cfinvokeargument name="requestData" value=#requestData#>
	<cfinvokeargument name="serverURL" value=#serverURL#>
	<cfinvokeargument name="proxyName" value=#proxyName#>
	<cfinvokeargument name="proxyPort" value=#proxyPort#>
	<cfinvokeargument name="useProxy" value=#useProxy#>

</cfinvoke>

		<cfset responseStruct = caller.getNVPResponse(#URLDecode(response)#)>
		<cfset Session.resStruct = #responseStruct#>
		<!--- On successfull transaction Transaction ID,Amount,
			Shipping Calculation Mode,Shipping Option Amount,
			Shipping Option Name are displayed to the user --->
		<cfif responseStruct.Ack is "Success">
		  <center>
			<br>
				<center>
				<font size=2 color=black face=Verdana><b>DoExpressCheckoutPayment</b></font>
				<br><br>
				<b>Thank you for your payment!</b><br><br>
                <table class="api"> #displayText(responseStruct)#</table>
		    </center>
		</cfif>
	<cfif responseStruct.Ack is "Failure">
		<CFLOCATION URL="APIError.cfm?error=fromServer"> 
	</cfif>

	<!--
		If the transaction is failure redirect to APIError page
	-->
<CFCATCH>
	<cfset responseStruct = StructNew() >
	<cfset responseStruct.errorType =  "#cfcatch.type#">
	<cfset responseStruct.errorMessage =  "#cfcatch.message#">
	<cfset Session.resStruct = "#responseStruct#">
	 <CFLOCATION URL="APIError.cfm?error=fromClient"> 
</CFCATCH>
</CFTRY>
</center> </center>
</body>
<a class="home" id="CallsLink" href="index.html">Home</a>
</html>
</cfoutput>