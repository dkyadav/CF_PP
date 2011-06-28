<!--
*************************************************
ReviewOrder.cfm


When click submit button in the setexpresscheckout.cfm, the page submitted in Orderreview.cfm
it takes necessary values as parameter and pass into destination URL which returns token and
payerid.This token we need to pass as parameter for getExpresscheckout which return shipping
details. Then we need to pass payer id, token and other necessary information for doexpresschekout

*************************************************
-->
<cfoutput>
<html>
<head>
<title>PayPal CF SDK - ReviewOrder API</title>
<link href="sdk.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<!--
		Getting the Credential information from the CredentialInfo component and retrieving amount
		 from the form object
	-->

<CFTRY>
	<cfset StructClear(Session)>
	<cfset serverName = #SERVER_NAME#>
	<cfset serverPort = #CGI.SERVER_PORT#>
	<cfset contextPath = GetDirectoryFromPath(#SCRIPT_NAME#)>
	<cfset protocol = #CGI.SERVER_PROTOCOL#>
	<cfset cancelUrlPath = "http://" & serverName & ":" & serverPort & contextPath & "SetExpressCheckout.cfm?paymentaction="&#Form.PAYMENTACTION#>
	<CFOBJECT COMPONENT="CallerService" name="caller">

	<!--
		Passing necessary parameter to perform Setexpresscheckout transaction in the CFHTTP Tag
	-->
	<CFSET requestData = StructNew()>
	<CFSET requestData.METHOD = "SetExpressCheckout">
	<CFSET requestData.PAYMENTACTION = "#Form.PAYMENTACTION#">
	<CFSET requestData.USER = "#USERNAME#">
	<CFSET requestData.PWD = "#PASSWORD#">
	<CFSET requestData.SIGNATURE = "#SIGNATURE#">
	<CFSET requestData.SUBJECT = "#UNIPAYSUBJECT#">
	<CFSET requestData.VERSION = "#version#">
	<CFSET requestData.ADDRESSOVERRIDE = "1">
	<!--- Setting up the Shipping address details --->
	<CFSET requestData.SHIPTONAME = "#Form.NAME#">
	<CFSET requestData.SHIPTOSTREET = "#Form.SHIPTOSTREET#">
	<CFSET requestData.SHIPTOCITY = "#Form.SHIPTOCITY#">
	<CFSET requestData.SHIPTOSTATE = "#Form.SHIPTOSTATE#">
	<CFSET requestData.SHIPTOCOUNTRYCODE = "#Form.SHIPTOCOUNTRYCODE#">
	<CFSET requestData.SHIPTOZIP = "#Form.SHIPTOZIP#">
	<CFSET requestData.L_NAME0 = "#Form.L_NAME0#">
	<CFSET requestData.L_NAME1 = "#Form.L_NAME1#">
	<CFSET requestData.L_AMT0 = "#Form.L_AMT0#">
	<CFSET requestData.L_AMT1 = "#Form.L_AMT1#">
	<CFSET requestData.L_QTY0 = "#Form.L_QTY0#">
	<CFSET requestData.L_QTY1 = "#Form.L_QTY1#">
	<CFSET requestData.L_NUMBER0 = "1000">
	<CFSET requestData.L_NUMBER1 = "10001">
	<CFSET requestData.L_DESC0 = "Size: 8.8-oz">
	<CFSET requestData.L_DESC1 = "Size: Two 24-piece boxes">
	<CFSET requestData.L_ITEMWEIGHTVALUE1 = "0.5">
	<CFSET requestData.L_ITEMWEIGHTUNIT1 = "lbs">
	<!--- Calculating ITEMAMT =(amount1*quantity1)+(amount2*quantity2)  --->
	<cfset itemAmt=("#Form.L_QTY0#"*"#Form.L_AMT0#")+ ("#Form.L_QTY1#"*"#Form.L_AMT1#")>
	<CFSET requestData.ITEMAMT = "#itemAmt#">
	<!--- Calculating amount = itemamount+ shippingamt+shippingdisc+taxamt+insuranceamount; --->
	<cfset amt= #DecimalFormat(Evaluate(#itemAmt#+5.00+2.00+1.00))#>
	<CFSET requestData.AMT = "#amt#">
	<!--- calculating maxamt --->
	<cfset maxamt=#DecimalFormat(Evaluate(#amt#+25))#>
	<CFSET requestData.MAXAMT = "#maxamt#">
	
	<CFSET requestData.CALLBACKTIMEOUT = "4">
	<CFSET requestData.L_SHIPPINGOPTIONAMOUNT0 = "3.00">
	<CFSET requestData.L_SHIPPINGOPTIONAMOUNT1 = "8.00">
	<CFSET requestData.L_SHIPPINGOPTIONLABEL0 = "UPS Ground 7 Days">
	<CFSET requestData.L_SHIPPINGOPTIONlABEL1 = "UPS Next Day Air">
	<CFSET requestData.L_SHIPPINGOPTIONNAME0 ="Ground">
	<CFSET requestData.L_SHIPPINGOPTIONNAME1 = "UPS Air">
	<CFSET requestData.L_SHIPPINGOPTIONISDEFAULT0 = "false">
	<CFSET requestData.L_SHIPPINGOPTIONISDEFAULT1 ="true">	
	<CFSET requestData.INSURANCEAMT = "1.00">
	<CFSET requestData.INSURANCEOPTIONOFFERED = "true">
	<CFSET requestData.CALLBACK = "https://d-sjn-00513807/callback.pl">
	<CFSET requestData.SHIPPINGAMT = "8.00">
	<CFSET requestData.SHIPDISCAMT = "-3.00">
	<CFSET requestData.TAXAMT = "2.00">
	<CFSET requestData.CURRENCYCODE = "#Form.currencyCodeType#">
	<CFSET requestData.CURRENCYCODE = "#Form.currencyCodeType#">
	<!---
		The returnURL is the location where buyers return when a
		payment has been succesfully authorized.
		The cancelURL is the location buyers are sent to when they hit the
		cancel button during authorization of payment during the PayPal flow
	 --->
	<CFSET requestData.CancelURL = "#cancelUrlPath#">
	<cfset returnUrlPath = "http://" & serverName & ":" & serverPort & contextPath & "GetExpressCheckoutDetails.cfm?amt=#amt#&currencycode=#Form.currencyCodeType#&paymentaction=#Form.PAYMENTACTION#">
	<CFSET requestData.ReturnURL = "#returnUrlPath#">
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

	<cfset Session.resStruct = #responseStruct#>

	<cfif responseStruct.Ack is not "Success">
		<cfthrow>
	<cfelse>
		<CFSET TOKEN = #responseStruct.TOKEN#>
	</cfif>
	<!--
		cfhttp.FileContent returns token and other response value from the server.
		We need to pass token as parameter to destination URL which redirect to return URL
	-->

	<CFSET redirecturl = #PayPalURL# & #TOKEN#>

	 <CFLOCATION URL="#redirecturl#" ADDTOKEN="no">
<CFCATCH>

<cfset urlPath = "APIError.cfm?error=fromClient&errorType=" & #cfcatch.type# & "&errorMessage=" & #cfcatch.message#>


<cfif "#cfcatch.message#" is not "">

	<cfset responseStruct = StructNew() >
	<cfset responseStruct.errorType =  "#cfcatch.type#">
	<cfset responseStruct.errorMessage =  "#cfcatch.message#">
	<cfset Session.resStruct = "#responseStruct#">
	<CFLOCATION URL="APIError.cfm?error=fromClient">
</cfif>

<cfset urlPath = "APIError.cfm?error=fromServer">

<cfif responseStruct.Ack is "Failure">
       <CFLOCATION URL="APIError.cfm?error=fromServer">
 </cfif>

</CFCATCH>
</CFTRY>
<a class="home" id="CallsLink" href="index.html">Home</a>
</body>
</html>
</cfoutput>