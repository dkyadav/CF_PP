<!-- 
*************************************************
GetTransactionDetails.cfm

This page contains necessary inputs for Transaction details. 
When click submit button, page will submit the
values of this page to transactionDetails.cfm 
and transactionDetails.cfm will do a HTTP Post to API server
and get the transaction details.	

*************************************************
-->

<head>
    <title>PayPal CF SDK - GetTransactionDetails API</title>
    <link href="sdk.css" rel="stylesheet" type="text/css" />
</head>
	
<body>
    <center>
    <span id=apiheader>GetTransactionDetails</span>
    <cfform action="TransactionDetails.cfm">
        <table class="api">
            <tr>
                <td class="field">
                    Transaction ID:
                </td>
                <td>
                    <input type="text" name="transactionID" value="20P46879S1049380U" />
                    (Required)</td>
            </tr>
            <tr>
                <td colspan="2">
                    <center>
                    <input type="Submit" value="Submit" /></center>
                </td>
            </tr>
        </table>
    </cfform>
    </center>
    <br />
    <a class="home" href="index.html">Home</a>
</body>
</html>