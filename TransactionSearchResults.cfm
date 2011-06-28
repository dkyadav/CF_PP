<!-- 
*************************************************
TransactionSearchResults.cfm

This page takes necessary parameter from TransactionSearch.cfm page 
and pssing into doHttppost function which takes request value
as Struct Object it will call cfhttp tag to perform TransactionSearch 
This page will show the response value coming from the Server. If 
any error occurs, the page will redirect to APIError.cfm to 
show exact error details

*************************************************
-->


<head>
    <title>PayPal CF SDK: Transaction Search Results</title>
    <link href="sdk.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <center>
   <cfset StructClear(Session)>
   <CFSET requestData = StructNew()>
<CFOBJECT COMPONENT="CallerService" NAME="caller">
    <cfset fromDate = #DateFormat(#Form.startDateStr#, "mm-dd-yyyy")#>
    <cfset month = #month(fromDate)#>
    <cfset day = #day(fromDate)#>
    <cfset year = #year(fromDate)#>
    <cfset paypalfrmDate = year &"-"& month &"-"& day & "T00:00:00Z">
    <cfif #Form.endDateStr# IS NOT "">
	    <cfset toDate = #DateFormat(#Form.endDateStr#, "mm-dd-yyyy")#>
	    <cfset month = #month(toDate)#>
	    <cfset day = #day(toDate)#>
	    <cfset year = #year(toDate)#>
	    <CFSET requestData.ENDDATE = year &"-"& month &"-"& day & "T23:00:00Z">
    </cfif>
    <cfset transactionID = "#Form.transactionID#">
    <CFTRY>

<CFSET requestData.METHOD = "TransactionSearch">
<CFSET requestData.USER = "#USERNAME#">
<CFSET requestData.PWD = "#PASSWORD#">
<CFSET requestData.SIGNATURE = "#SIGNATURE#">
<CFSET requestData.SUBJECT = "#UNIPAYSUBJECT#">
<CFSET requestData.VERSION = "#version#">
<CFSET requestData.STARTDATE = "#paypalfrmDate#">
<CFIF #Form.transactionID# IS NOT "">
<CFSET requestData.TRANSACTIONID = "#Form.transactionID#">
</CFIF>

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
 <CFSET txnCount = 0>
 <CFLOOP collection=#responseStruct# item="key">
	<CFIF StructKeyExists(responseStruct, "L_TRANSACTIONID" & #txnCount#)>
		<CFSET #txnCount# = txnCount + 1>
	</CFIF>
</CFLOOP>
 <CFIF (responseStruct.Ack is "Success" or responseStruct.Ack is "SuccessWithWarning")  and txnCount is not 0>
 <center>
 <span id=apiheader>Transaction Search Results</span> <br><br>
    <table class = "api">
			<tr>
            <td colspan="6" align =right>
                Results 1 - <CFOUTPUT>#txnCount#</CFOUTPUT> 
            </td>
			</tr>
        
			<tr>
            <td class="field">
            </td>
            <td>
               <b>ID</b></td>
            <td>
               <b> Time</b></td>
            <td>
               <b> Status</b></td>
            <td>
               <b> Payer Name</b></td>
            <td>
                <b>Gross Amount</b></td>
        </tr>
 <CFSET txnCount = 0>
 <CFSET	txnSearchTable = StructNew()>
 <CFSET rowCount =  0>
<CFLOOP collection=#responseStruct# item="key">

	<CFIF StructKeyExists(responseStruct, "L_TRANSACTIONID" & #txnCount#)>
	 <CFSET rowCount =  rowCount + 1>
	<tr>

		<CFSET txnKey = "L_TRANSACTIONID" & #txnCount#>
		<CFSET timeStmpKey = "L_TIMESTAMP" & #txnCount#>
		<CFSET statusKey = "L_STATUS" & #txnCount#>
		<CFSET nameKey  = "L_NAME" & #txnCount#>
		<CFSET amtKey = "L_AMT" & #txnCount#>
		<td><CFOUTPUT>#rowCount#</CFOUTPUT></td>
		<td><a id=TransactionDetailsLink0 href="TransactionDetails.cfm?transactionID=<CFOUTPUT>#responseStruct[txnKey]#</CFOUTPUT>"><CFOUTPUT>#responseStruct[txnKey]#</CFOUTPUT></a></td>
		<td><CFOUTPUT>
			<CFIF StructKeyExists(responseStruct, "L_TIMESTAMP" & #txnCount#)>
				#responseStruct[timeStmpKey]#
			</cfif>
		   </CFOUTPUT>
		</td>
		<td>
			<CFOUTPUT>
				<CFIF StructKeyExists(responseStruct, "L_STATUS" & #txnCount#)>
					#responseStruct[statusKey]#
				</cfif>
			</CFOUTPUT></td>
		<td><CFOUTPUT>
			<CFIF StructKeyExists(responseStruct, "L_NAME" & #txnCount#)>
				#responseStruct[nameKey]#
			</cfif>
			</CFOUTPUT>
		</td>
		<td><CFOUTPUT>
			<CFIF StructKeyExists(responseStruct, "L_AMT" & #txnCount#)>
				#responseStruct[amtKey]#
			</cfif>
		    </CFOUTPUT>
		</td>
        </tr>
</CFIF>
<CFSET #txnCount# = txnCount + 1>

</CFLOOP>

</CFIF>

    </table>
<CFIF txnCount is 0>
	<br>Found 0 transactions

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
    </center>
   <a class="home" id="CallsLink" href="index.html">Home</a>
</body>
</html>