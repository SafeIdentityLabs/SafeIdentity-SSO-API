<%@ page import="java.io.*" %>
<%@ page import="SafeIdentity.*" %>
<%@ page language="java" contentType="text/html; charset=euc-kr" %>
<%
	//*************************************************************************
	// Response�� ��� ������ �߰��Ѵ�. ĳ������ �ʵ��� �����Ѵ�.
	response.setHeader("Cache-Control", "no-cache");

	// �ʿ��� ������ �����Ѵ�.
	String resultMsg = null;
	int ret = -1;
	SSO sso = new SSO("368B184727E89AB69FAF");
// 	sso.setHostName("192.168.10.84");	
	sso.setHostName("192.168.60.144");	
	sso.setPortNumber(7000);
	//*************************************************************************
	// Request ó��
	//*************************************************************************
	System.out.println("\n\n\n"); 
	// �Ű������� �����´�.
	
	String token = request.getParameter("ssoToken");
	   
	System.out.println("ssoToken : " + token);
	
	sso.verifyToken(token);
	
	ret = sso.getLastError();

	//*******************************************************
	// Ŭ���̾�Ʈ�� ���� Response ����
	//*******************************************************

	// Response�� NVDS �������� �����Ƿ�, �̿� �ʿ��� NVDS �ļ��� �����Ѵ�.
	SsoParser parser = new SsoParser();

	// RESULT �±׸� �߰��Ѵ�. (���������� 0, ���������� �����ڵ�� �߰��ȴ�.)
	System.out.println("RESULT : " + ret);
	parser.add("RESULT", Integer.toString(ret));
 
	
	// RESULTMSG �±׸� �߰��Ѵ�.
	if (resultMsg == null && ret < 0) {
		resultMsg = sso.getLastErrorMsg();
	}
	
	System.out.println("RESULTMSG : " + resultMsg);
	parser.add("RESULTMSG", resultMsg);
	
	
	// HTTP�� body�� Response�� Ŭ���̾�Ʈ���� ������.
	//out.println(csEncrypt("RESULT-0*" + request.getQueryString() + "-*"));
	//out.println(csEncrypt(parser.getQuery()));
	//out.println(parser.getQuery());
	
	out.println(sso.getValueUserID() + " ���� �α����Ͽ����ϴ�.");
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xml:lang="ko" xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Mobile SSO Demo</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />

<script type="text/javascript">

function checkApplicationInstall() 
{
	//�ܸ� ���ÿ� �ִ� ���ø����̼� ����
	var url = "com.example.mobilessoa://simsso?sso_token = " + "<%=token%>";
	
<%-- 	document.checkframe.location = "com.example.mobilessoa://simsso?sso_token=" + "<%=token%>"; --%>
	document.checkframe.location = "com.softforum.msisample://simsso?sso_token=" + "<%=token%>";
	alert('dsfsdf');
	//1�� �Ŀ� ���� ����� ����
	setTimeout("checkApplicationInstall_callback()", 1000); 
}

function checkApplicationInstall_IPHONE() 
{
	//�ܸ� ���ÿ� �ִ� ���ø����̼� ����
	var url = "issoa://?sso_token = " + "<%=token%>";
	
	alert(url);
	
	location = url;
	 
}

function checkApplicationInstall_callback() 
{
	try {
		var s = document.checkframe.document.body.innerHTML;
	   	// ���ø����̼� ��ġ�Ǿ�����
	 	//������ ����ǰ� �� ���� �׼�
	} catch (e) {
	   // ���ø����̼� ��ġ �� �Ǿ�����
	//������ ��ġ �ȵǾ� �ִ� �����̹Ƿ� �������� �����Ѵ�.
	//location.replace("intent://viewer?#Intent;scheme='com.wiz.bellringallandroid';action='android.intent.action.VIEW';category='android.intent.category.BROWSABLE';package=com.wiz.bellringallandroid;end");
	}
}
</script>

<style type="text/css">
#container {
    min-height: 80%;
    position: relative;
    z-index: 1;
    width: auto;
}

#footer {
    height: 50px;
    background: #ddd;
}
}
</style>

</head>
<body>
<div id="container">
		<br/>
		<a href="com.softforum.sample://sofohost">scheme111 test</a>
<!-- 		<a href="msisample://simsso">scheme test</a> -->
		<input type="button" value="Android App Luncher" onclick="checkApplicationInstall()"/><br/>
		<input type="button" value="IPhone App Luncher" onclick="checkApplicationInstall_IPHONE()"/><br/>
		<iframe id="checkframe" name="checkframe" src="check.html" width="1" height="1"></iframe>
</div>
<div id="footer"><p>Copyright �� 2014 by SoftForum All Rights Reserved.&nbsp;&nbsp;&nbsp;&nbsp;</p></div>
</body>
</html>