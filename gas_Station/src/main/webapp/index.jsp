<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	function gotest(){
		var x=$("input[name=x]").val();
		var y=$("input[name=y]").val();
		
		location.href="main.do?x="+x+"&y="+y;
	}
</script>
</head>
<body>
<input type="hidden" name="x">
<input type="hidden" name="y">
<button onclick="gotest()">메인페이지</button>
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
</body>
</html>