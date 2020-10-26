<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="ex02_redirect_resp.jsp" ><!-- name="ex02_redirect_resp~~~.jsp" value="redirect_resp.jsp"-->
		<select name="site">
			<option value="naver">네이버</option>
			<option value="google">구글</option>
			<option value="daum">다음</option>
		</select>
		<input type="submit" value="웹사이트 이동하라">
	</form>
</body>
</html>