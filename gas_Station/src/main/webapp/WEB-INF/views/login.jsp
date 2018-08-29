<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<style type="text/css">
	#regist_form{
		border:5px solid #dfbe6a;
	}
	.r_input{
		border:1px solid #dfbe6a;
/* 		background-color: #3A3A3C; */
/* 		color: #dfbe6a; */
	}
	#find_form{
		background-color: #3A3A3C; 
		color: #dfbe6a;
		border:5px solid #dfbe6a;
	}
	p{
		color: #dfbe6a;
	}
	.btn_mini {
	  display: inline-block;
	  background: transparent;
	  text-transform: uppercase; 
	  font-weight: 500; 
	  font-style: normal; 
	  font-size: 1rem; 
	  letter-spacing: 0.3em; 
	  color: rgba(223,190,106,0.7);
	  border-radius: 0;
	  padding: 5px 10px 5px;
	  transition: all 0.7s ease-out;
	  background: linear-gradient(270deg, rgba(223,190,106,0.8), rgba(146,111,52,0.8), rgba(34,34,34,0), rgba(34,34,34,0));
	  background-position: 1% 50%;
	  background-size: 300% 300%;
	  text-decoration: none;
	  margin: 10px 20px 0px 30px;
	  border: none;
	  border: 1px solid rgba(223,190,106,0.3);
	}
	.btn_mini:hover {
	  color: #fff;
	  border: 1px solid rgba(223,190,106,0);
	  color: $white;
	  background-position: 99% 50%;
	}
	.find_find{
		color: #dfbe6a;
	}
	.find_input{
		background-color: #3A3A3C; 
		color: white;
		border: 1px solid #dfbe6a;
	}

</style>
</head>
<body>
<div id="sub_container">
	<img class="back_btn" src="image/back.png" alt="돌아가기" onclick="call_main_container()">
	<div id="logo" style="margin: 0 auto; width: 66%; text-align: center; ">
		<span class='login_logo'>주유를 어디서 하주유???</span>
	</div>
	<div id="login_main" style=" margin: 0 auto; width: 66%; height: 61%;">
		<div id="login_input" style="width: 60%; margin: 0 auto; position: relative; top: 120px;">
			<div id="id_input_div">
			<span class="input_title">아이디</span>
				<input class="l_input" type="text" name="login_id">
			</div>
			<div id="pwd_input_div">
			<span class="input_title">비밀번호</span>
				<input class="l_input" type="password" onkeyup="enterkey()" name="login_pwd">
			</div>
			<button class="btn" onclick="gas_login()"  style="position: relative; left: 23%; ">로그인</button>
			<hr style="color:#dfbe6a; background-color: #dfbe6a; border-color: #dfbe6a;">
			<div id="login_sub">
				<ul>
					<li style="border: none;" onclick="findForm()">아이디/비밀번호 찾기</li>
					<li onclick="registForm()">회원가입</li>
				</ul>
			</div>
		</div>
	</div>
	<div id="regist_form">
		<br>
		<div style="text-align: center;">
			<span class="login_logo" style="font-size: 60px;">회원가입</span>
		</div>
		<div class="r_div">
			<span class="regist_category">ID</span>
			<input type="text" class='r_input' name="id"  placeholder="아이디  입력(6~20자,영문,숫자)" oninput="chk_id()">
		</div>
		<div class="r_div">
			<span class="regist_category">PASSWORD</span>
			<input type="password" class='r_input' name="password"  placeholder="비밀번호 입력(8~20자,영문,숫자)" oninput="pwd_chk()">
		</div>
		<div class="r_div">
			<span class="regist_category">PASSWORD</span>
			<input type="password" class='r_input' name="repassword" placeholder="비밀번호  재입력" oninput="repwd_chk()">
		</div>
		<div class="r_div">
			<span class="regist_category">NAME</span>
			<input type="text" class='r_input' name="name" placeholder="이름 입력">
		</div>
		<div class="r_div">
			<span class="regist_category">E-MAIL</span>
			<input type="text" class='r_input' name="email" placeholder="이메일 입력">
		</div>
		<div class="r_div">
			<span class="regist_category">PHONE</span>
			<input type="text" class='r_input' name="phone" placeholder="숫자만 입력" oninput="chk_phone()">
		</div>
		<br>
		<hr style="color:#dfbe6a; background-color: #dfbe6a; border-color: #dfbe6a;">
		<div style="width: 100%; height:10%; padding: 0; margin: 0;" >
		<ul style="width: 100%; height:100%; padding: 0; margin: 0;">
			<li style="border: none; position: relative; top: -5px;" id="r_cancel_btn" onclick="close_regi()"><span>취소</span></li>
			<li style="position: relative; top: -5px;" id="r_ok_btn" onclick="insert_user()"><span>확인</span></li>
		</ul>
		</div>
	</div>

	<div id="find_form" style="color: gray; display: none;">
		<span class="login_logo" style="font-size: 32px; margin: 10px; padding: 10px; text-align: center;">아이디 비밀번호 찾기</span>
		<img alt="나가기" src="image/close.png" onclick="close_find()" style="float: right; position: relative; top: -65px; left: -10px; cursor: pointer;">
		<hr style="clear: both; color:#dfbe6a; background-color: #dfbe6a; border-color: #dfbe6a;"/>
		<div id="idpwd">
			<table id="sel">
				<col width="200px">
				<col width="200px"> 
				<tr>
					<th>
						<img src="image/id.png" alt="아이디찾기" onclick="find_id();"/>
						<p>아이디 찾기</p>
					</th>
					<th style="border-left: 1px solid #dfbe6a;">
						<img src="image/pwd.png" alt="비밀번호찾기" onclick="find_pwd();"/>
						<p>비밀번호 찾기</p>
					</th>
				</tr>
			</table>
			<div id="findid">
				<table>
					<col width="100px">
					<col width="200px">	
					<tr>
						<th class="find_find">이름</th>
						<td><input class="find_input" type="text" name="f_name" required="required"></td>
					</tr>
					<tr>
						<th class="find_find">연락처<br>(-제외 입력)</th>
						<td><input class="find_input" type="text" name="f_phone" required="required" onkeyup="enterkey_find_id()"></td>
					</tr>
					<tr>
						<th colspan="2">
							<button onclick="find_id_ajax()" class="btn_mini">확인</button>
						</th>
					</tr>
				</table>
			</div>
			<div id="findpwd">
				<table>
					<col width="100px">
					<col width="200px">	
					<tr>
						<th class="find_find">아이디</th>
						<td><input class="find_input" type="text" name="f_id" required="required"></td>
					</tr>
					<tr>
						<th class="find_find">이메일</th>
						<td><input class="find_input" type="text" name="f_email" required="required" onkeyup="enterkey_find_pw()">
					</tr>
					<tr>
						<th colspan="2">
							<button onclick="find_pwd_ajax()" class="btn_mini">확인</button>
						</th>
					</tr>
				</table>
			</div>
			<div id="id_list">
				<fieldset style="text-align: left;" >
					<legend>ID</legend>
					조회된 회원님의 아이디수는<span id="id_index"></span>개 입니다.
					<br>
					<ul id="find_id_list">
					
					</ul>
					<br>
				</fieldset>
			</div>
			<div id="pwd_reset">
				<table>
					<tr>
						<th>새비밀번호 	:</th>
						<td><input type="password" name="reset_pwd" required="required"></td>
					</tr>
					<tr>
						<th>새비밀번호 확인 :</th>
						<td><input type="password" name="reset_pwd" required="required"></td>
					</tr>
					<tr>
						<th colspan="2">
							<button class="btn_mini" onclick="pwd_reset()">변경</button>
						</th>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<iframe id="frame_sub" style="display: none;"></iframe>
</div>
</body>
</html>