<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 전달 받은 사번으로 디비에서 데이터 조회해서 가져온 데이터를 화면에 표시 --%>
<%
	// post 요청 처리시 한글 처리를 위해 encoding 설정, 안하면 깨짐.
	request.setCharacterEncoding("utf-8");
%>
<%
		// 파라미터 값 추출
		int idx = Integer.parseInt(request.getParameter("idx"));

		final String DRIVER = "oracle.jdbc.driver.OracleDriver";
   		final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
   		final String USER = "mystudy";
   		final String PASSWORD = "mystudypw";
   		
   		
   		Connection conn = null;
   		PreparedStatement pstmt = null;
   		ResultSet rs = null;
   		
   		int sabun = 0;
   		String name = "";
   		Date nalja = null;
   		int pay = 0;
   		
   		//사용할 sql 쿼리
   		String sql = "SELECT SABUN, NAME, NALJA, PAY";
   		sql += " FROM GUEST";
   		sql += " WHERE SABUN = ?";
   		
   		
   		try {
   			//1. 드라이버 로딩
   			Class.forName(DRIVER);
   			//2. DB 연결
   			conn = DriverManager.getConnection(URL, USER, PASSWORD);
   			//3. Statement 객체 생성(Connection 객체 사용)
   			pstmt = conn.prepareStatement(sql);
   			
   			pstmt.setInt(1, idx);
   			
   			rs = pstmt.executeQuery();
   			
   			if(rs.next()) {
   				sabun = rs.getInt(1);
   				name = rs.getString(2);
   				nalja = rs.getDate(3);
   				pay = rs.getInt(4);
   			}
   			
   		}catch(SQLException e) {
   			e.printStackTrace();
   		}finally {
   			
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
<title>상세 정보</title>
</head>
<body>
	<h1>상세정보</h1>
	<table border>
		<tr>
			<th>사번</th>
			<td><%=sabun %></td>
		</tr>
		<tr>
			<th>이름</th>
			<td><%=name %></td>
		</tr>
		<tr>
			<th>날짜</th>
			<td><%=nalja %></td>
		</tr>
		<tr>
			<th>금액</th>
			<td><%=pay %></td>
		</tr>
	
	</table>
	<a href="editForm.jsp?idx=<%=sabun%>&name=<%=name%>&nalja=<%=nalja %>&pay=<%=pay%>">수정</a>
	<a href="delete.jsp?idx=<%=sabun %>">삭제</a>
</body>
</html>