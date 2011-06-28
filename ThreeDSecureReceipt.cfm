<cfoutput>
<!-- 
ThreeDSecureReceipt.cfm

Submits a credit card transaction to PayPal using a
DoDirectPayment request.

The code collects transaction parameters from the form
displayed by ThreeDSecure.cfm then constructs and sends
the DoDirectPayment request string to the PayPal server.
The paymentType variable becomes the PAYMENTACTION parameter
of the request string.

After the PayPal server returns the response, the code
displays the API request and response in the browser.
If the response from PayPal was a success, it displays the
response parameters. If the response was an error, it
displays the errors.

Called by ThreeDSecure.cfm.

Calls CallerService.cfc and APIError.cfm. 
-->

<head>
<title>PayPal ColdFusion SDK - 3D Secure DoDirectPayment API</title>
<link href="sdk.css" rel="stylesheet" type="text/css" />
</head>
<body>
<cfset StructClear(Session)>
<CFOBJECT COMPONENT="CallerService" NAME="caller">

<table class="api" align="center" border="0">

<CFTRY>

<CFSET expDate =  #Form.expDateMonth# & #Form.expDateYear#>
<CFSET startDate =  #Form.startDateMonth# & #Form.startDateYear#>
<CFSET requestData = StructNew()>
<CFSET requestData.METHOD = "DoDirectPayment">
<CFSET requestData.PAYMENTACTION = "#Form.PAYMENTACTION#">
<CFSET requestData.AMT = "#Form.amount#">
<CFSET requestData.CREDITCARDTYPE = "#Form.creditCardType#">
<CFSET requestData.ACCT = "#Form.creditCardNumber#">
<CFSET requestData.EXPDATE = "#expDate#">
<CFSET requestData.CVV2 = "#Form.cvv2Number#">
<CFSET requestData.FIRSTNAME = "#Form.firstName#">
<CFSET requestData.LASTNAME = "#Form.lastName#">
<CFSET requestData.STREET = "#Form.address1#">
<CFSET requestData.CITY = "#Form.city#">
<CFSET requestData.STATE = "#Form.state#">
<CFSET requestData.ZIP = "#Form.zip#">
<CFSET requestData.COUNTRYCODE = "GB">
<CFSET requestData.CURRENCYCODE = "#Form.currency#">
<CFSET requestData.STARTDATE = "#startDate#">
<CFSET requestData.ECI3DS = "#Form.eciFlag#">
<CFSET requestData.CAVV = "#Form.cavv#">
<CFSET requestData.XID = "#Form.xid#">
<CFSET requestData.MPIVENDOR3DS = "#Form.enrolled#">
<CFSET requestData.AUTHSTATUS3DS = "#Form.pAResStatus#">
<CFSET requestData.USER = "#USERNAME#">
<CFSET requestData.PWD = "#PASSWORD#">
<CFSET requestData.SIGNATURE = "#SIGNATURE#">
<CFSET requestData.SUBJECT = "#UNIPAYSUBJECT#">
<CFSET requestData.VERSION = "#version#">


<!--CFSET requestData.CURRENCYCODE = "#Form.currency#"-->





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
<cfif responseStruct.Ack is "Success" || responseStruct.Ack is "SuccessWithWarning" >

	<br>
	<center>
	<font size=2 color=black face=Verdana><b>3D Secure DDP Response</b></font>
	<br><br>
	<b>Thank you for your payment!</b><br><br>
    <table class="api"> #displayText(responseStruct)#</table>
    </center>
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
<a class="home" id="CallsLink" href="index.html">Home</a>
</body>
</html>
</cfoutput>
