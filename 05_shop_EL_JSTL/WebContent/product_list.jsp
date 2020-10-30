<%@page import="com.bc.mybatis.ShopVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 전달받은 제품분류목록(category) 값에 해당하는 제품정보를
    DB에서 조회 후 화면에 목록형태(테이블)로 표시 --%>
   <jsp:useBean id="dao" class="com.bc.mybatis.ShopDAO" scope="session"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%
   //전달받은 파라미터 값 추출
   String category = request.getParameter("category");
      
   //category 값으로 DB조회
   List<ShopVO> list = dao.list(category);
   System.out.println("list : " + list);
   pageContext.setAttribute("list", list);	// 두번째 인자는 Object 타입이므로 어떤 타입도 올 수 있음. 
											// getAttribute return type은 Object 이므로 
											// 알맞은 타입으로 강제 형변환하여 받아오는 것임. 
   //DB데이터 화면 표시
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품목록</title>
	<link href="CSS/menu.css" rel=stylesheet type="text/css">
	<style>
		table {
			width:600px;
			margin: 30px auto 0; /* 상 좌우 하 */
			border: 1px solid navy;
			border-collapse: collapse;
			font-size: 0.8em;
		}
		th, td {
			border: 1px solid navy;
			padding : 4px;
		}
		
		th {background-color: #445;}
		.red {color: red;}
	</style>
</head>
<body>
	<%@ include file="common/menu.jspf" %>
	
	<table>
		<thead>
			<tr>
				<th width="15%">제품번호</th>
				<th width="10%">이미지</th>
				<th width="20%">제품명</th>
				<th width="20%">판매가격</th>
				<th>비고</th>
				
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>rc-113</td>
				<td>
					<img src="images/pds1.jpg" width="100px">
				</td>
				<td>로체스인라인</td>
				<td>할인가:1150원<br>
					<span class="red">(할인율: 40%)</span>
				</td>
				<td>정가:42000원</td>
			</tr>
			<%-- 등록된 제품이 없는 경우 
			<c:if test="${list.size() == 0 }">--%>
			<c:if test="${empty list }">
				<tr>
					<td colspan="5">현재 등록된 제품이 없습니다(준비중)</td>
				</tr>
			</c:if>
			
			<%-- 등록된 제품이 있는 경우 --%>
			<c:if test="${not empty list }">
				<c:forEach var="vo" items="${list }">
					<tr>
						<td>${vo.p_num }</td>
						<td>
							<img src="images/${vo.getP_image_s()}" width="100px">
						</td>
						<td> <a href="product_content.jsp?p_num=${vo.p_num }">${vo.p_name }</a></td>
						<td>할인가: ${vo.p_saleprice }원<br>
							<span class="red">(할인율: ${vo.getPercent()}%)</span>
						</td>
						<td>정가:${ vo.getP_price()}원</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</body>
</html>