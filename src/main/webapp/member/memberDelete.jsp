<%-- projectJSP/src/main/webapp/member/memberDelete.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="member.bean.MemberDTO" %>
<%@ page import="member.dao.MemberDAO" %>

<%
	//1. Data 받기 & Request
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");

	// 2. DB 
	MemberDAO memberDAO = MemberDAO.getInstance();
	boolean result = memberDAO.memberDelete(id, pwd);
	
	// 3. Response
	if (result) {
	    session.invalidate(); // 세션 만료
	    out.print("success");
	} else {
	    out.print("fail");
	}
%>
