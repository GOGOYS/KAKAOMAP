<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set value="${pageContext.request.contextPath}" var="rootPath" />

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>카카오 - 현재 GPS상에서 반경2km 이내의 업체들 거리, 도보/자전거 이동시간 구하기</title>
<style>
* {
	padding: 0;
	margin: 0;
	list-style: none;
}

.around-tour-title {
	border-bottom: 3px solid rgb(255, 99, 99);
	width: 1220px;
	margin: 0 auto;
}

.around-tour-title h1 {
	text-align: center;
	margin-top: 30px;
}

.around-tour-wrap {
	width: 1220px;
	height: 700px;
	display: flex;
	margin: 20px auto 0;
	justify-content: space-between;
}

#map {
	width: 620px;
	height: 700px;
}

.around-tour-menu {
	width: 400px;
}

.around-tour-button {
	height: 100px;
	display: flex;
	width: 100%;
}


.around-tour-button form button {
	width: 100%;
	border: none;
}

#placesList {
	overflow: scroll;
	overflow-x: hidden;
}
</style>

</head>
<body>
	<div class="around-tour-title">
		<h1>주변 관광지</h1>
	</div>
	<div class="around-tour-wrap">
		<div id="map"
			style="width: 80%; height: 100%; position: relative; overflow: hidden;"></div>

		<div class="around-tour-menu">
			<div class="around-tour-button">
					<form onsubmit="searchPlaces(); return false;">
						<button onclick="food()" type="submit" value="서울월드컵경기장 식당"
							id="keyword1">식당</button>
						<button onclick="bad()" type="submit" value="서울월드컵경기장 숙박"
							id="keyword2">숙박</button>
					</form>
			</div>

			<ul id="placesList"></ul>
			<div id="pagination"></div>
		</div>
	</div>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=665cdafd23b2d9fb009a5271b16ded99&libraries=services"></script>
	<script src="${rootPath}/static/js/map.js?ver=2022-06-10-006"></script>
</body>
</html>