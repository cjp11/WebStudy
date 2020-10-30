<%@page import="com.bc.mybatis.BBSVO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.bc.mybatis.DAO"%>
<%@page import="com.bc.mybatis.Paging"%>
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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BBS</title>
<style>
	#bbs table {
		width: 580px;
		border: 1px solid red;
	}
	
	#bbs table th, #bbs table td {
		border: 1px solid black;
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
				<tr>
					<td>10</td>
					<td>게시글 10</td>
					<td>글쓴이10</td>
					<td>2020.10.30</td>
					<td>3</td>
					
				</tr>
			</tbody>
			
			<tfoot>
				<tr>
					<td colspan="4">이전으로 1,2,3, 다음으로</td>
					<td>글쓰기 버튼</td>
				</tr>
			</tfoot>
		</table>
	</div>
</body>
</html>