<!-- 
*************************************************
DoReauthorization.cfm

	This page has necessary input value to perform DoReauthorization transaction
	When click submit button, action will submit to DoReauthorizationReceipt page 
	In  DoReauthorizationReceipt page all form values will be retrieved and passed 
	into cfhttp tag as query parameter for destination URL.

*************************************************
-->

<html>
<head>
    <title>PayPal SDK - DoReauthorization</title>
    <link href="sdk.css" rel="stylesheet" type="text/css" />
</head>
<body>
<cfform action="DoReauthorizationReceipt.cfm">
    <center>
    <table class="api">
        <tr>
            <td colspan="2" align = center>
             <font size=larger color=black face=Verdana><b>  DoReauthorization </b></font>
            </td>
        </tr>
        <tr>
            <td class="field">
                AuthorizationID:</td>
            <td>
                <input type="text" name="authorizationID" />
                (Required)</td>
        </tr>
        <tr>
            <td class="field">
                Amount:</td>
            <td>
                <input type="text" name="amount" size="5" maxlength="7" />
                <select name="currency">
                <option value="USD">USD</option>
                <option value="GBP">GBP</option>
                <option value="EUR">EUR</option>
                <option value="JPY">JPY</option>
                <option value="CAD">CAD</option>
                <option value="AUD">AUD</option>
                </select>
                (Required)</td>
        </tr>
        <tr>
            <td class="field">
            </td>
            <td>
                <input type="Submit" value="Submit" />
            </td>
        </tr>
    </table>
    </center>
    </cfform>
   <a class="home" id="CallsLink" href="index.html">Home</a>
</body>
</html>