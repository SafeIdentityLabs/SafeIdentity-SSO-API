# Overview

모바일 SSO를 연동하기 위해서 아래와 같이 3개의 프로젝트가 제공 됩니다.



[SafeIdentity-SSO-API](https://github.com/SafeIdentityLabs/SafeIdentity-SSO-API)

모바일에서 SSO 인증하기 위한 API를 제공합니다. 먼저 서버에 설치가 되어 있어야 다음 단계를 진행 할수 있습니다.

[SafeIdentity-SSO-Android-Sample](https://github.com/SafeIdentityLabs/SafeIdentity-SSO-Android-Sample)

안드로이드 샘플 코드를 제공합니다.

[SafeIdentity-SSO-iOS-Sample](https://github.com/SafeIdentityLabs/SafeIdentity-SSO-iOS-Sample)

아이폰 샘플 코드를 제공합니다.


# SafeIdentity-SSO-API

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
