<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//요청한 웹사이트로 이동처리(재요청처리)
	String site = request.getParameter("site");
	String action = request.getParameter("ex02_redirect_resp.jsp");
	System.out.println(">> site: " +site);
	System.out.println(">> action: " +action);
	
	switch(site) {
	case "naver":
		response.sendRedirect("http://www.naver.com");
		break;
	case "daum":
		response.sendRedirect("http://daum.net");
		break;
	case "google":
		response.sendRedirect("http://google.com");
		break;
	}
%>