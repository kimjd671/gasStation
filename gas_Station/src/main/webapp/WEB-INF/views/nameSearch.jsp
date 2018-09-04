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
		
		$("#sido_selbar option[value="+l_a+"]").attr("selected",true);
		$.ajax({
			url:"http://www.opinet.co.kr/api/areaCode.do",
			method:"get",
			data:{"out":"json",
				"code":"F330180731",
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
			},
			error:function(){
				alert("서버통신실패");
			}
		});
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new daum.maps.LatLng(${x},${y}), // 지도의 중심좌표
	        draggable: false,
	        level: 11// 지도의 확대 레벨
	        
	    };
	
		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new daum.maps.Map(mapContainer, mapOption); 
		
		function setDraggable(draggable) {
		    // 마우스 드래그로 지도 이동 가능여부를 설정합니다
		    map.setDraggable(draggable);    
		}
		function setZoomable(zoomable) {
		    // 마우스 휠로 지도 확대,축소 가능여부를 설정합니다
		    map.setZoomable(zoomable);    
		}
		setZoomable(true);
	});
	var area_cd=null;
	var out="json";
	var code="F330180731";
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
							$("#list").append("<div class='find_list' id='"+rows[i].UNI_ID+"'>"+
									"<span>"+rows[i].OS_NM+""+
									"<input type='hidden' name='x' value="+rows[i].GIS_X_COOR+">"+
									"<input type='hidden' name='y' value="+rows[i].GIS_Y_COOR+">"+
									"</div>");
							
						}
					}
				},
				error:function(){
					alert("서버통신실패");
				}
			});
		}
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
			
			
		</div>
	</div>
</div>
</body>
</html>