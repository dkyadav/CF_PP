<!-- 
*************************************************
MassPayReceipt.cfm

This page takes necessary parameter from MassPay.cfm page 
and passing into doHttppost function which takes request value
as Struct Object it will call cfhttp tag to perform MassPay.This 
page will show the response value coming from the Server. If 
any error occurs, the page will redirect to APIError.cfm to 
show exact error details

*************************************************
-->

<head>
    <title>PayPal CF SDK - MassPay API</title>
    <link href="sdk.css" rel="stylesheet" type="text/css" />
</head>
<body>

<cfset StructClear(Session)>
<CFOBJECT COMPONENT="CallerService" NAME="caller">


<CFSET requestData = StructNew()>
<CFSET requestData.METHOD = "MassPay">
<CFSET requestData.USER = "#USERNAME#">
<CFSET requestData.PWD = "#PASSWORD#">
<CFSET requestData.SIGNATURE = "#SIGNATURE#">
<CFSET requestData.SUBJECT = "#UNIPAYSUBJECT#">
<CFSET requestData.VERSION = "#version#">
<CFSET requestData.EMAILSUBJECT = "#Form.emailSubject#">
<CFSET requestData.RECEIVERTYPE = "#Form.receiverType#">
<CFSET requestData.CURRENCYCODE = "#Form.currency#">

<cfset receivermailArray = #ListToArray(receiveremail)#>
<cfset amtArray = #ListToArray(amount)#>
<cfset uidArray = #ListToArray(uniqueID)#>
<cfset noteArray = #ListToArray(note)#>
<cfset size = #ArrayLen(receivermailArray)#>

<!---
	If note is nulll, this method wil create empty noteArray 
--->
<cfinvoke component="CallerService" method="populateEmptyValue" returnvariable="note">
	<cfinvokeargument name="noteORuid" value=#noteArray#>
	<cfinvokeargument name="size" value=#size#>
</cfinvoke>
<cfset noteArray = #note#>

<!---
	If uniqueid  is nulll, this method wil create empty uniqueIdArray 
--->
<cfinvoke component="CallerService" method="populateEmptyValue" returnvariable="uid">
	<cfinvokeargument name="noteORuid" value=#uidArray#>
	<cfinvokeargument name="size" value=#size#>
</cfinvoke>
<cfset uidArray = "#uid#">

<cfloop index = "i" from = "1" to = #size#>

	<CFSET email = "L_EMAIL" & (i-1)>
	<CFSET amt = "L_Amt" & (i-1)>
	<CFSET uniqueid = "L_UNIQUEID" & (i-1)>
	<CFSET note = "L_NOTE" & (i-1)>

	<cfscript>

		StructInsert(requestData, email, receivermailArray[i]);
		StructInsert(requestData, amt, amtArray[i]);
		if(#ArrayLen(uidArray)# is not 0)
		StructInsert(requestData, uniqueid, uidArray[i]);
		if(#ArrayLen(noteArray)# is not 0)
		StructInsert(requestData, note, noteArray[i]);

	</cfscript>
</cfloop>

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

 <CFSET responseStruct = caller.getNVPResponse(#URLDecode(response)#)>
 <CFSET messages = ArrayNew(1)>
 <CFSET Session.resStruct ="#responseStruct#">
 <CFIF responseStruct.Ack is "Success">
	<center>
	<font size=2 color=black face=Verdana><b>Mass Payment</b></font>
	<br><br>
	<b>MassPay has been completed successfully!</b>
	<br>
    <center>
	<table class="api"><cfoutput>#displayText(responseStruct)#</cfoutput></table>
    </center>
    </CFIF>
    <CFIF responseStruct.Ack is "Failure">
    <CFLOCATION URL="APIError.cfm?error=fromServer">
</CFIF>

<CFCATCH>
	<CFSET responseStruct = StructNew() >
	<CFSET responseStruct.errorType =  "#cfcatch.type#">
	<CFSET responseStruct.errorMessage =  "#cfcatch.message#">
	<CFSET Session.resStruct = "#responseStruct#">
	<CFLOCATION URL="APIError.cfm?error=fromClient">

</CFCATCH>
</CFTRY>  

   <a class="home" id="CallsLink" href="index.html">Home</a>
</body>
</html>