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
#shadow{background: black; width: 100%; height: 100%; position:absolute; display: block; opacity: 0.4;  z-index: 4;}
*>div{color: white; border-color: white; margin: 2px;}
#container{ width: 1511px; height:956px; overflow: hidden; margin: 0 auto; position: relative;}
#main_container{background-color: #3A3A3C; overflow: hidden; width: 1510px; height:955px; position: absolute; }
#login_container{background-color: #3A3A3C; overflow: hidden; width: 1510px; height:955px; position: absolute; left: 1510px; }
a{color: white;  text-decoration:none;}
ul{list-style: none;}
.back_btn{cursor: pointer;}
.table{ margin: 0 auto; background-color:#3A3A3C; }

</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>

<script type="text/javascript">
	function main_page(){
		var x=$("input[name=x]").val();
		var y=$("input[name=y]").val();
		
		location.href="main.do?x="+x+"&y="+y;
	}
</script>
</head>
<body>

<script type="text/javascript">
$(function(){
	$.ajax({
		url:"http://ip-api.com/json",
		method:"get",
		async:false,
		datatype:"json",
		success:function(jsonData){
			$("input[name=x]").val(jsonData.lat);
			$("input[name=y]").val(jsonData.lon);
		},
		error:function(){
			alert("서버통신실패");
		}
	});
});
</script>
<input type="hidden" name="x">
<input type="hidden" name="y">
<div id="container">	
	<div id="main_container">
		<img class="back_btn" src="image/back.png" alt="돌아가기" onclick="main_page()">
		<h1 style="text-align: center;"><small style="cursor: pointer;">자유게시판</small></h1>
			<input type="hidden" name="command" value="muldel">
				<table class="table" border="1">
					<col width="70px"/>
					<col width="70px"/>
					<col width="300px"/>
					<col width="90px"/>
					<col width="80px"/>
					<col width="70px"/>
					<col width="70px"/>
					<col width="70px"/>
					<col width="70px"/>
					<tr>
						<th>글번호</th>
						<th>작성자</th>
						<th>제목</th>
						<th>작성일</th>
						<th>refer</th>
						<th>step</th>
						<th>depth</th>
						<th>조회수</th>
						<th>추천수</th>
					</tr>
				</table>
</div>
</div>
</body>
</html>