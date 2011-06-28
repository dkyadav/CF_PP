<!--
*************************************************
BillOutStandingAmt.cfm

	This page has necessary inputs to perform Bill Outstanding amount API.
	When clicking of submit button in this page,form will be submited to OutstandingAmtReceipt.cfm page
	there form values are passed into doHttppost function.

*************************************************
-->
<cfoutput>
<head>
<title>PayPal CF SDK - Bill Outstanding Amount API</title>
<link href="sdk.css" rel="stylesheet" type="text/css" />
</head>
<body>

<CFFORM ACTION="OutstandingAmtReceipt.cfm" METHOD="post" name="formBillOutstandingAmt">
  <center>
	<font size=2 color=black face=Verdana><br><b>Bill Outstanding Amount</b><br><br>
    <table class="api">
            <tr>
                <td class="field">
                    Profile ID:
                </td>
                <td>
                    <input type="text" name="profileID" value="" /> 
                    (Required)</td>
            </tr>
            <tr>
                <td class="field">
                    Amount:
                </td>
                <td>
                    <input type="text" name="amount" value="" /> 
                    </td>
            </tr>
            <tr>
                <td colspan="2">
                    <center>
                    <input type="Submit" value="Submit" /></center>
                </td>
            </tr>
        </table>
    </form>
    </center>

</CFFORM>
</body>
<a class="home" id="CallsLink" href="RecurringPaymentsIndex.cfm">Recurring Payments Home</a>
</html>
</cfoutput>