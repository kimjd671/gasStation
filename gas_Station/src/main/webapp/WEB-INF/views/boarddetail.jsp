<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<style type="text/css">
	#header,#footer{
		height: 80px;
		background-color: #70F170;
		text-align: center;
		line-height: 80px;
	}
	#container{
		width: 1000px;
		height: 550px;
		margin: 0 auto;
		overflow: auto;
	}
	a{text-decoration: none;}
	#replyForm{
	display: none;
	}
</style>
<script type="text/javascript">
	//글목록페이지로 돌아가기
	function boardList() {
		location.href="boardlist.do";
	}
</script>
<script type="text/javascript">
$(function () {
	$("#container form").submit(function () {
		var bool=true;
		$("#replyForm tr>td").each(function () {//[td,td,td,td,td....]길이만큼 each가 function을 실행
			if($(this).children().val()==""){
				alert($(this).children().attr("name")+"을 입력하세요");
				$(this).children().focus();//바로입력할수있게 포커스(커서)를 준다.
				bool=false;//submit이벤트 취소를 위한 값저장
				return false;
			}
		});//each종료
		return bool;//bool의 값이 false면 submit이벤트 취소됨
	});//submit종료
});
</script>
<script type="text/javascript">
	function replyForm() {
		$("#replyForm").show();
		var replyposition=$("#replyForm").offset().top;
// 		alert(replyposition);
		$("#container").animate({
			"scrollTop":replyposition
		},2000);
	}
</script>

</head>
<body>
<div id="container">
<h1>게시글<small>상세보기</small></h1>
<table class="table table-striped">
	<tr>
		<th>아이디</th>
		<td>${dto.id}</td>
	</tr>
	<tr>
		<th>제목</th>
		<td>${dto.title}</td>
	</tr>
	<tr>
		<th>작성일</th>
		<td>${dto.regdate}</td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea class="form-control" rows="10" cols="60" readonly="readonly">${dto.content}</textarea></td>
	</tr>
	<tr>
		<td colspan="2">
			<a class="btn btn-primary btn-sm" href="updateform.do?seq=${dto.seq}">수정</a>
			<a class="btn btn-danger btn-sm" href="muldel.do?chk=${dto.seq}">삭제</a>
			<button class="btn btn-warning btn-sm" onclick="replyForm()">답글</button>
			<input type="button" class="btn btn-success btn-sm" value="목록" onclick="boardList()"/>
			
		</td>
	</tr>
</table>
<div id="replyForm">
<hr/>
<h2>답글달기</h2>
	<form action="replyboard.do" method="post">
		<input type="hidden" name="seq" value="${dto.seq}"/>
		<table class="table table-striped">
			<tr>
				<th>아이디</th>
				<td><input type="text" class="form-control" name="id"/></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" class="form-control" name="title"/></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="10" class="form-control" cols="60" name="content"></textarea></td>
			</tr>
			<tr>
				<td colspan="2">
				<input type="submit" class="btn btn-primary btn-sm" value="답글추가"/>
				<input type="button" class="btn btn-success btn-sm" value="목록" onclick="boardList()"/>
				</td>
			</tr>
		</table>
	</form>	
</div>
</div>
</body>
</html>