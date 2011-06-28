<!--
*************************************************
GetRPprofileDetails.cfm

	This page has necessary inputs to perform Get recurring payments profile details.
	When clicking of submit button, action will submit RPprofileDetails.cfm page
	there retrieving all form values and passing into doHttppost function.

*************************************************
-->
<cfoutput>
<head>
<title>PayPal CF SDK - Create Recurring Payments Profile API</title>
<link href="sdk.css" rel="stylesheet" type="text/css" />
</head>
<body>

<CFFORM ACTION="RPprofileDetails.cfm" METHOD="post" name="formManageRPprofile">
  <center>
	<font size=2 color=black face=Verdana><br><b>Recurring Payments Profile Details</b><br><br>
    <table class="api">
	  <tr>
        	<td class="field"> Profile Id: </td>
        	<td> <input type="text" size="30" maxlength="32" name="profileId" <cfif isdefined("URL.profileid")>value=#URL.profileid#<cfelse>value=""</cfif> />(Required) </td>
      </tr>
      	<tr>
	        <td class="field"></td>
	        <td><input type="Submit" value="Submit"/></td>
      </tr>
    </table>
  </center>
</CFFORM>
</body>
<a class="home" id="CallsLink" href="RecurringPaymentsIndex.cfm">Recurring Payments Home</a>
</html>
</cfoutput>