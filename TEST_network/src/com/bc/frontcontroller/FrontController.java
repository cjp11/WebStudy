package com.bc.frontcontroller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bc.model.command.Command;
import com.bc.model.command.LoginCommand;
import com.bc.model.command.SignupCommand;

@WebServlet("/controller")
public class FrontController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void init() throws ServletException {
		System.out.println("init 메서드 호출");
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(">>doGet() 호출");
		String type = request.getParameter("type");
		System.out.println("> type : " + type);
		Command command = null;
		if ("login".equals(type)) {
			command = new LoginCommand();
			System.out.println("command 객체 생성: " + command);
		} else if ("signup".equals(type)) {
			command = new SignupCommand();
		} 
		String path = command.exec(request, response);
		System.out.println("path: " + path);
		request.getRequestDispatcher(path).forward(request, response);
		System.out.println("forward 처리 후");
		System.out.println("=======================");
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(">>doPost() 호출");
		request.setCharacterEncoding("UTF-8");
		doGet(request, response);
	}
	
	public void destroy() {
		System.out.println("destroy 메서드 호출");
	}
}










