function CheckShoppingCart(frmCSC, pushedBtn) {
	//alert(pushedBtn);
	//evalGoodsCnt = parseInt(form.elements("amount").value);	
	
	frmSize = typeof(frmCSC.gSize);
	frmColor = typeof(frmCSC.gColor);
	if(frmSize == "object" && frmCSC.gSize.value == "") {
		alert('��ǰũ�⸦ �����ϼ���.');
		frmCSC.gSize.focus();
		return;
	}

	if(frmColor == "object" && frmCSC.gColor.value == "") {
		alert('��ǰ���� �����ϼ���.');
		frmCSC.gColor.focus();
		return;
	}
	
	if(frmCSC.amount.value == "") {
		alert('�ֹ������� �Է��Ͻʽÿ�.');
		frmCSC.amount.focus();
		return;
	}
	else if(isNaN(frmCSC.amount.value)) {
		alert('�ֹ������� ���ڷ� �Է��Ͻʽÿ�.');
		frmCSC.amount.focus();
		return;
	}
	else if(frmCSC.amount.value < 1) {
		alert('�Ѱ� �̻��� �ֹ��ϼž� �մϴ�.');
		frmCSC.amount.focus();
		return;
	}
	else {
		if(pushedBtn == "directBuy") {
			SubmitJ("���� �ٷα��Ÿ� �Ͻðڽ��ϱ�?", frmOrder, "OrderProcess/HowToPay_ok.asp")
		}
		else {
			frmCSC.submit();
		}
		//return true;
	}
}