<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>forEach varStatus</title>
</head>
<body>
<%
	List<String> list = new ArrayList<>();
	list.add("홍길동-1");
	list.add("홍길동-2");
	list.add("홍길동-3");
	list.add("홍길동-4");
	pageContext.setAttribute("alist", list);
%>
	<h2>forEach List 데이터 화면 표시</h2>
	<c:forEach var="listItem" items="${alist }">
		${listItem } &nbsp;
	</c:forEach>
	<hr>
	
	<ol>
	<c:forEach var="listItem" items="${alist }"
		varStatus="status"
		begin="0" end="${alist.size() - 1 }" step="1">
		<li>
		var값 : ${listItem }<br>
		current : ${status.current }<br> <%-- 현재 처리중 데이터 --%>
		count : ${status.count }<br> <%--처리되는 데이터 건수 --%>
		index : ${status.index }<br> <%--인덱스 번호 --%>
		first : ${status.first }<br> <%--첫 번째 데이터 여부 --%>
		last : ${status.index }<br> <%--마지막 데이터 여부 --%>
		
		</li>
	</c:forEach>
	</ol>
</body>
</html>









