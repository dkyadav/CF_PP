<!-- 
*************************************************
RPprofile.cfm

This page takes necessary parameter from createRPprofile page 
and pssing into doHttppost function to perform create Recurring Payments Profile.
This page will show the response value coming from the Server. 
If any error occurs, the page will redirect to APIError.cfm 
to show exact error details

*************************************************
-->
<cfoutput>
<head>
<title>PayPal CF SDK - RPprofile API</title>
<link href="sdk.css" rel="stylesheet" type="text/css" />
</head>
<body>
<cfset StructClear(Session)>
<CFOBJECT COMPONENT="CallerService" NAME="caller">

<table class="api" align="center" border="0">

<CFTRY>

<CFSET expDate =  #Form.expDateMonth# & #Form.expDateYear# >
<CFSET requestData = StructNew()>
<CFSET requestData.USER = "#USERNAME#">
<CFSET requestData.PWD = "#PASSWORD#">
<CFSET requestData.SIGNATURE = "#SIGNATURE#">
<CFSET requestData.SUBJECT = "#UNIPAYSUBJECT#">
<CFSET requestData.VERSION = "#version#">
<CFSET requestData.METHOD = "CreateRecurringPaymentsProfile">
<CFSET requestData.AMT = "#Form.amount#">
<CFSET requestData.CURRENCYCODE = "USD">
<CFSET requestData.CREDITCARDTYPE = "#Form.creditCardType#">
<CFSET requestData.ACCT = "#Form.creditCardNumber#">
<CFSET requestData.FIRSTNAME = "#Form.firstName#">
<CFSET requestData.LASTNAME = "#Form.lastName#">
<CFSET requestData.STREET = "#Form.address1#">
<CFSET requestData.CITY = "#Form.city#">
<CFSET requestData.STATE = "#Form.state#">
<CFSET requestData.ZIP = "#Form.zip#">
<CFSET requestData.COUNTRYCODE = "US">
<CFSET requestData.EXPDATE = "#expDate#">
<CFSET requestData.CVV2 = "#Form.cvv2Number#">
<CFSET requestData.DESC = "#Form.ProfileDescription#">
<CFSET requestData.PROFILESTARTDATE = "#Form.profileStartDateYear#" &"-"& "#Form.profileStartDateMonth#" &"-"& "#Form.profileStartDateDay#" & "T01:00:00,0Z">
<CFSET requestData.BILLINGPERIOD = "#Form.BillingPeriod#">
<CFSET requestData.BILLINGFREQUENCY = "#Form.BillingFrequency#">
<CFSET requestData.TOTALBILLINGCYCLES = "#Form.totalBillingCycles#">
<CFSET requestData.ADDRESSSTATUS = "Confirmed">
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

	<br>
	<center>
	<b>Create Recurring Payment Profile</b><br><br>
    
    <table class="api">
		<cfloop collection=#responseStruct# item="key">
			<tr>
				<td>
					#key#
				</td>
				<td>
					#responseStruct[key]#
				</td>
			</tr>
		</cfloop>
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
<a class="home" id="CallsLink" href="RecurringPaymentsIndex.cfm">Recurring Payments Home</a>
</body>
</html>
</cfoutput>