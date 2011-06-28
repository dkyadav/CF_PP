

<!-- 
*************************************************
DoCapture.cfm

	This page has necessary input value to perform DoCapture transaction
	When click submit button, action will submit to DoCapturereceipt page 
	there retrieving all form values and pass into cfhttp tag as query parameter for 
	destination URL.

*************************************************
-->


<html>
<head>
    <title>PayPal CF SDK - DoCapture API</title>
    <link href="sdk.css" rel="stylesheet" type="text/css" />
</head>
<cfform action="DoCaptureReceipt.cfm">
<body>
    
		<br>
		<center>
		<font size=2 color=black face=Verdana><b>DoCapture</b></font>
		<br><br>
    <table class="api">
        
	    <!---
		We can perform doCapture in two ways by entering transaction id directly in 
		doCapture page and by clicking doCapture link from transaction details response 
		page. If transaction id is in URL object, it has come from transactionreceipt.cfm 
		otherwise it has come from doCapture.cfm
	    --->

            <td class="field">
                Authorization ID:</td>
            <td>
	    <CFIF StructKeyExists(URL, "authorizationID")>
                <input type="text" name="authorization_id" value = "<CFOUTPUT>#URL.authorizationID#</CFOUTPUT>"/>
  	    <CFELSE>
		<input type="text" name="authorization_id" />
	    </CFIF>

                </td>
       <td><b>(Required)</b></td>
        </tr>
        <tr>
            <td class="field">
                Complete Code Type:</td>
            <td>
                <select name="CompleteCodeType">
                <option value="Complete">Complete</option>
                <option value="NotComplete">NotComplete</option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="field">
                Amount:</td>
            <td>
	    <CFIF StructKeyExists(URL, "currency")> 
                <input type="text" name="amount" size="5" maxlength="7" value="<CFOUTPUT>#URL.amount#</CFOUTPUT>"/>
            <CFELSE>
		<input type="text" name="amount" size="5" maxlength="7" />
	    </CFIF>
              <CFIF StructKeyExists(URL, "currency")> 
		<select name="currency" value="<CFOUTPUT>#URL.currency#</CFOUTPUT>" >
                <option value="USD">USD</option>
                <option value="GBP">GBP</option>
                <option value="EUR">EUR</option>
                <option value="JPY">JPY</option>
                <option value="CAD">CAD</option>
                <option value="AUD">AUD</option>
                </select>
	        <CFELSE>
		<select name="currency">
                <option value="USD">USD</option>
                <option value="GBP">GBP</option>
                <option value="EUR">EUR</option>
                <option value="JPY">JPY</option>
                <option value="CAD">CAD</option>
                <option value="AUD">AUD</option>
                </select>
		</CFIF>

               </td>
               <td><b>(Required)</b></td>
        </tr>
        <tr>
            <td class="field">
                Invoice ID:</td>
            <td>
                <input type="text" name="invoice_id" /></td>
        </tr>
        <tr>
            <td class="field">
                Note:</td>
            <td>
                <textarea name="note" cols="30" rows="4"></textarea></td>
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
      <a class="home" id="CallsLink" href="index.html">Home</a>

</body>
</cfform>
</html>