<%@page import="java.util.Calendar"%>
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
.back_btn{cursor: pointer;margin: 15px;display: inline;}
.table{ margin: 0 auto; top: 50px;position: relative; border-collapse: collapse; width:70%; height:65%;border: 1px solid #dfbe6a; color: white; line-height: 30px;}
td{border: 1px solid #dfbe6a; height: 34px;}
th{background-color:  #3A3A3C; color: white; border: 1px solid #dfbe6a;height: 34px;}
.btn {
  display: inline-block;
  background: transparent;
  text-transform: uppercase; 
  font-weight: 500; 
  font-style: normal; 
  font-size: 0.525rem; 
  letter-spacing: 0.3em; 
  color: rgba(223,190,106,0.7);
  border-radius: 0;
  padding: 8px 30px 10px;
  transition: all 0.7s ease-out;
  background: linear-gradient(270deg, rgba(223,190,106,0.8), rgba(146,111,52,0.8), rgba(34,34,34,0), rgba(34,34,34,0));
  background-position: 1% 50%;
  background-size: 300% 300%;
  text-decoration: none;
  margin: 0.625rem;
  border: none;
  border: 1px solid rgba(223,190,106,0.3);
}
.btn:hover {
  color: #fff;
  border: 1px solid rgba(223,190,106,0);
  color: $white;
  background-position: 99% 50%;
}

.paging:hover{
	color:#dfbe6a;
}


</style>
<%
	List<FreeBoardDto> list=(List<FreeBoardDto>)request.getAttribute("pagelist");
	List<FreeBoardDto> alllist=(List<FreeBoardDto>)request.getAttribute("alllist");
	SimpleDateFormat yyyymmdd = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat hhmm = new SimpleDateFormat("HH:mm");
	Calendar cal=Calendar.getInstance();
	String year=cal.get(cal.YEAR)+"";
	String today=cal.get(cal.DATE)+"";
	String month=(cal.get(cal.MONTH)+1)+"";
	int pageNum =Integer.parseInt(request.getParameter("page"));
	if(today.length()<2){
		today="0"+today;
	}
	if(month.length()<2){
		month="0"+month;
	}
	String yymmdd=year+"-"+month+"-"+today;
	
	int arr[]=new int[1000];
	int j=0;
	for(int i=0;i<alllist.size();i++){
		FreeBoardDto dto=alllist.get(i);
		arr[dto.getRefer()]= arr[dto.getRefer()]+1;
		System.out.println(arr[dto.getRefer()]);
	}
	
%>
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
		var page_num='<%=pageNum%>';
		$(".paging").eq(page_num-1).css("color","#dfbe6a");
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
	
	function search_board(){
		var category=$("select[name=category]").val();
		var value=$("input[name=findvalue]").val();
		if(category=="find_id"){
			location.href="boardlist.do?page=1&category=id&value="+value;
		}else if(category=="find_title"){
			location.href="boardlist.do?page=1&category=title&value="+value;
		}else if(category=="find_content"){
			location.href="boardlist.do?page=1&category=content&value="+value;
		}
	}
</script>

</head>
<body>


<div id="container">	
	<div id="main_container">
	<img class='back_btn' src='image/back.png' alt='돌아가기' onclick='parent.call_main_container()'>
		<div id="logo" style="margin: 0 auto; width: 66%;  text-align: center;display: inline-block; left: 40%; position: relative; transform: translate(-50%,-50%); ">
			<span class='login_logo'>자유게시판</span>
		</div>
		<table class="table">
			<col width="50px"/>
			<col width="100px"/>
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
					for(int i=0;i<14;i++){
						%>
							<tr><td colspan="7" style="border: none;"></td></tr>
						<%
					}
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
							<td><a href="boardDetatil.do?page=<%=pageNum%>&seq=<%=dto.getSeq()%>"><%=dto.getTitle()%></a><small>[<%=arr[dto.getRefer()]-1%>]</small></td>
							
							<%if(yyyymmdd.format(dto.getRegdate()).equals((yymmdd))){
								
								%>
								<td style="text-align: center;"><%=hhmm.format(dto.getRegdate())%></td>
								<%
							}else{
								
								%>
								<td style="text-align: center;"><%=yyyymmdd.format(dto.getRegdate())%></td>
								<%
							}
							%>
							<td style="text-align: center;"><%=dto.getReadcount()%></td>
							<td style="text-align: center;"><%=count%></td>
						</tr>		
						<%
						}
					}
					for(int k=0;k<15-list.size();k++){
						%>	
							<tr><td colspan="7" style="border: none;"></td></tr>
						<%
					}
				}
			%>
			<tr>
				<td colspan="6" style="text-align: right;">
				<div style="margin: 0 auto; text-align: center; font-size: 25px; width: 80%;  ">
				<%String category=request.getParameter("category");
					String value=request.getParameter("value");
					if(category==null){
						%>
						<c:forEach var="a" items="${freelist}" begin="1" varStatus="stat" end="${(fn:length(freelist)/15)+1}">
						<a class="paging" href="boardlist.do?page=${stat.index}" style="font-weight: bold">${stat.index}</a>
						</c:forEach>
						<%
					}else{
						%>
						<c:forEach var="a" items="${freelist}" begin="1" varStatus="stat" end="${(fn:length(freelist)/15)+1}">
						<a class="paging" href="boardlist.do?page=${stat.index}&category=<%=category%>&value=<%=value%>" style="font-weight: bold">${stat.index}</a>
						</c:forEach>
						<%
					}
				%>		
				</div>
				<div>
					<select name="category" style="float: left; margin: 2px; width: 70px; height: 33px; background-color: #3A3A3C; color:#dfbe6a;  border-color:#dfbe6a; ">
						<option value="find_id">아이디</option>
						<option value="find_title">글 제목</option>
						<option value="find_content">내용</option>
					</select>
					<input type="text" name="findvalue"   style="float: left; margin: 2px; width:180px; height:33px; background-color: #3A3A3C; color: white; border-color:#dfbe6a; ">
					<button class="btn" style="float: left; margin: 2px; " onclick="search_board()">검색</button>
				 <button class="btn" onclick="call_insertform()" >글쓰기</button>
				 </div>
			 </td>
			</tr>
		</table>
		<div id="insert_form" style="display:none;  width: 70%; height: 60%; color:black; background-color: #F4F6FC;position:absolute;  top: 50%;left: 50%;  transform: translate(-50%, -50%);" >
				<br>
				<span class='login_logo' style="font-size: 50px; text-align: center;">글쓰기</span>
				<table style="width: 95%;  margin: 0 auto; position: relative; top: 15px;">
					<col width="100px;">
					<tr>
						<th>아이디</th>
						<td><input type="text" name="id" style="width: 150px;" readonly="readonly" value="${ldto.id}"></td>
					</tr>
					<tr>
						<th>제목</th>
						<td><input type="text" name="title" style="width: 90%;"></td>
					</tr>
			
					<tr>
						<th>내용</th>
						<td><textarea rows="20" style="width: 100%;" name="content"></textarea></td>
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

</body>
</html>