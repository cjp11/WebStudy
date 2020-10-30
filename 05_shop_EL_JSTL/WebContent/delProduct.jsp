<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<jsp:useBean id="cart" class="com.bc.mybatis.Cart" scope="session"/>
	
<%
	//1. 파라미터 값 추출
	String pNum = request.getParameter("p_num");
	
	//2. 카트(cart)에서 품목 삭제
	cart.delProduct(pNum);
	
	//3. 화면 전환(cartList.jsp)
	response.sendRedirect("cartList.jsp");
%>