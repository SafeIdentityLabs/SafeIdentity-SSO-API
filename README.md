# SecureOn-SSO-API

모바일앱에서 호출하여 사용되는 웹페이지를 구성한 웹프로젝트이다.

jQuery, jQueryMobile을 사용하였고 SafeIdentity Server API가 lib로 추가 되어있다. url scheme이 틀리기 때문에 ios, android 소스는 구분되어져 있다. web 프로젝트라 특별히 소스 설명은 없고 파일 역할만 설명한다.

## exp_mobilesso.jsp

해당 jsp에서는 cmd로 사용을 위한 API 명을 입력받고 웹에서 SI 서버 API를 호출 후 결과 값을 리턴하는 구조이다.

## msso_auth_id_smaple.jsp

로그인 페이지로 ssoToken이 파라미터로 있는 경우 자동 로그인 처리 및 authID 처리

## msso_web_sample.jsp

모바일 앱 호출 및 로그아웃(unregsession)을 처리하는 페이지

## mobilesso_web1.jsp

기존 샘플에서 사용한 페이지

## mobilesso_web2.jsp

기존 샘플에서 사용한 페이지
