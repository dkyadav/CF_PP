<!-- 
*************************************************
DoDirectPaymentReceipt.cfm

This page takes necessary parameter from DoDirectPayment page 
and pssing into doHttppost function to perform DoDirectPayment.
This page will show the response value coming from the Server. 
If any error occurs, the page will redirect to APIError.cfm 
to show exact error details

*************************************************
-->

<cfoutput>
<head>
<title>PayPal CF SDK - DoDirectPayment API</title>
<link href="sdk.css" rel="stylesheet" type="text/css" />
</head>
<body>
	
<cfset StructClear(Session)>
<CFOBJECT COMPONENT="CallerService" NAME="caller">

<CFTRY>
<CFSET expDate =  #Form.expDateMonth# & #Form.expDateYear# >
<CFSET requestData = StructNew()>
<CFSET requestData.METHOD = "DoDirectPayment">
<CFSET requestData.PAYMENTACTION = "#Form.PAYMENTACTION#">
<CFSET requestData.USER = "#USERNAME#">
<CFSET requestData.PWD = "#PASSWORD#">
<CFSET requestData.SIGNATURE = "#SIGNATURE#">
<CFSET requestData.SUBJECT = "#UNIPAYSUBJECT#">
<CFSET requestData.VERSION = "#version#">
<CFSET requestData.FIRSTNAME = "#Form.firstName#">
<CFSET requestData.LASTNAME = "#Form.lastName#">
<CFSET requestData.AMT = "#Form.amount#">
<CFSET requestData.STREET = "#Form.address1#">
<CFSET requestData.CURRENCYCODE = "USD">
<CFSET requestData.ZIP = "#Form.zip#">
<CFSET requestData.CVV2 = "#Form.cvv2Number#">
<CFSET requestData.CREDITCARDTYPE = "#Form.creditCardType#">
<CFSET requestData.EXPDATE = "#expDate#">
<CFSET requestData.STATE = "#Form.state#">
<CFSET requestData.COUNTRYCODE = "US">
<CFSET requestData.ACCT = "#Form.creditCardNumber#">
<CFSET requestData.CITY = "#Form.city#">
<!--- 
	Calling doHttppost for API call 
--->
<cfinvoke component="CallerService" method="doHttppost" returnvariable="response">

	<cfinvokeargument name="requestData" value=#requestData#>
	<cfinvokeargument name="serverURL" value=#serverURL#>
	<cfinvokeargument name="proxyName" value=#proxyName#>
	<cfinvokeargument name="proxyPort" value=#proxyPort#>
	<cfinvokeargument name="useProxy" value=#useProxy#>

</cfinvoke>

 <cfset responseStruct = caller.getNVPResponse(#URLDecode(response)#)>
 <cfset messages = ArrayNew(1)>
 <cfset Session.resStruct ="#responseStruct#">
<cfif responseStruct.Ack is "Success" || responseStruct.Ack is "SuccessWithWarning">
    
	<br>
	<center>
	<font size=2 color=black face=Verdana><b>Do Direct Payment</b></font>
	<br><br>
	<b>Thank you for your payment!</b>
	<br>
    <table class="api"> #displayText(responseStruct)#</table>

</cfif>
      
<cfif responseStruct.Ack is "Failure">
    <CFLOCATION URL="APIError.cfm?error=fromServer">
</cfif>

<CFCATCH>
	<cfset responseStruct = StructNew() >
	<cfset responseStruct.errorType =  "#cfcatch.type#">
	<cfset responseStruct.errorMessage =  "#cfcatch.message#">
	<cfset Session.resStruct = "#responseStruct#">
	<CFLOCATION URL="APIError.cfm?error=fromClient">

</CFCATCH>

</CFTRY>
 <br>
</body>
<a class="home" id="CallsLink" href="index.html">Home</a>
</html>
</cfoutput>