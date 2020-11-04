<%@page import="com.bc.mybatis.BBSVO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.bc.mybatis.DAO"%>
<%@page import="com.bc.mybatis.Paging"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 현재 페이지 표시할 데이터를 화면 표시 
	1. 페이지 처리를 위한 객체(Paging) 생성해서 필요한 데이터 참조
	2. (DB) 전체 데이터 조회페이징 객체에 설정할 데이터 구하고 저장
	3. 페이징 객체에 설정할 데이터 구하고 저장
	4. (DB) 현재 페이지에 표시할 데이터 조회 
	5. 데이터 화면 표시
--%>

<%
	//페이징 처리를 위한 Paging 객체 생성해서 값을 읽고, 값 설정
	Paging p = new Paging();
	
	// 1. 전체 게시물의 수를 구하기
	System.out.println(DAO.getTotalCount());
	p.setTotalRecord(DAO.getTotalCount()); // 전체 게시글 수
	p.setTotalPage(); //전체 페이지 갯수 구하기
	System.out.println("전체 게시글 수 : " + p.getTotalRecord());
	System.out.println("전체 페이지 수 : " + p.getTotalPage());
	
	// 2. 현재 페이지 구하기
	String cPage = request.getParameter("cPage");
	if(cPage != null) {
		p.setNowPage(Integer.parseInt(cPage));
	}
	
	// 3. 현재 페이지에 표시할 게시글 시작번호(begin), 끝번호(end)
	p.setEnd(p.getNowPage() * p.getNumPerPage());
	p.setBegin(p.getEnd() - p.getNumPerPage() + 1);
	
	System.out.println("현재 페이지 : " + p.getNowPage());
	System.out.println("시작 글번호 : " + p.getBegin());
	System.out.println("끝 글번호 : " + p.getEnd());
	
	// 4. 블록 계산하기
	int nowPage = p.getNowPage();
	int currentBlock = (nowPage - 1) / (p.getPagePerBlock()) + 1;
	p.setEndPage(currentBlock * p.getPagePerBlock());
	p.setBeginPage(p.getEndPage() - p.getPagePerBlock() + 1);
	
	System.out.println("-----블럭의 시작, 끝 페이지 ----- ");
	System.out.println("현재 페이지  " + p.getNowPage());
	System.out.println("시작 페이지  " + p.getBeginPage());
	System.out.println("끝 페이지 " + p.getEndPage());
	
	// 5. 끝 페이지(endPage)가 전체 페이지 수(totalPage) 보다 크면
	//    끝 페이지 값을 전체 페이지 수로 변경 처리
	if(p.getEndPage() > p.getTotalPage()) {
		p.setEndPage(p.getTotalPage());
	}
	System.out.println(p.getEndPage());
	
	// 현재 페이지 기준으로 DB데이터(게시글) 가져오기
	// 시작 글번호, 끝 글번호로 Map 데이터 만들어서 파라미터 전달
	Map<String,Integer> map = new HashMap<>();
	map.put("begin", p.getBegin());
	map.put("end", p.getEnd());
	
	List<BBSVO> list = DAO.getList(map);
	System.out.println("list: " + list);
%>

<%
	//===================
	//EL, JSTL 사용을 위해 scope에 데이터 등록(page 영역)
	pageContext.setAttribute("list", list);
	pageContext.setAttribute("pvo", p);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BBS</title>
<style>
	#bbs table {
		width: 580px;
		border: 1px solid black;
		border-collapse: collapse;
		font-size: 14px;
	}
	#bbs table caption {
		font-size: 20px;
		font-weight: bold;
		margin-bottom: 10px;
	}
	#bbs table th, #bbs table td {
		border: 1px solid black;
		text-align: center;
		padding: 4px 10px;
	}
	#bbs .align-left { text-align: left; }
	
	.paging {list-style: none;}
	.paging li {
		float: left;
		margin-right: 8px;
	}
	.paging li a {
		text-decoration: none;	
		display: block;
		border: 1px solid #00b3dc;
		padding: 3px 7px;
		font-weight: bold;
		
	}
	.paging.disable {
		border: 1px solid silver;
		padding: 3px 7px;
		color:silver;
	}
	
	.paging .now {
		border: 1px solid #ff4aa5;
		padding: 3px 7px;
		
	}
</style>
</head>
<body>
	<div id="bbs">
		<table>
	<caption>게시글 목록</caption>
	<thead>
		<tr class="title">
			<th class="no">번호</th>
			<th class="subject">제목</th>
			<th class="writer">글쓴이</th>
			<th class="regdate">날짜</th>
			<th class="hit">조회수</th>
		</tr>
	</thead>
	
	<tbody>
	<c:if test="${empty list }">
		<tr>
			<td colspan="5">현재 등록된 게시글이 없습니다</td>
		</tr>
	</c:if>
	<c:if test="${not empty list }">
		<c:forEach var="vo" items="${list }">
		<tr>
			<td>${vo.b_idx }</td>
			<td class="align-left">
				<a href="view.jsp?b_idx=${vo.b_idx }&cPage=${pvo.nowPage}">${vo.subject }</a></td>
			<td>${vo.writer }</td>
			<td>${vo.write_date.substring(0,10) }</td>
			<td>${vo.hit }</td>
		</tr>
		</c:forEach>
	</c:if>
		
	</tbody>
	
	<tfoot>
		<tr>
			<td colspan="4">
				<ol class="paging">
					<%--[이전으로] 사용불가 또는 안보이게 : 첫번째 블록인경우 --%>
				<c:if test="${pvo.beginPage == 1}">	
					<li class="disable">이전으로</li>
				</c:if>
				<c:if test="${pvo.beginPage != 1}">	
					<li>
						<a href="list.jsp?cPage=${pvo.beginPage - 1 }">이전으로</a>
					</li>
				</c:if>
				<%-- 페이지 표시(시작~끝페이지) --%>
				<c:forEach var="pageNo" begin="${pvo.beginPage }" end="${pvo.endPage }">
				<c:if test="${pageNo == pvo.nowPage }"> 
				 	<li class="now">${pageNo }</li> 
				</c:if>
				<c:if test="${pageNo != pvo.nowPage }">
				 	<li>
				 		<a href="list.jsp?cPage=${pageNo }">${pageNo }</a>
				 	</li>
				</c:if> 
				</c:forEach>
				<c:if test="${pvo.endPage >= pvo.totalPage }">	
				 	<li class="disable">다음으로</li>
				</c:if> 
				<c:if test="${pvo.endPage < pvo.totalPage }">	
				 	<li>
				 		<a href="list.jsp?cPage=${pvo.endPage + 1 }">다음으로</a>
				 	</li>
				</c:if> 
				</ol>
			</td>
			<td>
				<input type="button" value="글쓰기"
					onclick="javascript:location.href='write.jsp'">
			</td>
		</tr>
	</tfoot>

</table>
	</div>
</body>
</html>