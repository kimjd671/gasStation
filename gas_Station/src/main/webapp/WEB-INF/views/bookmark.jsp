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
#bookmark_list{background-color: #f4f6fc; color: #000000; margin: 0 auto; position: relative; top: 150px; width: 1200px;}
.title{font-size: 72px; display: block; width: 90%; margin: 0 auto; color:#dfbe6a; position: relative; top:100px; font-family: 'Jeju Hallasan', serif; text-align: center; }

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
<%
	List<BookMarkDto> list=(List<BookMarkDto>)request.getAttribute("lists");
// 	BookMarkDto bkdto=(BookMarkDto)session.getAttribute("ldto");
%>
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
		<div>
			<span class='title'>즐겨찾기</span>
		</div>
		<table id="bookmark_list" border="1">
			<tr id="bktr">			
				<th style="width: 142.85px;">아이디</th>
				<th style="width: 142.85px;">상호명</th>
				<th style="width: 142.85px;">지역</th>
				<th style="width: 142.85px;">휘발유</th>
				<th style="width: 142.85px;">경유</th>
				<th style="width: 142.85px;">LPG</th>
				<th style="width: 142.85px;">업데이트날짜</th>
			</tr>	
			<%
				if(list==null || list.size()==0){
					%>
					<tr>
						<td colspan="7" style="text-align: center;">---등록된 주유소가 없습니다---</td>
					</tr>
					<%
				}else{
					for(BookMarkDto dto:list){
						%>
						<tr>
							<td<%=dto.getId()%>></td>
							<td<%=dto.getB_name()%>></td>
							<td<%=dto.getLocation()%>></td>
							<td<%=dto.getGasoline()%>></td>
							<td<%=dto.getDiesel()%>></td>
							<td<%=dto.getLpg()%>></td>
							<td<%=dto.getRegdate()%>></td>
						</tr>		
						<% 
					}
				}
			%>					
		</table>		
	</div>
</div>
</body>
</html>