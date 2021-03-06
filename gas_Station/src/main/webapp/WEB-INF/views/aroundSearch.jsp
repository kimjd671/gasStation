<%@page import="com.hk.gas.dtos.GasUserDto"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.hk.gas.utils.Util"%>
<%@page import="java.util.List"%>
<%@page import="com.hk.gas.dtos.BookMarkDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=utf-8"); %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>즐겨찾기</title>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/jejuhallasan.css);
*{box-sizing:border-box;}
html,body{margin:0; width:100%; height:100%; position: absolute; };
#shadow{background: black; width: 100%; height: 100%; position:absolute; display: block; opacity: 0.4;  z-index: 4;}

#container{ width: 100%; height:100%; overflow: hidden; margin: 0 auto; position: relative;}
#main_container{background-color: #3A3A3C; overflow: hidden; width: 100%; height:955px; position: absolute; }
a{color: white;  text-decoration:none;}
ul{list-style: none;}
.back_btn{cursor: pointer;margin: 15px;display: inline; }
.login_logo{font-size: 72px; display: block; width: 90%; margin: 0 auto; color:#dfbe6a; position: relative; font-family: 'Jeju Hallasan', serif; }
.customoverlay {display:block; width: 300px; text-decoration:none;color:#000;text-align:center; bottom:85px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left; font-size:14px;font-weight:bold;overflow:hidden;background: #d95050;background: #d95050 url('image/arrow_white.png') no-repeat right 14px center;}
.customoverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
/* .customoverlay a { border-radius:6px;} */
.customoverlay .title {display:block;text-align:center;background:#fff;margin-right:35px;padding:10px 15px;font-size:14px;font-weight:bold;}
.customoverlay:after {content:'';position:absolute;margin-left:-12px;left:50%;bottom:-12px;width:22px;height:12px;background:url('image/vertex_white.png')}
#gas_info table{color: white;}
.map_b{
width:85%;height:75%; margin: 0 0 0 100px; float: left; 
transition:width 1.2s;
-moz-transition:width 1.2s;
-webkit-transition:width 1.2s;
-o-transition:width 1.2s;
}
.lpg_btn{
	float: right;
}
.btn_mini {
  display: inline-block;
  background: transparent;
  text-transform: uppercase; 
  font-weight: 500; 
  font-style: normal; 
  font-size: 1rem; 
  letter-spacing: 0.3em; 
  color: rgba(223,190,106,0.7);
  border-radius: 0;
  padding: 5px 7% 5px;
  transition: all 0.7s ease-out;
  background: linear-gradient(270deg, rgba(223,190,106,0.8), rgba(146,111,52,0.8), rgba(34,34,34,0), rgba(34,34,34,0));
  background-position: 1% 50%;
  background-size: 300% 300%;
  text-decoration: none;
  margin: 5px 5px 5px 5px;
  border: none;
  border: 1px solid rgba(223,190,106,0.3);
}
.btn_mini:hover {
  color: #fff;
  border: 1px solid rgba(223,190,106,0);
  color: white;
  background-position: 99% 50%;
}
.c_price{ margin-left: 10px; display: block;}
#book_td button{
	width: 100%;
/* 	padding: 5px 30% 5px; */
	margin: 0;
}
</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d5a3febeb4d52aaf0a2bcdd28926d84a&libraries=services,clusterer,drawing"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d5a3febeb4d52aaf0a2bcdd28926d84a"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<%
	Object ldto=session.getAttribute("ldto");
	if(ldto!=null){
		List<BookMarkDto> booklist=(List<BookMarkDto>)request.getAttribute("booklist");

	}

%>
<script type="text/javascript">
	var radius =1000;
	var prodcd="B027";
	var kind="";
	var load_us=false;
	$(function(){
		$("#Progress_Loading").hide();
		document.onkeydown = doNotReload;
		$("#gas_info").hide();
		function doNotReload(){
			if( (event.ctrlKey == true && (event.keyCode == 78 || event.keyCode == 82)) //ctrl+N , ctrl+R 
			|| (event.keyCode == 116)){
			event.keyCode = 0;
			event.cancelBubble = true;
			event.returnValue = false;
			document.location.reload();
			}
		}
		road_map();
		
		
		
	});
	
	function road_map(){
		
		function search_Radius(){
			if(prodcd=="B027"){
				$("#b027btn").css("display","none");
				$("#k015btn").css("display","block");
			}
			if(prodcd=="K015"){
				$("#b027btn").css("display","block");
				$("#k015btn").css("display","none");
			}
			var xy='${xy}';
			var myXY=xy.split("/");
			var pro=$("input[name='prodcd']:checked").val();
			$.ajax({
				url:"http://www.opinet.co.kr/api/aroundAll.do",
				method:"get",
				data:{"out":"json",
					"radius":radius,
					"code":"F339180809",
					"prodcd":prodcd,
					"sort":"1",
					"x":myXY[0],
					"y":myXY[1]
				},
				async:true,
				dataType:"json",
				success:function(Data){
					var rows=Data["RESULT"]["OIL"];
					var jsonArray=new Array();
					for(var i=0; i<rows.length; i++){
						var around_station = new Object();
						around_station.uni_id=rows[i].UNI_ID;
						around_station.name=rows[i].OS_NM;
						around_station.price=rows[i].PRICE;
						around_station.distance=rows[i].DISTANCE;
						around_station.x=rows[i].GIS_X_COOR;
						around_station.y=rows[i].GIS_Y_COOR;
						
						jsonArray.push(around_station);
						}
	 				projection(jsonArray);
	 					
	 			
				},
				error:function(){
					alert("서버통신실패");
				}
			});
		}
		var positions=new Array();
		function projection(Array){
			$.ajax({
				url:"projection.do",
				method:"post",
				data:{"data":JSON.stringify(Array)
				},
				async:true,
				traditional:true,
				dataType:"json",
				success:function(Data){
	 				for(var i=0; i<Data.length;i++){
	 					var pos=new Object();
	 					pos.title=Data[i].name;
	 					pos.latlng= new daum.maps.LatLng(Data[i].x, Data[i].y);
	 					pos.content='  <div class="customoverlay">' +
	 				    '    <span class="title">'+Data[i].name.replace(/\(주\)/gi,"")+'</span>' +
// 	 				    '<span class="title">'+kind+"> "+Data[i].price+'원<span>'+
	 				    '  </div>';
	 					pos.uni_id=Data[i].uni_id;
	 					positions.push(pos);
	 				}
	 				test();
				},
				error:function(){
					alert("서버통신실패");
				}
			});
			
		}
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new daum.maps.LatLng(${x},${y}), // 지도의 중심좌표
		        level: 6 // 지도의 확대 레벨
		    };
		
		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new daum.maps.Map(mapContainer, mapOption); 
		var mapTypeControl = new daum.maps.MapTypeControl();

		// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
		// daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
		map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

		// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
		var zoomControl = new daum.maps.ZoomControl();
		map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);
		
		function setMapType(maptype) { 
		    var roadmapControl = document.getElementById('btnRoadmap');
		    var skyviewControl = document.getElementById('btnSkyview'); 
		    if (maptype === 'roadmap') {
		        map.setMapTypeId(daum.maps.MapTypeId.ROADMAP);    
		        roadmapControl.className = 'selected_btn';
		        skyviewControl.className = 'btn';
		    } else {
		        map.setMapTypeId(daum.maps.MapTypeId.HYBRID);    
		        skyviewControl.className = 'selected_btn';
		        roadmapControl.className = 'btn';
		    }
		}

		// 지도 확대, 축소 컨트롤에서 확대 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
		function zoomIn() {
		    map.setLevel(map.getLevel() - 1);
		}

		// 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
		function zoomOut() {
		    map.setLevel(map.getLevel() + 1);
		}
		var markerPosition  = new daum.maps.LatLng(${x},${y}); 
		// 마커를 생성합니다
		var marker = new daum.maps.Marker({
		    position: markerPosition
		});
		marker.setMap(map);


		// 마커 이미지의 이미지 주소입니다
		var imageSrc = "http://192.168.3.110:8090/gas/image/markerGas.png"; 
		   function test(){
			   for (var i = 0; i < positions.length; i ++) {
				    
				    // 마커 이미지의 이미지 크기 입니다
				    var imageSize = new daum.maps.Size(24, 35); 
				    
				    // 마커 이미지를 생성합니다    
				    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 
				    
				    // 마커를 생성합니다
				    var marker = new daum.maps.Marker({
				        map: map, // 마커를 표시할 지도
				        position: positions[i].latlng, // 마커를 표시할 위치
				        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
				        image : markerImage // 마커 이미지 
				    });
				    var infowindow = new daum.maps.InfoWindow({
				        content: positions[i].content // 인포윈도우에 표시할 내용
				    });
				    
				    daum.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
				    daum.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow,marker));
				    daum.maps.event.addListener(marker, 'click', makeInfomation(map,marker,infowindow,positions[i].uni_id));
				}
		   }
		
		 
		   
	   function makeOverListener(map, marker, infowindow) {
		    return function() {
		    	markerZIndex =marker.getZIndex();
		    	infowindowZIndex=infowindow.getZIndex();
		    	marker.setZIndex(999);
		    	infowindow.setZIndex(999);
		        infowindow.open(map, marker);
		        $(".customoverlay").parent("div").parent("div").css({"border":"none",'width': '10px','height': '10px',});
		    };
		}
	   function panTo() {
		    // 이동할 위도 경도 위치를 생성합니다 
		    var moveLatLon = new daum.maps.LatLng(${x},${y});
		    
		    // 지도 중심을 부드럽게 이동시킵니다
		    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
		    map.panTo(moveLatLon);            
		}    
	   function numberWithCommas(x) {  
	    	return x.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
	   function makeInfomation(map,marker,infowindow,uid){
		   return function	() {
			   $.ajax({
					url:"http://www.opinet.co.kr/api/detailById.do",
					method:"get",
					data:{"out":"xml",
						"code":"F339180809",
						"id":uid
					},
					async:false,
					success:function(Data){
						
						var l_t=1200;
						$(".map_b").css("width","55%");
						setTimeout(function() {
							$("#gas_info").fadeIn();
							if(load_us==false){		
								$("#map").empty();
								road_map();
								load_us=true;
							}
						var oil=$(Data).find("OIL");
						var uni_code=oil.children().eq(0).text();
						var i=3;
						var name=oil.children().eq(i++).text().replace(/\(주\)/gi,"");
						var old_adr=oil.children().eq(i++).text();
						var new_adr=oil.children().eq(i++).text().replace(/특별시/gi,"");;
						var tel=oil.children().eq(i++).text(); //전화번호
				     	var sigun=oil.children().eq(i++).text();
						var category=oil.children().eq(i++).text();
						var maint=oil.children().eq(i++).text();
						var wash=oil.children().eq(i++).text();
						var cvs=oil.children().eq(i++).text();

						var oil_price=$(Data).find("OIL_PRICE");
						var d_oil=0;
						var d_die=0;
						var d_lpg=0;
						$("#d_oil").empty();
						$("#d_die").empty();
						$("#d_lpg").empty();
						for(var j=0;j<oil_price.length;j++){
							if(oil_price.eq(j).find("PRODCD").text()=="B027"){
								$("#d_oil").text(numberWithCommas(oil_price.eq(j).find("PRICE").text()));
								d_oil=oil_price.eq(j).find("PRICE").text();
							}else if(oil_price.eq(j).find("PRODCD").text()=="D047"){
								$("#d_die").text(numberWithCommas(oil_price.eq(j).find("PRICE").text()));
								d_die=oil_price.eq(j).find("PRICE").text();
							}
							if(oil_price.eq(j).find("PRODCD").text()=="K015"){
								$("#d_lpg").text(numberWithCommas(oil_price.eq(j).find("PRICE").text()));
								d_lpg=oil_price.eq(j).find("PRICE").text();
							}
						}
						
						$("#book_td").empty();
						var book_use = true;
						var book_Array=new Array();
						var book='${booklist}';
						book_Array=book.split("BookMarkDto");
						if('${booklist[0].uni_id}'!=''){
							for(var q=0; q<book_Array.length;q++){
								if(book_Array[q].indexOf(uni_code)>0){
										book_use=false;
										break;
								}	
							}
						}
						if(book_use){
							$("#book_td").append("<button class='btn_mini' onclick='insert_bookmark("+'"'+uni_code+'"'+","+'"'+name+'"'+","+'"'+old_adr+'"'+","+'"'+d_oil+'"'+","+'"'+d_die+'"'+","+'"'+d_lpg+'"'+")'>즐겨찾기 등록</button>");
						}else {
							$("#book_td").append("<button class='btn_mini'>이미등록된 주유소</button>");
							
						}
						
						if($("#d_oil").text()==""){
							$("#d_oil").text("-");
						}
						if($("#d_die").text()==""){
							$("#d_die").text("-");
						}
						if($("#d_lpg").text()==""){
							$("#d_lpg").text("-");
						}
						
						$("#maint_ny").empty();
						$("#wash_ny").empty();
						$("#cvs_ny").empty();
						if(maint=="N"){
							$("#maint_ny").text("X");
						}else {
							$("#maint_ny").text("O");
						}
						if(wash=="N"){
							$("#wash_ny").text("X");
						}else {
							$("#wash_ny").text("O");
						}
						if(cvs=="N"){
							$("#cvs_ny").text("X");
						}else {
							$("#cvs_ny").text("O");
						}
						
						$("#u_name").text(name);
						$("#o_adr").text(old_adr);
						$("#n_adr").text(new_adr);
						$("#tel").text(tel);
						l_t=100;
						
						}, l_t)
// 						alert("이름:"+name+
// 								"\n옛주소:"+old_adr+
// 								"\n신주소:"+new_adr+
// 								"\n전화번호:"+tel+
// 								"\n업종:"+category+
// 								"\n정비소:"+maint+
// 								"\n세차장:"+wash+
// 								"\n편의점:"+cvs+
// 								"\n품질인증:"+kpetro);
					},
					error:function(){
						alert("서버통신실패");
					}
				});
		};
	   }
	   

		// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
		function makeOutListener(infowindow,marker) {
		    return function() {
		    	marker.setZIndex(markerZIndex);
		    	infowindow.setZIndex(infowindowZIndex);
		        infowindow.close();
		    };
		}
		
		
		
		var circle = new daum.maps.Circle({
		    center : new daum.maps.LatLng(${x},${y}),  // 원의 중심좌표 입니다 
		    radius: radius, // 미터 단위의 원의 반지름입니다 
		    strokeWeight: 1, // 선의 두께입니다 
		    strokeColor: '#75B8FA', // 선의 색깔입니다
		    strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
		    strokeStyle: 'solid', // 선의 스타일 입니다
		    fillColor: '#CFE7FF', // 채우기 색깔입니다
		    fillOpacity: 0.5 // 채우기 불투명도 입니다   
		}); 

		// 지도에 원을 표시합니다 
		circle.setMap(map); 
		search_Radius();
		radi_button_chk();
		}
	//반경검색
	function radi_button_chk(){
		if(radius=="1000"){
			$(".radi_btn").eq(0).prop("disabled",true);
			$(".radi_btn").eq(1).prop("disabled",false);
			$(".radi_btn").eq(2).prop("disabled",false);
		}else if(radius=="2000"){
			$(".radi_btn").eq(0).prop("disabled",false);
			$(".radi_btn").eq(1).prop("disabled",true);
			$(".radi_btn").eq(2).prop("disabled",false);
		}else if(radius=="3000"){
			$(".radi_btn").eq(0).prop("disabled",false);
			$(".radi_btn").eq(1).prop("disabled",false);
			$(".radi_btn").eq(2).prop("disabled",true);
		}
	}
	function change_radius(radi){
		radius=radi;
		$("#map").empty();
		road_map();
	}
	function change_prodcd(procd){
		prodcd=procd;
		$("#map").empty();
		road_map();
	}
	function insert_bookmark(uni_code,name,adr,oil,die,lpgs){
		var id='${ldto.id}';
		if(id==null||id==""){
		alert("로그인을 해주세요");
		}else{
			
			
			var uni_id=uni_code;
			var b_name=name;
			var addr=adr;
			var gas=oil;
			var diesel=die;
			var lpg=lpgs;
			$.ajax({
				url:"bookmark_insert.do",
				method:"get",
				data:{"id":id,
					"b_name":b_name,
					"location":addr,
					"gasoline":gas,
					"diesel":diesel,
					"lpg":lpg,
					"uni_id":uni_id
				},
				async:false,
				dataType:"json",
				success:function(Data){
					var isS=Data["isS"];
					if(isS){
						alert("즐겨찾기가 등록되었습니다.");
						$("#book_td").empty();
						$("#book_td").append("<button class='btn_mini'>이미등록된 주유소</button>");
					}else{
						alert("실패/시스템오류");
					}	
				},
				error:function(){
					alert("서버통신실패");
				}
			});
			
		}
// 		alert(uni_code+"/"+name+"/"+adr+"/"+oil+"/"+die+"/"+lpg);
	}
</script>
</head>
<body>
<div id ="Progress_Loading" style="position: absolute; z-index: 6; width: 100%;"><!-- 로딩바 -->
	<img src="image/gugun/loading.gif" style="display: block; top:30%;left:50%;  transform: translate(-50%, -50%);  position: fixed;"/>
</div>
<div id="container">	
	<div id="main_container" > 
		<img class='back_btn' src='image/back.png' alt='돌아가기' onclick='parent.call_main_container_around()'>
		<div id="logo" style="margin: 0 auto; width: 66%;  text-align: center;display: inline-block; left: 40%; position: relative; transform: translate(-50%,-50%); ">
			<span class='login_logo'>주변 주유소 찾기</span>
		</div>
		<div id="radi_ctrl" style="width:85%; margin: 0 0 0 100px;">
				<button class="btn_mini radi_btn" onclick="change_radius('1000')">1000m</button> 
				<button class="btn_mini radi_btn" onclick="change_radius('2000')">2000m</button>
				<button class="btn_mini radi_btn" onclick="change_radius('3000')">3000m</button>
				<button class="btn_mini lpg_btn" id="k015btn" onclick="change_prodcd('K015')">LPG충전소</button>
				<button class="btn_mini lpg_btn" id="b027btn" onclick="change_prodcd('B027')">일반 주유소</button>
		</div>
		<div id="map" class="map_b">
		</div>
		<div id="gas_info" style="float: left; height: 68%; width: 35%; ">
			<div style="width: 100%; height: 100%;">
			<table id="gas_info_table" border="1" style="border-collapse:collapse; border:1px solid white; line-height: 40px; position: relative; top: 100px; margin: 0 auto;">
				<col width="120px">
				<col width="380px">
				<tr>
					<th>주유소 이름</th>
					<td><span id="u_name" class="c_price"></span></td>
				</tr>
				<tr>
					<th>주소</th>
					<td><span id="o_adr" class="c_price"></span></td>
				</tr>
				<tr>
					<th>새주소</th>
					<td><span id="n_adr" class="c_price"></span></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td><span id="tel" class="c_price"></span></td>
				</tr>
				<tr>
					<th>가격정보</th>
					<td>
						<table class="info_table" border="1" style="border-collapse: collapse; border:1px solid white; width: 100%;" >
							<col width="70px">
							<tr>
								<th>휘발유</th>
								<td><span class="c_price" id="d_oil"></span> </td>
							</tr>
							<tr>
								<th>경유</th>
								<td><span class="c_price" id="d_die"></span></td>
							</tr>
							<tr>
								<th>LPG</th>
								<td><span class="c_price" id="d_lpg"></span></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<th colspan="2">편의시설여부</th>
				</tr>
				<tr>
					<td id="cvs" colspan="2">
						<table class="info_table" border="1" style="border-collapse: collapse; border:1px solid white; width: 100%; text-align: center;">
							<tr>
								<th>세차장</th>
								<th>편의점</th>
								<th>정비소</th>
							</tr>
							<tr>
								<td id="wash_ny"></td>
								<td id="cvs_ny"></td>
								<td id="maint_ny"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2" id="book_td"></td>
				</tr>
			</table>
			</div>
		
		</div>
	</div>
</div>
</body>
</html>