<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>ex03_forward_resp-2 페이지</h2>
	<h3>id: <%=id %></h3>
	<h3>pwd: <%=pwd %></h3>
	
</body>
</html>