<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 제품번호, 수량을 전달받아 장바구니(cart) 데이터 수정 후
	장바구니 보기 페이지로 이동 --%>
	<jsp:useBean id="cart" class="com.bc.mybatis.Cart" scope="session"/>
	
<%
	//1. 파라미터 값 추출
	String pNum = request.getParameter("p_num");
	int su = Integer.parseInt(request.getParameter("su"));
	
	//2. 카트(cart)에서 제품 수량 변경
	cart.editQuant(pNum,su);
	
	//3. 화면 전환(cartList.jsp)
	response.sendRedirect("cartList.jsp");
%>