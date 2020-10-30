<%@page import="com.bc.mybatis.ShopVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%-- 전달 받은 제품 번호를 사용해서 DB데이터 조회 후 화면 표시--%>

<%
	String pNum = request.getParameter("p_num");
%>

<jsp:useBean id="dao" class="com.bc.mybatis.ShopDAO" scope="session"/>
<%
	ShopVO vo = dao.selectOne(pNum);
	System.out.println(pNum);
	System.out.println("vo: "+ vo);
	
	//EL, JSTL 사용을 위한 속성값 설정
	pageContext.setAttribute("vo", vo);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품상세보기</title>
<link href="css/menu.css" rel="stylesheet" type="text/css">
<style>
	table {
		width: 600px;
		margin: 30px auto 0; /* 상 좌우 하 */
		border: 1px solid navy;
		border-collapse: collapse;
		font-size: 0.8em;
	}
	th, td { border: 1px solid navy; padding: 4px; }
	th { background-color: #ddd; }
	.red { color: red; }
	
	tfoot {height: 3em; padding: 20px 0;}
	.center { text-align: center; }
	.title {width:30%;}
</style>
</head>
<body>
<%@ include file="common/menu.jspf" %>

	<table>
		<tbody>
			<tr>
				<th>품목코드</th>
				<td>${vo.category }</td>
			</tr>
			<tr>
				<th>제품번호</th>
				<td>${vo.p_num }</td>
			</tr>
			<tr>
				<th>제품명</th>
				<td>${vo.p_name }</td>
			</tr>
			<tr>
				<th>제조사</th>
				<td>${vo.p_company }</td>
			</tr>
			<tr>
				<th>가격</th>
				<td>정가: ${vo.p_price }원 
					<span class="red">(할인가격: ${vo.p_saleprice }원)</span></td>
			</tr>
			<tr>
				<th>제품 설명</th>
				<td>${vo.p_content}</td>
			</tr>
			<tr>
				<td colspan="2">
					<img src="images/${vo.getP_image_l() }" alt="제품이미지">
				</td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="2">
					<input type="button" value="장바구니 담기"
						onclick="add()">
					<input type="button" value="장바구니 보기"
						onclick="cart_go()">
				</td>
			</tr>
	</table>
	<script>
		function add() {
			location.href = "addProduct.jsp?p_num=${vo.p_num}";
			
		}
		
		function cart_go() {
			location.href = "cartList.jsp";
			
		}
	</script>
</body>
</html>
