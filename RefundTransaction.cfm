<!-- 
*************************************************
RefundTransaction.cfm

	This page has necessary input value to perform RefundTransaction transaction
	When click submit button, action will submit to RefundReceipt.cfm page 
	there retrieving all form values and pass into doHttppost function.

*************************************************
-->

<html>
<head>
    <title>PayPal CF SDK - RefundTransaction API</title>
    <link href="sdk.css" rel="stylesheet" type="text/css" />
</head>
<body>
    
	<br>
	<center>
	<font size=2 color=black face=Verdana><b>RefundTransaction</b></font>
<br><br>
    <CFFORM method="POST" action="RefundReceipt.cfm">
        <table class="api">
            
            <tr>
                <td class="field">
                    Transaction ID:</td>
                <td>
		<CFIF StructKeyExists(URL, "transactionID")>
                    <input type="text" name="transactionID" value = "<CFOUTPUT>#URL.transactionID#</CFOUTPUT>" />
		<CFELSE>
                    <input type="text" name="transactionID" />
		</CFIF>
		 <td><b>(Required)</b></td>
		 </td>
            </tr>
            <tr>
                <td class="field">
                    Refund Type:</td>
                <td>
                    <select name="refundType">
                    <option value="Full">Full</option>
                    <option value="Partial">Partial</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="field">
                    Amount:</td>
                <td>
	            <CFIF StructKeyExists(URL, "currency")>
                    <input type="text" name="amount" value="<CFOUTPUT>#URL.amount#</CFOUTPUT>" />
		    <CFELSE>
		    <input type="text" name="amount" value="0.00" />
		    </CFIF>

		    <CFIF StructKeyExists(URL, "currency")>
                    <select name="currency" value="<CFOUTPUT>#URL.currency#</CFOUTPUT>" >
                    <option value="USD">USD</option>
                    <option value="GBP">GBP</option>
                    <option value="JPY">JPY</option>
                    <option value="EUR">EUR</option>
                    <option value="CAD">CAD</option>
                    <option value="AUD">AUD</option>
                    </select>
		    <CFELSE>
                    <select name="currency" >
                    <option value="USD">USD</option>
                    <option value="GBP">GBP</option>
                    <option value="JPY">JPY</option>
                    <option value="EUR">EUR</option>
                    <option value="CAD">CAD</option>
                    <option value="AUD">AUD</option>
                    </select>
		    </CFIF>
                </td>
            </tr>
            <tr>
                <td />
                <td>
                    <b>(Required if Partial Refund)</b>
                </td>
            </tr>
            <tr>
                <td class="field">
                    Memo:</td>
                <td>
                    <textarea name="memo" cols="30" rows="4"></textarea></td>
            </tr>
            <tr>
                <td class="field">
                </td>
                <td>
                    <input type="Submit" value="Submit" /></td>
            </tr>
        </table>
    </CFFORM>
    </center>
   <a class="home" id="CallsLink" href="index.html">Home</a>
</body>
</html>