<%@page import="java.util.List"%>
<%@page import="com.hk.gas.dtos.BookMarkDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=utf-8"); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
.table{ margin: 0 auto; background-color:white; top: 50px;position: relative; border-collapse: collapse; width: 80%;border: 1px solid #dfbe6a;}
td{border: 1px solid #dfbe6a;}
th{background-color:  white; color: black; border: 1px dashed black;}

</style>
</head>
<body>
<div id="container">	
	<div id="main_container">
		<div id="logo" style="margin: 0 auto; width: 66%; text-align: center; ">
			<span class='login_logo'>자유게시판</span>
		</div>
		<table class="table">
			<col width="70px"/>
			<col width="70px"/>
			<col width="300px"/>
			<col width="100px"/>
			<col width="70px"/>
			<col width="70px"/>
			<tr>
				<th>글번호</th>	
				<th>작성자</th>
				<th>제목</th>
				<th>작성일</th>
				<th>조회수</th>
				<th>추천수</th>
			</tr>
			<tr>
				<td colspan="6" style="text-align: right;">
				<div style="margin: 0 auto; text-align: center; font-size: 25px;  ">
			  	<c:forEach var="a" items="${freelist}" begin="1" varStatus="stat" end="${(fn:length(freelist)/10)+1}">
					<a href="boardlist.do?page=${stat.index}" style="font-weight: bold">${stat.index}</a>
				</c:forEach>
				</div>
				 <input type="button"  value="글쓰기"/>
				  		<c:choose>
							<c:when test="${ldto.role eq 'USER'}">
								<input type="button" value="삭제" disabled="disabled" >
							</c:when>
							<c:otherwise>
								<input type="button" value="삭제" >
							</c:otherwise>
						</c:choose>
			 </td>
			</tr>
		</table>
</div>
</div>
</body>
</html>