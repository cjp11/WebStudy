<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서블릿변수(전역변수, 로컬변수)</title>
</head>
<body>
	<%!
		// 선언부(declaration)는 서블릿 필드 영역에 작성되는 코드
		int globalNum = 0;  
	%>
	<%
		// 스크립트릿 - service() 메소드 영역(로컬 영역, 로컬 변수 선언 및 업무처리 로직 작성)
		int localNum = 0;
		globalNum++;
		localNum++;
		System.out.println("globalNum: " + globalNum);
		System.out.println("localNum: " + localNum);
		
	%>
	<h2>globalNum: <%=globalNum %></h2>
	<h2>localNum: <%=localNum %></h2>
</body>
</html>