<%@page import="com.mystudy.mybatis.DBService"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 전달 받은 id 값으로 DB데이터 삭제 후 전체 조회 페이지로 이동
	SqlSession 객체 생성시 오토커밋 상태로 생성
--%>

	<jsp:useBean id="memberVO" class="com.mystudy.mybatis.MemberVO"/>
	<jsp:setProperty property="*" name="memberVO"/>

<%
	// 위의 usebean 쓰지 않고 
	// String id = request.getParameter("id"); 로 받아서 써도 됨
	// 이 때는 ss.delete("member2.deleteMember",id); 로 처리
 	System.out.println("memberVO: " + memberVO);
 	
	//DB 연동 입력 처리
	// openSession() : 자동커밋 아님(명시적 커밋 필요)
	// openSession(true): 자동커밋
	SqlSession ss = DBService.getFactory().openSession(true);
	
	int result = 0;
	
	try {
		result = ss.delete("member2.deleteMember", memberVO);
	} catch(Exception e) {
		ss.rollback(); //명시적 롤백 처리
		result = -1;
	} finally {
		ss.close();
	}
	System.out.println(result);
	if (result <= 0) { //예외발생시
		response.sendRedirect("error.jsp");
	} else {
		response.sendRedirect("selectAll.jsp");
	} 
	
	
%>