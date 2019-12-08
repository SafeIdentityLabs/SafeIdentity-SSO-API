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
	//sso.setHostName("192.168.10.84");	
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
	out.println(parser.getQuery());
	
%>
