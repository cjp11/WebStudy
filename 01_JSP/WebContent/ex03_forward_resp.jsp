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
	<h2>ex03_forward_resp</h2>
	<h3>id: <%=id %></h3>
	<h3>pw: <%=pwd %></h3>
	
<%
	// 포워딩 처리
	RequestDispatcher rd = request.getRequestDispatcher("ex03_forward_resp-2.jsp");
	rd.forward(request,response);
%>
</body>
</html>