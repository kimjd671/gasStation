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
.back_btn{cursor: pointer;}
.login_logo{font-size: 72px; display: block; width: 90%; margin: 0 auto; color:#dfbe6a; position: relative; font-family: 'Jeju Hallasan', serif; }
#bookmark_list{ color: white; margin: 0 auto; position: relative; top: 30px; width: 80%; border-collapse: collapse; border: 1px solid #dfbe6a;}
td{border: 1px solid #dfbe6a; height: 50px;}
th{background-color:  white; color: black; border: 1px dashed black;}
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
</script>
</head>
<body>
<%
	List<BookMarkDto> list=(List<BookMarkDto>)request.getAttribute("lists");
	SimpleDateFormat yyyymmdd = new SimpleDateFormat("yyyy-MM-dd");
// 	BookMarkDto bkdto=(BookMarkDto)session.getAttribute("ldto");
%>
<div id ="Progress_Loading" style="position: absolute; z-index: 6; width: 100%;"><!-- 로딩바 -->
	<img src="image/gugun/loading.gif" style="display: block; top:30%;left:50%;  transform: translate(-50%, -50%);  position: fixed;"/>
</div>
<div id="container">	
	<div id="main_container">
		<div id="logo" style="margin: 0 auto; width: 66%; text-align: center; ">
			<span class='login_logo'>즐겨찾기</span>
		</div>
		<table id="bookmark_list">
			<tr id="bktr">			
				<th style="width: 327.7px;">상호명</th>
				<th style="width: 184.85px;">지역</th>
				<th style="width: 110.85px;">휘발유</th>
				<th style="width: 110.85px;">경유</th>
				<th style="width: 110.85px;">LPG</th>
				<th style="width: 124.85px;">업데이트날짜</th>
				<th style="width: 90px;">-</th>
			</tr>	
			<%
				if(list==null || list.size()==0){
					%>
					<tr>
						<td colspan="7" style="text-align: center;">---등록된 주유소가 없습니다---</td>
					</tr>
					<%
				}else{
					for(int i=0;i<list.size();i++){
						BookMarkDto dto=list.get(i);
						%>
						<tr>
							<td><%=dto.getB_name()%></td>
							<td><%=dto.getLocation()%></td>
							<td><%=dto.getGasoline()%></td>
							<td><%=dto.getDiesel()%></td>
							<td><%=dto.getLpg()==0?"-":dto.getLpg()%></td>
							<td style="text-align: center;"><%=yyyymmdd.format(dto.getRegdate())%></td>
							<td>
								<button style="width: 100%;" class="bookmark<%=i%>_btn" onclick="parent.reload_price('<%=dto.getUni_id()%>',this)">새로고침</button>
								<br>
								<button style="width: 100%;">삭제</button>
							</td>
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