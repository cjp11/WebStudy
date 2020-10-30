<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<%-- 장바구니(cart)에 있는 제품목록을 화면에 표시 --%>
	<jsp:useBean id="cart" class="com.bc.mybatis.Cart" scope="session"/>
	<c:set var="list" value="${cart.getList() }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니(cart)</title>
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
		<thead>
			<tr>
				<th colspan="6">::장바구니 내용</th>
			</tr>
			<tr>
				<th>제품번호</th>
				<th>제품명</th>
				<th>단가</th>
				<th>수량</th>
				<th>금액</th>
				<th>삭제</th>
			</tr>
			
		</thead>
		<tbody>
			<c:if test="${empty list }">
				<tr>
					<td colspan="6">장바구니가 비었습니다</td>
				</tr>
			</c:if>
			<c:if test="${not empty list }">
				<c:forEach var="vo" items="${list }">
					<tr>
						<td>${vo.p_num }</td>
						<td>${vo.p_name }</td>
						<td><span class="red">판매가: ${vo.p_saleprice }</span>
							(정가: ${vo.p_price }원)</td>
						<td>
							<form action="editQuant.jsp">
								<input type="number" name="su" size="3"
									value="${vo.quant }">
								<input type="submit" value="수정">
								<input type="hidden" name="p_num" value="${vo.p_num }">
							</form>
						</td>
						<td>${vo.totalprice }원</td>
						<td>
							<input type="button" value="삭제"
								onclick='delProduct("${vo.p_num }")'>
						</td>
					
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="6">총 결제 금액: ${cart.total }</td>
			</tr>
		</tfoot>
	</table>
<script>
	function delProduct(pNum) {
		location.href = "delProduct.jsp?p_num=" + pNum;
	}
	
</script>

</body>
</html>