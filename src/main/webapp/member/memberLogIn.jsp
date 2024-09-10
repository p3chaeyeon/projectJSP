<%-- projectJSP/src/main/webapp/member/memberLogIn.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="member.dao.MemberDAO" %>
<%@ page import="java.util.Map" %> 

<%
    // 요청에서 전달된 아이디와 비밀번호 가져오기
    String userId = request.getParameter("id");
    String userPwd = request.getParameter("pwd");

    // DAO 인스턴스 가져오기
    MemberDAO memberDAO = MemberDAO.getInstance();
    
    String result = "fail";  // 기본값은 실패

    try {
        if (userId != null && userPwd != null) {
            // DAO에서 이름 확인
            Map<String, String> userInfo = memberDAO.memberLogIn(userId, userPwd);
            
            if (userInfo != null && !userInfo.isEmpty()) {
                // 로그인 성공 시 이름 반환
                result = userInfo.get("name"); // 로그인 성공 시 name 반환
            }
        }
    } catch (Exception e) {
        e.printStackTrace(); // 오류 발생 시 콘솔에 로그 출력
    }

    // Response
    response.setContentType("text/plain; charset=UTF-8");
    out.print(result);
    out.flush();
%>