<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<c:set value="${pageContext.request.contextPath}" var="rootPath" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>지도</h1>
	<%--  <%@ include file="/WEB-INF/views/mapjs.jsp" %>--%>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b801ddbd49c9b14fef4051c9f7807b4f"></script>
	
<div id="map" style="width:500px;height:400px;"></div>
		
		
<script>
var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
var options = { //지도를 생성할 때 필요한 기본 옵션
	center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
	level: 3 //지도의 레벨(확대, 축소 정도)
};

var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

</script>
	
	
</body>
</html>