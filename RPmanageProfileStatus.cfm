<!-- 
*************************************************
changedRPstatus.cfm

This page takes necessary parameter from ManageRPprofile page 
and pssing into doHttppost function to perform manage Recurring Payments Profile.
This page will show the response value coming from the Server. 
If any error occurs, the page will redirect to APIError.cfm 
to show exact error details

*************************************************
-->
<cfoutput>
<head>
<title>PayPal CF SDK - Manage Recurring Payments Profile Status API</title>
<link href="sdk.css" rel="stylesheet" type="text/css" />
</head>
<body>
<cfset StructClear(Session)>
<CFOBJECT COMPONENT="CallerService" NAME="caller">

<table class="api" align="center" border="0">

<CFTRY> 
<CFSET requestData = StructNew()>
<CFSET requestData.USER = "#USERNAME#">
<CFSET requestData.PWD = "#PASSWORD#">
<CFSET requestData.SIGNATURE = "#SIGNATURE#">
<CFSET requestData.SUBJECT = "#UNIPAYSUBJECT#">
<CFSET requestData.VERSION = "#version#">
<CFSET requestData.METHOD = "ManageRecurringPaymentsProfileStatus">
<CFSET requestData.PROFILEID = "#trim(Form.profileId)#">
<CFSET requestData.ACTION = "#Form.action#">
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
<cfif responseStruct.Ack is "Success">
	<center>
	<b>Manage Recurring Payments Profile Status</b><br><br>
    
    <table class="api">
		 <cfoutput>#displayText(responseStruct)#</cfoutput>
		<tr><td><a id="CallsLink" href="RPgetProfileDetails.cfm?profileid=#responseStruct["PROFILEID"]#">Get Recurring Payments Details</a></td></tr>
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
<br>
</body>
<a class="home" id="CallRPLink" href="RecurringPaymentsIndex.cfm">Recurring Payments Home</a>
</html>
</cfoutput>