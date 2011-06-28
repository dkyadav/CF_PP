<!--
*************************************************
ManageRPprofile.cfm

	This page has necessary inputs to perform manage recurring payments profile transaction.
	When clicking of submit button, action will submit changedRPstatus.cfm page
	there retrieving all form values and pass into doHttppost function.

*************************************************
-->

<head>
<title>PayPal CF SDK - Manage Recurring Payments Profile Status API</title>
<link href="sdk.css" rel="stylesheet" type="text/css" />
</head>

<body>
<CFFORM ACTION="RPmanageProfileStatus.cfm" METHOD="post" name="formManageRPprofile">
  <center>
	<font size=2 color=black face=Verdana><br><b>Manage Recurring Payments Profile Status</b>
    <table class="api">
	  <tr>
          <td class="field">  Profile ID:</td> 
          <td><input type="text" name="profileID" value="" /> (Required)</td>
      </tr>
      <tr>
          <td class="field">Action:</td>
          <td>
              <select name="action">
              	<option value="Cancel">Cancel</option>
              	<option value="Suspend">Suspend</option>
              	<option value="Reactivate">Reactivate</option>
              </select>
          </td>
      </tr>
      <tr>
          <td colspan="2">
              <center>
              <input type="Submit" value="Submit" /></center>
          </td>
      </tr>
    </table>
  </center>
</CFFORM>
</body>
<a class="home" id="CallsLink" href="RecurringPaymentsIndex.cfm">Recurring Payments Home</a>
</html>