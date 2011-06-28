<!-- 
*************************************************
DoVoid.cfm

	This page has necessary input value to perform DoVoid transaction
	When click submit button, action will submit to DoVoidreceipt page 
	there retrieving all form values and pass into doHttppost function

*************************************************
-->

<html>
<head>
    <title>PayPal CF SDK - DoVoid API</title>
    <link href="sdk.css" rel="stylesheet" type="text/css" />
</head>
<body>
<cfform action="DoVoidReceipt.cfm">
    
	<br>
	<center>
	<font size=2 color=black face=Verdana><b>DoVoid</b></font>
	<br><br>
    <table class="api">
        <tr>
            <td class="field">
                Authorization ID:</td>
            <td>
	    <CFOBJECT COMPONENT="CallerService" NAME="caller">
	<CFIF StructKeyExists(URL, "authorizationID")>
		 <input type="text" name="authorization_id" value="<CFOUTPUT>#URL.authorizationId#</CFOUTPUT>" />
	<CFELSE>
		<input type="text" name="authorization_id"/>
	</CFIF>
               
                </td>
                <td><b>(Required)</b></td>
        </tr>
        <tr>
            <td class="field">
                Note:</td>
            <td>
                <textarea name="note" cols="30" rows="4"></textarea></td>
        </tr>
        <tr>
            <td colspan="2">
                <center>
                <input type="Submit" value="Submit" /></center>
            </td>
        </tr>
    </table>
    </center>
</cfform>
   <a class="home" id="CallsLink" href="index.html">Home</a>
</body>
</html>