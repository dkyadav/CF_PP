<!--
*************************************************
DoDirectPayment.cfm

	This is page has necessary input value to perform dodirectpayment transaction
	When click submit button, action will submit to dodirectpaymentreceipt page
	there retrieving all form values and pass into doHttppost function.

*************************************************
-->


<head>
<title>PayPal CF SDK - DoDirectPayment API</title>
<link href="sdk.css" rel="stylesheet" type="text/css" />
<script language="JavaScript">
	function generateCC(){
		var cc_number = new Array(16);
		var cc_len = 16;
		var start = 0;
		var rand_number = Math.random();

		switch(document.frmDCC.creditCardType.value)
        {
			case "Visa":
				cc_number[start++] = 4;
				break;
			case "Discover":
				cc_number[start++] = 6;
				cc_number[start++] = 0;
				cc_number[start++] = 1;
				cc_number[start++] = 1;
				break;
			case "MasterCard":
				cc_number[start++] = 5;
				cc_number[start++] = Math.floor(Math.random() * 5) + 1;
				break;
			case "Amex":
				cc_number[start++] = 3;
				cc_number[start++] = Math.round(Math.random()) ? 7 : 4 ;
				cc_len = 15;
				break;
        }

        for (var i = start; i < (cc_len - 1); i++) {
			cc_number[i] = Math.floor(Math.random() * 10);
        }

		var sum = 0;
		for (var j = 0; j < (cc_len - 1); j++) {
			var digit = cc_number[j];
			if ((j & 1) == (cc_len & 1)) digit *= 2;
			if (digit > 9) digit -= 9;
			sum += digit;
		}

		var check_digit = new Array(0, 9, 8, 7, 6, 5, 4, 3, 2, 1);
		cc_number[cc_len - 1] = check_digit[sum % 10];

		document.frmDCC.creditCardNumber.value = "";
		for (var k = 0; k < cc_len; k++) {
			document.frmDCC.creditCardNumber.value += cc_number[k];
		}
	}


</script>
</head>
<body>

<CFFORM ACTION="DoDirectPaymentReceipt.cfm" METHOD="post" name="frmDCC">
  <center>
	<font size=2 color=black face=Verdana><br><b>DoDirectPayment</b>
    <table class="api">

      <tr>
        <td class="field"> First Name:</td>
        <td><input type="text" size="30" maxlength="32" name="firstName" value="John" /></td>
      </tr>
      <tr>
        <td class="field"> Last Name:</td>
        <td><input type="text" size="30" maxlength="32" name="lastName" value="Doe" /></td>
      </tr>
      <tr>
        <td class="field"> Card Type:</td>
        <td><select name="creditCardType" onChange="javascript:generateCC(); return false;">
            <option value="Visa" selected>Visa</option>
            <option value="MasterCard">MasterCard</option>
            <option value="Discover">Discover</option>
            <option value="Amex">American Express</option>
          </select>
        </td>
      </tr>
      <tr>
        <td class="field"> Card Number:</td>
        <td><input type="text" size="19" maxlength="19" name="creditCardNumber" value="4623226975828898" /></td>
      </tr>
      <tr>
        <td class="field"> Expiration Date:</td>
        <td><select name="expDateMonth">
            <option value="01">01</option>
            <option value="02">02</option>
            <option value="03">03</option>
            <option value="04">04</option>
            <option value="05">05</option>
            <option value="06">06</option>
            <option value="07">07</option>
            <option value="08">08</option>
            <option value="09">09</option>
            <option value="10">10</option>
            <option value="11">11</option>
            <option value="12">12</option>
          </select>
          <select name="expDateYear">
            <option value="2004">2004</option>
            <option value="2005">2005</option>
            <option value="2006">2006</option>
            <option value="2007">2007</option>
            <option value="2008">2008</option>
            <option value="2009">2009</option>
            <option value="2010">2010</option>
            <option value="2011" selected>2011</option>
            <option value="2012">2012</option>
            <option value="2013">2013</option>
            <option value="2014">2014</option>
            <option value="2015">2015</option>
          </select>
        </td>
      </tr>
      <tr>
        <td class="field"> Card Verification Number:</td>
        <td><input type="text" size="3" maxlength="4" name="cvv2Number" value="962" /></td>
      </tr>
      <tr>
         <td align=right><br><b>Billing Address:</b></td>
      </tr>
      <tr>
        <td class="field"> Address 1: </td>
        <td><input type="text" size="25" maxlength="100" name="address1" value="123 Fake St" /></td>
      </tr>
      <tr>
        <td class="field"> Address 2: </td>
        <td><input type="text" size="25" maxlength="100" name="address2" />
          (optional)</td>
      </tr>
      <tr>
        <td class="field"> City: </td>
        <td><input type="text" size="25" maxlength="40" name="city" value="Omaha" /></td>
      </tr>
      <tr>
        <td class="field"> State: </td>
        <td><select name="state">
            <option></option>
            <option value="AK">AK</option>
            <option value="AL">AL</option>
            <option value="AR">AR</option>
            <option value="AZ">AZ</option>
            <option value="CA" selected>CA</option>
            <option value="CO">CO</option>
            <option value="CT">CT</option>
            <option value="DC">DC</option>
            <option value="DE">DE</option>
            <option value="FL">FL</option>
            <option value="GA">GA</option>
            <option value="HI">HI</option>
            <option value="IA">IA</option>
            <option value="ID">ID</option>
            <option value="IL">IL</option>
            <option value="IN">IN</option>
            <option value="KS">KS</option>
            <option value="KY">KY</option>
            <option value="LA">LA</option>
            <option value="MA">MA</option>
            <option value="MD">MD</option>
            <option value="ME">ME</option>
            <option value="MI">MI</option>
            <option value="MN">MN</option>
            <option value="MO">MO</option>
            <option value="MS">MS</option>
            <option value="MT">MT</option>
            <option value="NC">NC</option>
            <option value="ND">ND</option>
            <option value="NE">NE</option>
            <option value="NH">NH</option>
            <option value="NJ">NJ</option>
            <option value="NM">NM</option>
            <option value="NV">NV</option>
            <option value="NY">NY</option>
            <option value="OH">OH</option>
            <option value="OK">OK</option>
            <option value="OR">OR</option>
            <option value="PA">PA</option>
            <option value="RI">RI</option>
            <option value="SC">SC</option>
            <option value="SD">SD</option>
            <option value="TN">TN</option>
            <option value="TX">TX</option>
            <option value="UT">UT</option>
            <option value="VA">VA</option>
            <option value="VT">VT</option>
            <option value="WA">WA</option>
            <option value="WI">WI</option>
            <option value="WV">WV</option>
            <option value="WY">WY</option>
            <option value="AA">AA</option>
            <option value="AE">AE</option>
            <option value="AP">AP</option>
            <option value="AS">AS</option>
            <option value="FM">FM</option>
            <option value="GU">GU</option>
            <option value="MH">MH</option>
            <option value="MP">MP</option>
            <option value="PR">PR</option>
            <option value="PW">PW</option>
            <option value="VI">VI</option>
          </select>
        </td>
      </tr>
      <tr>
        <td class="field"> ZIP Code: </td>
        <td><input type="text" size="10" maxlength="10" name="zip" value="95131" />
          (5 or 9 digits) </td>
      </tr>
      <tr>
        <td class="field"> Country: </td>
        <td> United States </td>
      </tr>
      <tr>
        <td class="field"> Amount:</td>
        <td><input type="text" size="4" maxlength="7" name="amount" value="1.00" />USD

            <!--select name="currency">
            <option value="USD">USD</option>
            <option value="GBP">GBP</option>
            <option value="EUR">EUR</option>
            <option value="JPY">JPY</option>
            <option value="CAD">CAD</option>
            <option value="AUD">AUD</option>
          </select-->
        </td>
        </tr>
       <tr><td/> <td align=left><b>(DoDirectPayment only supports USD at this time)</b></td>
       </tr>
      <tr>
        <td class="field"></td>
        <td><input type="Submit" value="Submit" /></td>
      </tr>
    </table>
  </center>
 	<!--
		Using this hidden variable the system can identify whether it is Authorization or Sale
		This paymentaction coming from Calls.html
	-->
  <CFINPUT TYPE="hidden" NAME="PAYMENTACTION" VALUE="#URL.paymentaction#">
</CFFORM>
</body>
<a class="home" id="CallsLink" href="index.html">Home</a>
</html>