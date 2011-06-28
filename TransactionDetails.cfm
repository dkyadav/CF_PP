<!--
*************************************************
TransactionDetails.cfm

This page takes necessary parameter from GetTransactionDetails.cfm page
and passing the parameters to doHttppost function which takes request value
as Struct Object it will call cfhttp tag to perform TransactionDetails.This
page will show the response value coming from the Server. If
any error occurs, the page will redirect to APIError.cfm to
show exact error details

*************************************************
-->


<head>
<title>PayPal CF SDK - Transaction details</title>
<link href="sdk.css" rel="stylesheet" type="text/css" />
</head>
<body>

	<cfset StructClear(Session)>
	<CFOBJECT COMPONENT="CallerService" name="caller">
	<!--
		Passing necessary parameter to CFHTTP tag to perform Transactiondetails
	-->
	<CFSET transactionID = "">
	<CFIF StructKeyExists(Form, "transactionID")>

		<CFSET transactionID = #Form.transactionID#>
	</CFIF>
	<CFIF StructKeyExists(URL, "transactionID")>

		<CFSET transactionID = #URL.transactionID#>
	</CFIF>

<CFSET requestData = StructNew()>
<CFSET requestData.METHOD = "GetTransactionDetails">
<CFSET requestData.TRANSACTIONID = "#transactionID#">
<CFSET requestData.USER = "#USERNAME#">
<CFSET requestData.PWD = "#PASSWORD#">
<CFSET requestData.SIGNATURE = "#SIGNATURE#">
<CFSET requestData.SUBJECT = "#UNIPAYSUBJECT#">
<CFSET requestData.VERSION = "#version#">
<CFTRY>

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
<center>
  <!--
	getNVPResponse method returns nvp response string as CF struct object
	-->
<cfset responseStruct = caller.getNVPResponse(#URLDecode(response)#)>
<cfset Session.resStruct = #responseStruct#>
<cfif not StructKeyExists(responseStruct, "PARENTTRANSACTIONID")>
	<cfset responseStruct.PARENTTRANSACTIONID = "">
</cfif>
 <cfif responseStruct.Ack is "Success">
    <center>
    <span id=apiheader>Transaction Details</span>
    <br><br>

    <table width =400>

        <tr>
            <td >
                Payer:
            </td>
            <td><CFOUTPUT>#responseStruct.RECEIVEREMAIL#</CFOUTPUT></td>
        </tr>
        <tr>
            <td >
                Payer ID:
            </td>
            <td><CFOUTPUT>#responseStruct.PAYERID#</CFOUTPUT></td>
        </tr>
        <tr>
            <td >
                First Name:
            </td>
            <td><CFOUTPUT>#responseStruct.FIRSTNAME#</CFOUTPUT></td>
        </tr>
        <tr>
            <td >
                Last Name:
            </td>
            <td><CFOUTPUT>#responseStruct.LASTNAME#</CFOUTPUT></td>
        </tr>
        <tr>
            <td >
                Transaction ID:
            </td>
            <td><CFOUTPUT>#responseStruct.TRANSACTIONID#</CFOUTPUT></td>
        </tr>
        <tr>
            <td >
                Parent Transaction ID (if any):
            </td>
            <td><CFOUTPUT>#responseStruct.PARENTTRANSACTIONID#</CFOUTPUT></td>
	 </tr>
        <tr>
            <td >
                Gross Amount:
            </td>
            <td><CFOUTPUT>#responseStruct.AMT#</CFOUTPUT></td>
        </tr>
        <tr>
            <td >
                Payment Status:
            </td>
            <td><CFOUTPUT>#responseStruct.PAYERSTATUS#</CFOUTPUT></td>
        </tr>
        <tr>
			<td >
				Pending Reason:</td>
			<td><CFOUTPUT>#responseStruct.PENDINGREASON#</CFOUTPUT></td>
		</tr>
		<tr>
			<td >
				ProtectionEligibility:</td>
			<td><CFOUTPUT>#responseStruct.PROTECTIONELIGIBILITY#</CFOUTPUT></td>
        </tr>
	<tr align="center">
            <td colspan="2" >
	    <table align="center">
		<tr>
		<td>
                <a id="DoVoidLink" href="DoVoid.cfm?authorizationID=<CFOUTPUT>#responseStruct.TRANSACTIONID#</CFOUTPUT>">Void</a>
		<a id="DoCaptureLink" href="DoCapture.cfm?authorizationID=<CFOUTPUT>#responseStruct.TRANSACTIONID#</CFOUTPUT>&currency=<CFOUTPUT>#responseStruct.CURRENCYCODE#</CFOUTPUT>&amount=<CFOUTPUT>#responseStruct.AMT#</CFOUTPUT>">
                Capture</a>
		<a id="RefundTransactionLink" href="RefundTransaction.cfm?transactionID=<CFOUTPUT>#responseStruct.TRANSACTIONID#</CFOUTPUT>&currency=<CFOUTPUT>#responseStruct.CURRENCYCODE#</CFOUTPUT>&amount=<CFOUTPUT>#responseStruct.AMT#</CFOUTPUT>">
                Refund</a>
		<a href="javascript:history.back()">Back</a>
		</td>
		</tr>
		</table>
            </td>
        </tr>

</table>
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
</center>
<a  id="CallsLink" class="home"  href="index.html"><font color=blue><B>Home<B><font></a>
</body>
</html>