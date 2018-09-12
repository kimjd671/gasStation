<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
#bookmark_list{ color: white; margin: 0 auto; position: relative; top: 30px; width: 90%; border-collapse: collapse; border: 1px solid #dfbe6a;}
td{border: 1px solid #dfbe6a; height: 50px;}
th{background-color:  #3A3A3C; color: white; border: 1px solid #dfbe6a;}
#info_form{position: absolute; z-index: 6; background-color: #3A3A3C; border: 5px solid #dfbe6a;  opacity: 0.95;width: 40%; height: 60%; position: absolute;top: 50%;left: 50%;  transform: translate(-50%, -50%); line-height:40px; display: none;}
#info_form table{border-collapse: collapse; height: 70%;}
#info_form input{margin: 2px; width:180px; height:33px; background-color: #3A3A3C; color: white; border-color:#dfbe6a;}
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
  padding: 20px 22% 20px;
  transition: all 0.7s ease-out;
  background: linear-gradient(270deg, rgba(223,190,106,0.8), rgba(146,111,52,0.8), rgba(34,34,34,0), rgba(34,34,34,0));
  background-position: 1% 50%;
  background-size: 300% 300%;
  text-decoration: none;
  margin:50px 10%;
  border: none;
  border: 1px solid rgba(223,190,106,0.3);
}
.btn:hover {
  color: #fff;
  border: 1px solid rgba(223,190,106,0);
  color: white;
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
  padding: 10px 15px 10px;
  transition: all 0.7s ease-out;
  background: linear-gradient(270deg, rgba(223,190,106,0.8), rgba(146,111,52,0.8), rgba(34,34,34,0), rgba(34,34,34,0));
  background-position: 1% 50%;
  background-size: 300% 300%;
  text-decoration: none;
  margin: 10px 30px;
  border: none;
  border: 1px solid rgba(223,190,106,0.3);
}
.btn_mini:hover {
  color: #fff;
  border: 1px solid rgba(223,190,106,0);
  color: $white;
  background-position: 99% 50%;
}

#radi_ctrl{
	position: relative; 
	top: 80px;
	left: 150px;
}
#user_list{
	position: relative;
	top: 30px;	
	left: 20px;
}
#user_black{
	position: relative;
	top: 30px;	
	left: 20px;
}
#user_allList{width: 70%; height: 80%; position: absolute;top: 50%;left: 50%;  transform: translate(-50%, -50%); line-height: 45px; }
#blacklist{width: 90%; height: 80%; position: absolute;top: 50%;left: 50%;  transform: translate(-50%, -50%); line-height: 45px; }
::-webkit-scrollbar{display:none;}
::-moz-scrollbar{display: none;}
</style>
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
	});
	
	function open_user_list(){
		$.ajax({
			url:"userlist.do",
			method:"get",			
			async:false,
			dataType:"json",
			success:function(Data){
				var list=Data["list"];
// 				alert(list.length);
				$("#usertable").empty();
				$("#usertable").append("<tr><th>아이디</th><th>이름</th><th>이메일</th><th>연락처</th><th>등급</th><th>가입일</th></tr>")
				for(var i =0; i<list.length;i++){
					//list쓸때 
// 					alert(list[i].id);	
					var date =new Date(list[i].regdate).toISOString().slice(0,10);
					$("#usertable").append("<tr><td><a href='#' onclick='call_info(this)'>"+list[i].id+"</a></td><td>"+list[i].name+"</td><td>"+list[i].email+"</td><td>"+list[i].phone+"</td><td>"+list[i].role+"</td><td>"+date+"</td></tr>")
				}
			},
			error:function(){
				alert("서버통신실패");
			}
		});
		$("#user_allList").fadeIn();		
	}
	function close_user_list(){
		$("#user_allList").fadeOut();		
	}
	function open_blacklist(){
		$.ajax({
			url:"blacklist.do",
			method:"get",			
			async:false,
			dataType:"json",
			success:function(Data){
				var list=Data["list"];
// 				alert(list.length);
// 				alert(list[0].ID);
				$("#blacktable").empty();
				$("#blacktable").append("<tr><th style='width: 150px;'>신고자아이디</th><th style='width: 150px;'>신고당한아이디</th><th>신고사유</th><th>채팅내용</th><th width='180px'>신고날짜</th></tr>");
				for(var i =0; i<list.length;i++){
					//list쓸때 
					var date =new Date(list[i].REGDATE).toISOString().slice(0,10);
					$("#blacktable").append("<tr><td>"+list[i].ID+"</td><td><a href='#'>"+list[i].BLACK_ID+"</a></td><td>"+list[i].WHY+"</td><td>"+list[i].CONTENT+"</td><td>"+date+"</td></tr>")
				}
			},
			error:function(){
				alert("서버통신실패");
			}
		});
		$("#blacklist").fadeIn();		
	}
	function close_blacklist(){
		$("#blacklist").fadeOut();		
	}
	
	function call_info(info){	
		$("#info_id").text($(info).text());
		$("#info_name").val($(info).parent().next().text());
		$("#info_email").val($(info).parent().next().next().text());
		$("#info_phone").val($(info).parent().next().next().next().text());
		$("#info_regdate").text($(info).parent().next().next().next().next().next().text());
		var role=$(info).parent().next().next().next().next().text();
		$("#role_sel").val(role).prop("selected",true);

		$("#info_form").fadeIn();
		
	}
	
	function close_info(){
		$("#info_form").fadeOut();		
	}
</script>
</head>
<body>
<div id="container">	
	<div id="main_container">
		<img class='back_btn' src='image/back.png' alt='돌아가기' onclick='parent.call_main_container()'>
		<div id="logo" style="margin: 0 auto; width: 66%;  text-align: center;display: inline-block; left: 40%; position: relative; transform: translate(-50%,-50%); ">
			<span class='login_logo'>관리자페이지</span>
		</div>	
		<div id="radi_ctrl" style="width:85%; margin: 0 0 0 100px;">
				<button style="padding:20px 20.5% 20px;" class="btn " onclick="open_user_list()">회원리스트</button> 
				<button class="btn " onclick="open_blacklist()">신고회원</button>
		</div>
	</div>	
	<div id="user_allList" style="overflow-y:scroll; overflow-x:auto; position: absolute; z-index: 6; background-color: #3A3A3C; border: 5px solid #dfbe6a;  opacity: 0.95; display: none;">
	<img alt="창닫기" src="image/close.png" onclick="close_user_list()" style="float: right; position: relative; top: 10px; left: -10px; cursor: pointer; z-index: 100;">
		<div id="user_list">		
			<span class='login_logo' style="font-size: 50px; text-align: center;">회원리스트</span>
			<table id="usertable" style="width: 95%;  margin: 0 auto; position: relative; top: 15px; border-collapse: collapse;">
				<col width="100px;">
				
			</table>			
		</div>
	</div>
	<div id="blacklist" style="position: absolute; z-index: 6; background-color: #3A3A3C; border: 5px solid #dfbe6a;  opacity: 0.95; display: none;">
	<img alt="창닫기" src="image/close.png" onclick="close_blacklist()" style="float: right; position: relative; top: 10px; left: -10px; cursor: pointer; z-index: 100;">
		<div id="user_black">		
			<span class='login_logo' style="font-size: 50px; text-align: center;">블랙리스트</span>
			<table id="blacktable" style="width: 95%;  margin: 0 auto; position: relative; top: 15px; border-collapse: collapse;">

			</table>			
		</div>
	</div>
</div>
<div id="info_form">
	<img alt="창닫기" src="image/close.png" onclick="close_info()" style="z-index:10; float: right; position: relative; top: 10px; left: -10px; cursor: pointer;">
	
	<span class="login_logo" style="font-size: 40px; top:30px; text-align: center;">회원정보</span>
	<table style="position: relative; top: 50px; left: 20px"> 
	 <col width="150px">
	 <col width="400px">
		<tr>
			<th>아이디</th>
			<td id="info_id"></td>
		</tr>
		<tr>
			<th>이름</th>
			<td><input type="text"  id="info_name"></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><input type="text"  id="info_email"></td>
		</tr>
		<tr>
			<th>연락처</th>
			<td><input type="text"  id="info_phone"></td>
		</tr>
		<tr>
			<th>등급</th>
			<td id="info_role">
				<select id="role_sel" style="margin: 2px; width:180px; height:33px; background-color: #3A3A3C; color: white; border-color:#dfbe6a;">
					<option value="ADMIN">관리자</option>
					<option value="USER">일반유저</option>
					<option value="BLACK">불량유저</option>
				</select>
			</td>
		</tr>
		<tr>
			<th>가입일</th>
			<td id="info_regdate"></td>
		</tr>
		<tr>
			<th colspan="2"><button class="btn_mini" onclick="">수정하기</button><button class="btn_mini" onclick="">회원삭제</button></th>
		</tr>
	</table>
</div>

</body>
</html>