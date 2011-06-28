<!-- 
*************************************************
TransctionSearch.cfm

	This page has necessary input value to perform Transaction Search 
	When click submit button, action will submit to Transaction Search result page
	there retrieving all form values and pass into doHttppost function.

*************************************************
-->


<html>
<head>
    <title>PayPal CF SDK - TransactionSearch API</title>
    <link href="sdk.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <center>
    <span id=apiheader>Transaction Search</span>
     <br>
    <cfform action="TransactionSearchResults.cfm">
        <table class="api">
            <tr>
                <td class="field">
                    StartDate:</td>
                <td>
                   <cfinput type="text" name="startDateStr" maxlength="10" size="10"  value="#DateFormat(Now()-1, "mm/dd/yyyy")#"/>
                </td>
                <td>(Required)</td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    MM/DD/YYYY
                </td>
            </tr>
            <tr>
                <td class="field">
                    EndDate:</td>
                <td>
                    <cfinput type="text" name="endDateStr" maxlength="10" size="10"  value="#DateFormat(Now(), "mm/dd/yyyy")#" />
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    MM/DD/YYYY
                </td>
            </tr>
            <tr>
                <td class="field">
                    TransactionID:</td>
                <td>
                    <input type="text" name="transactionID" /></td>
            </tr>
            <tr>
                <td class="field">
                </td>
                <td>
                    <br />
                    <input type="Submit" value="Submit" /></td>
            </tr>
        </table>
    </cfform>
    </center>
   <a class="home" id="CallsLink" href="index.html">Home</a>
</body>
</html>