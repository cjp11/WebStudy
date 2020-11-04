package com.bc.model.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bc.model.DAO;
import com.bc.model.vo.MemberVO;

public class LoginCommand implements Command {
	int call_cnt = 0;
	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("exec 호출된 횟수: " + ++call_cnt);
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		System.out.println("id: " + id);
		System.out.println("password: " + password);
		// id 또는 password를 입력하지 않은 경우
		if (id == null) {
			//System.out.println("id == null");
			return "login.jsp";
		}
		System.out.println("살아있네");
		
		// id 또는 password를 입력한 경우
		MemberVO member = DAO.selectMember(id);
		String jspPage = "loginFail.jsp";
		if (member != null && member.getPassword().equals(password)) {
			System.out.println("member.getPassword(): " + member.getPassword());
			jspPage = "loginSuccess.jsp";
			request.setAttribute("member", member);
		}
		System.out.println("member.getPassword(): " + member.getPassword());
		return jspPage;
	}

}






