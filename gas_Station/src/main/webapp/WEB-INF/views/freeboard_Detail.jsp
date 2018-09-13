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
.back_btn{cursor: pointer;margin: 15px;display: inline;}
#main_container{background-color: #3A3A3C; overflow-y: scroll; overflow-x:auto; width: 100%; height:100%; position: absolute; }
::-webkit-scrollbar{display:none;}
::-moz-scrollbar{display: none;}
a{color: white;  text-decoration:none;}
ul{list-style: none;}
.table{ margin: 0 auto; top: 50px;position: relative; border-collapse: collapse; width:100%;border: 1px solid #dfbe6a; color: white; line-height: 35px;}
td{border: 1px solid #dfbe6a; }
th{background-color:  #3A3A3C; color: white; border: 1px solid #dfbe6a;height: 34px; }
h3{color: white; text-align: center;}
.reply td{border:none}
#declar{position: absolute; z-index: 6; background-color: #3A3A3C; border: 5px solid #dfbe6a;  opacity: 0.95;width: 40%; height: 80%; position: absolute;top: 50%;left: 50%;  transform: translate(-50%, -50%); line-height:30px; display: none;}
#declar table{border: none; color: white; border-collapse: collapse; width: 100%; table-layout:fixed; height: 70%;}
#declar td,#declar th{border:none; border-bottom: 1px solid #dfbe6a;}
#detail_div{width: 70%; margin: 0 auto;}
.reply_decla{float: right; cursor: pointer;}
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
#update_form{
	display:none;  
	width: 70%; 
	height: 60%; 
	color:black; 
	background-color: #3A3A3C;
	position:absolute;  
	top: 50%;
	left: 49.9999%;  
	transform: translate(-50%, -50%);
	border:5px solid #dfbe6a;
	color: white;
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
		
		$("input:radio[name=dec]").click(function(){
			 var thisEle = event.target;
			 if(thisEle.id!="g_dec"){
				 $("textarea[name=g_dec_text]").prop("disabled", true);
			 }else{
				 $("textarea[name=g_dec_text]").prop("disabled", false);
			 }
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
		var up=confirm("수정하시겠습니까?");
		if(up){
			var seq='${dto.seq}';
			var title=$("input[name=title]").val();
			var content=$("textarea[name=content]").val();
			$.ajax({
				url:"freeboard_update.do",
				method:"get",
				data:{"seq":seq,
					"title":title,
					"content":content
				},
				async:false,
				dataType:"json",
				success:function(Data){
					var isS=Data["isS"];
					if(isS){
						close_update();
	 					location.reload();
					}else{
						alert("글수정실패");
					}
					
				},
				error:function(){
					alert("서버통신실패");
				}
			});
		}
		
	}
	
	function call_updateform(){
		var title='${dto.title}';
		var content='<%=dtos.getContent().replaceAll("\n", "<br>")%>';
		$("input[name=title]").val(title);
		$("textarea[name=content]").val(content.replace(/<br>/gi, "\r\n"));
		$("#update_form").fadeIn();
	}
	
	function close_update(){
		$("#update_form input").not("input[name=id]").val("");
		$("#update_form textarea").val("");
		$("#update_form").fadeOut();
	}
	
	function update_reply(seq){
		var he=$("#reply_view"+seq).height();
		var content=$("#reply_view"+seq).html();
		$("#reply_view"+seq).css("display","none");
		$("#reply_input"+seq).css("display","block");
		$("#reply_input"+seq).children("textarea").height(he);
		$("#reply_input"+seq).children("textarea").val(content.replace(/<br>/gi, "\r\n"));
		
		$("#reply_del"+seq).css("display","none");
		$("#reply_up"+seq).css("display","none");
		
		$("#reply_up_close"+seq).css("display","inline-block");
		$("#reply_up_done"+seq).css("display","inline-block");
		
	}
	function reply_up_close(seq) {
		
		$("#reply_view"+seq).css("display","block");
		$("#reply_input"+seq).css("display","none");
		
		$("#reply_del"+seq).css("display","inline-block");
		$("#reply_up"+seq).css("display","inline-block");
		
		$("#reply_up_close"+seq).css("display","none");
		$("#reply_up_done"+seq).css("display","none");
	}
	
	
	function reply_up_done(seq){
		
		var up=confirm("수정하시겠습니까?");
		if(up){
			var content=$("textarea[name=reply_"+seq+"]").val()
			$.ajax({
				url:"reply_update.do",
				method:"get",
				data:{"seq":seq,
					"content":content
				},
				async:false,
				dataType:"json",
				success:function(Data){
					var isS=Data["isS"];
					if(isS){
						$("#reply_view"+seq).html(content.replace(/\n/gi,"<br>"));
						reply_up_close(seq);
	 					
					}else{
						alert("댓글수정실패");
					}
					
				},
				error:function(){
					alert("서버통신실패");
				}
			});
		}
		
	}
	
	function reply_delete(seq){
		var up=confirm("삭제하시겠습니까?");
		if(up){
			$.ajax({
				url:"delete_reply.do",
				method:"get",
				data:{"seq":seq
				},
				async:false,
				dataType:"json",
				success:function(Data){
					var isS=Data["isS"];
					if(isS){
	 					location.reload();
					}else{
						alert("댓글삭제실패");
					}
					
				},
				error:function(){
					alert("서버통신실패");
				}
			});
		}
	}
	 function Declaration(board){
		 var sup=board.className;
		 if(sup=="board_decla"){
			 var id='${dto.id}';
	    	 var context=$("textarea[name=content_box]").val();
	    	 
	    	 $("#shadow").css("display","block");
	 		 $("#black_id").text(id);
	 		 $("#black_context").text(context);
		 }else if(sup=="reply_decla"){
			 var id=$(board).siblings("span").eq(0).text();
			 var context=$(board).parent().parent().next().children().eq(0).text();
			 $("#shadow").css("display","block");
	 		 $("#black_id").text(id);
	 		 $("#black_context").text(context);
		 }
    	 
    	 $("#declar").fadeIn();
    	 
     }
     
     function close_declar(){
    	$("#shadow").css("display","none");
    	$("textarea[name=g_dec_text]").val("");
 		$("#declar").fadeOut();
     }
	
     function send_decla(){
    	 var myid='${ldto.id}';
			if(myid==null||myid==""){
				myid=lid;
		}
		var black_id=$("#black_id").text();
		var content=$("#black_context").text();
		var why=$("input:radio[name=dec]:checked").val();
		if(why=="기타"){
			why=$("textarea[name=g_dec_text]").val();
			if(why.length==0){
				alert("신고내용을 작성해주세요.");
				return
			}
		}
    	 $.ajax({
 			url:"black_insert.do",
 			method:"get",
 			data:{"id":myid,
 				"black_id":black_id,
 				"why":why,
 				"content":content
 			},
 			async:false,
 			dataType:"json",
 			success:function(obj){
 				var isS=obj["isS"];
 				if(isS){
 					alert("신고처리 되었습니다.");
 					close_declar();
 				}else{
 					alert("시스템 오류");
 				}
 			},
 			error:function(){
 				alert("서버통신 실패");
 			}
 		});
     }
     
</script>

</head>
<body>
<div id="container">	
	<div id="main_container">
	<img class='back_btn' src='image/back.png' alt='돌아가기' onclick='parent.call_main_container()'>
		<div id="logo" style="margin: 0 auto; width: 66%;  text-align: center;display: inline-block; left: 40%; position: relative; transform: translate(-50%,-50%); ">
			<span class='login_logo'>글상세보기</span>
		</div>
		<div id="detail_div">
			<table class="table">
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
					<td>${dto.title}<div style="float: right; cursor:pointer;"><span class="board_decla" onclick='Declaration(this)' ${ldto.id==dto.id?"style='display:none;'":"" }>[신고하기]</span></div></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="content_box"  style="width: 100%; border:none; color: white; background-color:#3A3A3C; " rows="20" readonly="readonly" >${dto.content}</textarea></td>
				</tr>
				<tr>
					<td colspan="2">
						<div style="text-align: right; ">
							<button class="btn" onclick="display_reply()">댓글[${fn:length(reply)-1}]</button>
							<button class="btn" id="like_btn" onclick="likethis()">추천하기</button>
							<button class="btn" ${ldto.id==dto.id ||ldto.role=='ADMIN'?"":"style='display:none;'"} onclick="delete_board('${dto.seq}')">삭제</button>
							<button class="btn" ${ldto.id==dto.id ||ldto.role=='ADMIN'?"":"style='display:none;'"} onclick="call_updateform()">수정</button>
							<button class="btn" onclick="location.href='boardlist.do?page=<%=pageNum%>'">글목록</button>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div id="replyform" style="position: relative; top: 50px; display: none;">
			<h3>댓글</h3>
			<div id="reply_div" style="width: 70%; margin: 0 auto;" >
					<%
					if(reply==null || reply.size()<=1){
						%>
							<span style="color: white;">작성된 댓글이 없습니다.</span>
							<hr style="display: block; position: relative ; margin: 10px; background-color: gray; color: gray; border-color: gray;">
						<%
					}
					for(int i=1;i<reply.size();i++){
						FreeBoardDto redto=reply.get(i);
						%>
							<table class="table reply"  style="top:0; position: relative;">
								<tr>	
									<td><span><%=redto.getId()%></span>(<%=yyyyMMddhhmm.format(redto.getRegdate())%>)<span class="reply_decla" onclick='Declaration(this)' <%=ldtos.getId().equals(redto.getId())?"style='display:none;'":"" %>>[신고하기]</span></td>
								</tr>
								<tr>
									<td id="reply_view<%=redto.getSeq()%>"><%=redto.getContent().replaceAll("\n", "<br>")%></td>
									<td id="reply_input<%=redto.getSeq()%>" style="display: none; "><textarea name="reply_<%=redto.getSeq()%>" class="autosize" style=" width:100%; "></textarea></td>
								</tr>
								<tr>
									<td style="text-align: right;">
										<div>	
											<button id="reply_up<%=redto.getSeq()%>"class="btn" <%=ldtos.getId().equals(redto.getId())?"":"style='display:none;'" %> onclick="update_reply('<%=redto.getSeq()%>')">수정</button>
											<button id="reply_del<%=redto.getSeq()%>" class="btn" <%=ldtos.getId().equals(redto.getId())?"":"style='display:none;'" %> onclick="reply_delete('<%=redto.getSeq()%>')">삭제</button>
											<button id="reply_up_done<%=redto.getSeq()%>" class="btn" style="display: none;" onclick="reply_up_done('<%=redto.getSeq()%>')">수정완료</button>
											<button id="reply_up_close<%=redto.getSeq()%>" style="display: none;" class="btn" onclick="reply_up_close('<%=redto.getSeq()%>')">취소</button>
										</div>
									</td>
								</tr>
							</table>
							<hr style="display: block; position: relative ; margin: 10px; background-color: gray; color: gray; border-color: gray;">
							
						<%
						
					}
				
				%>
			
			
			</div>			
			<div style="margin: 0 auto; width: 70%; ">
				<table class="table" style="top:15px;">
				<tr>
					<th>내용</th>
					<td class="reply_textarea"><textarea  name="reply_content"  class="autosize" style="font-size:15px; width:100%;" placeholder="내용을 입력하세요"></textarea></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: right;">
						<button class="btn" onclick="insert_reply()">등록</button>
					</td>
				</tr>
			</table>
			
			</div>
			<br>
			<br>
		</div>
		<div id="update_form">
				<br>
				<span class='login_logo' style="font-size: 50px; text-align: center;">글수정</span>
				<table style="width: 95%;  margin: 0 auto; position: relative; top: 15px; border-collapse: collapse;">
					<col width="100px;">
					<tr>
						<th>아이디</th>
						<td><input type="text" name="id" style="background-color: #3A3A3C; color:white; border:none; width: 150px;" readonly="readonly" value="${dto.id}"></td>
					</tr>
					<tr>
						<th>제목</th>
						<td><input type="text" name="title" style="background-color: #3A3A3C; color:white; border:none; width: 90%;"></td>
					</tr>
			
					<tr>
						<th>내용</th>
						<td><textarea rows="20" style="background-color: #3A3A3C; color:white; border:none; width: 100%;" name="content"></textarea></td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: right;">
							<button class="btn" onclick="update_board()">완료</button>
							<button class="btn" onclick="close_update()">취소</button>
						</td>
					</tr>
				</table>
		</div>
		
	</div>
</div>
<div id="declar">
	<img alt="창닫기" src="image/close.png" onclick="close_declar()" style="z-index:10; float: right; position: relative; top: 10px; left: -10px; cursor: pointer;">
	
	<span class="login_logo" style="font-size: 40px; top:30px; text-align: center;">신고하기</span>
	<table style="position: relative; top: 30px;"> 
	 <col width="100px">
		<tr>
			<th >아이디</th>
			<td id="black_id"></td>
		</tr>
		<tr>
			<th>내용</th>
			<td id="black_context" height="135px" style="overflow: scroll; word-break:break-all;"></td>
		</tr>
		<tr>
			<th>사유</th>
			<td>
				<input type="radio" name="dec" value="홍보성">홍보성
				<br>
				<input type="radio" name="dec" value="불법정보">불법정보
				<br>
				<input type="radio" name="dec" value="음란성">음란성
				<br>
				<input type="radio" name="dec" value="욕설/인신공격">욕설/인신공격
				<br>
				<input type="radio" name="dec" value="개인정보노출">개인정보노출
				<br>
				<input type="radio" name="dec" value="도배">도배
				<br>
				<input type="radio" name="dec" id="g_dec" value="기타">기타
				<br>
				<textarea rows="4" cols="60" name="g_dec_text" disabled="disabled" placeholder="기타 항목 선택 후 입력해주세요(최대 500자)"></textarea>
			</td>
		</tr>
		<tr>
			<th colspan="2"><button class="btn" onclick="send_decla()">신고하기</button> </th>
		</tr>
	</table>
</div>
</body>
</html>