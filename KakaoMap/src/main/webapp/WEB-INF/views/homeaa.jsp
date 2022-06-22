<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<c:set value="${pageContext.request.contextPath}" var="rootPath" />

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>카카오 </title>
   <style>
.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:1220px;height:700px;}
#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:280px; margin-left:940px; height:inherit;padding:5px;background:rgb(255, 255, 255);z-index: 1;font-size:12px;border-radius: 10px;}
.bg_white {background:#fff;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid rgb(255, 99, 99);margin:3px 0;}
#menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}  
#menu_wrap .option button {margin-left:5px;}
#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#placesList .item .info{padding:10px 0 10px 55px;}
#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:18px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#placesList .item .marker_1 {background-position: 0 -10px;}
#placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;}
#placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;}
#placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;}
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}

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
	width: 940px;
	height: 700px;
}

.around-tour-menu {
	width: 280px;
}
.around-tour-button form{
	width:140px;
}
.around-tour-button {
	height: 80px;
	width: 100%;
	display: flex;
}



.around-tour-button form button {
	width: 100%;
	border: 1px solid rgb(0, 24, 65);
	height: 60px;
	font-size: 24px;
	background-color: #fff;
	cursor: pointer;
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

#placesList .mini-info {
	display: flex;
	justify-content: space-between;
}

#keyword1:hover, #keyword2:hover {
 	color: rgb(255, 99, 99);
 	border-bottom: 5px solid rgb(255, 99, 99);
}

.click{
	color: rgb(255, 99, 99);
	border-bottom: 3px solid rgb(255, 99, 99)!important;
}

</style>
  
</head>
<body>
	<p style="text-align:center;">카카오지도</p>
	<div style="height:1000px;"></div>
		<div class="map_wrap">
			<div id="map"></div>
			<div id="menu_wrap" class="bg_white">
	            <div class="around-tour-button">
	                <form onsubmit="searchPlaces1(); return false;">
	                    <button id="keyword1" type="submit" value="북광주세무서 맛집" >식당</button> 
	                </form>
	                <form onsubmit="searchPlaces2(); return false;">
	                    <button type="submit" value="북광주세무서 숙박" id="keyword2" >숙박</button>
	                 </form> 
	            </div>
	        <hr>
	        <ul id="placesList"></ul>
	        <div id="pagination"></div>
	    </div>
	</div>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=665cdafd23b2d9fb009a5271b16ded99&libraries=services"></script>
<script src="${rootPath}/static/js/kakao-map.js?ver=2022-06-22-008"></script>
<script src="${rootPath}/static/js/btn.js?var=2022-06-15-002"></script>


</body>
</html>