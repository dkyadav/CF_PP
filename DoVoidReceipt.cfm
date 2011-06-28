<!-- 
*************************************************
DoVoidReceipt.cfm

This page takes necessary parameter from DoVoidReceipt.cfm page 
and pssing into doHttppost function which takes request value
as Struct Object it will call cfhttp tag to perform DoVoid. This 
page will show the response value coming from the Server. If 
any error occurs, the page will redirect to APIError.cfm to 
show exact error details

*************************************************
-->

<html>
<head>
    <title>PayPal CF SDK - DoVoid API</title>
    <link href="sdk.css" rel="stylesheet" type="text/css" />
</head>
<body>
<cfset StructClear(Session)>
<CFOBJECT COMPONENT="CallerService" NAME="caller">
<CFTRY>

<CFSET requestData = StructNew()>
<CFSET requestData.METHOD = "DOVoid">
<CFSET requestData.USER = "#USERNAME#">
<CFSET requestData.PWD = "#PASSWORD#">
<CFSET requestData.SIGNATURE = "#SIGNATURE#">
<CFSET requestData.SUBJECT = "#UNIPAYSUBJECT#">
<CFSET requestData.VERSION = "#version#">
<CFSET requestData.AUTHORIZATIONID = "#Form.authorization_id#">
<CFSET requestData.NOTE = "#Form.note#">

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
		<br>
		<center>
		<font size=2 color=black face=Verdana><b>Do Void</b></font>
		<br><br>
		<b>Authorization voided!</b><br><br>
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