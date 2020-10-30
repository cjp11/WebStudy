<%@page import="com.mystudy.mybatis.MemberVO"%>
<%@page import="com.mystudy.mybatis.DBService"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 전달받은 데이터(id)를 사용 DB데이터를 조회 후 화면 표시 --%>
<%
	//1. 파라미터 값 추출
	String id = request.getParameter("id");
	//System.out.println(id);
	//2. DB연동 작업 - SqlSession 객체 생성하고 DB 데이터 조회
	SqlSession ss = DBService.getFactory().openSession();
	MemberVO vo = ss.selectOne("member2.selectOne", id); //네임스페이스.id명
	ss.close();
	
	//3. 조회 데이터 화면표시(출력)
	System.out.println("vo : " + vo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID검색</title>
<script src="includee/event.js" type="text/javascript"></script>
</head>
<body>
	<%@ include file="includee/menu.jspf" %>
	
	<h1>ID검색 데이터 조회 결과</h1>
<%
	if (vo != null) { //데이터 있음
%>
	<ul>
		<li><%=vo.getIdx() %> :: 
			<%=vo.getId() %> :: 
			<%=vo.getName() %> :: 
			<%=vo.getAddress() %>
		</li>		
	</ul>
<%
	} else { //조회 데이터가 없을 때
		out.println("<h2>검색된 데이터가 없습니다</h2>");
	}
%>
</body>
</html>
