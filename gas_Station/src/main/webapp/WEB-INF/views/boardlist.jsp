<%@page import="java.util.List"%>
<%@page import="com.hk.gas.dtos.BookMarkDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>커뮤니티</title>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/jejuhallasan.css);
#shadow{background: black; width: 100%; height: 100%; position:absolute; display: block; opacity: 0.4;  z-index: 4;}
*{box-sizing:border-box;}
body{margin:0; width:100%; height:100%};
#shadow{background: black; width: 100%; height: 100%; position:absolute; display: block; opacity: 0.4;  z-index: 4;}
*>div{color: white; border-color: white; margin: 2px;}
.login_logo{font-size: 72px; display: block; width: 90%; margin: 0 auto; color:#dfbe6a; position: relative; font-family: 'Jeju Hallasan', serif; }
#container{ width: 1440px; height:956px; overflow: hidden; margin: 0 auto; position: relative;}

#main_container{background-color: #3A3A3C; overflow: hidden; width: 100%; height:955px; position: absolute; }
#login_container{background-color: #3A3A3C; overflow: hidden; width: 100%; height:955px; position: absolute; left: 1510px; }
a{color: white;  text-decoration:none;}
ul{list-style: none;}
.back_btn{cursor: pointer;}
.table{ margin: 0 auto; background-color:#3A3A3C; }

</style>
</head>
<body>
<div id="container">	
	<div id="main_container">
		<div id="logo" style="margin: 0 auto; width: 66%; text-align: center; ">
			<span class='login_logo'>자유게시판</span>
		</div>
		
			<input type="hidden" name="command" value="muldel">
				<table class="table" border="1">
					<col width="70px"/>
					<col width="70px"/>
					<col width="300px"/>
					<col width="200px"/>
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