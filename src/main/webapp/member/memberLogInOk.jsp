<%-- projectJSP/src/main/webapp/member/memberLogInOk.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="java.io.UnsupportedEncodingException" %>

<%
    String name = null;
    String id = null;

    // Cookie ; /특정 쿠키만 가져오는 것이 아님
    /* Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (int i = 0; i < cookies.length; i++) { 
            String cookieName = cookies[i].getName(); // 쿠키 이름
            String cookieValue = cookies[i].getValue(); // 쿠키 값

            if ("memName".equals(cookieName)) {
                name = cookieValue;
            }
            if ("memId".equals(cookieName)) {
                id = cookieValue;
            }
        }
    } */
    
    // Session
    name = (String)session.getAttribute("memName");
    id = (String)session.getAttribute("memId");
    String email = (String)session.getAttribute("memEmail");
    
%>
<%= name %> / <%= id %>