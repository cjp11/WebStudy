<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 전달 받은 데이터를 디비에서 삭제
	  정상 처리 후: list.jsp 이동
	  예외 발생시: 현재 페이지 보여주기(링크추가: 상세보기, 목록보기) --%>
<%
	// post 요청 처리시 한글 처리를 위해 encoding 설정, 안하면 깨짐.
	request.setCharacterEncoding("utf-8");
%>
<%
// 파라미터 값 추출
	int idx = Integer.parseInt(request.getParameter("idx"));

	System.out.println(idx);

	final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	final String USER = "mystudy";
	final String PASSWORD = "mystudypw";
	
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	//사용할 sql 쿼리
	String sql = "DELETE FROM GUEST ";
	sql += " WHERE SABUN = ?";
	
	
	try {
		//1. 드라이버 로딩
		Class.forName(DRIVER);
		//2. DB 연결
		conn = DriverManager.getConnection(URL, USER, PASSWORD);
		//3. Statement 객체 생성(Connection 객체 사용)
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1, idx);
		
		pstmt.executeUpdate();
		
	}catch(SQLException e) {
		e.printStackTrace(); 
	}finally {
		
		try {
			
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정보 삭제하기</title>
</head>
<body>
<h1>삭제 처리 완료</h1>
	
	<a href="list.jsp">입력 페이지로 이동</a>

</body>
</html>