<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
	#container {
		width: 700px;
		margin: 0 auto;
	}
	h1, h3, p { text-align: center; }
	table { border-collapse: collapse; }
	table, th, td {
		border: 1px solid black;
		margin: 0 auto;
	}
	th { background-color: orange; }
	.center { text-align: center; }
	.border-none, .border-none td { border: none; }
</style>
</head>
<body>

<div id="container">
	<h1>회원가입</h1>
	<hr>
	
	<form action="controller?type=signup" method="post">
	<table>
		<tr>
			<th width="70">아이디</th>
			<td>
				<input type="text" name="id" size="30">
			</td>
		</tr>
		<tr>
			<th>성명</th>
			<td>
				<input type="text" name="name">
			</td>
		</tr>
		<tr>
			<th>암호</th>
			<td>
				<input type="password" name="password">
			</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>
				<input type="email" name="email">
			</td>
		</tr>
		<tr>
			<td colspan="2" class="center">
				<input type="submit" value="회원가입">
			</td>
		</tr>
	</table>
	</form>
	<p><a href="controller?type=login">로그인 페이지로 이동</a></p>
</div>

</body>
</html>











