<%@page import="com.mystudy.mybatis.MemberVO"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="org.apache.ibatis.session.SqlSessionFactory"%>
<%@page import="com.mystudy.mybatis.DBService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--전체 데이터 보여주기(DB에서 가져와서) --%>
<%
	//DB 데이터 가져오기
	//SqlSessionFactory factory = DBService.getFactory();
	//SqlSession ss = factory.openSession();
	
	// openSession(), openSession(false): Auto commit 해제 상태(트랜잭션 처리 필요)
	// -> insert, update, delete 작업 후 명시적으로 commit 처리 필요
	// -> openSession(true): 자동 커밋 상태로 세션 객체 생성(sql문 실행 후 자동으로 커밋 처리됨)
	// JDBC는 Auto commit. 
	
	SqlSession ss = DBService.getFactory().openSession();
	List<MemberVO> memberList = ss.selectList("member2.selectAll");
	ss.close();
	System.out.println("memberList: " + memberList);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 데이터 표시</title>
<script src="includee/event.js" type="text/javascript"></script>
</head>
<body>
	<%@ include file ="includee/menu.jspf" %>

	<h1>전체 데이터 조회</h1>
	<ul>
	
	<% 
		if(memberList.size() > 0) { // 데이터가 있으면 
			for(MemberVO vo:memberList) {
	%>
		<li><%=vo.getIdx() %> :: 
			<%=vo.getId() %> :: 
			<%=vo.getName() %> :: 
			<%=vo.getAddress() %>
		</li>
		
	<% 
			}
		}else {
			System.out.print("<li>조회된 데이터가 없습니다");
		}
	%>
		
	</ul>
</body>
</html>