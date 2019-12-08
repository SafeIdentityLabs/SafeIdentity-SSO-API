<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="SafeIdentity.*"%>
<%
	String sApiKey = "368B184727E89AB69FAF";
	SSO sso = new SSO(sApiKey);
	SsoAuthInfo ssoAuthInfo = null;

	String play = (String) request.getParameter("play") != null
			? (String) request.getParameter("play")
			: "";
	// 	String ssoToken = (String) request.getParameter("ssoToken") != null ? (String) request.getParameter("ssoToken") : (String) request.getSession().getAttribute("ssoToken");
	String ssoToken = (String) request.getParameter("ssoToken") != null
			? (String) request.getParameter("ssoToken")
			: "";
	
	String secId = (String) request.getParameter("secId") != null ? (String) request.getParameter("secId") : "";
	System.out.println("msso_web_sample - ssoToken : " + ssoToken + " | secId : " + secId);

	//msso_auth_id_sample.jsp에서 넘어온 경우
	if ("".equals(ssoToken)) {
		if (request.getSession().getAttribute("ssoToken") != null || !"".equals(request.getSession().getAttribute("ssoToken"))) {
			ssoToken = (String) request.getSession().getAttribute("ssoToken");
			System.out.println("msso_web_sample - ssoToken session : " + ssoToken);

			if(request.getSession().getAttribute("secId") != null || !"".equals(request.getSession().getAttribute("secId"))) {
				secId = (String) request.getSession().getAttribute("secId");
			}
			
			int vResult = -1;
			
			if(!"".equals(secId)) {
				System.out.println("msso_web_sample - verifyToken secId ");
				vResult = sso.verifyToken(ssoToken, "127.0.0.1", secId);
			} else {
				System.out.println("msso_web_sample - verifyToken no secId ");
				vResult = sso.verifyToken(ssoToken);
			}
			System.out.println("msso_web_sample - verifyResult111 : " + vResult);

			if (vResult != 0) {
				session.invalidate();
				response.sendRedirect(request.getContextPath() + "/ios/msso_auth_id_sample.jsp");
				return;
			}
		} else {
			System.out.println("msso_web_sample - sso token is null");
			out.println("<script type=\"text/javascript\">");
			out.println("alert(\"SSO Token is null\");");
			out.println("document.location.href='./msso_auth_id_sample.jsp';");
			out.println("</script>");
		}
	} else {
		int vResult = -1;
// 		vResult = sso.verifyToken(ssoToken);
		if(!"".equals(secId)) {
			System.out.println("msso_web_sample - verifyToken secId");
			vResult = sso.verifyToken(ssoToken, "127.0.0.1", secId);
		} else {
			System.out.println("msso_web_sample - verifyToken no secId");
			vResult = sso.verifyToken(ssoToken);
		}
		
		System.out.println("msso_web_sample - verifyResult : " + vResult);

		if (vResult != 0) {
			session.invalidate();
			System.out.println("msso_web_sample - no secID vResult : " + vResult);
			response.sendRedirect(request.getContextPath() + "/ios/msso_auth_id_sample.jsp");
			return;
		}
	}

	//로그아웃 버튼을 선택한 경우
	if ("unreg".equals(play)) {
		System.out.println("msso_web_sample - unreg ssoToken : " + ssoToken);
		int uResult = sso.unregUserSession(ssoToken);

		if (uResult == 0) {
			System.out.println("로그아웃 되었습니다.");
			System.out.println("msso_web_sample - no secId uResult : " + uResult);
			response.sendRedirect(request.getContextPath() + "/ios/msso_auth_id_sample.jsp");
			return;
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>Mobile SSO Web Sample</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet"	href="<%=request.getContextPath()%>/resources/css/jquery.mobile-1.4.2.css" />
<script type="text/javascript"	src="<%=request.getContextPath()%>/resources/js/jquery-1.9.0.js"></script>
<script type="text/javascript"	src="<%=request.getContextPath()%>/resources/js/jquery.mobile-1.4.2.js"></script>
<script type="text/javascript"	src="<%=request.getContextPath()%>/resources/js/common.util.js"></script>
<script type="text/javascript">

	function unreg() {
		document.getElementById("play").value = "unreg";
		document.jQfrm.submit();
	}
	
	function initCheck() {
		var osPlatform = getMobileCheck();
// 		alert(osPlatform);
		if(osPlatform != null) {
			if(osPlatform != 'undefined' || osPlatform != '') {
				if(osPlatform == 'android') {
					$("#ios_mssosample").remove();
					$("#ios_issoa").remove();
				} else if(osPlatform == 'ios') {
					$("#android").remove();
				}
			}
		}
	}
</script>
</head>
<body onLoad="javascript:initCheck();">
	<div data-role="page">
		<div data-role="header">
			<h1>SafeIdentity API Test</h1>
		</div>

		<div data-role="content">
			<form id="jQfrm" name="jQfrm" method="post" action="<%=request.getContextPath()%>/ios/msso_web_sample.jsp">
				<input type="hidden" id="ssoToken" name="ssoToken" value="<%=ssoToken %>"/>
				<input type="hidden" id="play" name="play" value=""/>
				<ul data-role="listview" data-insert="true">
					<li>SSO Token : <input type="text" name="ssoToken" value="<%=ssoToken%>" /></li>
<!-- 					<li>OS Platform : <input type="text" name="osPlatform" id="osPlatform" value="" /></li> -->
					
					<li id="android"><a href="com.softforum.sample://sofohost?ssoToken=<%=ssoToken%>" data-transition="slide">Android App Check (MSSOSample)</a></li>
					<li id="ios_mssosample"><a href="MSSOSample://?ssoToken=<%=ssoToken%>" data-transition="slide">IOS App Check (MSSOSample)</a></li>
					<li id="ios_issoa"><a href="issoa://?sso_token=<%=ssoToken %>" data-transition="slide">IOS App Check(ISSOA)</a>
					<li><a href="#" data-transition="flip" onClick="unreg();">로그아웃</a></li>
				</ul>
			</form>
		</div>
	</div>
</body>
</html>