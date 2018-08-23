<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.hk.gas.dtos.FreeBoardDto"%>
<%@page import="java.util.List"%>
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
html,body{margin:0; width:100%; height:100%; position: absolute;};
#shadow{background: black; width: 100%; height: 100%; position:absolute; display: block; opacity: 0.4;  z-index: 4;}
*>div{border-color: white; margin: 2px;}
.login_logo{font-size: 72px; display: block; width: 90%; margin: 0 auto; color:#dfbe6a; position: relative; font-family: 'Jeju Hallasan', serif; }
#container{ width: 1440px; height:956px; overflow: hidden; margin: 0 auto; position: relative;}

#main_container{background-color: #3A3A3C; overflow: hidden; width: 100%; height:955px; position: absolute; }
#login_container{background-color: #3A3A3C; overflow: hidden; width: 100%; height:955px; position: absolute; left: 1510px; }
a{color: white;  text-decoration:none;}
ul{list-style: none;}
.back_btn{cursor: pointer;}
.table{ margin: 0 auto; top: 50px;position: relative; border-collapse: collapse; width:60%;border: 1px solid #dfbe6a; color: white;}
td{border: 1px solid #dfbe6a; }
th{background-color:  white; color: black; border: 1px dashed black;}

</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(function(){
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

	function call_insertform(){
		$("#insert_form").fadeIn();
	}
	
	function close_insert(){
		$("#insert_form input").not("input[name=id]").val("");
		$("#insert_form textarea").val("");
		$("#insert_form").fadeOut();
	}
	
	function insert(){
		var id=$("input[name=id]").val();
		var title=$("input[name=title]").val();
		var content=$("textarea[name=content]").val();
		$.ajax({
			url:"freeboard_insert.do",
			method:"get",
			data:{"id":id,
				"title":title,
				"content":content
			},
			async:false,
			dataType:"json",
			success:function(Data){
				var isS=Data["isS"];
				if(isS){
					close_insert();
 					parent.reload_free();
				}else{
					alert("글작성실패");
				}
				
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
	List<FreeBoardDto> list=(List<FreeBoardDto>)request.getAttribute("pagelist");
	SimpleDateFormat yyyymmdd = new SimpleDateFormat("yyyy-MM-dd");
	int arr[]=new int[1000];
	int j=0;
	for(int i=0;i<list.size();i++){
		FreeBoardDto dto=list.get(i);
		arr[dto.getRefer()]= arr[dto.getRefer()]+1;
	}
	
%>
<div id="container">	
	<div id="main_container">
		<div id="logo" style="margin: 0 auto; width: 66%; text-align: center; ">
			<span class='login_logo'>자유게시판</span>
		</div>
		<table class="table">
			<col width="50px"/>
			<col width="70px"/>
			<col width="300px"/>
			<col width="100px"/>
			<col width="50px"/>
			<col width="50px"/>
			<tr>
				<th>글번호</th>	
				<th>작성자</th>
				<th>제목</th>
				<th>작성일</th>
				<th>조회수</th>
				<th>추천수</th>
			</tr>
				<%
				if(list==null || list.size()==0){
					%>
					<tr>
						<td colspan="7" style="text-align: center;">---등록된 글이 없습니다---</td>
					</tr>
					<%
				}else{
					for(int i=0;i<list.size();i++){
						FreeBoardDto dto=list.get(i);
						int count=0;
						if(dto.getLikecount()!=null){
							String likeuser=dto.getLikecount();
							String[] likecount=likeuser.split(",");
							count=likecount.length;
						}
						if(dto.getStep()==0){
						%>
						<tr>
							<td><%=dto.getSeq()%></td>
							<td><%=dto.getId()%></td>
							<td><%=dto.getTitle()%>[<%=arr[dto.getRefer()]-1%>]</td>
							<td style="text-align: center;"><%=yyyymmdd.format(dto.getRegdate())%></td>
							<td style="text-align: center;"><%=dto.getReadcount()%></td>
							<td style="text-align: center;"><%=count%></td>
						</tr>		
						<%
						}
					}
				}
			%>
			<tr>
				<td colspan="6" style="text-align: right;">
				<div style="margin: 0 auto; text-align: center; font-size: 25px;  ">
			  	<c:forEach var="a" items="${freelist}" begin="1" varStatus="stat" end="${(fn:length(freelist)/20)+1}">
					<a href="boardlist.do?page=${stat.index}" style="font-weight: bold">${stat.index}</a>
				</c:forEach>
				</div>
				 <button onclick="call_insertform()" style="position:relative; top: -30px;">글쓰기</button>
			 </td>
			</tr>
		</table>
		<div id="insert_form" style="display:none;  width: 50%; height: 50%; color:black; background-color: #F4F6FC;position:absolute;  top: 30%;left: 50%;  transform: translate(-50%, -50%);" >
<!-- 			<div> -->
<%-- 				<span>아이디</span><input type="text" value="${ldto.id}" readonly="readonly" name="id"> --%>
<!-- 			</div> -->
<!-- 			<div> -->
<!-- 				<span>제목</span><input type="text" name="title"> -->
<!-- 			</div> -->
<!-- 			<div> -->
<!-- 				<span style="display: block;">내용</span> -->
<!-- 				<textarea rows="20" cols="90"></textarea> -->
<!-- 			</div> -->
<!-- 			<div> -->
				<br>
				<span class='login_logo' style="font-size: 50px; text-align: center;">글쓰기</span>
				<table style="width: 80%;  margin: 0 auto; position: relative; top: 15px;">
					<col width="100px;">
					<col width="400px;">
					<tr>
						<th>아이디</th>
						<td><input type="text" name="id" style="width: 150px;" readonly="readonly" value="${ldto.id}"></td>
					</tr>
					<tr>
						<th>제목</th>
						<td><input type="text" name="title" style="width: 300px;"></td>
					</tr>
			
					<tr>
						<th>내용</th>
						<td><textarea rows="13" cols="55" name="content"></textarea></td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: right;">
							<button onclick="insert()">완료</button>
							<button onclick="close_insert()">취소</button>
						</td>
					</tr>
				</table>

				
			</div>
		</div>
	</div>
</div>
</body>
</html>