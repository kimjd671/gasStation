<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.hk.gas.dtos.GasUserDto"%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=utf-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta content="BlendTrans(Duration=0.2)" http-equiv="Page-Enter">
<meta content="BlendTrans(Duration=0.2)" http-equiv="Page-exit">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>메인페이지</title>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/jejuhallasan.css);
*{box-sizing:border-box;}
html,body{margin:0; width:100%; height:100%; position: absolute;};
#shadow{background: black; width: 100%; height: 100%; position:absolute; display: block; opacity: 0.4;  z-index: 4;}
*>div{color: white; border-color: white; margin: 2px;}
#container{ width: 79%; height:98%; overflow: hidden; margin: 0 auto; position: relative;}

#main_container{background-color: #3A3A3C; overflow: hidden; width: 100%; height:100%; position: absolute; }
#sub_container{background-color: #3A3A3C; overflow: hidden; width: 100%; height:100%; position: absolute; left: 1510px; }
#bookmark_list{background-color: #f4f6fc; color: #000000; margin: 0 auto; position: relative; top: 150px; width: 1200px;}
a{color: white;  text-decoration:none;}
ul{list-style: none;}
h3{margin: 10px;}
.display_none{	display: none;}
.display_block{	display: block;}
.img_btn{cursor: pointer;}
#imgs_gugun{width: 50%; padding: 2% 2%;}
.r_btn_img{display:block; position: relative; top: 50%;left: 50%;transform: translate(-50%, -50%); width: 50%;height: 100%; object-fit: contain;}
.b_btn_img{display:block; position: relative; top: 50%;left: 50%;transform: translate(-50%, -50%); width: 35%;height: 100%; object-fit: contain;}
ul.tabs {
    margin: 0 auto;
    padding: 0;
    float: left;
    list-style: none;
    height: 11%;
    background-color:#dfbe6a;
    width: 100%;
    font-family:"dotum";
    font-size:16px;
}
#login_sub li{
	float: left;
    color:#dfbe6a;
    text-align:center;
    cursor: pointer;
    width:50%;
    height: 100%;
    line-height: 31px;
    border-left: none;
    font-weight: bold;
    overflow: hidden;
    position: relative;
    border-left: 1px solid gray;
    font-size: 20px;
	
}
#regist_form{background-color:#F4F6FC; width: 40%; height: 85%; position: absolute;top: 50%;left: 50%;  transform: translate(-50%, -50%); line-height: 45px; display: none; z-index: 5}
#regist_form li{
	float: left;
    color:gray;
    text-align:center;
    cursor: pointer;
    width:50%;
    height: 100%;
	line-height: 31px;
    border-left: none;
    font-weight: bold;
    overflow: hidden;
    position: relative;
    border-left: 2px solid #F4F6FC;
    font-size: 21px;
    background-color: #DCE2F5;
	margin: 0;
}
#regist_form li>span{	position: relative;	top: 25px;}
ul.tabs li {
    float: left;
    color:gray;
    border-radius:15px 15px 0 0;
    text-align:center;
    cursor: pointer;
    width:33%;
    height: 100%;
    line-height: 31px;
    border-left: none;
    font-weight: bold;
    background: #fafafa;
    overflow: hidden;
    position: relative;
    border-left: 1px solid #3A3A3C;
}
ul.tabs li.active {
	color:#dfbe6a;
    background: #3A3A3C;
    border-bottom: 1px solid #3A3A3C;
}
.btn {
  display: inline-block;
  background: transparent;
  text-transform: uppercase; 
  font-weight: 500; 
  font-style: normal; 
  font-size: 2rem; 
  letter-spacing: 0.3em; 
  color: rgba(223,190,106,0.7);
  border-radius: 0;
  padding: 20px 80px 20px;
  transition: all 0.7s ease-out;
  background: linear-gradient(270deg, rgba(223,190,106,0.8), rgba(146,111,52,0.8), rgba(34,34,34,0), rgba(34,34,34,0));
  background-position: 1% 50%;
  background-size: 300% 300%;
  text-decoration: none;
  margin: 70px 30px;
  border: none;
  border: 1px solid rgba(223,190,106,0.3);
}
.btn:hover {
  color: #fff;
  border: 1px solid rgba(223,190,106,0);
  color: $white;
  background-position: 99% 50%;
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
  padding: 5px 10px 5px;
  transition: all 0.7s ease-out;
  background: linear-gradient(270deg, rgba(223,190,106,0.8), rgba(146,111,52,0.8), rgba(34,34,34,0), rgba(34,34,34,0));
  background-position: 1% 50%;
  background-size: 300% 300%;
  text-decoration: none;
  margin: 10px 20px 0px 30px;
  border: none;
  border: 1px solid rgba(223,190,106,0.3);
}
.btn_mini:hover {
  color: #fff;
  border: 1px solid rgba(223,190,106,0);
  color: $white;
  background-position: 99% 50%;
}
/* .btn{ */
/* 	background:    #dfbe6a; */
/* 	background:    -webkit-linear-gradient(#dfbe6a, #897952); */
/* 	background:    linear-gradient(#dfbe6a, #897952); */
/* 	border-radius: 1000px; */
/* 	border-color:#3A3A3C; */
/* 	padding:       3% 15%; */
/* 	color:         #000000; */
/* 	display:       block; */
/* 	font:          normal 400 3vw/1 "Zenhei", sans-serif; */
/* 	text-align:    center; */
/* 	text-shadow:   none; */
/* 	margin: 20px auto; */
/* 	position:relative; */
/* 	cursor: pointer; */
/* } */
.btn_old{ 
 	background:    #dfbe6a; 
 	background:    -webkit-linear-gradient(#dfbe6a, #897952); 
	background:    linear-gradient(#dfbe6a, #897952); 
 	border-radius: 500px; 
 	border-color:#3A3A3C; 
 	padding:       1% 5%; 
 	color:         #000000; 
 	display:       block; 
 	font:          normal 400 1vw/1 "Zenhei", sans-serif; 
 	text-align:    center; 
 	text-shadow:   none; 
 	margin: 0 auto; 
 	cursor: pointer; 
 } 
#right_view1,#right_view2,#right_view3{width:23%; height:24%; border: 1px solid #dfbe6a; background-color:#3A3A3C;  float:left; overflow: hidden; position: relative;  }
.right_div,.bottom_div{width: 100%;height: 100%;}
.right_div *{transition: all 0.35s ease; box-sizing: border-box; }
.right_div:hover img{  	opacity: 0.5; }
.right_div h3{
	position: absolute;
 	top: 0%;
 	width: 100%;
  	background-color: #dfbe6a;
  	z-index: 1;
  	text-align: right;
  	padding: 15px 25px 0px;
 	margin: 0;
	transform: translateY(-200%);
	color:#3A3A3C; 
	font-size: 30px;
}
.right_div h3:before {
  position: absolute;
  content: '';
  top: 100%;
  left: 0;
  width: 0;
  height: 0;
  border-style: solid;
  border-width: 0 345px 80px 0;
  border-color: transparent #dfbe6a transparent transparent;
}
.right_div:hover h3{
	transform: translateY(0%);
	color:white;
  	opacity: 1;
}


#bottom_view1,#bottom_view2{width:35%; height:24%; border: 1px solid #dfbe6a; background-color:#3A3A3C; float: left; overflow: hidden; position: relative;}
.bottom_div *{transition: all 0.35s ease; box-sizing: border-box; }
.bottom_div:hover img{opacity: 0.5; }
.bottom_div h3{
	position: absolute;
 	top: 0%;
 	width: 100%;
  	background-color: #dfbe6a;
  	z-index: 1;
  	text-align: right;
  	padding: 15px 25px 0px;
 	margin: 0;
	transform: translateY(-200%);
	color:#3A3A3C; 
	font-size: 30px;
}
.bottom_div h3:before {
  position: absolute;
  content: '';
  top: 100%;
  left: 0;
  width: 0;
  height: 0;
  border-style: solid;
  border-width: 0 528px 90px 0;
  border-color: transparent #dfbe6a transparent transparent;
}
.bottom_div:hover h3{
	transform: translateY(0%);
	color:white;
  	opacity: 1;
}



.sido_avg_span,.all_avg_span{font-size: 40px;}
#all_avg_t{	margin: 80px 0 10px 0;}
#all_oil_avg_o1,#all_oil_avg_o2,#all_oil_avg_o3,.top5_div{width: 90%;}
.all_diff,.sido_diff{position:relative;left:100px; top:0; display:inline-block; font-size:25px;}
.back_btn{cursor: pointer;margin: 15px;display: inline-block;}
.l_input{width: 80%; height: 100%; font-size: 35px; margin: 0 auto; display: block;}
.input_title{font-size: 40px; display: block; width: 80%; margin: 0 auto; color:#dfbe6a; }
.login_logo{font-size: 72px; display: block; width: 90%; margin: 0 auto; color:#dfbe6a; position: relative; font-family: 'Jeju Hallasan', serif; }
.regist_category{font-size: 30px; color: gray; display: block;}
.r_input{width: 90%; height: 100%; font-size: 33px; border: 1px dashed gray; background-color: #F4F6FC; }
input::placeholder{color:#CBCBCD; font-size: 20px;}
.r_div{padding-left: 40px;}
#r_cancel_btn:hover {background: #FC0543;}
#r_ok_btn:hover{background: #35D500;}
#sub_container fieldset{color: black;}
#main_container fieldset{margin-top: 20px; color: white; line-height: 30px;}
#update_info{background-color:#F4F6FC; width: 40%; height: 80%; position: absolute;top: 50%;left: 50%;  transform: translate(-50%, -50%); line-height: 45px; display: none;}
/* 아이디비번찾기 */
#find_form{background-color:#F4F6FC; width: 30%; height: 50%; position: absolute;top: 50%;left: 50%;  transform: translate(-50%, -50%); line-height: 45px;  z-index: 5;}
#idpwd{margin: 0 auto}
#find_form table {margin: 50px 0 0 0; border-spacing: 10px; color: gray}
#find_form th>img{opacity: 0.5;}
#find_form th>img:hover {opacity: 1;}
#findid,#findpwd,#id_list,#changepwd,#pwd_reset{display: none;} 
.info_btn{float: left; margin-left: 10px;}


</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="http://dapi.kakao.com/v2/maps/sdk.js?appkey=d5a3febeb4d52aaf0a2bcdd28926d84a&libraries=services,clusterer,drawing"></script>
<%
	GasUserDto sdto=(GasUserDto)session.getAttribute("ldto");
	SimpleDateFormat yyyymmdd = new SimpleDateFormat("yyyy-MM-dd");
%>

<script type="text/javascript">
	var code="F330180731";
	var out="json";
	var myaddrs;
	var a = '${xy}';
	var myXY=a.split("/",2);
	var area=null;
	var area_cd=null;
	var all_Price= new Array(); //0:고급유 1:휘발유 2:자동차용경유 3:실내등유 4:자동차용부탄
	var sido_Price=new Array(); //모든시도의 평균 사용시 sidocd 로 조회 
	var sido_Top5=new Array(); 
	var all_top10=new Array();
	var sel_sidonm=null;
	var sel_gugun=null;
	var roll_id;
	var sel_prodcd="B027";
	var my_focus="main";
	//휘발유 : B027  ,경유 :D047  , LPG : K015
	
	$(function(){
// 		$('#Progress_Loading').hide();
		function doNotReload(){
			if( (event.ctrlKey == true && (event.keyCode == 78 || event.keyCode == 82)) //ctrl+N , ctrl+R 
			|| (event.keyCode == 116)){
			event.keyCode = 0;
			event.cancelBubble = true;
			event.returnValue = false;
				if(my_focus=="bookmark"){
					reload_book();
				}else if(my_focus=="board"){
					reload_free();
				}
			}
		}
		document.onkeydown = doNotReload;

			var container = document.getElementById('map');
			var options = {
				center: new daum.maps.LatLng(${x},${y}),
				level: 4
			};

			var map = new daum.maps.Map(container, options);

			var geocoder = new daum.maps.services.Geocoder();

			
			searchAddrFromCoords(map.getCenter(), displayCenterInfo);
			
			function displayCenterInfo(result, status) {
			    if (status === daum.maps.services.Status.OK) {
			        var infoDiv = document.getElementById('centerAddr');

			        for(var i = 0; i < result.length; i++) {
			            // 행정동의 region_type 값은 'H' 이므로
			            if (result[i].region_type === 'H') {
// 			                infoDiv.innerHTML = result[i].address_name;
			                myaddrs=result[i].address_name;
			                mapping2();
// 			              	load_allPrice();  //전국평균 로드
// 			              	load_sidoPrice(); //시도평균 로드
// 			              	load_allTop10();//전국 Top10 휘발유 주유소로드
// 			              	load_sidoTop5(sel_prodcd); //로드된 시도기준 탑5 리스트
			              	
// 							insert_all_oil_avg();
							
// 			              	chk_sido_avg();
			              	chk_login();
// 			              	auto();
			              	$(".all_avg_content").hide();
			    		 	$(".all_avg_content:first").show();
			    		 	
			    		 	$(".sido_avg_content").hide();
			    		 	$(".sido_avg_content:first").show();
			                break;
			            }
			        }
			    }    
			}
			
			 $("ul.tabs li").click(function () {
			        $("ul.tabs li").removeClass("active").css("color", "gray");
			        //$(this).addClass("active").css({"color": "darkred","font-weight": "bolder"});
			        $(this).addClass("active").css("color", "#dfbe6a");
			        $(".sido_avg_content").hide();
			        $(".all_avg_content").hide();
			     	var count=$(this).attr("id");
			        $("#all_oil_"+count).fadeIn();
			        $("#sido_oil_"+count).fadeIn();
				        if(count=="avg_o1"){
				        	sel_prodcd="B027";
				        }else if(count=="avg_o2"){
				        	sel_prodcd="D047";
				        }else if(count=="avg_o3"){
				        	sel_prodcd="K015";
				        }
			        load_sidoTop5(sel_prodcd);
			});
			 
			 $("#top10_slide").children("div").children("ul").mouseover(function() {
           		clearInterval(roll_id);
           		
           	});
			 
           	$("#top10_slide").children("div").children("ul").mouseout(function() {
           		auto();
           	});
           	
			function auto() {
				roll_id=setInterval(function() {
              		top10_roll();
              	},2200);
			}
			$("#regist_form input").focusin(function() {
				$(this).prev("span").css("color","#dfbe6a");
			}).focusout(function() {
				$(this).prev("span").css("color","gray");
			})
			
			function chk_login(){
				var id='${ldto.id}'
				if(id==null||id==""){
						id=lid;
				}
				if(id!=null){
					$("#sub_container").empty();
					$("#sub_container").append("<img class='back_btn' src='image/back.png' alt='돌아가기' onclick='call_main_container()' style='z-index: 1000;'>")
					$("#sub_container").append("<iframe id='frame_sub' scrolling='no'  frameborder='0' width='100%' height='100%'  ></iframe>")
				}
			}
			
			function searchAddrFromCoords(coords, callback) {
			    // 좌표로 행정동 주소 정보를 요청합니다
			    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
			}
		
	});

	$(document).ajaxStart(function(){
		$('#Progress_Loading').show(); //ajax실행시 로딩바를 보여준다.
		$("#frame_sub").contents().find("#Progress_Loading").show();
		$("#shadow").css("display","block");
	});
	
	$(document).ajaxStop(function(){
		$('#Progress_Loading').hide(); //ajax종료시 로딩바를 숨겨준다.
		setTimeout(function() {
			 $("#frame_sub").contents().find("#Progress_Loading").hide();
		}, 500);
		$("#shadow").css("display","none");
	});
	
	function make_slide(){
		var count1=1;
		var count2=1;
		var count3=1;
		for(var i=0;i<3;i++){
			for(var j=0;j<10;j++){
				if(all_top10[i][j].price!=0){
					if(i==0){
						$("#top10_o1").children("ul").append("<li><a href='#'><span>"+count1+".</span><span>"+all_top10[i][j].u_name+"</span><span style='float:right;'>"+all_top10[i][j].price+"</span></a></li>");	
						count1++;
					}
					if(i==1){
						$("#top10_o2").children("ul").append("<li><a href='#'><span>"+count2+".</span><span>"+all_top10[i][j].u_name+"</span><span style='float:right;'>"+all_top10[i][j].price+"</span></a></li>");	
						count2++;
					}
					if(i==2){
						$("#top10_o3").children("ul").append("<li><a href='#'><span>"+count3+".</span><span>"+all_top10[i][j].u_name+"</span><span style='float:right;'>"+all_top10[i][j].price+"</span></a></li>");	
						count3++;
					}
				}
			}
		}
		if(count3!=11){
			var temp=count3-1;
			for(var k=0;k<10-temp;k++){
				$("#top10_o3").children("ul").append("<li><span>"+count3+".</span><span> 조회된 정보가 없습니다.</span><span style='float:right;'>-</span></li>");
				count3++;
			}
		}
		
	}
	function insert_all_oil_avg(){
		$("#all_oil_avg_o1").append("<div><h3>전국 평균가격<small>(원/리터)</small></h3><span class='all_avg_span'>"+all_Price[1].price+"</span><span class='all_diff'>"+all_Price[1].diff+"</span> </div>");
		$("#all_oil_avg_o2").append("<div><h3>전국 평균가격<small>(원/리터)</small></h3><span class='all_avg_span'>"+all_Price[2].price+"</span><span class='all_diff'>"+all_Price[2].diff+"</span> </div>");
		$("#all_oil_avg_o3").append("<div><h3>전국 평균가격<small>(원/리터)</small></h3><span class='all_avg_span'>"+all_Price[4].price+"</span><span class='all_diff'>"+all_Price[4].diff+"</span> </div>");
		
	}
	
	var top_count=0;
	function top10_roll(){
		if(top_count>9){
			top_count=0;
		}
		var tar1=$("#top10_o1").children("ul").children();
		tar1.attr("class", "display_none");
		tar1.eq(top_count).attr("class", "display_block");
		

		
		var tar2=$("#top10_o2").children("ul").children();
		tar2.attr("class", "display_none");
		tar2.eq(top_count).attr("class", "display_block");

		
		var tar3=$("#top10_o3").children("ul").children();
		tar3.attr("class", "display_none");
		tar3.eq(top_count).attr("class", "display_block");
		top_count++;
	}
	
	function chk_sido_avg(){
		$("#sido_oil_avg_o1").empty();
		$("#sido_oil_avg_o2").empty();
		$("#sido_oil_avg_o3").empty();
		var plus="";
		//휘발유 : B027  ,경유 :D047  , LPG : K015
      	for(var j=0;j<sido_Price.length;j++){
      		var diff=sido_Price[j].diff+"";
      		if(diff.indexOf("-")<0){
      			plus="+";
      		}
      		if(sido_Price[j].sidocd==area &&sido_Price[j].prodcd=='B027' ){
      			$("#sido_oil_avg_o1").append("<div id='sido_avg_1'><h3>"+sido_Price[j].sidonm+" 평균가격<small>(원/리터)</small></h3><span class='sido_avg_span'>"+sido_Price[j].price+"</span><span class='sido_diff'>"+plus+sido_Price[j].diff+"</span></div>");
      		}
      		if(sido_Price[j].sidocd==area &&sido_Price[j].prodcd=='D047'){
      			$("#sido_oil_avg_o2").append("<div id='sido_avg_2'><h3>"+sido_Price[j].sidonm+" 평균가격<small>(원/리터)</small></h3><span class='sido_avg_span'>"+sido_Price[j].price+"</span><span class='sido_diff'>"+plus+sido_Price[j].diff+"</span></div>");
      		}
      		if(sido_Price[j].sidocd==area &&sido_Price[j].prodcd=='K015'){
      			$("#sido_oil_avg_o3").append("<div id='sido_avg_3'><h3>"+sido_Price[j].sidonm+" 평균가격<small>(원/리터)</small></h3><span class='sido_avg_span'>"+sido_Price[j].price+"</span><span class='sido_diff'>"+plus+sido_Price[j].diff+"</span></div>");
      		}
      		sel_sidonm=sido_Price[j].sidonm;
      		plus="";
      	}
  	}
	//전국평균
	function load_allPrice(){
        $.ajax({
			url:"http://www.opinet.co.kr/api/avgAllPrice.do",
			method:"get",
			data:{"out":out,
				"code":code
			},
			async:false,
			dataType:"json",
			success:function(jsonData){
				var rows=jsonData["RESULT"]["OIL"];
				for(var i=0; i<rows.length; i++){
					all_Price[i]={  //0:고급유 1:휘발유 2:자동차용경유 3:실내등유 4:자동차용부탄
							prodcd:rows[i].PRODCD,
							prodnm:rows[i].PRODNM,
							price:rows[i].PRICE,
							diff:rows[i].DIFF
					}
				}
			},
			error:function(){
				alert("서버통신실패");
			}
		});
	}
	
	//시도평균
	function load_sidoPrice(){
        $.ajax({
			url:"http://www.opinet.co.kr/api/avgSidoPrice.do",
			method:"get",
			data:{"out":out,
				"code":code
			},
			async:false,
			dataType:"json",
			success:function(jsonData){
				var rows=jsonData["RESULT"]["OIL"];
				for(var i=0; i<rows.length; i++){
					sido_Price[i]={
							sidocd:rows[i].SIDOCD,
							sidonm:rows[i].SIDONM,
							prodcd:rows[i].PRODCD,
							price:rows[i].PRICE,
							diff:rows[i].DIFF
					}
				}
				
			},
			error:function(){
				alert("서버통신실패");
			}
		});
	}
	
	//시도별 top5 list로드
	function load_sidoTop5(prodcd){
		sel_gugun=$("#gugun_selbar option:selected").text();
		var o_name=null;
		if(sel_prodcd=="B027"){
			o_name="휘발유";
		}else if(sel_prodcd=="D047"){
			o_name="경유";
		}else if(sel_prodcd=="K015"){
			o_name="LPG";
		}
		 $.ajax({
				url:"http://www.opinet.co.kr/api/lowTop10.do",
				method:"get",
				data:{"out":out,
					"code":code,
					"prodcd":prodcd,
					"area":area_cd
				},
				async:true,
				dataType:"json",
				success:function(jsonData){
					var rows=jsonData["RESULT"]["OIL"];
					$("#gugun_oil_top5").empty();
					$("#gugun_oil_top5").append("<h5>"+sel_gugun+"의 최저가 "+o_name+" 주유소</h5>");
					for(var i=0; i<5; i++){
						if(rows[i] !=null){
							sido_Top5[i]={
									u_id:rows[i].UNI_ID,
									price:rows[i].PRICE,
									company:rows[i].POLL_DIV_CO,
									u_name:rows[i].OS_NM,
									old_addr:rows[i].VAN_ADR,
									new_addr:rows[i].NEW_ADR,
									x:rows[i].GIS_X_COOR,
									y:rows[i].GIS_Y_COOR
							}
						$("#gugun_oil_top5").append("<div class='top5_div'>"+(i+1)+". "+sido_Top5[i].u_name+"<span style='display:block; float:right;'>"+sido_Top5[i].price+"</span> </div>");
						}
					}
				},
				error:function(){
					alert("서버통신실패");
				}
			});
	}
	
	//유종별 전국탑10 휘발유 경유
	function load_allTop10(){
		var prd= new Array("B027","D047","K015");
// 		var prd= new Array("B027","D047");	
		for(var j=0;j<3;j++){
		 $.ajax({
				url:"http://www.opinet.co.kr/api/lowTop10.do",
				method:"get",
				data:{"out":out,
					"code":code,
					"prodcd":prd[j]
				},
				async:false,
				dataType:"json",
				success:function(jsonData){
					var rows=jsonData["RESULT"]["OIL"];
					all_top10[j]=new Array();
					for(var i=0; i<10; i++){
							all_top10[j][i]={
										u_id:rows[i].UNI_ID,
										price:rows[i].PRICE,
										company:rows[i].POLL_DIV_CO,
										u_name:rows[i].OS_NM,
										old_addr:rows[i].VAN_ADR,
										new_addr:rows[i].NEW_ADR,
										x:rows[i].GIS_X_COOR,
										y:rows[i].GIS_Y_COOR
							}	
					}
				},
				error:function(){
					alert("서버통신실패");
				}
			});
		}
		make_slide();
	}
	
	
	//시도 클릭시 시도이미변환과 마지막 구/군선택
	function chk_sido(aa){
		var id=aa.id;
		if(aa.id!=area){
			var img=document.getElementById("imgs");
			img.setAttribute("src", "image/sido/"+id+".png");
			area=id;
			chk_sido_avg();
			
			$("#gugun_selbar").empty();
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
					for(var i=0;i<rows.length;i++){
						area_cd=rows[i].AREA_CD;
	 					$("#gugun_selbar").append("<option value='"+rows[i].AREA_CD+"' selected>"+rows[i].AREA_NM+"</option>");
					}
				},
				error:function(){
					alert("서버통신실패");
				}
			});
			load_gugun_img();
			load_sidoTop5(sel_prodcd);
		}
	}
	
	//선택된 구군이름으로 이미지불러오기
	function load_gugun_img(){
		var img=document.getElementById("imgs_gugun");
		img.setAttribute("src", "image/gugun/"+area+"/"+area_cd+".png");
		
	}
	
// 	//반경검색
// 	function search_Radius(){
// 		var radius =$("input[name=sido]").val();
// 		var pro=$("input[name='prodcd']:checked").val();
// 		$.ajax({
// 			url:"http://www.opinet.co.kr/api/aroundAll.do",
// 			method:"get",
// 			data:{"out":out,
// 				"radius":radius,
// 				"code":code,
// 				"prodcd":pro,
// 				"sort":"1",
// 				"x":myXY[0],
// 				"y":myXY[1]
// 			},
// 			async:true,
// 			datatype:"xml",
// 			success:function(xmlData){
// 				var rows=$(xmlData).find("OIL");
// 			//	alert(rows.eq(0).children().eq(0).text());

// 				var table=makeTable(rows);
// 				$("#test_div").empty().append(table);
// 			},
// 			error:function(){
// 				alert("서버통신실패");
// 			}
// 		});
// 	}
	
	
	//주소확인하여 시도위치 확인 이미지 수정
	function mapping2(){
		myaddrs=String(myaddrs);
		
		if(myaddrs.indexOf("서울")>-1){
			var img=document.getElementById("imgs");
			img.setAttribute("src", "image/sido/01.png");
			area="01";
		}else if(myaddrs.indexOf("인천광역시")>-1){
			var img=document.getElementById("imgs");
			img.setAttribute("src", "image/sido/15.png");
			area="15";
		}else if(myaddrs.indexOf("경기도")>-1){
			var img=document.getElementById("imgs");
			img.setAttribute("src", "image/sido/02.png");
			area="02";
		}else if(myaddrs.indexOf("강원도")>-1){
			var img=document.getElementById("imgs");
			img.setAttribute("src", "image/sido/03.png");
			area="03";
		}else if(myaddrs.indexOf("충청남도")>-1){
			var img=document.getElementById("imgs");
			img.setAttribute("src", "image/sido/05.png");
			area="05";
		}else if(myaddrs.indexOf("세종특별자치시")>-1){
			var img=document.getElementById("imgs");
			img.setAttribute("src", "image/sido/19.png");
			area="19";
		}else if(myaddrs.indexOf("대전광역시")>-1){
			var img=document.getElementById("imgs");
			img.setAttribute("src", "image/sido/17.png");
			area="17";
		}else if(myaddrs.indexOf("충청북도")>-1){
			var img=document.getElementById("imgs");
			img.setAttribute("src", "image/sido/04.png");
			area="04";
		}else if(myaddrs.indexOf("경상북도")>-1){
			var img=document.getElementById("imgs");
			img.setAttribute("src", "image/sido/08.png");
			area="08";
		}else if(myaddrs.indexOf("대구광역시")>-1){
			var img=document.getElementById("imgs");
			img.setAttribute("src", "image/sido/14.png");
			area="14";
		}else if(myaddrs.indexOf("전라북도")>-1){
			var img=document.getElementById("imgs");
			img.setAttribute("src", "image/sido/06.png");
			area="06";
		}else if(myaddrs.indexOf("경상남도")>-1){
			var img=document.getElementById("imgs");
			img.setAttribute("src", "image/sido/09.png");
			area="09";
		}else if(myaddrs.indexOf("울산광역시")>-1){
			var img=document.getElementById("imgs");
			img.setAttribute("src", "image/sido/19.png");
			area="18";
		}else if(myaddrs.indexOf("부산광역시")>-1){
			var img=document.getElementById("imgs");
			img.setAttribute("src", "image/sido/10.png");
			area="10";
		}else if(myaddrs.indexOf("전라남도")>-1){
			var img=document.getElementById("imgs");
			img.setAttribute("src", "image/sido/07.png");
			area="07";
		}else if(myaddrs.indexOf("광주광역시")>-1){
			var img=document.getElementById("imgs");
			img.setAttribute("src", "image/sido/16.png");
			area="16";
		}else if(myaddrs.indexOf("제주특별자치도")>-1){
			var img=document.getElementById("imgs");
			img.setAttribute("src", "image/sido/11.png");
			area="11";
		}
		
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
				for(var i=0;i<rows.length;i++){
 					if(myaddrs.indexOf(rows[i].AREA_NM)>0){
 						area_cd=rows[i].AREA_CD;
 						$("#gugun_selbar").append("<option value='"+rows[i].AREA_CD+"' selected>"+rows[i].AREA_NM+"</option>");
 					}else{
 						$("#gugun_selbar").append("<option value='"+rows[i].AREA_CD+"'>"+rows[i].AREA_NM+"</option>");
 					}
				}
				load_gugun_img();
			},
			error:function(){
				alert("서버통신실패");
			}
		});
	}
	
	function gugunsel(t){
		area_cd= $("#gugun_selbar option:selected").val();
		load_sidoTop5(sel_prodcd);
		load_gugun_img();
	}
	
	//시도코드기반 구군코드로드  주소매칭하여 시도구군코드가져오기
	var call_login =0;
	function call_sub_container(){
		call_login= setInterval(function() {
			slide();
		}, 5)
	}
	function slide(){
		var main_x=$("#main_container").position().left;
		var login_x=$("#sub_container").position().left;
		if(main_x!=-1510){
			$("#main_container").css("left",main_x-10);
		}
		if(login_x!=0){
			$("#sub_container").css("left",login_x-10);
		}
		
		if(main_x==-1510 && login_x==0){
			clearInterval(call_login);
		}
	}
	
	////////////////////////////
	
	
	var call_main=0;
	function call_main_container(){
		call_main= setInterval(function() {
			return_slide();
		}, 5)
		my_focus="main";
	}
	
	function return_slide(){
			var main_x=$("#main_container").position().left;
			var login_x=$("#sub_container").position().left;
			if(main_x!=0){
				$("#main_container").css("left",main_x+10);
			}
			if(login_x!=1510){
				$("#sub_container").css("left",login_x+10);
			}
			
			if(main_x==0 && login_x==1510){
				clearInterval(call_main);
			}
	}
	
	function registForm(){
		$("#shadow").css("display","block");
		$("#regist_form").fadeIn();
		$("#sub_container").children().css("pointer-events","none");
		$("#regist_form").css("pointer-events","auto");
	}
	
	function close_regi(){
		$("#regist_form").fadeOut();
		$("#shadow").css("display","none");
		$("#regist_form input").val("");
		$("#regist_form input[name=id]").css("background-color", "#F4F6FC");
		$("#regist_form input[name=password]").css("background-color", "#F4F6FC");
		$("#regist_form input[name=repassword]").css("background-color", "#F4F6FC");
		$("#sub_container").children().css("pointer-events","auto");
	}
	function insert_user(){
		if(idchk&&pwdchk&&phonechk){
			var id=$("#regist_form input[name=id]").val();
			var password=$("#regist_form input[name=password]").val();
			var name=$("#regist_form input[name=name]").val();
			var email=$("#regist_form input[name=email]").val();
			var phone=$("#regist_form input[name=phone]").val();
			
			$.ajax({
				url:"insertuser.do",
				method:"get",
				data:{"id":id,
					"password":password,
					"name":name,
					"email":email,
					"phone":phone
				},
				async:false,
				dataType:"json",
				success:function(obj){
					var str=obj["isS"];
					if(str){
						alert("회원가입 성공");
						pwdchk=false;
						idchk=false;
						phonechk=false;
						close_regi();
					}else{
						alert("회원가입 실패");
						$("#regist_form input[name=password]").val("");
						$("#regist_form input[name=repassword]").val("");
						$("#regist_form input[name=password]").css("background-color", "#F4F6FC");
						$("#regist_form input[name=repassword]").css("background-color", "#F4F6FC");
						pwdchk=false;
						idchk=false;
						phonechk=false;
					}
	
				},
				error:function(){
					alert("회원가입 실패");
					$("#regist_form input[name=password]").val("");
					$("#regist_form input[name=repassword]").val("");
					$("#regist_form input[name=password]").css("background-color", "#F4F6FC");
					$("#regist_form input[name=repassword]").css("background-color", "#F4F6FC");
					pwdchk=false;
					idchk=false;
					phonechk=false;
				}
			});
		}else{
			alert("형식에 맞게 작성해주세요.");
		}
	}
	
	var idchk=false;
	var pwdchk=false;
	var phonechk=false;
	function chk_id(){
		var id=$("#regist_form input[name=id]").val();
		if(id==null||id==""){
			$("#regist_form input[name=id]").css("background-color", "#F4F6FC");
			idchk=false;
		}else if(id.length<6 || id.length>20){
			$("#regist_form input[name=id]").css("background-color", "#FFCECE");
			idchk=false;
		}else{
			$.ajax({
				url:"idchk.do",
				method:"get",
				data:{"id":id
				},
				async:false,
				dataType:"json",
				success:function(obj){
					var str=obj["isS"];
					if(str){
						$("#regist_form input[name=id]").css("background-color", "#FFCECE");
						idchk=false;
					}else{
						$("#regist_form input[name=id]").css("background-color", "#B0F6AC");
						idchk=true;
					}
				},
				error:function(){
					alert("통신 실패");
				}
			});
		}
	}
	
	function repwd_chk(){
		var pwd=$("#regist_form input[name=password]").val();
		var repwd=$("#regist_form input[name=repassword]").val();
		if(repwd==null || repwd==""){
			$("#regist_form input[name=repassword]").css("background-color", "#F4F6FC");
			pwdchk=false;
		}
		else if(pwd==repwd){
			$("#regist_form input[name=repassword]").css("background-color", "#B0F6AC");
			pwdchk=true;
		}else{
			$("#regist_form input[name=repassword]").css("background-color", "#FFCECE");
			pwdchk=false;
		}
	}
	
	function pwd_chk(){
		var pwd=$("#regist_form input[name=password]").val();
		if(pwd==null || pwd==""){
			$("#regist_form input[name=password]").css("background-color", "#F4F6FC");
		}else if(pwd.length<8 || pwd.length>20){
			$("#regist_form input[name=password]").css("background-color", "#FFCECE");
		}else{
			$("#regist_form input[name=password]").css("background-color", "#B0F6AC");
		}
	}
	
	
	function chk_phone(){
		var phone=$("#regist_form input[name=phone]").val();
		var regNumber = /^[0-9]*$/;
		if(phone==null || phone==""){
			$("#regist_form input[name=phone]").css("background-color", "#F4F6FC");
			phonechk=false;
		}else if(!regNumber.test(phone)){
			$("#regist_form input[name=phone]").css("background-color", "#FFCECE");
			phonechk=false;
		}else{
			$("#regist_form input[name=phone]").css("background-color", "#B0F6AC");
			phonechk=true;
		}
		
	}
	
	function findForm(){
		$("#shadow").css("display","block");
		$("#find_form").fadeIn();
		$("#sub_container").children().css("pointer-events","none");
		$("#find_form").css("pointer-events","auto");
	}
	
	function close_find(){
		$("#find_form").fadeOut();
		$("#shadow").css("display","none");
		$("#idpwd").children().css("display","none");
		$("#sel").css("display","block");
		$("#find_form input").val("");
		$("#sub_container").children().css("pointer-events","auto");
	}
	
	function find_id(){
		$("#main").children("span").text("아이디 찾기");
		$("#sel").css("display","none");
		$("#findid").css("display","block");
	}
	
	function find_id_ajax(){
		var name=$("input[name=f_name]").val();
		var phone=$("input[name=f_phone]").val();
		$.ajax({
			url:"findid.do",
			method:"get",
			data:{"name":name,
				"phone":phone
			},
			async:false,
			dataType:"json",
			success:function(obj){
				var str=obj["dto"];
				if(str.length==0){
					alert("조회된 아이디가 없습니다.");
				}else{
					$("#find_id_list").empty();
					$("#id_index").text(str.length);
					for(var i=0;i<str.length;i++){
						$("#find_id_list").append("<li>"+str[i].id+"</li>");
					}
					$("#findid").css("display","none");
					$("#id_list").css("display","block");
				}
			},
			error:function(){
				alert("서버통신 실패");
			}
		});
	}
	
	function find_pwd_ajax(){
		var id=$("input[name=f_id]").val();
		var email=$("input[name=f_email]").val();
		$.ajax({
			url:"findpwd.do",
			method:"get",
			data:{"id":id,
				"email":email
			},
			async:false,
			dataType:"json",
			success:function(obj){
				var str=obj["isS"];
				if(str){
					$("#findpwd").css("display","none");
					$("#pwd_reset").css("display","block");
				}else{
					alert("조회된 아이디가 없습니다.");
				}
			},
			error:function(){
				alert("서버통신 실패");
			}
		});
		
	}
	
	function find_pwd(){
		$("#main").children("span").text("비밀번호 찾기");
		$("#sel").css("display","none");
		$("#findpwd").css("display","block");
	}
	
	function pwd_reset(){
		var pwd=$("input[name=reset_pwd]");
		var id=$("input[name=f_id]").val();
		var npwd=pwd.eq(0).val();
		if(pwd.eq(0).val()!=pwd.eq(1).val()){
			alert("비밀번호가 일치하지 않습니다.");
		}else if(pwd.eq(0).val().length<8 || pwd.eq(0).val().length>20){
			alert("비밀번호의 길이는 8~20자로 설정해주세요.")	
		}else{
			$.ajax({
				url:"pwdreset.do",
				method:"get",
				data:{"id":id,
					"password":npwd
				},
				async:false,
				dataType:"json",
				success:function(obj){
					var str=obj["isS"];
					if(str){
						alert("비밀번호를 변경하였습니다.");
						close_find();
					}else{
						alert("비밀번호 변경 실패");
					}
				},
				error:function(){
					alert("서버통신 실패");
				}
			});
		}
		
		
	}
	
	function showKeyCode(event) {
		event = event || window.event;  //여러브라우저 지원형 
		var keyID = (event.which) ? event.which : event.keyCode;  //여러브라우저 지원형 
		var phone=$("input[name=phone]");
		if( !(( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) || (keyID==8 || keyID==9)) )
		{
			phone.val(phone.val().substr(0, phone.val().length-1));
			alert("숫자만입력해주세요");
		}
		if(phone.val().length>11){
			phone.val(phone.val().substr(0, phone.val().length-1));
			alert("최대 입력가능수 초과");
		}
	}
	var lid=null;
	function gas_login(){
		var pwd=$("input[name=login_pwd]").val();
		var id=$("input[name=login_id]").val();
		if(pwd==null || id==null || pwd=="" || id==""){
			alert("로그인 정보를 모두 입력해주세요.");
		}else{
			$.ajax({
				url:"login.do",
				method:"get",
				data:{"id":id,
					"password":pwd
				},
				async:false,
				dataType:"json",
				success:function(obj){
					var str=obj["dto"];
					if(str==null){
						alert("로그인 정보가 잘못되었습니다.");
					}else{
						lid=str.id;
						$("#sub_container input").val("");
						$("#login_button").css("display","none");
						$("#myInfo").fadeIn();
						$("#myinfo_id").text(str.id);
						$("#myinfo_name").text(str.name);
						date =new Date(str.regdate).toISOString().slice(0,10);
						$("#myinfo_regdate").text(date);
						if(str.role=="USER"){
							$("#superuser").css("display","none");
							$("#information").css("display","block");
						}else if(str.role=="ADMIN"){
							$("#superuser").css("display","block");
							$("#information").css("display","none");
						}
						$("#sub_container").empty();
						$("#sub_container").append("<img class='back_btn' src='image/back.png' alt='돌아가기' onclick='call_main_container()' style='z-index: 1000;'>")
						$("#sub_container").append("<iframe id='frame_sub' scrolling='no'  frameborder='0' width='100%' height='100%'  ></iframe>")
						call_main_container();

						
					}
				},
				error:function(){
					alert("서버통신 실패");
				}
			});
		}
	}

	
	function call_update_info(){
		$("#shadow").css("display","block");
		$("#update_info").fadeIn();
		
	}
	
	function close_update_info(){
		$("#shadow").css("display","none");
		$("#update_info").fadeOut();
		$("#info_pwd_chk").fadeIn();
		$("#info_change").css("display","none");
		$("#update_info input").not("input[name=old_email]").not("input[name=old_phone]").val("");
		
	}
	
	function logout(){
		$.ajax({
			url:"logout.do",
			method:"get",
			async:false,
			success:function(){
				alert("로그아웃 되었습니다.");
				window.location.reload();
				
			},
			error:function(){
				alert("서버통신 실패");
			}
		});
	}
	
	function info_chk_pwd(){
		var inpwd=$("input[name=info_chk_pwd]").val();
		<%
			if(sdto==null){
				%>
				var myid=lid;
				<%
			}else{
				%>
				var myid='${ldto.id}';
				<%
			}
		%>
		
		$.ajax({
			url:"chk_pwd.do",
			method:"get",
			data:{"id":myid,
				"password":inpwd
			},
			async:false,
			dataType:"json",
			success:function(obj){
				var str=obj["chkdto"];
				if(str==null){
					alert("비밀번호가 틀렸습니다.");
				}else{
					$("#info_pwd_chk").css("display","none");
					$("#info_change").fadeIn();
					$("#old_id").text(str.id);
					$("#old_name").text(str.name);
					$("input[name=old_email]").val(str.email);
					$("input[name=old_phone]").val(str.phone);
					date =new Date(str.regdate).toISOString().slice(0,10);
					$("#old_regdate").text(date);
				}
			},
			error:function(){
				alert("서버통신 실패");
			}
		});
	}
	
	function change_myinfo(){
		var myid=$("#old_id").text();
		var email=$("input[name=old_email]").val();
		var phone=$("input[name=old_phone]").val();
		var regNumber = /^[0-9]*$/;
		if(!regNumber.test(phone)){
			alert("연락처는 숫자만 입력해주세요.");
		}else{
			$.ajax({
				url:"update_info.do",
				method:"get",
				data:{"id":myid,
					"email":email,
					"phone":phone
				},
				async:false,
				dataType:"json",
				success:function(obj){
					var str=obj["isS"];
					if(str){
						alert("변경완료");
						close_update_info();
					}else{
						alert("변경실패");
					}
				},
				error:function(){
					alert("서버통신 실패");
				}
			});
			
		}
	}
	
	function change_password(){
		var npwd=$("input[name=new_pwd]").val();
		var rpwd=$("input[name=new_repwd]").val();
		var myid=$("#old_id").text();
		if(npwd==rpwd){
			$.ajax({
				url:"pwdreset.do",
				method:"get",
				data:{"id":myid,
					"password":npwd
				},
				async:false,
				dataType:"json",
				success:function(obj){
					var str=obj["isS"];
					if(str){
						alert("변경완료");
						close_update_info();
					}else{
						alert("변경실패");
					}
				},
				error:function(){
					alert("서버통신 실패");
				}
			});
		}else{
			alert("비밀번호가 일치하지 않습니다.");
		}
	}
	
	function search_area(){
	 	if (navigator.geolocation) { // GPS를 지원하면
	    navigator.geolocation.getCurrentPosition(function(position) {
			alert("페이지이동");
	    }, function(error) {
	      console.error(error);
	    }, {
	      enableHighAccuracy: false,
	      maximumAge: 0,
	      timeout: Infinity
	    });
	  } else {
	    alert('GPS를 지원하지 않습니다');
	  }
		
	}
	
	
	
	function load_bookmark(){
		var id='${ldto.id}'
		if(id==null||id==""){
			id=lid;
		}
		if(id==null || id==""){
			alert("로그인을 해주세요.");
		}else{
			$("iframe").attr("src", "bookmark.do");
			my_focus="bookmark";
			call_sub_container();
		}
		
	}
	
	function reload_book(){
		$("iframe").attr("src", "bookmark.do");
	}
	
	function reload_free(){
		$("iframe").attr("src", "boardlist.do?page=1");
	}
	
	function go_board(){
		var id='${ldto.id}'
		if(id==null||id==""){
			id=lid;
		}
		if(id==null || id==""){
			alert("로그인을 해주세요.");
		}else{
			$("iframe").attr("src", "boardlist.do?page=1");
			my_focus="board";
			call_sub_container();
		}
	}

	function del_bookmark(uid,target){
		var trs=$("#frame_sub").contents().find("."+target.className).parent("td").parent("tr");
		var myid='${ldto.id}';
		if(myid==null||myid==""){
			myid=lid;
	}
		$.ajax({
			url:"delete_bookmark.do",
			method:"get",
			data:{"id":myid,
				"uni_id":uid
			},
			async:false,
			dataType:"json",
			success:function(obj){
				trs.remove();
				alert("삭제되었습니다.");
			},
			error:function(){
				alert("서버통신 실패");
			}
		});
	}
	
	function reload_price(id,target){
		var tar=target.className;
		var tds=$("#frame_sub").contents().find("."+tar).parent("td").siblings("td");
		$.ajax({
			url:"http://www.opinet.co.kr/api/detailById.do",
			method:"get",
			data:{"out":"xml",
				"code":code,
				"id":id
			},
			async:false,
			success:function(jsonData){
				var len=$(jsonData).find("OIL_PRICE").size();
				for(var i=0; i<len;i++){
					if($(jsonData).find("OIL_PRICE").eq(i).children().eq(0).text()=="B027"){
						var gas=$(jsonData).find("OIL_PRICE").eq(i).children("PRICE").text();
						tds.eq(2).text(gas);
					}else if($(jsonData).find("OIL_PRICE").eq(i).children().eq(0).text()=="D047"){
						 var sel=$(jsonData).find("OIL_PRICE").eq(i).children("PRICE").text();
						tds.eq(3).text(sel);
					}else if($(jsonData).find("OIL_PRICE").eq(i).children().eq(0).text()=="C004"){
						var lpg=$(jsonData).find("OIL_PRICE").eq(i).children("PRICE").text();
						tds.eq(4).text(lpg);
					}
				}
				var date = new Date();
		        var year  = date.getFullYear();
		        var month = date.getMonth() + 1; // 0부터 시작하므로 1더함 더함
		        var day   = date.getDate();
		        if (("" + month).length == 1) { month = "0" + month; }
		        if (("" + day).length   == 1) { day   = "0" + day;   }
// 			        alert(tds.eq(5).html());
		        tds.eq(5).text(""+year+"-"+month+"-"+day);        
		        save_bookmark(gas,sel,lpg,id);
			},
			error:function(){
				alert("서버통신실패");
			}
		});
		 
		 
	}
	
	function save_bookmark(gas,sel,lpg,uid){
		var myid='${ldto.id}';
			if(myid==null||myid==""){
				myid=lid;
		}
		$.ajax({
			url:"reload_price.do",
			method:"get",
			data:{"id":myid,
				"gasoline":gas,
				"diesel":sel,
				"lpg":lpg,
				"uni_id":uid
			},
			async:false,
			dataType:"json",
			success:function(obj){
			},
			error:function(){
				alert("서버통신 실패");
			}
		});
	}
	
	
	

</script>
</head>
<body>

<div id="map" style="display: none;" ></div>
<script type="text/javascript" src="http://dapi.kakao.com/v2/maps/sdk.js?appkey=d5a3febeb4d52aaf0a2bcdd28926d84a"></script>
<div id="container">
<div id="shadow">
</div>
<div id="main_container">
<div id = "Progress_Loading" style="position: absolute; z-index: 6; width: 100%;"><!-- 로딩바 -->
	<img src="image/gugun/loading.gif" style="display: block; top:50%;left:50%;  transform: translate(-50%, -50%);  position: fixed;"/>
</div>
<div id="main_view" style="width:75%; height:71%;  float: left;">
<div id="map_div" style="width:31%; height:100%;   float: left; border: 1px solid #dfbe6a; overflow: hidden;" >
<div style="background-color: #3A3A3C; width: 90%; margin: 10px auto 10px auto;">
<img id="imgs" src="image/map.png" usemap="#sido" style="margin: 0 auto; display: block;">
<map name="sido">
<!-- 	강원 -->
	<area id="03" shape="poly" onclick="chk_sido(this)" coords="200,0,188,26,104,29,96,35,106,46,110,41,119,43,120,48,128,46,134,58,145,64,144,78,138,79,141,94,152,99,163,103,158,111,157,127,156,142,166,141,168,133,175,132,178,138,190,132,200,138,197,143,205,143,209,146,232,153,235,144,246,149,263,149,269,153,280,139,249,80,220,40">
<!-- 	경기 -->
	<area id="02" shape="poly" onclick="chk_sido(this)" coords="95,39,89,49,86,50,84,57,77,63,82,72,84,88,90,95,96,88,104,91,105,101,110,101,107,109,100,116,94,115,76,118,75,112,71,125,76,126,77,128,80,136,69,132,69,145,87,167,94,160,95,164,105,161,116,167,124,162,125,158,129,157,131,153,140,152,143,149,145,142,148,145,154,133,154,123,156,118,155,109,159,105,155,102,148,101,145,97,138,97,136,87,135,76,142,69,141,66,131,59,127,50,121,51,116,48,116,45,110,46,108,50,100,45">
<!-- 	서울 -->
	<area id="01" shape="poly" onclick="chk_sido(this)" coords="96,90,93,97,88,98,85,103,79,101,79,103,83,108,85,108,88,113,99,112,100,114,107,104,102,103,103,97,101,91">
<!-- 	인천 -->
	<area id="15" shape="poly" onclick="chk_sido(this)" coords="72,64,69,84,59,83,56,87,56,97,67,98,69,106,78,110,79,115,84,114,84,111,81,111,79,106,77,103,77,99,80,98,83,100,86,98,86,94,81,86,78,70,75,65" >
<!-- 	대구 -->
	<area id="14" shape="poly" onclick="chk_sido(this)" coords="236,268,236,272,231,279,224,277,218,280,211,274,216,266,216,258,220,261,226,257,231,258">
<!-- 	광주 -->
	<area id="16" shape="poly" onclick="chk_sido(this)" coords="87,333,90,339,94,341,94,347,89,350,84,350,79,350,76,347,80,342,80,339,81,337,80,336,82,335,85,334">
<!--	경북 -->
	<area id="08" shape="poly" onclick="chk_sido(this)" coords="282,144,272,150,272,155,267,155,261,150,243,152,239,146,236,147,234,156,225,154,209,166,209,176,199,180,195,174,188,178,178,180,178,184,180,187,178,190,172,187,160,200,167,208,165,212,165,224,162,229,178,232,178,239,174,240,175,246,166,258,166,268,175,274,182,274,192,285,191,292,203,293,206,296,217,294,223,298,231,298,238,300,249,292,254,296,267,285,276,286,277,292,284,289,292,291,301,252,297,252,291,258,284,253,286,251,284,235,284,223,290,218,288,204,286,196,291,187,291,177,285,160,287,151">
<!-- 	경남 -->
	<area id="09" shape="poly" onclick="chk_sido(this)" coords="165,269,174,276,183,276,189,288,187,293,201,295,205,298,215,295,222,300,228,299,238,303,247,296,252,308,262,319,263,327,252,334,240,343,242,346,232,348,223,341,224,338,222,336,219,340,226,352,213,348,205,356,214,353,214,358,208,360,208,369,203,369,201,363,196,368,194,364,188,364,178,365,179,351,174,359,168,359,166,363,170,368,167,373,171,377,174,374,171,372,176,367,179,370,179,387,171,387,169,382,164,387,160,373,164,364,156,361,156,354,142,336,142,327,149,316,143,302,148,286,150,281,156,275">
<!-- 	부산 -->
	<area id="10" shape="poly" onclick="chk_sido(this)" coords="265,329,272,338,254,353,252,344,243,349,244,346,242,343,249,340,249,337,257,333,258,331,261,329">
<!-- 	울산 -->
	<area id="18" shape="poly" onclick="chk_sido(this)" coords="250,296,252,306,263,317,266,326,274,337,281,323,285,323,284,310,288,310,293,299,287,292,282,292,275,293,274,289,270,287,262,289,262,293,256,297">
<!-- 	충북 -->
	<area id="04" shape="poly" onclick="chk_sido(this)" coords="153,142,150,146,146,147,145,151,139,155,131,155,130,159,127,161,125,165,121,166,119,169,122,175,128,180,127,186,122,185,117,193,122,202,125,204,125,209,129,212,134,212,136,215,140,217,136,223,134,228,135,233,142,237,144,250,146,252,150,252,153,255,166,254,170,250,172,244,172,238,176,237,175,233,168,234,167,232,162,232,161,229,163,221,163,210,165,207,157,200,163,194,163,190,167,189,171,185,177,186,176,182,178,177,189,176,193,171,199,174,200,177,207,176,207,167,218,156,218,154,223,153,213,149,207,149,203,145,195,147,194,141,196,139,191,137,187,137,178,142,173,134,169,137,169,144,156,145">
<!-- 	세종 -->
	<area id="19" shape="poly" onclick="chk_sido(this)" coords="118,187,111,184,108,184,107,186,107,191,110,200,118,214,120,210,122,209,121,204,114,194,118,189">
<!-- 	대전 -->
	<area id="17" shape="poly" onclick="chk_sido(this)" coords="122,212,115,225,115,234,123,234,127,232,131,232,134,223,135,222,135,220,132,218,132,215,126,215">
<!-- 	충남 -->
	<area id="05" shape="poly" onclick="chk_sido(this)" coords="61,159,56,161,53,173,52,162,44,173,41,184,46,188,44,192,55,206,52,210,62,222,56,225,54,243,65,249,67,257,71,257,82,251,84,244,101,243,106,249,121,246,128,258,139,258,144,253,141,247,140,237,128,234,124,236,114,236,112,234,112,224,117,216,106,198,105,185,108,182,119,184,125,182,125,179,120,176,116,169,111,168,109,164,104,164,84,172,76,162,70,160,66,164,62,159">
<!-- 	전북 -->
	<area id="06" shape="poly" onclick="chk_sido(this)" coords="84,253,66,262,63,265,72,269,79,268,76,271,70,272,70,274,77,279,69,280,63,286,51,294,51,299,66,299,66,302,53,306,48,313,52,314,56,325,71,319,74,311,81,308,89,317,96,311,100,323,99,326,103,326,109,324,119,326,124,326,132,320,140,325,142,325,142,320,146,315,141,300,147,282,163,268,165,260,161,257,150,257,142,258,136,261,127,260,118,248,104,251,97,246,88,245,85,247">
<!-- 	전남 -->
	<area id="07" shape="poly" onclick="chk_sido(this)" coords="48,314,56,327,66,324,73,318,74,312,81,310,87,318,91,318,95,313,97,320,98,327,126,327,129,323,133,322,140,329,141,339,154,353,154,362,152,362,152,360,151,360,151,365,146,368,144,368,141,364,139,368,146,376,150,373,155,373,155,381,151,386,147,385,144,387,145,395,141,395,137,391,138,385,140,383,135,377,135,370,131,375,123,375,127,378,122,381,126,383,124,386,135,398,126,400,125,398,121,399,121,402,127,406,118,413,111,404,103,405,102,400,107,396,107,394,110,394,110,399,112,399,111,391,115,387,117,391,120,390,119,384,116,385,112,382,109,385,109,389,103,389,93,397,93,401,88,408,87,412,84,413,83,416,79,413,76,413,76,400,74,399,72,411,70,411,70,414,67,414,67,416,64,416,61,419,62,421,59,427,52,428,52,422,49,422,49,419,52,416,49,413,49,406,54,404,53,402,49,402,47,404,43,403,39,400,35,395,32,391,36,381,40,386,39,390,41,392,41,395,48,397,42,390,45,387,49,389,48,392,53,394,56,392,57,394,58,394,51,385,46,383,45,383,41,384,43,380,53,381,55,378,62,378,65,376,57,374,59,367,55,370,55,375,53,375,53,378,50,376,46,377,46,378,43,378,43,375,44,375,44,364,45,359,43,359,49,365,37,365,36,361,41,356,41,354,37,349,36,352,34,349,31,345,34,342,37,344,40,342,41,349,45,351,46,353,48,350,48,344,44,345,44,343,42,341,42,336,40,334,37,333,41,332,44,328,44,320,47,321,47,318">
<!-- 	제주 -->
	<area id="11" shape="poly" onclick="chk_sido(this)" coords="37,459,50,448,73,442,85,441,86,440,89,440,92,443,95,443,97,446,99,450,97,452,98,454,89,465,87,467,70,471,54,471,47,472,44,475,41,475,34,467,35,460">
</map>
<div id="gu_map" style="background-color: #3A3A3C; border-top:1px solid #dfbe6a;  width: 100%; margin: 0 auto;">
	<select id="gugun_selbar" name="gugun_selbar" onchange="gugunsel(this)" style="float: right;" >  </select>
	<img id="imgs_gugun"  style="margin: 0 auto; display: block;">
</div>
</div>
</div>
<div id="sido_oil_avg_div" style="width:33%; height:50%; border: 1px solid #dfbe6a; float: left;">
	<ul class="tabs">
        <li class="active" id="avg_o1">휘발유</li>
        <li id="avg_o2">경유</li>
        <li id="avg_o3">LPG</li>
    </ul>
    <div class="all_avg_container" id="all_avg_t">
		<div class="all_avg_content" id="all_oil_avg_o1"></div>
		<div class="all_avg_content" id="all_oil_avg_o2"></div>
		<div class="all_avg_content" id="all_oil_avg_o3"></div>
	</div>
	<div class="sido_avg_container">
		<div class="sido_avg_content" id="sido_oil_avg_o1"></div>
		<div class="sido_avg_content" id="sido_oil_avg_o2"></div>
		<div class="sido_avg_content" id="sido_oil_avg_o3"></div>
	</div>	
</div>
<div id="top10_slide" style="width:33%; height:50%; border: 1px solid #dfbe6a; float: left; ">
	<h3>전국 최저가 주유소 TOP10</h3>
	&nbsp;&nbsp;휘발유<br>
	<div id="top10_o1" style="height: 41px; width:80%;  overflow: hidden;">
		<ul>
		
		</ul>
	</div>
	&nbsp;&nbsp;경유<br>
	<div id="top10_o2" style="height: 41px; width:80%;   overflow: hidden;">
		<ul>
		
		</ul>
	</div>
	&nbsp;&nbsp;LPG<br>
	<div id="top10_o3" style="height: 41px; width:80%;  overflow: hidden;">
		<ul>
		
		</ul>
	</div>
	
</div>
<div id="oil_top5" style="width:33%; height:50%; border: 1px solid #dfbe6a; float: left;">
	<h3>최저가 Top5 주유소</h3>
	<div id="gugun_oil_top5">
<!-- 	<img id="loading_img" src="image/gugun/loading.gif" alt="로딩" style=" margin: auto auto;"/> -->
	</div>
</div>
<div id="week_day_avg" style="width:33%; height:50%; border: 1px solid #dfbe6a; float: left;">
	<h3 style="float: left;">최근 1주간  평균유가</h3><button class="btn_mini" style="position: relative;" onclick="reload_price('A0028706',this)" >조회하기</button>
	
</div>
</div>
<div id="right_view1">
	<%   	if(sdto==null){	%>
		<button id="login_button" class="btn" onclick="call_sub_container()" >로그인</button>
		<div id="myInfo" style="display: none;">
			<fieldset style="color: white;">
				<legend>내 정보</legend>
				<table>
					<tr><td>아이디:</td><td><span id="myinfo_id"></span></td></tr>
					<tr><td>이름:</td><td><span id="myinfo_name"></span></td></tr>
					<tr><td>가입일:</td><td><span id="myinfo_regdate"></span></td></tr>
				</table>
			</fieldset>
			<button id="information" class="btn_mini" onclick="call_update_info()" style="float:left;">정보수정</button>
			<button id="superuser" class="btn_mini" onclick='amdin_page()' style="float:left; margin: 10px 10px 10px 10px;">관리자페이지</button>
			<button class="btn_mini" onclick="logout()">로그아웃</button>
		</div>
			<%	}else{	%>
		<button id="login_button" class="btn" onclick="call_sub_container()" style="display: none;" >로그인</button>
		<div id="myInfo">
			<fieldset>
				<legend>내 정보</legend>
				<table>
					<tr><td>아이디:</td><td><span id="myinfo_id"><%=sdto.getId()%></span></td></tr>
					<tr><td>이름:</td><td><span id="myinfo_name"><%=sdto.getName() %></span></td></tr>
					<tr><td>가입일:</td><td><span id="myinfo_regdate"><%=yyyymmdd.format(sdto.getRegdate()) %></span></td></tr>
				</table>
			</fieldset>
			<button class="btn_mini" onclick="call_update_info()" ${ldto.role=='USER'?"":"style='display:none;'"} style="float:left;">정보수정</button>
			<button class="btn_mini" onclick='amdin_page()' ${ldto.role!='USER'?"":"style='display:none;'"} style="float:left; margin: 10px 10px 10px 10px;">관리자페이지</button>
			<button class="btn_mini" onclick="logout()">로그아웃</button>
		</div>	
			<%		}	%>
</div>
<div class="img_btn" id="right_view2" onclick="load_bookmark()">
	<div class="right_div" >
	<h3>즐겨찾기</h3>
	<img class="r_btn_img" alt="즐겨찾기" src="image/star.png">
	</div>
</div>
<div class="img_btn" id="right_view3"  onclick="go_board()">
	<div class="right_div">
	<h3>커뮤니티</h3>
	<img class="r_btn_img" alt="커뮤니티" src="image/board.png" >
	</div>
</div>
<div class="img_btn" id="bottom_view1">
	<div class="bottom_div">
	<h3>상호명 검색</h3>
	<img class="b_btn_img" alt="상호검색" src="image/search.png">
	</div>
</div>
<div class="img_btn" id="bottom_view2" onclick="search_area()">
	<div class="bottom_div">
	<h3>주변주유소 찾기</h3>
	<img class="b_btn_img" alt="반경검색" src="image/maker.png" >
	</div>
</div>
<div style="clear: left;"></div>
</div>


<!-- 내정보수정 -->
<div id="update_info" style="position: absolute; z-index: 6;">
	<img alt="창닫기" src="image/close.png" onclick="close_update_info()" style="float: right; position: relative; top: 10px; left: -10px; cursor: pointer;">
	<div id="info_pwd_chk" style="color: black; width: 100%; height: 100%; text-align: center;">
		<fieldset style="width: 90%; margin: 0 auto; position: relative; top: 250px;">
			<legend>비밀번호 재확인</legend>
			비밀번호 입력 : <input type="password" name="info_chk_pwd">
			<br>
			<button class="btn_old" onclick="info_chk_pwd()">확인</button>
		</fieldset>
	</div>
	<br>
	<div id="info_change" style="color: black; width: 100%; height: 100%; text-align: center; display: none;">
		<span class="login_logo" style="font-size: 40px; text-align: center;">정보수정</span>
		<fieldset style="width: 90%; margin: 0 auto;">
			<legend>내정보 수정</legend>
			<table>
				<tr><td>아이디 :</td><td id="old_id"></td></tr>
				<tr><td>이름    :</td><td id="old_name"></td></tr>
				<tr><td>이메일 :</td><td><input name="old_email" type="text"></td></tr>
				<tr><td>연락처 :</td><td><input name="old_phone" type="text"></td></tr>
				<tr><td>가입일 :</td><td id="old_regdate"></td></tr>
			</table>
			<hr>
			<button class="btn_old" onclick="change_myinfo()">확인</button>
		</fieldset>
		<hr style="width: 80%; margin: 20px auto;">
		<fieldset style="width: 90%; margin: 0 auto;">
			<legend>비밀번호 수정</legend>
			<table>
				<tr>	
					<td>새 비밀번호 : </td>	<td><input type="password" name="new_pwd"></td>
				</tr>
				<tr>	
					<td>새 비밀번호 재입력 : 	</td><td><input type="password" name="new_repwd"></td>
				</tr>
			</table>
			<hr>
			<button class="btn_old" onclick="change_password()">확인</button>
		</fieldset>
		
	</div>
</div>
<!-- 로그인창 -->

<%@include file="login.jsp"%>
</div>

</body>
</html>