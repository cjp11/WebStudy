<%@page import="com.bc.mybatis.CommVO"%>
<%@page import="java.util.List"%>
<%@page import="com.bc.mybatis.BBSVO"%>
<%@page import="com.bc.mybatis.DAO"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 전달 받은 파라미터 값 b_id 사용해서
	1. 게시글 조회수 1증가(실습)
	2. 게시글(b_idx) 데이터 조회 후 화면 표시
	3. 게시글(b_idx)에 딸린 댓글이 있으면 화면 표시 --%>
	
<%
	// 파라미터 값 추출
	String b_idx = request.getParameter("b_idx");
	String cPage = request.getParameter("cPage");
	
	//1. 게시글 조회수 1증가
	//DAO.updateHit(Integer.parseInt(b_idx));
	//2. 게시글(b_idx) 데이터 조회 후 화면 표시
	BBSVO vo = DAO.selectOne(b_idx);
	System.out.println("vo: " + vo);
	//3. 게시글(b_idx)에 딸린 댓글이 있으면 화면 표시
	
	List<CommVO> list = DAO.getCommentList(b_idx);
%>
<%
	//EL, JSTL 사용 위한 scope 상에 속성 등록하고 화면 표시
	pageContext.setAttribute("c_list",list);	//page scope
	session.setAttribute("bvo",vo);				//session scope
	session.setAttribute("cPage",cPage);
	
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function modify_go() {
		document.frm.action = "modify.jsp"
		document.frm.submit();
	}
	function delete_go() {
		document.frm.action = "delete.jsp"
		document.frm.submit();
	}
	function list_go() {
		document.frm.action = "list.jsp"
		document.frm.submit();
	}
</script>
</head>
<body>
	<div id=bbs>
	<%-- 게시글 표시 --%>
	<form method="post" name="frm">
		<table>
			<caption>상세보기</caption>
			<tbody>
				<tr>
					<th>제목</th>
					<td>${bvo.subject }</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${bvo.writer }</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td>
						<c:if test="${empty bvo.file_name }">
							첨부파일 없음
						</c:if>
						<c:if test="${not empty bvo.file_name }">
							<a href="download.jsp?f_name=${bvo.file_name }">$bvo.file_name</a>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>${bvo.content }</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2">
						<input type="button" value="수정" onclick="modify_go()">
						<input type="button" value="삭제" onclick="delete_go()">
						<input type="button" value="목록" onclick="list_go()">
						<!-- 세션스코프에 등록이 되었으므로 히든 처리를 하지 않아도 된다 
						<input type="hidden" value="${cPage }" name="cPage"> -->
					</td>
				</tr>
						
			</tfoot>
		</table>
	</form>
	<hr>
	
	<%-- 게시글에 대한 댓글 작성영역 --%>
	<form action="ans_write_ok.jsp" method="post">
		<p>이름: <input type="text" name="writer">
			비밀번호: <input type="password" name="pwd">
		</p>
		<p>내용: <textarea name="content" rows="4" cols="55"></textarea></p>
		<input type="submit" value="댓글저장">
		<input type="hidden" name="b_idx" value="${bvo.b_idx }">
	</form>
	<hr>
	댓글들
	<hr>
	<%-- 댓글 표시 영역 --%>
	<c:forEach var="commVO" items="${c_list }">
	<div class="comment">
		<form action="ans_del_ok.jsp" method="post">
			<p>작성자 : ${commVO.writer } &nbsp;&nbsp; 날짜 : ${commVO.write_date }</p>
			<p>내용 : ${commVO.content }</p>
			
			<input type="submit" value="댓글삭제">
			<input type="hidden" name="c_idx" value="${commVO.c_idx }">
		</form>
		
	
	</div>
	<hr>
	</c:forEach>
		
	</div>

</body>
</html>