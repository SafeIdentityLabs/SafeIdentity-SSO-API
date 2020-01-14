<%@ page import="java.io.*"%>
<%@ page import="SafeIdentity.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%
	//*************************************************************************
	// Response에 헤더 정보를 추가한다. 캐쉬하지 않도록 설정한다.
	response.setHeader("Cache-Control", "no-cache");

	// 필요한 변수를 선언한다.
	String resultMsg = null;
	String tokenKey = "saftidentitymobile";
	int ret = -1;
	SSO sso = new SSO("368B184727E89AB69FAF");
	sso.setHostName("10.211.55.4");
	sso.setPortNumber(7000);

	//*************************************************************************
	// Request 처리
	//*************************************************************************
	System.out.println("\n\n\n");
	// 매개변수를 가져온다.
	String cmd = request.getParameter("cmd");
	String token = request.getParameter("token");

	//String queryString = request.getQueryString();
	//System.out.print("QueryString : "+queryString);

	System.out.println("\n");
	System.out.println("CMD   : " + cmd);

	//*******************************************************
	// CMD 처리
	//*******************************************************
	// Request를 파싱한다. cmd 매개변수에 따라 해당 명령을 수행한다.

	//-------------------------------------------------------
	if (cmd.equals("get_key")) {
		resultMsg = tokenKey;
		ret = 0;
	} else if (cmd.equals("verify_token")) {
		// verify_token
		String cip = request.getParameter("cip");
		String secId = request.getParameter("secId");
		
		if(secId != null && !"".equals(secId)) {
			ret = sso.verifyToken(token, cip, secId);
		} else {
			ret = sso.verifyToken(token, cip);
		}

		resultMsg = sso.getValueUserID();
	}
	//-------------------------------------------------------
	else if (cmd.equals("user_view")) {
		// user_view
		String cip = request.getParameter("cip");
		SsoAuthInfo authInfo = new SsoAuthInfo();

		authInfo = sso.userView(token, cip);
		ret = sso.getLastError();

		SsoParser parser = new SsoParser();

		parser.add(SsoConst.TAGUID, authInfo.getUserId());
		parser.add(SsoConst.TAGNAME, authInfo.getUserName());
		parser.add(SsoConst.TAGRRN, authInfo.getRrn());
		parser.add(SsoConst.TAGEMAIL, authInfo.getEmailAddress());
		parser.add(SsoConst.TAGPROFILE, authInfo.getProfile());
		parser.add(SsoConst.TAGPRIDN, authInfo.getPrivateDn());
		parser.add(SsoConst.TAGPUBDN, authInfo.getPublicDn());
		parser.add(SsoConst.TAGPATHID, authInfo.getPathId());
		parser.add(SsoConst.TAGOUS, authInfo.getOus());

		resultMsg = parser.getQuery();
	}
	//-------------------------------------------------------
	else if (cmd.equals("unreg_us")) {
		// unreg_us
		String cip = request.getParameter("cip");

		ret = sso.unregUserSession(token, cip);
		//ret = sso.getLastError();
	}	
	//-------------------------------------------------------
	else if(cmd.equals("reguser_session")) {
		String uid = request.getParameter("uid");
		String cip = request.getParameter("cip");
		String overwrite = request.getParameter("overwrite");
		String secId = request.getParameter("secId");
		
		boolean overwriteFlag;
		int retRegUser;
		if(overwrite.equalsIgnoreCase("true")) {
			overwriteFlag = true;
		}else {
			overwriteFlag = false;
		}
		
		if(secId != null && !"".equals(secId)) {
			retRegUser = sso.regUserSession(uid, cip, overwriteFlag, secId);
		} else {
			retRegUser = sso.regUserSession(uid, cip, overwriteFlag);
		}
		
		if(retRegUser >= 0) {
			ret = 0;
			resultMsg = sso.getToken();
		}
	}
	//-------------------------------------------------------
	else if (cmd.equals("auth_id")) {
		// auth_dn
		String uid = request.getParameter("uid");
		String pwd = request.getParameter("pwd");
		String overwrite = request.getParameter("overwrite");
		String cip = request.getParameter("cip");
		//add 20140721
		String secId = request.getParameter("secId");

		boolean overwriteFlag;
		SsoAuthInfo authInfo = new SsoAuthInfo();

		// 		if (overwrite.equals("true") || overwrite.equals("TRUE")){
		if (overwrite.equalsIgnoreCase("true")) {
			overwriteFlag = true;
		} else {
			overwriteFlag = false;
		}

		if(secId != null && !"".equals(secId)) {
			authInfo = sso.authID(uid, pwd, overwriteFlag, cip, secId);
		} else {
			authInfo = sso.authID(uid, pwd, overwriteFlag, cip);
		}
		
		ret = sso.getLastError();
		
		if (ret == SsoConst.E_SUCCESS) {
			resultMsg = authInfo.getToken();
		}
	}
	
	//-------------------------------------------------------	
	else if (cmd.equals("ms_token")) {
		String putValue = request.getParameter("version");
		String uid = request.getParameter("uid");
		String cip = request.getParameter("cip");

		System.out.println(putValue);
		SsoParser putValueNvds = new SsoParser(putValue);
		String dcd = putValueNvds.search("DeptCD");
		String dnm = putValueNvds.search("DeptName");

		System.out.println(dcd + " : " + dnm);

		sso.putValue("DeptCD", dcd);
		sso.putValue("DeptName", dnm);
		resultMsg = sso.makeSimpleToken(3, uid, "GID_DEMO1", cip);
		ret = sso.getLastError();
	}
	else if (cmd.equals("get_dsd_role_list")) {
		String tok = request.getParameter("tok");
		System.out.println("token : " + tok);
		String cip = request.getParameter("cip");
		System.out.println("cip : " + cip);

		resultMsg = sso.getDSDRoleList(tok, cip);
		ret = sso.getLastError();
	} else if (cmd.equals("auth_service_list_with_role")) {
		String base = request.getParameter("sbase");
		String scope = request.getParameter("scope");
		String tok = request.getParameter("tok");
		String permission = request.getParameter("permission");
		String cip = request.getParameter("cip");
		String userole = request.getParameter("rolesearch");
		boolean role = false;

		if (userole.equalsIgnoreCase("true")) {
			role = true;
		}

		resultMsg = sso.getResourceList(base, scope, tok, permission, cip, role);
		ret = sso.getLastError();
	} else if (cmd.equals("auth_permission_with_role")) {
		String tok = request.getParameter("tok");
		String srdn = request.getParameter("srdn");
		String cip = request.getParameter("cip");
		String userole = request.getParameter("rolesearch");

		boolean role = false;

		if (userole.equalsIgnoreCase("true")) {
			role = true;
		}

		resultMsg = sso.getResourcePermission(srdn, tok, cip, role);
		ret = sso.getLastError();
	} else if (cmd.equals("get_user_role_list")) {
		String tok = request.getParameter("tok");
		String cip = request.getParameter("cip");

		String[] list = sso.getUserRoleList(tok, cip);

		for (String role : list) {
			resultMsg = resultMsg + "*" + role;
		}
		ret = sso.getLastError();
	} else if (cmd.equals("set_dsd_role_list")) {
		String tok = request.getParameter("tok");
		String dsd = request.getParameter("dsd");
		String cip = request.getParameter("cip");

		String[] DSDRoleList = dsd.split("@");

		resultMsg = sso.setDSDRoleList(DSDRoleList, tok, cip);
		ret = sso.getLastError();
	}
	//-------------------------------------------------------	
	else {
		// 알 수 없는 명령이 들어온 경우
		ret = -1;
		resultMsg = "Invalid command";
	}

	//*******************************************************
	// 클라이언트에 보낼 Response 생성
	//*******************************************************

	// Response를 NVDS 형식으로 보내므로, 이에 필요한 NVDS 파서를 생성한다.
	SsoParser parser = new SsoParser();

	// RESULT 태그를 추가한다. (성공했으면 0, 실패했으면 에러코드로 추가된다.)
	parser.add("RESULT", Integer.toString(ret));
	System.out.println("RESULT : " + ret);

	// RESULTMSG 태그를 추가한다.
	if (resultMsg == null && ret < 0) {
		resultMsg = sso.getLastErrorMsg();
	}

	System.out.println("RESULTMSG : " + resultMsg);
	parser.add("RESULTMSG", resultMsg);

	// HTTP의 body로 Response를 클라이언트에게 보낸다.
	//out.println(csEncrypt("RESULT-0*" + request.getQueryString() + "-*"));
	//out.println(csEncrypt(parser.getQuery()));
	//out.println("<sso>" + parser.getQuery() + "</sso>");
	out.println(parser.getQuery());
%>
