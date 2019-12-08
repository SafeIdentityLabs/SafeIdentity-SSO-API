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
	//sso.setHostName("192.168.10.84");	
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
	out.println(parser.getQuery());
	
%>
