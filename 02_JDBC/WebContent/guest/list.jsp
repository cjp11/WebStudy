<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%--JDBC 프로그램으로 DB데이터를 가져와서 화면 출력 --%>
   <%	// JDBC 프로그램을 위한 변수 선언
   		final String DRIVER = "oracle.jdbc.driver.OracleDriver";
   		final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
   		final String USER = "mystudy";
   		final String PASSWORD = "mystudypw";
   		
   		Connection conn = null;
   		PreparedStatement pstmt = null;
   		ResultSet rs = null;
   		
   		//사용할 sql 쿼리
   		String sql = "SELECT ROWNUM AS RN, SABUN, NAME, NALJA, PAY ";
   		sql += "FROM GUEST ";
   		sql += "ORDER BY SABUN";
   		
   		int cnt = 0;	// 사원수
   %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 목록</title>
</head>
<body>
   <h1>사원 목록</h1>
   <table border>
      <thead>
         <tr>
            <th>번호</th>
            <th>사번</th>
            <th>성명</th>
            <th>날짜</th>
            <th>금액</th>
            <th>상세보기</th>
         </tr>
      </thead>
      <tbody>
      <%--
      	<tr>
      		<td>1</td>
      		<td>1111</td>
      		<td>USER-1</td>
      		<td>2020/10/21</td>
      		<td>1000</td>
      		<td>상세보기</td>
      	<tr>
      	--%>
<%
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
		while(rs.next()) { 
%>
		 
		<tr>
      		<td><%=rs.getInt("RN") %></td>
      		<td><%=rs.getInt("sabun") %></td>
      		<td><%=rs.getString(3) %></td>
      		<td><%=rs.getDate("nalja") %></td>
      		<td><%=rs.getInt(5) %></td>
      		<td><a href="detail.jsp?idx=<%=rs.getInt("SABUN") %>">상세보기</a></td>
      		
      	</tr>
<%
		}
		rs.close();
		rs = pstmt.executeQuery("SELECT COUNT(*) as cnt FROM GUEST");
		if(rs.next()) {
			cnt = rs.getInt("cnt");
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
      </tbody>
   </table>
   <P>총원: <%=cnt %> </P>
   <p><a href="addForm.jsp">사원등록</a></p>	<!-- 상대주소 방식임, /addForm.jsp로 하면 절대 경로주소 방식 -->
</body>
</html>