<!--
*************************************************
GetExpressCheckoutDetails.cfm

This page shows shipping details coming from the server's response object. When click the submit button
token, payerid, amount, currency and other necessary information passed into DoExpressChekoutpayment.cfm.

*************************************************
-->
<cfoutput>
<head>
<title>PayPal CF SDK - ExpressCheckout API</title>
<link href="sdk.css" rel="stylesheet" type="text/css" />
</head>

<body>
  <CFFORM ACTION="DoExpressCheckoutPayment.cfm" method="post">

<CFTRY>

	<cfset StructClear(Session)>

	<CFOBJECT COMPONENT="CallerService" name="caller">

	<CFSET requestData = StructNew()>
	<CFSET requestData.METHOD = "GetExpressCheckoutDetails">
	<cfif #USERNAME# neq ""><CFSET requestData.USER = "#USERNAME#"></cfif>
	<cfif #PASSWORD# neq ""><CFSET requestData.PWD = "#PASSWORD#"></cfif>
	<cfif #SIGNATURE# neq ""><CFSET requestData.SIGNATURE = "#SIGNATURE#"></cfif>
	<cfif #UNIPAYSUBJECT# neq ""><CFSET requestData.SUBJECT = "#UNIPAYSUBJECT#"></cfif>
	<CFSET requestData.VERSION = "#version#">
	<CFSET requestData.TOKEN = "#URL.token#">

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
<cfif not StructKeyExists(responseStruct, "SHIPTOSTREET2")>
	<cfset responseStruct.SHIPTOSTREET2 = "">
</cfif>
  <cfif responseStruct.Ack is "Success">
	<cfinput type="hidden" name="totalAmt" value="#responseStruct.AMT#">
	<center> 
		                                             <b>Review Order</b>
		                                              <br>
		   <font size=2 color=black face=Verdana><b>DoExpressCheckoutPayment</b></font><br><br>
           <table class="api"> #displayText(responseStruct)#</table>
		   <tr>
                <td colspan="2" align = center>
                    <input type="submit" value="Pay" />
                </td>
            </tr>

	</center>
</cfif>

<cfif responseStruct.Ack is "Failure">
	<CFLOCATION URL="APIError.cfm?error=fromServer">
</cfif>

    <CFINPUT TYPE="hidden"  NAME="payerId" VALUE="#URL.payerId#">
    <CFINPUT TYPE="hidden" NAME="token" VALUE="#URL.token#">
    <CFINPUT TYPE="hidden"  NAME="amount" VALUE="#URL.AMT#">
    <CFINPUT TYPE="hidden" NAME="currencycode" VALUE="#URL.currencycode#">
    <CFINPUT TYPE="hidden" NAME="paymentaction" VALUE="#URL.paymentaction#">

    <!--
		Following variable passed as hidden values in the doexpresschekout
		page to perform expresscheckout transaction
	-->
 <CFCATCH>

	<cfset responseStruct = StructNew() >
	<cfset responseStruct.errorType =  "#cfcatch.type#">
	<cfset responseStruct.errorMessage =  "#cfcatch.message#">
	<cfset Session.resStruct = "#responseStruct#">
	<CFLOCATION URL="APIError.cfm?error=fromClient">

</CFCATCH>
</CFTRY>
  </CFFORM>
<a class="home" id="CallsLink" href="index.html">Home</a>
</body>
</html>
</cfoutput>