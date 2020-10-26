<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--DB연결하고 GUEST 테이블에서 새로운 사번을 만들어 사번 항복에 설정 --%>
<%
	//JDBC 프로그램 사용해서 사번구하기(사번: 가장 큰 사원번호 + 1111 자동생성)
		final String DRIVER = "oracle.jdbc.driver.OracleDriver";
   		final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
   		final String USER = "mystudy";
   		final String PASSWORD = "mystudypw";
   		
   		Connection conn = null;
   		PreparedStatement pstmt = null;
   		ResultSet rs = null;
   		
   		//사용할 sql 쿼리
   		String sql = "SELECT NVL(MAX(SABUN),0) + 1111 AS SABUN FROM GUEST ";
   		int sabun = 0;
   		
   		try {
   			//1. 드라이버 로딩
   			Class.forName(DRIVER);
   			//2. DB 연결
   			conn = DriverManager.getConnection(URL, USER, PASSWORD);
   			//3. Statement 객체 생성(Connection 객체 사용)
   			pstmt = conn.prepareStatement(sql);
   			//4. 쿼리 실행
   			rs = pstmt.executeQuery();
   			//5. 쿼리 실행 결과 처리
   			if(rs.next()) {
   				sabun = rs.getInt(1);
   			}
   		}catch(SQLException e) {
   				e.printStackTrace();
   		}finally {
   			//6. 사용자원 반납처리(close)
   			try {
   				if(rs != null) rs.close();
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
<title>Insert title here</title>
</head>
<body>
	<h1>사원등록</h1>
	<form action="insert.jsp" method="get">	<!-- post 방식일 경우, utf-8로 인코딩 한다는 표시가 필요(get 방식은 자동으로 해줌)-->
		<table>
			<tr>
				<th>사번</th>
				<td><input type="text" name="sabun" value="<%=sabun%>" readonly></td>
			</tr>
			<tr>
				<th>성명</th>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<th>금액</th>
				<td><input type="number" name="pay"></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="사원등록">
					<input type="reset" value="초기화">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>