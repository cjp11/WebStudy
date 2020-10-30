<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL</title>
</head>
<body>
<%-- JSTL(JSP Standard Tag Library)
	0. 라이브러리 구하기(인터넷)
		다운로드 : https://tomcat.apache.org/download-taglibs.cgi
		다운로드 : https://mvnrepository.com/ > jstl 검색
	1. 라이브러리 등록
		WebContent > WEB-INF > lib > jar 파일 추가
	2. 사용시 JSTL 디렉티브(지시어)	taglib 추가
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
--%>
	<h2>JSTL 사용</h2>
	<h3>속성설정 : set</h3>
	<%-- set : 속성 값 설정 태그 setAttribute 역학
		<c:set var="속성명" value="설정값" scope="범위"></set>
		scope : page | request | session | application
	--%>
	<c:set var="test" value="Hello JSTL - page"/>
	<c:set var="test" value="Hello JSTL - request" scope="request" />
	<c:set var="test" value="Hello JSTL - session" scope="session" />
<%
	//System.out.println("test : " + test); //사용불가
	System.out.println("test : " + pageContext.getAttribute("test"));
%>	
	<p>page test : ${pageScope.test }</p>
	<p>request test : ${requestScope.test }</p>
	<hr><hr>
	
	<h3>속성값 출력 : out</h3>
	<p><c:out value="Hello World~~" /></p>
	<p>page test(c:out) : <c:out value="${pageScope.test }" /> </p>
	<p>page test(EL) : ${pageScope.test }</p>
	<p>session test(EL) : ${sessionScope.test }</p>
	
	<p>application test(EL) : ${applicationScope.test }</p>
	<p>application test(EL) : 
		<c:out value="${applicationScope.test }" default="데이터없음" />
	</p>
	<hr>
	
	<h3>삭제 : remove</h3>
	<c:remove var="test" scope="page"/>
	<p>EL : ${test }</p>
	<p>EL(page) : ${pageScope.test }</p>
	<p>EL(request) : ${requestScope.test }</p>
	<hr><hr>
	
	<%-- ============= if문 ============ --%>
	<h2>if 태그의 test 속성</h2>
	<c:if test="${20 > 10 }">
		<p>20 &gt; 10 결과 true인 경우 실행문장</p>
	</c:if>
	<c:if test="${20 <= 10 }">
		<p>20 &lt;= 10 결과 true인 경우 실행문장</p>
	</c:if>
	<hr><hr>
	
	<%-- choose ~ when ~ otherwise --%>
	<h3>choose ~ when ~ otherwise : 점수 평가</h3>
	<c:set var="jumsu" value="70" />
	<c:choose>
		<c:when test="${jumsu >= 90 }">
			<p>판정결과(${jumsu }) : A</p>
		</c:when>
		<c:when test="${jumsu >= 80 }">
			<p>판정결과(${jumsu }) : B</p>
		</c:when>
		<c:when test="${jumsu >= 70 }">
			<p>판정결과(${jumsu }) : C</p>
		</c:when>
		<c:otherwise>
			<p>판정결과(${jumsu }) : 노력하자</p>
		</c:otherwise>
	</c:choose>
	<hr><hr>
	
	<%-- ========= JSTL 반복문 forEach ============= --%>
	<h2>반복문 : forEach</h2>
	<h3>forEach문 : 자바의 기본 for문</h3>
	<p>1~10 까지의 숫자 출력</p>
	<c:forEach var="i" begin="1" end="10" step="1">
		${i } &nbsp;
	</c:forEach>
	<p>forEach문 종료 후 \${i } 값 출력 : ${i }</p>
	<hr>
	
	<p>(실습)1~10까지의 숫장 중 짝수 출력(step="1") 사용</p>
	<c:forEach var="i" begin="1" end="10" step="1">
		<c:if test="${i % 2 == 0 }">
			${i } 
		</c:if> 
	</c:forEach>
	
	<p>(실습)1~10까지의 숫장 중 짝수 출력(step="2") 사용</p>
	<c:forEach var="i" begin="2" end="10" step="2">
		${i } 
	</c:forEach>
	
	<!-- ==================================== -->
	<h2>forEach : 집합객체 처리</h2>
	<h3>스크립트릿으로 배열값 출력</h3>
<%
	String[] arr = {"홍길동", "일지매", "임꺽정", "둘리"};
	for (String name : arr) {
		out.print(name + ", ");
	}
	//pageContext.setAttribute("attr_name", arr);
%>	
	<h3>EL에서 배열값 사용</h3>
	arr[1] : ${attr_name[1] } :: EL은 스코프(scope)상에 등록된 데이터만 사용가능
	
	<h3>선언부, 스크립트릿 변수 속성등록 후 사용</h3>
	<c:set var="attr_name" value="<%=arr %>"></c:set>
	arr[1] : ${attr_name[1] } :: EL은 스코프(scope)상에 등록된 데이터만 사용가능
	<hr>
	
	<c:forEach var="name" items="${attr_name }">
		${name },  
	</c:forEach>
	<hr><hr>
	
	<%-- ====== forTokens 태그 =========== --%>
	<h2>forTokens : 문자열 자르기</h2>
	작업대상 문자열 : 홍길동/김유신/일지매,임꺽정/둘리,고길동<br>
	<c:set var="names" value="홍길동/김유신/일지매,임꺽정/둘리,고길동" />
	<c:forTokens var="str" items="${names}" delims="/">
		<p>${str }</p>
	</c:forTokens>
	<hr>
	
	<h3>구분자 / 와 , 함께 지정</h3>
	<c:forTokens var="str" items="${names}" delims="/,">
		<p>${str }</p>
	</c:forTokens>
	
	
	
	
	<br><br><br><br><br><br><br><br><br><br>
	<br><br><br><br><br><br><br><br><br><br>
</body>
</html>












