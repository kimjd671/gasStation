<%@page import="com.hk.gas.dtos.GasUserDto"%>
<%@page import="java.util.List"%>
<%@page import="com.hk.gas.dtos.FreeBoardDto"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=utf-8"); %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/jejuhallasan.css);
#shadow{background: black; width: 100%; height: 100%; position:absolute; display: block; opacity: 0.4;  z-index: 4;}
*{box-sizing:border-box;}
html,body{margin:0; width:100%; height:100%; position: absolute;};
#shadow{background: black; width: 100%; height: 100%; position:absolute; display: block; opacity: 0.4;  z-index: 4;}
*>div{border-color: white; margin: 2px;}
.login_logo{font-size: 72px; display: block; width: 90%; margin: 0 auto; color:#dfbe6a; position: relative; font-family: 'Jeju Hallasan', serif; }
#container{ width: 1440px; height:956px; overflow: hidden; margin: 0 auto; position: relative;}

#main_container{background-color: #3A3A3C; overflow-y: scroll; overflow-x:auto; width: 100%; height:83%; position: absolute; }
::-webkit-scrollbar{display:none;}
::-moz-scrollbar{display: none;}
a{color: white;  text-decoration:none;}
ul{list-style: none;}
.table{ margin: 0 auto; top: 50px;position: relative; border-collapse: collapse; width:100%;border: 1px solid #dfbe6a; color: white; line-height: 35px;}
th,td{border: 1px solid #dfbe6a; }
h3{color: white; text-align: center;}
.reply td{border:none}

#detail_div{width: 70%; margin: 0 auto;}

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

</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<%
	FreeBoardDto dtos=(FreeBoardDto)request.getAttribute("dto");
	SimpleDateFormat yyyyMMddhhmm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	int pageNum =Integer.parseInt(request.getParameter("page"));
	List<FreeBoardDto> reply=(List<FreeBoardDto>)request.getAttribute("reply");
	GasUserDto ldtos=(GasUserDto)session.getAttribute("ldto");
	if(ldtos==null){
		out.println("<script type='text/javascript'>alert('로그인정보가 없습니다.');parent.document.location.reload();</script>");
		return;
	}
%>
<script type="text/javascript">
	$(function(){
		document.onkeydown = doNotReload;
		var likelist='${dto.likecount}';
		var likelen=likelist.trim().split(",");
		for(var i=0;i<likelen.length-1;i++){
			if(likelen[i]=='${ldto.id}'){
				$("#like_btn").text("추천취소").attr("onclick","unlikethis()");
			}
		}
		$("#like").text(likelen.length-1);
		function doNotReload(){
			if( (event.ctrlKey == true && (event.keyCode == 78 || event.keyCode == 82)) //ctrl+N , ctrl+R 
			|| (event.keyCode == 116)){
			event.keyCode = 0;
			event.cancelBubble = true;
			event.returnValue = false;
			document.location.reload();
			}
		}
		
		$("textarea.autosize").on('keydown keyup', function () {
			  $(this).height(1).height( $(this).prop('scrollHeight')+12 );
// 			  $(".reply_textarea").height(1)
		});
	});
	
	
	function likethis(){
		var like='${dto.likecount}';
		var myid='${ldto.id}';
		var likechk=like.trim().split(",");
		for(var i=0;i<likechk.length-1;i++){
			if(likechk[i]=='${ldto.id}'){
				$("#like_btn").text("추천취소").attr("onclick","unlikethis()");
				return
			}
		}
		var likeup=like+myid+",";
		var likelen=likeup.trim().split(",");
		$.ajax({
			url:"likeup.do",
			method:"get",
			data:{"seq":'${dto.seq}',
				"likecount":likeup
			},
			async:false,
			dataType:"json",
			success:function(Data){
				var isS=Data["isS"];
				if(isS){
					alert("추천하였습니다.");
					location.reload();
				}else{
					alert("실패/시스템오류");
				}
				
			},
			error:function(){
				alert("서버통신실패");
			}
		});
	}
	
	function unlikethis(){
		var like='${dto.likecount}';
		var myid='${ldto.id}';
		var likelen=like.trim().split(",");
		var nlike="";
		for(var i=0; i<likelen.length-1;i++){
			if(likelen[i]==myid){
				likelen.splice(i, 1);
			}else{
				nlike=nlike+likelen[i]+",";
			}
		}
		$.ajax({
			url:"likeup.do",
			method:"get",
			data:{"seq":'${dto.seq}',
				"likecount":nlike
			},
			async:false,
			dataType:"json",
			success:function(Data){
				var isS=Data["isS"];
				if(isS){
					alert("추천취소");
					location.reload();
				}else{
					alert("실패/시스템오류");
				}
				
			},
			error:function(){
				alert("서버통신실패");
			}
		});
		
	}
	
	function display_reply(){
		$("#replyform").slideToggle("slow");
		var a=$("#replyform").offset().top;
		$("#main_container").animate({
			"scrollTop":a
		},500);

	}
	
	
	function insert_reply(){
		var id='${ldto.id}';
		var seq='${dto.seq}';
		var title=seq+"_reply";
		var content=$("textarea[name=reply_content]").val();
		$.ajax({
			url:"reply_insert.do",
			method:"get",
			data:{
				"seq":seq,
				"id":id,
				"title":title,
				"content":content
			},
			async:false,
			dataType:"json",
			success:function(Data){
				var isS=Data["isS"];
				if(isS){
					location.reload();
				}else{
					alert("글작성실패");
				}
				
			},
			error:function(){
				alert("서버통신실패");
			}
		});
	}
	
	function delete_board(seq){
		var del= confirm("삭제하시겠습니까?");
		var page= '<%=pageNum%>';
		if(del){
			$.ajax({
				url:"delete_freeboard.do",
				method:"get",
				data:{"seq":seq
				},
				async:false,
				dataType:"json",
				success:function(obj){
					location.href="boardlist.do?page="+page;
				},
				error:function(){
					alert("서버통신 실패");
				}
			});
		}
	}
	
	function update_board(){
		
	}
</script>

</head>
<body>
<div id="container">	
	<div id="main_container">
		<div id="logo" style="margin: 0 auto; width: 66%; text-align: center; ">
			<span class='login_logo'>글상세보기</span>
		</div>
		<div id="detail_div">
			<table class="table" >
				<col width="100px;">
				<tr>
					<th>글번호</th>
					<td>${dto.seq}<div style="float: right;"><span>조회수:${dto.readcount}</span> / 추천수:<span id="like"></span></div></td>
				</tr>
				<tr>
					<th>작성일</th>
					<td><%=yyyyMMddhhmm.format(dtos.getRegdate()) %></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${dto.id}</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>${dto.title}</td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea style="width: 100%; border:none; color: white; background-color:#3A3A3C; " rows="20" readonly="readonly" >${dto.content}</textarea></td>
				</tr>
				<tr>
					<td colspan="2">
						<div style="text-align: right; ">
							<button class="btn" onclick="display_reply()">댓글[${fn:length(reply)-1}]</button>
							<button class="btn" id="like_btn" onclick="likethis()">추천하기</button>
							<button class="btn" ${ldto.id==dto.id ||ldto.role=='ADMIN'?"":"style='display:none;'"} onclick="delete_board('${dto.seq}')">삭제</button>
							<button class="btn" ${ldto.id==dto.id ||ldto.role=='ADMIN'?"":"style='display:none;'"} onclick="update_board('${dto.seq}')">수정</button>
							<button class="btn" onclick="location.href='boardlist.do?page=<%=pageNum%>'">글목록</button>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div id="replyform" style="position: relative; top: 50px; display: none;">
			<h3>댓글</h3>
			<div style="width: 70%; margin: 0 auto;" >
					<%
					if(reply==null || reply.size()<=1){
						%>
							<span style="color: white;">작성된 댓글이 없니다.</span>
							<hr style="display: block; position: relative ; margin: 10px; background-color: gray; color: gray; border-color: gray;">
						<%
					}
					for(int i=1;i<reply.size();i++){
						FreeBoardDto redto=reply.get(i);
						%>
							<table class="table reply"  style="top:0; position: relative;">
								<tr>	
									<td><%=redto.getId()%> (<%=yyyyMMddhhmm.format(redto.getRegdate())%>)</td>
								</tr>
								<tr>
									<td><%=redto.getContent()%></td>
								</tr>
								<tr>
									<td style="text-align: right;">
										<div>	
											<button class="btn" <%=ldtos.getId().equals(redto.getId())?"":"disabled" %>>수정</button>
											<button class="btn" <%=ldtos.getId().equals(redto.getId())?"":"disabled" %>>삭제</button>
										</div>
									</td>
								</tr>
							</table>
							<hr style="display: block; position: relative ; margin: 10px; background-color: gray; color: gray; border-color: gray;">
							
						<%
						
					}
				
				%>
			
			
			</div>			
			<div style="margin: 0 auto; width: 70%;">
				<table class="table" style="top:25px;">
				<tr>
					<th>내용</th>
					<td class="reply_textarea"><textarea  name="reply_content"  class="autosize" style=" width:100%; "></textarea></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: right;">
						<button class="btn" onclick="insert_reply()">등록</button>
					</td>
				</tr>
			</table>
			</div>
		</div>
		
		
	</div>
</div>
</body>
</html>