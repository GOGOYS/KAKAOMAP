<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<c:set value="${pageContext.request.contextPath}" var="rootPath" />

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>카카오 - 현재 GPS상에서 반경2km 이내의 업체들 거리, 도보/자전거 이동시간 구하기</title>
   <style>
.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:1220px;height:700px;}
#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin-left:80%;padding:5px;overflow-y:auto;background:rgb(255, 255, 255);z-index: 1;font-size:12px;border-radius: 10px;}
.bg_white {background:#fff;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
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
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
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
</style>
  
</head>
<body>
<p style="text-align:center;">카카오지도 - 현재 GPS 상에서 반경 2km 이내의 업체들 거리, 도보/자전거 이동시간 구하기</p>
<div class="map_wrap">
<div id="map" style="width:100%;height:500px;"></div>
<div id="menu_wrap" class="bg_white">
	        <div class="option">
	            <div>
	                <form onsubmit="searchPlaces(); return false;">
	                    키워드 : <input type="text" value="이태원 맛집" id="keyword" size="15"> 
	                    <button type="submit">검색하기</button> 
	                </form>
	            </div>
	        </div>
	        <hr>
	        <ul id="placesList"></ul>
	        <div id="pagination"></div>
	    </div>
	    </div>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=665cdafd23b2d9fb009a5271b16ded99&libraries=services"></script>
<script>
var mapContainer = document.getElementById("map");

var latlngyo = new kakao.maps.LatLng(35.160028805690565,126.91016363439223);// 좌표값 지도변수에 담기
var mapOption = {
  center: latlngyo, // 지도의 중심좌표지정
        level: 5      // 지도의 확대 레벨 지정
 };
var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성
var circle = new kakao.maps.Circle({
    map: map,
    center : latlngyo,
    radius: 2000,
    strokeWeight: 10,
    strokeColor: '#ff1100',
    strokeOpacity: 0.8,
    strokeStyle: 'solid',
    fillColor: '#ffd2cf',
    fillOpacity: 0.3
});// 지도 반경의 원 생성
var marker = new kakao.maps.Marker({
 position: latlngyo, // 마커의 좌표
 title: "지도의 중심 한국경영원",
 map: map         // 마커를 표시할 지도 객체
});
var arr = new Array(); //마커들의 배열
arr[0] = ["a1",35.16101409549979, 126.90790152368493, "a1"];
arr[1] = ["a2",35.160856044206554, 126.90749010785005, "a2"];
arr[2] = ["a3",35.15982824767272,126.91324802717773, "a3"];
arr[3] = ["a4",35.15826824286665,126.90631865999285, "a4"];
arr[4] = ["테스트5",35.156413809479545,126.90943226732321, "a5"];
var markerTmp;      // 마커
var polyLineTmp;    // 두지점간 직선거리
var distanceArr = new Array();
var distanceStr = "";
var walkkTime = 0;
var walkHour = "", walkMin = "";

for (var i=0;i<arr.length;i++) {
	
    markerTmp = new kakao.maps.Marker({
        position: new kakao.maps.LatLng(arr[i][1],arr[i][2]),
        title: arr[i][0],
        map:map
    }); // 지도에 마커 표시하기
    
    polyLineTmp = new kakao.maps.Polyline({
        map: map,
        path: [
            latlngyo, new kakao.maps.LatLng(arr[i][1],arr[i][2])
        ],
        strokeWeight: 2,   
        strokeColor: '#FF00FF',
   		strokeOpacity: 0.8,
   		strokeStyle: 'dashed'
    }); // 중심좌표와 거리표시하기
    
    
    
    
    
    
    
 
}
</script>


</body>
</html>