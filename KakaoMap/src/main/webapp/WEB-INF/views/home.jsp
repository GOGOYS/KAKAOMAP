<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<c:set value="${pageContext.request.contextPath}" var="rootPath" />

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>카카오 - 현재 GPS상에서 반경2km 이내의 업체들 거리, 도보/자전거 이동시간 구하기</title>
</head>
<body>
<p style="text-align:center;">카카오지도 - 현재 GPS 상에서 반경 2km 이내의 업체들 거리, 도보/자전거 이동시간 구하기</p>

<div id="map" style="width:100%;height:500px;"></div>
<div id="coordXY"></div>
<div id="distance"></div>

<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=665cdafd23b2d9fb009a5271b16ded99"></script>
<script>
var mapContainer = document.getElementById("map");
var coordXY   = document.getElementById("coordXY");
var distanceGap  = document.getElementById("distance");



var x =  35.160028805690565;  // 현재 GPS x좌표
var y = 126.91016363439223;  // 현재 GPS y좌표
var radius = 2000;      // 반경 미터(m), 2km 지정



var latlngyo = new kakao.maps.LatLng(x, y);// 좌표값 지도변수에 담기
var mapOption = {
  center: latlngyo, // 지도의 중심좌표지정
        level: 5      // 지도의 확대 레벨 지정

 };



var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성



var circle = new kakao.maps.Circle({
    map: map,
    center : latlngyo,
    radius: radius,
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
    });



    polyLineTmp = new kakao.maps.Polyline({
        map: map,
        path: [
            latlngyo, new kakao.maps.LatLng(arr[i][1],arr[i][2])
        ],
        strokeWeight: 2,   
        strokeColor: '#FF00FF',
   strokeOpacity: 0.8,
   strokeStyle: 'dashed'
    });


}


</script>
</body>
</html>