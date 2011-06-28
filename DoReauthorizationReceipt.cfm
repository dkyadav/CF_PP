<!-- 
*************************************************
DoReauthorizationReceipt.cfm

This page takes necessary parameter from DoReauthorization page 
and pass pass parameters to doHttppost function to perform DoReauthorization.
This page will show the response value coming from the Server. 
If any error occurs, the page will redirect to APIError.cfm 
to show exact error details

*************************************************
-->


<head>
    <title>PayPal CF SDK - DoReAuthorization API</title>
    <link href="sdk.css" rel="stylesheet" type="text/css" />
</head>
<body>

<cfset StructClear(Session)>
<CFOBJECT COMPONENT="CallerService" NAME="caller">
<CFTRY>

<CFSET requestData = StructNew()>
<CFSET requestData.METHOD = "DoReauthorization">
<CFSET requestData.USER = "#USERNAME#">
<CFSET requestData.PWD = "#PASSWORD#">
<CFSET requestData.SIGNATURE = "#SIGNATURE#">
<CFSET requestData.SUBJECT = "#UNIPAYSUBJECT#">
<CFSET requestData.VERSION = "#version#">
<CFSET requestData.AuthorizationID = "#Form.authorizationID#">
<CFSET requestData.AMT = "#Form.amount#">
<CFSET requestData.CURRENCYCODE = "#Form.currency#">

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
    
		<br>
		<center>
		<font size=2 color=black face=Verdana><b>Do ReAuthorization</b></font>
		<br><br>
		<b>ReAuthorization Succeeded!</b><br><br>
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