package com.bc.model.command;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bc.model.DAO;
import com.bc.model.vo.MemberVO;

public class SignupCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		if (id == null) {
			System.out.println("id null");
			return "signup.jsp";
		}
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		MemberVO member = new MemberVO(id, name, password, email);
	
		int cnt = DAO.insertMember(member);
		String jspPage = "signup.jsp";
		if (cnt == 0) {
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('회원가입실패!!!'");
			out.println("</script>");
			out.close();
		} else {
			jspPage = "signupSuccess.jsp";
			request.setAttribute("member", member);
		}
		
		return jspPage;
	}

}






