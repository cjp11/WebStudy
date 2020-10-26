<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>ex03_forward_req.jsp</h2>
	<form>
		아이디: <input type="text" name="id"><br>
		비밀번호: <input type="text" name="pwd">
		<input type="button" value = "포워딩" 
			onclick="send_forward(this.form)">
	</form>
	<script>
		function send_forward(frm) {
			frm.action = "ex03_forward_resp.jsp";
			frm.submit();
		}
	</script>
</body>
</html>