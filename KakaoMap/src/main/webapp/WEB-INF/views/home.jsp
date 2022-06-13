<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set value="${pageContext.request.contextPath}" var="rootPath" />

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>지도 구현</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/js/all.min.js">
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
	width: 350px;
}

.around-tour-button {
	height: 80px;
	width: 100%;
}

.around-tour-button form {
	display: flex;
}

.around-tour-button form button {
	width: 100%;
	border: 1px solid rgb(0, 24, 65);
	height: 60px;
	font-size: 24px;
	background-color: #fff;
}

#placesList {
	overflow: scroll;
	overflow-x: hidden;
	height: 580px;
}

#placesList li {
	list-style: none;
}

#placesList .item {
	position: relative;
	border-bottom: 1px solid #888;
	overflow: hidden;
	cursor: pointer;
	min-height: 65px;
}

#placesList .item span {
	display: block;
	margin-top: 2px;
}

#placesList .item h5, #placesList .item .info {
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}

#placesList .item h5 {
	font-size: 20px;
	color: rgb(0, 24, 65);
}

#placesList .item .info {
	padding: 15px 0 10px 50px;
	margin-bottom: 10px;
}

#placesList .fa-solid {
	margin-right: 8px;
	font-size: 14px;
}

#placesList .info .tel {
	color: #2fa5d4;
	display: inline-block;
}

#placesList .detail-go {
	margin-top: 2px; font-size : 14px;
	padding: 3px 20px;
	background-color: rgb(221, 221, 221);
	color: rgb(0, 24, 65);
	text-decoration: none;
	border-radius: 8px;
	font-size: 14px;
}

#placesList .detail-go:hover {
	background-color: rgb(0, 24, 65);
	color: #fff;
}

/* 마커표시할 위치 값 지정, 없으면 마커가 안뜸 ㅠㅠ */
#placesList .item .markerbg {
	float: left;
	position: absolute;
	width: 36px;
	height: 37px;
	margin: 20px 0 0 10px;
	background:
		url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png)
		no-repeat;
}

#placesList .item .marker_1 {
	background-position: 0 -10px;
}

#placesList .item .marker_2 {
	background-position: 0 -56px;
}

#placesList .item .marker_3 {
	background-position: 0 -102px
}

#placesList .item .marker_4 {
	background-position: 0 -148px;
}

#placesList .item .marker_5 {
	background-position: 0 -194px;
}

#placesList .item .marker_6 {
	background-position: 0 -240px;
}

#placesList .item .marker_7 {
	background-position: 0 -286px;
}

#placesList .item .marker_8 {
	background-position: 0 -332px;
}

#placesList .item .marker_9 {
	background-position: 0 -378px;
}

#placesList .item .marker_10 {
	background-position: 0 -423px;
}

#placesList .item .marker_11 {
	background-position: 0 -470px;
}

#placesList .item .marker_12 {
	background-position: 0 -516px;
}

#placesList .item .marker_13 {
	background-position: 0 -562px;
}

#placesList .item .marker_14 {
	background-position: 0 -608px;
}

#placesList .item .marker_15 {
	background-position: 0 -654px;
}

#pagination {
	margin: 10px auto;
	text-align: center;
}

#pagination a {
	display: inline-block;
	margin-right: 10px;
}

#pagination .on {
	font-weight: bold;
	cursor: default;
	color: #777;
}

.click-btn {
	color: rgb(255, 99, 99);
	border-bottom: 3px solid rgb(255, 99, 99);
}

.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:1220px;height:700px;}
#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px; height:inherit; margin-left:80%;padding:5px;overflow-y:auto;background:rgb(255, 255, 255);z-index: 1;font-size:12px;border-radius: 10px;}
.bg_white {background:#fff;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
#menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}  
#menu_wrap .option button {margin-left:5px;}
</style>

</head>
<body>
	<div class="around-tour-title">
		<h1>주변 관광지</h1>
	</div>
	<div class="around-tour-wrap">
		<div id="map"
			style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>

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
			
		</div>
	
	</div>
	<div id="pagination"></div>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=665cdafd23b2d9fb009a5271b16ded99&libraries=services"></script>
	<script src="${rootPath}/static/js/kakao-map.js?ver=2022-06-10-024"></script>
</body>
</html>