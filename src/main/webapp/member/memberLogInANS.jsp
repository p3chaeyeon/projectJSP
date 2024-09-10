<%-- projectJSP/src/main/webapp/member/memberLogInANS.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="member.dao.MemberDAO" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.Map" %>

<%
    // 1. Data 받기 & Request
    request.setCharacterEncoding("UTF-8");    
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");

	// 2. DB 
	MemberDAO memberDAO = MemberDAO.getInstance();
	Map<String, String> userInfo = memberDAO.memberLogIn(id, pwd);
	
	// 3. Response
	String name = userInfo.get("name");
	String email1 = userInfo.get("email1");
	String email2 = userInfo.get("email2");
	String email = email1 + "@" + email2;
	
	System.out.println("id : " + id);
	System.out.println("pwd : " + pwd);
	System.out.println("email : " + email);
%>
<%
    if (name == null) {
        response.sendRedirect("./memberLogInFail.jsp"); // 페이지 이동
    } else {
    	
    	/* Cookie */
        /* 
        Cookie nameCookie = new Cookie("memName", name); // 쿠키 생성
        nameCookie.setMaxAge(3*10*60); // 초단위; 30분
        response.addCookie(nameCookie); // 클라이언트에 저장

        Cookie idCookie = new Cookie("memId", id);
        idCookie.setMaxAge(3*10*60);
        response.addCookie(idCookie); */
		
        
        /* Session */
        // 세션 생성; 내장객체로 제공하기 때문에 생성할 필요 없음
        // HttpSession session = request.getSession(); 
        
        session.setAttribute("memName", name);
        session.setAttribute("memId", id);
        session.setAttribute("memEmail", email);
        
        response.sendRedirect("./memberLogInOk.jsp");

    }
%>

