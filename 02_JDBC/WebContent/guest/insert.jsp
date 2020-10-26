<%@page import="java.sql.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%--전달 받은 데이터를 이용해서 DB에 입력 처리
    	정상입력: list.jsp 페이지로 이동(재요청 방식)
    	예외 발생: 현재 페이지 보여주기
    	 --%>
<%
	// post 요청 처리시 한글 처리를 위해 encoding 설정, 안하면 깨짐.
	request.setCharacterEncoding("utf-8");
%>
<%
	//1. 파라미터값 추출
	int sabun = Integer.parseInt(request.getParameter("sabun"));
	String name = request.getParameter("name");
	int pay = Integer.parseInt(request.getParameter("pay"));
	//2. DB 입력 처리
	//JDBC 프로그램 사용해서 사번구하기(사번: 가장 큰 사원번호 + 1111 자동생성)
		final String DRIVER = "oracle.jdbc.driver.OracleDriver";
   		final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
   		final String USER = "mystudy";
   		final String PASSWORD = "mystudypw";
   		
   		
   		Connection conn = null;
   		PreparedStatement pstmt = null;
   		
   		
   		//사용할 sql 쿼리
   		String sql = "INSERT INTO GUEST ";
   		sql += "	(SABUN, NAME, NALJA, PAY)";
   		sql += "VALUES (?,?,SYSDATE,?)";
   		
   		int result = -111;	// 예외처리 해주려고 임의 제어 변수 설정
   		try {
   			//1. 드라이버 로딩
   			Class.forName(DRIVER);
   			//2. DB 연결
   			conn = DriverManager.getConnection(URL, USER, PASSWORD);
   			//3. Statement 객체 생성(Connection 객체 사용)
   			pstmt = conn.prepareStatement(sql);
   			
   			//4. 쿼리 실행
   			//4-1. 바인드 변수에 값 매칭
   			pstmt.setInt(1,sabun);
   			pstmt.setString(2,name);
   			pstmt.setInt(3,pay);
   			//4-2. 쿼리 실행(Insert, Update, Delete)
   			result = pstmt.executeUpdate();
   			System.out.println(result);

   			
   			
   		}catch(SQLException e) {
   				result = -99990;
   				e.printStackTrace();
   		}finally {
   			
   			// 위의 내용이 정상처리시 페이지 이동
   			if(result > 0) {
   			
   	   			response.sendRedirect("list.jsp");
   			}
   			//6. 사용자원 반납처리(close)
   			try {
   				
   				if(pstmt != null) pstmt.close();
   				if(conn != null) conn.close();
   			}catch(Exception e) {
   				e.printStackTrace();
   			}
   		}
	//3. 페이지 이동처리
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원등록실패</title>
</head>
<body>
	<h1>사원 등록 실패</h1>
	<p>입력처리를 하지 못했습니다.<br>
	담당자에게 연락하시오(010-1234-5667)</p>
	
	<a href="addForm.jsp">입력 페이지로 이동</a>
	<a href="list.jsp">전체목록 보기</a>
</body>
</html>