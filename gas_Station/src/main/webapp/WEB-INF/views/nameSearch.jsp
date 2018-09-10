<%@page import="com.hk.gas.dtos.GasUserDto"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.hk.gas.utils.Util"%>
<%@page import="java.util.List"%>
<%@page import="com.hk.gas.dtos.BookMarkDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>즐겨찾기</title>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/jejuhallasan.css);
*{box-sizing:border-box;}
html,body{margin:0; width:100%; height:100%; position: absolute;};
#shadow{background: black; width: 100%; height: 100%; position:absolute; display: block; opacity: 0.4;  z-index: 4;}
*>div{color: white; border-color: white; margin: 2px;}

#container{ width: 100%; height:100%; overflow: hidden; margin: 0 auto; position: relative;}
#main_container{background-color: #3A3A3C; overflow: hidden; width: 100%; height:955px; position: absolute; }
a{color: white;  text-decoration:none;}
ul{list-style: none;}

.customoverlay {display:block; width: 300px; text-decoration:none;color:#000;text-align:center; bottom:85px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left; font-size:14px;font-weight:bold;overflow:hidden;background: #d95050;background: #d95050 url('image/arrow_white.png') no-repeat right 14px center;}
.customoverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
/* .customoverlay a { border-radius:6px;} */
.customoverlay .title {display:block;text-align:center;background:#fff;margin-right:35px;padding:10px 15px;font-size:14px;font-weight:bold;}
.customoverlay:after {content:'';position:absolute;margin-left:-12px;left:50%;bottom:-12px;width:22px;height:12px;background:url('image/vertex_white.png')}
.back_btn{cursor: pointer;margin: 15px;display: inline;}
.login_logo{font-size: 72px; display: block; width: 90%; margin: 0 auto; color:#dfbe6a; position: relative; font-family: 'Jeju Hallasan', serif; }
.find_list{
	width: 100%;
	line-height: 50px;
	margin: 3px auto;
	text-align: center;
	cursor: pointer;
	 display: inline-block;
	  background: transparent;
	  text-transform: uppercase; 
	  font-weight: 500; 
	  font-style: normal; 
	  font-size: 1rem; 
	  letter-spacing: 0.3em; 
	  color: rgba(223,190,106,0.7);
	  border-radius: 0;
	  padding: 3px 5% 3px;
	  transition: all 0.7s ease-out;
	  background: linear-gradient(270deg, rgba(223,190,106,0.8), rgba(146,111,52,0.8), rgba(34,34,34,0), rgba(34,34,34,0));
	  background-position: 1% 50%;
	  background-size: 300% 300%;
	  text-decoration: none;
	  border: none;
	  border: 1px solid rgba(223,190,106,0.3);
}
.find_list:hover {
	color: #fff;
  border: 1px solid rgba(223,190,106,0);
  color: white;
  background-position: 99% 50%;
}

::-webkit-scrollbar{display:none;}
::-moz-scrollbar{display: none;}


.btn_mini {
	cursor: pointer;
  display: inline-block;
  background: transparent;
  text-transform: uppercase; 
  font-weight: 500; 
  font-style: normal; 
  font-size: 1rem; 
  letter-spacing: 0.3em; 
  color: rgba(223,190,106,0.7);
  border-radius: 0;
  padding: 13px 5% 15px;
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
</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d5a3febeb4d52aaf0a2bcdd28926d84a&libraries=services,clusterer,drawing"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d5a3febeb4d52aaf0a2bcdd28926d84a"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(function(){
		$("#Progress_Loading").hide();
		document.onkeydown = doNotReload;
		mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new daum.maps.LatLng(${x},${y}), // 지도의 중심좌표
	        draggable: false,
	        level: 11// 지도의 확대 레벨
	        
	    };
	
		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		map = new daum.maps.Map(mapContainer, mapOption); 
		
		
		function doNotReload(){
			if( (event.ctrlKey == true && (event.keyCode == 78 || event.keyCode == 82)) //ctrl+N , ctrl+R 
			|| (event.keyCode == 116)){
			event.keyCode = 0;
			event.cancelBubble = true;
			event.returnValue = false;
			document.location.reload();
			}
		}
		var l_a='${sido}';
		var l_sigun='${sido}'+'${gugun}';
		var sel_name="${s_name}";
		$("#gas_detail").fadeOut();
		
		$("#sido_selbar option[value="+l_a+"]").attr("selected",true);
		$.ajax({
			url:"http://www.opinet.co.kr/api/areaCode.do",
			method:"get",
			data:{"out":"json",
				"code":"F339180809",
				"area":l_a
			},
			async:false,
			dataType:"json",
			success:function(Data){
				var rows=Data["RESULT"]["OIL"];
				$("#gugun_selbar").empty();
				$("#gugun_selbar").append("<option value='no'>선택안함</option>");
				for(var i=0;i<rows.length;i++){
					area_cd=rows[i].AREA_CD;
					if(area_cd==l_sigun){
						$("#gugun_selbar").append("<option value='"+rows[i].AREA_CD+"' selected>"+rows[i].AREA_NM+"</option>");
					}else{
						$("#gugun_selbar").append("<option value='"+rows[i].AREA_CD+"'>"+rows[i].AREA_NM+"</option>");
					}
 				}
				if(sel_name!=""){
					$("#b_name").val(sel_name);
					nameSearch();
					
					
					
				}
			},
			error:function(){
				alert("서버통신실패");
			}
		});
		
		
		function setDraggable(draggable) {
		    // 마우스 드래그로 지도 이동 가능여부를 설정합니다
		    map.setDraggable(draggable);    
		}
		function setZoomable(zoomable) {
		    // 마우스 휠로 지도 확대,축소 가능여부를 설정합니다
		    map.setZoomable(zoomable);    
		}
		setZoomable(true);
		
		var mapTypeControl = new daum.maps.MapTypeControl();

		// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
		// daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
		map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

		// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
		var zoomControl = new daum.maps.ZoomControl();
		map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);
		
		
		 
	});
	var map=null;
	var mapContainer=null;
	var get_x="";
	var get_y="";
	var area_cd=null;
	var out="json";
	var code="F339180809";
	function sidosel(aa){
		var area=$("#sido_selbar option:selected").val();
		$.ajax({
			url:"http://www.opinet.co.kr/api/areaCode.do",
			method:"get",
			data:{"out":out,
				"code":code,
				"area":area
			},
			async:false,
			dataType:"json",
			success:function(Data){
				var rows=Data["RESULT"]["OIL"];
				$("#gugun_selbar").empty();
				$("#gugun_selbar").append("<option value='no' selected>선택안함</option>");
				for(var i=0;i<rows.length;i++){
					area_cd=rows[i].AREA_CD;
 					$("#gugun_selbar").append("<option value='"+rows[i].AREA_CD+"'>"+rows[i].AREA_NM+"</option>");
				}
			},
			error:function(){
				alert("서버통신실패");
			}
		});
	}
	function enterkey() {
        if(window.event.keyCode == 13) {
             nameSearch();
        }
	}
	
	function nameSearch(){
		var s_name=$("#b_name").val();
		if(s_name.length<2){
			alert("검색어는 최소2자이상 입력해주세요.");
		}else{		
			var area=$("#sido_selbar option:selected").val();
			var gugun=$("#gugun_selbar option:selected").val();
			$.ajax({
				url:"http://www.opinet.co.kr/api/searchByName.do",
				method:"get",
				data:{"out":out,
					"code":code,
					"osnm":s_name,
					"area":area
				},
				async:false,
				dataType:"json",
				success:function(Data){
					var rows=Data["RESULT"]["OIL"];
					$("#list").empty();
					for(var i=0;i<rows.length;i++){
						if(rows[i].SIGUNCD==gugun){
							$("#list").append("<div class='find_list' id='"+rows[i].UNI_ID+"' onclick='load_station(this)' title='"+rows[i].OS_NM+"'>"+
									"<span>"+rows[i].OS_NM+""+
									"<input type='hidden' name='"+rows[i].UNI_ID+"_x' value="+rows[i].GIS_X_COOR+">"+
									"<input type='hidden' name='"+rows[i].UNI_ID+"_y' value="+rows[i].GIS_Y_COOR+">"+
									"</div>");
							
						}
					}
					var nn="${s_name}";
					if(nn!=""){
						var x=rows[0].GIS_X_COOR;
						var y=rows[0].GIS_Y_COOR;
						$.ajax({
							url:"projection_one.do",
							method:"get",
							data:{
								"x":x,
								"y":y
							},
							dataType:"json",
							async:false,
							success:function(data){
								get_x=data["x"];
								get_y=data["y"];
								panTo(get_x,get_y);
								setMarker(get_x,get_y,rows[0].UNI_ID,rows[0].OS_NM);	
							},
							error:function(){
								alert("서버통신실패");
							}
						});
					}
					
				},
				error:function(){
					alert("서버통신실패");
				}
			});
		}
	}
	function panTo(x,y) {
	    // 이동할 위도 경도 위치를 생성합니다 
	    var moveLatLon = new daum.maps.LatLng(x,y);
	    map.setLevel(3);
	    // 지도 중심을 부드럽게 이동시킵니다
	    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
	    map.panTo(moveLatLon);
	   
	}  
	var marker=null;
	function setMarker(x,y,id,name){
		var imageSrc = "http://192.168.3.111:8090/gas/image/markerGas.png";
		var imageSize = new daum.maps.Size(24, 35); 
	    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 
		if(marker!=null){
			marker.setMap(null);
			var markerPosition  = new daum.maps.LatLng(x,y); 
			marker = new daum.maps.Marker({
				map: map,
			    position: markerPosition,
			    image : markerImage
			});
			
			marker.setMap(map);
		}else{
			var markerPosition  = new daum.maps.LatLng(x,y); 
			marker = new daum.maps.Marker({
				map: map,
			    position: markerPosition,
			    image : markerImage
			});
			
			marker.setMap(map);
		}
		var pcontent=new Array();
		var pos=new Object();
		pos.uni_id=id;
		pos.content='  <div class="customoverlay">' +
		    '<span class="title">'+name.replace(/\(주\)/gi,"")+'</span>' +
		    '</div>';
		pcontent.push(pos);
		var infowindow = new daum.maps.InfoWindow({
	        content: pcontent[0].content // 인포윈도우에 표시할 내용
	    });
	    
	    daum.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
	    daum.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow,marker));
	    daum.maps.event.addListener(marker, 'click', makeInfomation(map,marker,infowindow,pcontent[0].uni_id));
		
		
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
							$("#book_td").append("<button class='btn_mini' onclick='insert_bookmark("+'"'+uni_code+'"'+","+'"'+name+'"'+","+'"'+old_adr+'"'+","+'"'+d_oil+'"'+","+'"'+d_die+'"'+","+'"'+d_lpg+'"'+")'>즐겨찾기 등록</button><button class='btn_mini' style='width:40%;float: right;' onclick='close_detail()'>닫기</button>");
						}else {
							$("#book_td").append("<button class='btn_mini'>이미등록된 주유소</button><button class='btn_mini' style='width:40%;float: right;' onclick='close_detail()'>닫기</button>");
							
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
						$("#list").fadeOut();
						$("#gas_detail").fadeIn();
					},
					error:function(){
						alert("서버통신실패");
					}
				});
		};
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
							$("#book_td").append("<button class='btn_mini'>이미등록된 주유소</button><button class='btn_mini' style='width:40%;float: right;'  onclick='close_detail()'>닫기</button>");
						}else{
							alert("실패/시스템오류");
						}	
					},
					error:function(){
						alert("서버통신실패");
					}
				});
				
			}
//	 		alert(uni_code+"/"+name+"/"+adr+"/"+oil+"/"+die+"/"+lpg);
		}
	  function close_detail(){
		  $("#gas_detail").fadeOut();
		  $("#list").fadeIn();
	  }
	  
		// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
		function makeOutListener(infowindow,marker) {
		    return function() {
		    	marker.setZIndex(markerZIndex);
		    	infowindow.setZIndex(infowindowZIndex);
		        infowindow.close();
		    };
		}
		function numberWithCommas(x) {  
	    	return x.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
	function load_station(li){
		var id=li.id;
		var name=li.title;
		var x=$("input[name="+id+"_x]").val();
		var y=$("input[name="+id+"_y]").val();
		$.ajax({
			url:"projection_one.do",
			method:"get",
			data:{
				"x":x,
				"y":y
			},
			dataType:"json",
			async:false,
			success:function(data){
				get_x=data["x"];
				get_y=data["y"];
				panTo(get_x,get_y);
				setMarker(get_x,get_y,id,name);
				
				
			},
			error:function(){
				alert("서버통신실패");
			}
		});
		
	}
</script>
</head>
<body>
<%
	Object ldto=session.getAttribute("ldto");
	if(ldto!=null){
		List<BookMarkDto> booklist=(List<BookMarkDto>)request.getAttribute("booklist");
	
	}

%>
<div id ="Progress_Loading" style="position: absolute; z-index: 6; width: 100%;"><!-- 로딩바 -->
	<img src="image/gugun/loading.gif" style="display: block; top:30%;left:50%;  transform: translate(-50%, -50%);  position: fixed;"/>
</div>
<div id="container">	
	
	<div id="main_container">
		<img class='back_btn' src='image/back.png' alt='돌아가기' onclick='parent.call_main_container_around()'>
		<div id="logo" style="margin: 0 auto; width: 66%;  text-align: center;display: inline-block; left: 40%; position: relative; transform: translate(-50%,-50%); ">
			<span class='login_logo'>상호명 검색</span>
		</div>
		<div style="margin: 0 auto; width: 90%; height:80%;">
			<div style="margin: 0 auto; width: 90%;">
				<div style="width: 60%; margin: 0 auto;">
				<span>시/도 :</span>
				<select id="sido_selbar" name="sido_selbar" onchange="sidosel(this)" style="background-color: #3A3A3C; color: #dfbe6a; border-color: #dfbe6a; margin-top: 5px; height: 45px; width: 200px;">
						<option value="01">서울특별시</option>
						<option value="02">경기도</option>
						<option value="03">강원도</option>
						<option value="04">충청북도</option>
						<option value="05">충청남도</option>
						<option value="06">전라북도</option>
						<option value="07">전라남도</option>
						<option value="08">경상북도</option>
						<option value="09">경상남도</option>
						<option value="10">부산광역시</option>
						<option value="11">제주특별자치도</option>
						<option value="14">대구광역시</option>
						<option value="15">인천광역시</option>
						<option value="16">광주광역시</option>
						<option value="17">대전광역시</option>
						<option value="18">울산광역시</option>
						<option value="19">세종특별자치시</option>
					</select>
					<span style="margin-left: 70px; display: inline-block;">구/군 :</span>
					<select id="gugun_selbar" name="gugun_selbar" style=" background-color: #3A3A3C; color: #dfbe6a; border-color: #dfbe6a; margin-top: 5px; height: 45px; width: 200px; " >  </select>
					<br>
					<span style="display: inline-block;">상호명 :</span>
					<input type="text" name="b_name" id="b_name" placeholder="상호명 검색/ 최소2자 입력" onkeyup="enterkey()"  style=" background-color: #3A3A3C; color: #dfbe6a; border-color: #dfbe6a; margin-top: 10px; height: 50px; width: 400px; ">
					<button class="btn_mini" onclick="nameSearch()">검색</button>
				</div>
			</div>
			<br>
			<div id="map" style="float: left; width: 40%; height: 80%;margin-left: 13%;"></div>
			<div id="list" style="float: left; width: 30%; height: 80%; overflow-y: scroll; overflow-x:auto;"></div>
			<div id="gas_detail" style="float: left; width: 30%; height: 80%;"> 
					<table id="gas_info_table" border="1" style="border-collapse:collapse; border:1px solid white; line-height: 40px; position: relative; width: 100%; ">
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