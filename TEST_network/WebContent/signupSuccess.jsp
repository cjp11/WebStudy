<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입성공</title>
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
	<h1>회원가입성공!!!!</h1>
	<hr>
	<h3>회원가입정보</h3>
	
	<table>
		<tr>
			<th width="70">아이디</th>
			<td>
				<input type="text" name="id" size="30" value="${member.id }">
			</td>
		</tr>
		<tr>
			<th>성명</th>
			<td>
				<input type="text" name="name" value="${member.name }">
			</td>
		</tr>
		<tr>
			<th>암호</th>
			<td>
				<input type="password" name="password" value="${member.password }">
			</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>
				<input type="email" name="email" value="${member.email }">
			</td>
		</tr>
	</table>
	<p><a href="index.jsp">시작페이지(index.jsp) 이동</a></p>
</div>

</body>
</html>











