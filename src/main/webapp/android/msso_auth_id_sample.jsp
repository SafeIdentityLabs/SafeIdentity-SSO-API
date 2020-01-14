<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ page import="SafeIdentity.*" %>
<%
	String secId = (String) request.getParameter("secId") != null ? (String) request.getParameter("secId") : "";

	if("".equals(secId)) {
		System.out.println("msso_auth_id_sample - secId is null.");
		response.sendRedirect("MSSOSample://");
		return;
	}

	System.out.println("secId : " + secId);

	final String sApiKey = "368B184727E89AB69FAF";
	SSO sso = new SSO(sApiKey);

	String userId = (String) request.getParameter("userId") != null ? (String) request.getParameter("userId") : "";
	String userPwd = (String) request.getParameter("userPwd") != null ? (String) request.getParameter("userPwd") : "";

	if(!"".equals(userId) && !"".equals(userPwd)) {
		System.out.println("userId : " + userId + " || userPwd : " + userPwd);

		SsoAuthInfo ssoAuthInfo = new SsoAuthInfo();

		if(secId != null && !"".equals(secId)) {
			System.out.println("sdfsdfsdfsdffsdfsdfds1");
			ssoAuthInfo = sso.authID(userId, userPwd, true, "127.0.0.1", secId);
		} else {
			System.out.println("sdfsdfsdfsdffsdfsdfds2");
			ssoAuthInfo = sso.authID(userId, userPwd, true, "127.0.0.1");
		}
		int iResult = sso.getLastError();

		if(ssoAuthInfo != null) {
			if(iResult == 0) {
				request.getSession().setAttribute("ssoToken", ssoAuthInfo.getToken());
				request.getSession().setAttribute("secId", secId);
				System.out.println("ssoAuthInfo.getToken() : " + ssoAuthInfo.getToken());
				response.sendRedirect(request.getContextPath() + "/ios/msso_web_sample.jsp");
				return;
			} else {
				out.println("<script type=\"text/javascript\">");
				out.println("alert(\"SSO Login Error Code 1: " + iResult + "\");");
				out.println("</script>");
			}
		} else {
			out.println("<script type=\"text/javascript\">");
			out.println("alert(\"SSO Login Error Code 2: " + iResult + "\");");
			out.println("</script>");
		}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Mobile SSO Web Sample</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1"/>

	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/jquery.mobile-1.4.2.css"/>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.0.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.mobile-1.4.2.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.util.js"></script>
	<script type="text/javascript">
		var osPlatform = '';

		$(function() {
			$("#userId").on("keyup", function(e) {
				if(e.which==13) {
					if($("#userId").val() == '') {
						alert('ID를 입력 바랍니다.');
					}else {
						$("#userPwd").focus();
					}
				}
			});

			$("#userPwd").on("keyup", function(e) {
				if(e.which == 13) {
					if($("#userId").val() == '') {
						alert('ID를 입력 바랍니다.');
						$('#userId').focus();
					} else if($('#userPwd').val() == '') {
						alert('패스워드를 입력 바랍니다.');
					} else {
						loginSubmit();
					}
				}
			});
		});

		function loginSubmit() {
			if(document.getElementById("userId").value == '') {
				alert('사용자 ID를 입력하시기 바랍니다.');
				document.getElementById('userId').focus();
			} else if(document.getElementById('userPwd').value == '') {
				alert('사용자 패스워드를 입력하시기 바랍니다.');
				document.getElementById('userPwd').focus();
			} else {
				document.authForm.submit();
			}
		}

		function initCheck() {
			var osPlatform = getMobileCheck();
		}
	</script>
</head>
<body onLoad="javascript:initCheck();">
<div data-role="content">
	<div data-role="header">
		<h1>Login Test</h1>
	</div>

	<div data-role="content">
		<form id="authForm" name="authForm" method="post" action="/ios/msso_auth_id_sample.jsp">
			<input type="text" id="secId" name="secId" value="<%=secId %>"/>
			<input type="text" id="userId" name="userId" value=""/>
			<input type="password" id="userPwd" name="userPwd" value=""/>
			<input type="button" id="loginBtn" name="loginBtn" value="로그인" onClick="javascript:loginSubmit();"/>
		</form>

		<!-- 	<a href="com.softforum.sample://getUUID" data-transition="slide">Android Get UUID</a> -->
	</div>
</div>
</body>
</html>