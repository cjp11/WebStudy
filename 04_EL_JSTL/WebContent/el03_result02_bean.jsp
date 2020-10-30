<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 전달받은 파라미터값을 자바빈(bean) VO에 저장해서 사용 --%>
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");
	/* <jsp:useBean id="vo" class="com.bc.vo.PersonVO" /> 코드
	PersonVO vo = (PersonVO) pageContext.getAttribute("vo");
	if (vo == null) {
		vo = new PersonVO();
		pageContext.setAttribute("vo", vo);
	}
	*/
%>
	<jsp:useBean id="vo" class="com.bc.vo.PersonVO" />
	<jsp:setProperty property="*" name="vo"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자바빈(Bean)</title>
</head>
<body>
	<h2>결과보기(Bean 사용)</h2>
	<ul>
		<li>이름 : <%=vo.getName() %></li>
		<li>나이 : ${vo.getAge()}></li>	<!-- el, 표현식 모두 
		사용 가능 -->
		<li>성별 : <%=vo.getGender() %></li>
		<li>취미 : <%=vo.getHobby() %></li>
		<li>취미(반복문) :
<%
		for (String h : vo.getHobby()) {
			out.print(h + " ");
		}
%>		 
		</li>	
	</ul>
</body>
</html>