//모바일 인지 확인
	function getMobileCheck() {
		var filter = "win16|win32|win64|mac";
		
		if(filter.indexOf(navigator.platform.toLowerCase()) < 0) {
			//mobile
			if(navigator.platform.toLowerCase().indexOf('iphone') > -1 || navigator.platform.toLocaleLowerCase().indexOf('ipad') > -1) {
				return 'ios';
			//안드로이드는 경우의 수가 많음
//				} else if(navigator.platform.toLowerCase().indexOf('android') > -1) {
			}else {
				return 'android';
			}
		} else {
			//pc
			if(navigator.platform.toLowerCase().indexOf('win') > -1) {
				return 'windows';
			}else {
				return 'mac';
			}
		}
	}

	//브라우저 버전 체크
	function getBrowserType() {
		var _ua = navigator.userAgent;
		/* IE7,8,9,10,11 */
		if (navigator.appName == 'Microsoft Internet Explorer') {
			var rv = -1;
			var trident = _ua.match(/Trident\/(\d.\d)/i);

			//ie11에서는 MSIE토큰이 제거되고 rv:11 토큰으로 수정됨 (Trident표기는 유지)
			if (trident != null && trident[1] == "7.0")
				return rv = "IE" + 11;
			if (trident != null && trident[1] == "6.0")
				return rv = "IE" + 10;
			if (trident != null && trident[1] == "5.0")
				return rv = "IE" + 9;
			if (trident != null && trident[1] == "4.0")
				return rv = "IE" + 8;
			if (trident == null)
				return rv = "IE" + 7;

			var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
			if (re.exec(_ua) != null)
				rv = parseFloat(RegExp.$1);
			return rv;
		}

		/* etc */
		var agt = _ua.toLowerCase();
		if (agt.indexOf("chrome") != -1)
			return 'Chrome';
		if (agt.indexOf("opera") != -1)
			return 'Opera';
		if (agt.indexOf("staroffice") != -1)
			return 'Star Office';
		if (agt.indexOf("webtv") != -1)
			return 'WebTV';
		if (agt.indexOf("beonex") != -1)
			return 'Beonex';
		if (agt.indexOf("chimera") != -1)
			return 'Chimera';
		if (agt.indexOf("netpositive") != -1)
			return 'NetPositive';
		if (agt.indexOf("phoenix") != -1)
			return 'Phoenix';
		if (agt.indexOf("firefox") != -1)
			return 'Firefox';
		if (agt.indexOf("safari") != -1)
			return 'Safari';
		if (agt.indexOf("skipstone") != -1)
			return 'SkipStone';
		if (agt.indexOf("netscape") != -1)
			return 'Netscape';
		if (agt.indexOf("mozilla/5.0") != -1)
			return 'Mozilla';
	}