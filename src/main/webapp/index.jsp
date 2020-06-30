<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booket List</title>
</head>
<style>
.content {
	width: 1200px;
	overflow: hidden;
	margin: 120px auto 0 auto;
	height: 900px;
	background-color: aliceblue;
}
</style>
<body style="line-height: normal;">
	<div class="wrapper">
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div class="content">

			<c:if test="${not empty sessionScope.member }">

				<!-- Channel Plugin Scripts -->
				<script>
					(function() {
						var w = window;
						if (w.ChannelIO) {
							return (window.console.error || window.console.log || function() {
							})('ChannelIO script included twice.');
						}
						var d = window.document;
						var ch = function() {
							ch.c(arguments);
						};
						ch.q = [];
						ch.c = function(args) {
							ch.q.push(args);
						};
						w.ChannelIO = ch;
						function l() {
							if (w.ChannelIOInitialized) {
								return;
							}
							w.ChannelIOInitialized = true;
							var s = document.createElement('script');
							s.type = 'text/javascript';
							s.async = true;
							s.src = 'https://cdn.channel.io/plugin/ch-plugin-web.js';
							s.charset = 'UTF-8';
							var x = document.getElementsByTagName('script')[0];
							x.parentNode.insertBefore(s, x);
						}
						if (document.readyState === 'complete') {
							l();
						} else if (window.attachEvent) {
							window.attachEvent('onload', l);
						} else {
							window.addEventListener('DOMContentLoaded', l,
									false);
							window.addEventListener('load', l, false);
						}
					})();
					ChannelIO('boot', {
						"pluginKey" : "e1accb0b-c1ed-4d99-8813-52c156de2e18", //please fill with your plugin key
						"memberId" : "${sessionScope.member.memberId }", //fill with user id
						"profile" : {
							"name" : "${sessionScope.member.memberName }", //fill with user name
							"mobileNumber" : "YOUR_USER_MOBILE_NUMBER", //fill with user phone number
							"CUSTOM_VALUE_1" : "VALUE_1", //any other custom meta data
							"CUSTOM_VALUE_2" : "VALUE_2"
						}
					});
				</script>
				<!-- End Channel Plugin -->
			</c:if>
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>

	</div>
</body>
</html>