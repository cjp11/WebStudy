<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.mystudy.mybatis.DBService"%>
<%@page import="com.mystudy.mybatis.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 전달 받은 데이터를 db에 입력처리
	1.파라미터 값을 MemberVO 타입의 객체(memberVO)에 저장
	2.mapper에 meberVO 데이터를 전달해서 DB입력 처리
	3.페이지 이동 처리: selectAll.jsp
 --%>
	<jsp:useBean id="memberVO" class="com.mystudy.mybatis.MemberVO"/>
	<jsp:setProperty property="*" name="memberVO"/>

<%
 	System.out.println("memberVO: " + memberVO);
 	
	//DB 연동 입력 처리
	// openSession() : 자동커밋 아님(명시적 커밋 필요)
	// openSession(true): 자동커밋
	SqlSession ss = DBService.getFactory().openSession();
	
	int result = 0;
	result = ss.insert("member2.insertMember", memberVO);
	try {
		ss.commit(); //명시적 커밋 처리
	} catch(Exception e) {
		ss.rollback(); //명시적 롤백 처리
		result = -1;
	} finally {
		ss.close();
	}
	System.out.println(result);
	if (result < 0) { //예외발생시
		response.sendRedirect("error.jsp");
	} else {
		response.sendRedirect("selectAll.jsp");
	} 
	
	
%>