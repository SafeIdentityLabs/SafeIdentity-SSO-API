<%@ page import="java.io.*" %>
<%@ page import="SafeIdentity.*" %>
<%@ page language="java" contentType="text/html; charset=euc-kr" %>
<%
	//*************************************************************************
	// Response에 헤더 정보를 추가한다. 캐쉬하지 않도록 설정한다.
	response.setHeader("Cache-Control", "no-cache");

	// 필요한 변수를 선언한다.
	String resultMsg = null;
	int ret = -1;
	SSO sso = new SSO("368B184727E89AB69FAF");
// 	sso.setHostName("192.168.10.84");	
	sso.setHostName("192.168.60.144");	
	sso.setPortNumber(7000);
	//*************************************************************************
	// Request 처리
	//*************************************************************************
	System.out.println("\n\n\n"); 
	// 매개변수를 가져온다.
	
	String token = request.getParameter("ssoToken");
	   
	System.out.println("ssoToken : " + token);
	
	sso.verifyToken(token);
	
	ret = sso.getLastError();

	//*******************************************************
	// 클라이언트에 보낼 Response 생성
	//*******************************************************

	// Response를 NVDS 형식으로 보내므로, 이에 필요한 NVDS 파서를 생성한다.
	SsoParser parser = new SsoParser();

	// RESULT 태그를 추가한다. (성공했으면 0, 실패했으면 에러코드로 추가된다.)
	System.out.println("RESULT : " + ret);
	parser.add("RESULT", Integer.toString(ret));
 
	
	// RESULTMSG 태그를 추가한다.
	if (resultMsg == null && ret < 0) {
		resultMsg = sso.getLastErrorMsg();
	}
	
	System.out.println("RESULTMSG : " + resultMsg);
	parser.add("RESULTMSG", resultMsg);
	
	
	// HTTP의 body로 Response를 클라이언트에게 보낸다.
	//out.println(csEncrypt("RESULT-0*" + request.getQueryString() + "-*"));
	//out.println(csEncrypt(parser.getQuery()));
	//out.println(parser.getQuery());
	
	out.println(sso.getValueUserID() + " 님이 로그인하였습니다.");
	
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
	//단말 로컬에 있는 어플리케이션 실행
	var url = "com.example.mobilessoa://simsso?sso_token = " + "<%=token%>";
	
<%-- 	document.checkframe.location = "com.example.mobilessoa://simsso?sso_token=" + "<%=token%>"; --%>
	document.checkframe.location = "com.softforum.msisample://simsso?sso_token=" + "<%=token%>";
	alert('dsfsdf');
	//1초 후에 다음 펑션을 수행
	setTimeout("checkApplicationInstall_callback()", 1000); 
}

function checkApplicationInstall_IPHONE() 
{
	//단말 로컬에 있는 어플리케이션 실행
	var url = "issoa://?sso_token = " + "<%=token%>";
	
	alert(url);
	
	location = url;
	 
}

function checkApplicationInstall_callback() 
{
	try {
		var s = document.checkframe.document.body.innerHTML;
	   	// 어플리케이션 설치되어있음
	 	//어플이 실행되고 난 뒤의 액션
	} catch (e) {
	   // 어플리케이션 설치 안 되어있음
	//어플이 설치 안되어 있는 상태이므로 마켓으로 연결한다.
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
<div id="footer"><p>Copyright ⓒ 2014 by SoftForum All Rights Reserved.&nbsp;&nbsp;&nbsp;&nbsp;</p></div>
</body>
</html>