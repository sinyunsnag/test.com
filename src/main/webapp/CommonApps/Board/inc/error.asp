<%
	no=request("no")
      
	caseVar = lcase (no)
	Select Case caseVar
		Case 1  msg = "�����ڷ� �α��� �ϼž� �̿밡���մϴ�." 'del_ok.asp,institute_ok.asp
		Case 2  msg = "��й�ȣ�� Ʋ���ϴ�."
		Case 3  msg = "������ ���� �������ּ���.."
		Case 4  msg = "������ �����ϴ�."
		Case 5  msg = "�̹� ������� ���̵��Դϴ�."	'join_ok.asp
		Case 6  msg = "�̹� ������� ���ڿ��� �ּ��Դϴ�."	'join_ok.asp
		Case 7  msg = "�̹� ��ϵ� �ֹε�Ϲ�ȣ�Դϴ�."	'join_ok.asp
		Case 8  msg = "DATA ������ �������� �ʽ��ϴ�.."	'tb_form_ok.asp
		Case 9  msg = "��й�ȣ�� �Է����ּ���."	'dext_form_ok.asp
		Case 10 msg = "���� �뷮�� �ʰ��Ͽ����ϴ�." 'write_ok.asp
		Case 11 msg = "��й�ȣ�� �������� ä��ø� �ȵ˴ϴ�." 'write_ok.asp
		Case 12 msg = request("strext")&"������ ���ε尡 �ȵ˴ϴ�."
	End Select
%>

<script language="JavaScript">
	alert("<%=msg%>");
	location.href="javascript:history.back()";
</script>
