function qFormValidate(qForm){
	var frmName = qForm;

	if(frmName.qTitle.value == ""){
		alert("������ �Է��Ͽ� �ּ���.");
		frmName.qTitle.focus();
		return false;
	}else{
		var strTitle = frmName.qTitle.value;
		var chTitle = strTitle.split(" ");

		if(strTitle.length+1 == chTitle.length){
			alert("������ �Է��Ͽ� �ּ���.");
			frmName.qTitle,value = "";
			frmName.qTitle.focus();
			return false;
		}
	}
	if(frmName.userName.value == ""){
		alert("������ �Է��Ͽ� �ּ���.");
		frmName.userName.focus();
		return false;
	}

	if(frmName.userPW.value == ""){
		alert("��ȣ�� �Է��Ͽ� �ּ���.");
		frmName.userPW.focus();
		return false;
	}

	if(frmName.userPhone.value == ""){
		alert("���� ��ȭ��ȣ�� �Է��Ͽ� �ּ���.");
		frmName.userPhone.focus();
		return false;
	}

	if(!CheckMailFormat(frmName.userEmail.value)) {
		alert("\n�̸��� �ּҰ� �Էµ��� �ʾҰų� ����Ȯ�մϴ�.");
		frmName.userEmail.focus();
		return false;
	}

	if(frmName.qContent.value == ""){
		alert("������ �Է��Ͽ� �ּ���.");
		frmName.qContent.focus();
		return false;
	}

	//frmName.submit();
}


function aFormValidate(aForm){
	var frmName = aForm;

	if(frmName.aTitle.value == ""){
		alert("������ �Է��Ͽ� �ּ���.");
		frmName.aTitle.focus();
		return false;
	}else{
		var strTitle = frmName.aTitle.value;
		var chTitle = strTitle.split(" ");

		if(strTitle.length+1 == chTitle.length){
			alert("������ �Է��Ͽ� �ּ���.");
			frmName.aTitle,value = "";
			frmName.aTitle.focus();
			return false;
		}
	}

	if(frmName.aContent.value == ""){
		alert("������ �Է��Ͽ� �ּ���.");
		frmName.aContent.focus();
		return false;
	}
	return true;
	//frmName.submit();
}


function nmFormValidate(nmForm){
	var frmName = nmForm;

	if(!CheckMailFormat(frmName.userEmail.value)) {
		alert("\n�̸��� �ּҰ� �Էµ��� �ʾҰų� ����Ȯ�մϴ�.");
		frmName.userEmail.focus();
		return false;
	}

	if(frmName.userPW.value == ""){
		alert("��ȣ�� �Է��Ͽ� �ּ���.");
		frmName.userPW.focus();
		return false;
	}
	return true;
	//frmName.submit();
}































