function SubmitOrderForm(frm) {
	<!-- �⺻ �׸� check -->
	<!-- name check -->
	if (frm.cName.value.length == 0 )	{
		alert("������ �����Ͽ� �ֽʽÿ�");
		frm.cName.focus();
		return false;
	}
	if (frm.cName.value.indexOf(" ") >= 0 )	{
		alert("������ ��ĭ���� �Է��Ͻʽÿ�.");
		frm.cName.focus();
		return false;
	}

	// ��ȭ��ȣ
	if(/^[0-9]+$/.test(frm.cTEL1.value) == false){
		alert("��ȭ��ȣ�� �Է��Ͻʽÿ�.");
		frm.cTEL1.select();
		frm.cTEL1.focus();
		return false;
     }
	if(/^[0-9]+$/.test(frm.cTEL2.value) == false){
		alert("��ȭ��ȣ�� �Է��Ͻʽÿ�.");
		frm.cTEL2.select();
		frm.cTEL2.focus();
		return false;
	}
	if(/^[0-9]+$/.test(frm.cTEL3.value) == false){
		alert("��ȭ��ȣ�� �Է��Ͻʽÿ�.");
		frm.cTEL3.select();
		frm.cTEL3.focus();
		return false;
	}

	// �ڵ�����ȭ��ȣ
	if (isNaN(frm.cMTEL1.value) || isNaN(frm.cMTEL2.value) || isNaN(frm.cMTEL3.value)) {
		alert("�ڵ�����ȣ�� ���ڷ� �Է��Ͻʽÿ�.");
		frm.cMTEL1.focus();
		return false;
	}

	//����Ȯ��
	if (frm.cEmail.value.length > 0)
	{
		if (!checkMail(frm.cEmail)) {
			frm.cEmail.focus();
			return false;
		}
	} else {
		alert("������ �Է��� �ּ���.");
		frm.cEmail.focus();
		return false;
	}


	//����üũ
	if(/^[0-9-]{7}$/.test(frm.cAddrZip.value) == false) {
	    alert("�����ȣ�� �Է����ֽʽÿ�.");
	    frm.cAddrZip.focus();
		frm.cAddrZip.select();
	    return false;
	}
	if (frm.cAddrStt.value.length ==0) {
		alert("���ּҸ� �Է��Ͻʽÿ�.");
		frm.cAddrStt.focus();
		return false;
	}


	//���������üũ
	if(/^[0-9-]{7}$/.test(frm.rAddrZip.value) == false) {
	    alert("����� �����ȣ�� �Է����ֽʽÿ�.");
	    frm.rAddrZip.focus();
		frm.rAddrZip.select();
	    return false;
	}
	if (frm.rAddrStt.value.length ==0) {
		alert("����� ���ּҸ� �Է��Ͻʽÿ�.");
		frm.rAddrStt.focus();
		return false;
	}

	if (frm.rName.value.length == 0 )	{
		alert("������(ó)�� �����Ͽ� �ֽʽÿ�");
		frm.rName.focus();
		return false;
	}
	if (frm.rName.value.indexOf(" ") >= 0 )	{
		alert("������(ó)�� ��ĭ���� �Է��Ͻʽÿ�.");
		frm.rName.focus();
		return false;
	}

	//����� ��ȭ��ȣ üũ
	if (frm.rTEL1.value.length ==0 || frm.rTEL2.value.length ==0 || frm.rTEL3.value.length ==0)	{
		alert("����� ��ȭ��ȣ�� �Է��Ͻʽÿ�.");
		frm.rTEL1.focus();
		return false;
	} else {
		if (isNaN(frm.rTEL1.value) || isNaN(frm.rTEL2.value) || isNaN(frm.rTEL3.value))	{
			alert("����� ��ȭ��ȣ�� ���ڷ� �Է��Ͻʽÿ�.");
			frm.rTEL1.focus();
			return false;
		}
	}
	if (isNaN(frm.rMTEL1.value) || isNaN(frm.rMTEL2.value) || isNaN(frm.rMTEL3.value)) {
		alert("����� �ڵ�����ȣ�� ���ڷ� �Է��Ͻʽÿ�.");
		frm.rMTEL1.focus();
		return false;
	}

	//�������Ա�
	if (typeof(frm.bankInfo) == "object")
	{
		//���༱��
		if (frm.bankInfo.options.selectedIndex < 1)	{
			alert("�Ա��� ������ �����ϼ���.");
			frm.bankInfo.selectedIndex = 0
			return false;
		}
		//�Ա��ڸ�
		if (frm.onlinePayer.value.length == 0 )	{
			alert("�Ա��ڸ��� �����Ͽ� �ֽʽÿ�");
			frm.onlinePayer.focus();
			return false;
		}
		if (frm.onlinePayer.value.indexOf(" ") >= 0 )	{
			alert("�Ա��ڸ��� ��ĭ���� �Է��Ͻʽÿ�.");
			frm.onlinePayer.focus();
			return false;
		}
	}


	return true;
}	//function SubmitOrderForm(frm)



<!-- �̸��� ���� Ȯ�� -->
function checkMail(eMail)
{
	var strEmail = eMail.value;
	var i;
	var strCheck1 = false;
	var strCheck2 = false;
	var iEmailLen = strEmail.length

	if (iEmailLen > 0) {
		// strEmail �� '.@', '@.' �� �ִ� ��� �����޽���.
		// strEmail�� �Ǿ� �Ǵ� �ǵڿ� '@', '.' �� �ִ� ��� �����޽���.
		if ((strEmail.indexOf(".@") != -1) || (strEmail.indexOf("@.") != -1) ||
			(strEmail.substring(0,1) == ".") || (strEmail.substring(0,1) == "@") ||
			(strEmail.substring(iEmailLen-1,iEmailLen) == ".") || (strEmail.substring(iEmailLen-1,iEmailLen) == "@")) {
				alert("\n�̸��� �ּҸ� ��Ȯ�ϰ� �Է��Ͻʽÿ�.");
				eMail.focus();
			return false;
		}

		for(i=0; i < iEmailLen; i++) {
	 		if ((strEmail.substring(i,i+1) == ".") ||
	 		 	(strEmail.substring(i,i+1) == "-") || (strEmail.substring(i,i+1) == "_") ||
	 		 	((strEmail.substring(i,i+1) >= "0") && (strEmail.substring(i,i+1) <= "9")) ||
	 		 	((strEmail.substring(i,i+1) >= "@") && (strEmail.substring(i,i+1) <= "Z")) ||
	 		 	((strEmail.substring(i,i+1) >= "a") && (strEmail.substring(i,i+1) <= "z"))) {
	 		 		if (strEmail.substring(i,i+1) == ".")
	 		 			strCheck1 = true;
	 		 		if (strEmail.substring(i,i+1) == "@")
	 		 			strCheck2 = true;
	 		 }
	 		else {
	 			alert("\n�̸��� �ּҸ� ��Ȯ�ϰ� �Է��Ͻʽÿ�. ");
	 			eMail.focus();
				return false;
	 		}
	 	}

	 	if ((strCheck1 == false) || (strCheck2 == false)) {
	 		alert("\n�̸��� �ּҸ� ��Ȯ�ϰ� �Է��Ͻʽÿ�.");
	 		eMail.focus();
	 		return false;
	 	}
	}

	return true;
}





function sameData(frm) {
    if(frm.cbSameData.checked) {
      frm.rAddrZip.value = frm.cAddrZip.value;
      frm.rAddrCity.value = frm.cAddrCity.value;
      frm.rAddrStt.value = frm.cAddrStt.value;
      frm.rName.value = frm.cName.value;
      frm.rTEL1.value = frm.cTEL1.value;
      frm.rTEL2.value = frm.cTEL2.value;
      frm.rTEL3.value = frm.cTEL3.value;
      frm.rMTEL1.value = frm.cMTEL1.value;
      frm.rMTEL2.value = frm.cMTEL2.value;
      frm.rMTEL3.value = frm.cMTEL3.value;
    } else {
      frm.rAddrZip.value = "";
      frm.rAddrCity.value = "";
      frm.rAddrStt.value = "";
      frm.rName.value = "";
      frm.rTEL1.value = "";
      frm.rTEL2.value = "";
      frm.rTEL3.value = "";
      frm.rMTEL1.value = "";
      frm.rMTEL2.value = "";
      frm.rMTEL3.value = "";
    }
}