<%-- projectJSP/src/main/webapp/member/memberWrite.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="member.dao.MemberDAO" %>
<%@ page import="member.bean.MemberDTO" %>
<%@ page import="java.util.Date" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:,">
<title>Insert Member</title>
</head>
<body>
<%
    // Data
    request.setCharacterEncoding("UTF-8");
    String userName = request.getParameter("name");
    String userId = request.getParameter("id");
    String userPwd = request.getParameter("pwd");
    String userGender = request.getParameter("gender");
    String userEmail1 = request.getParameter("email1");
    String userEmail2 = request.getParameter("email2");
    String userTel1 = request.getParameter("tel1");
    String userTel2 = request.getParameter("tel2");
    String userTel3 = request.getParameter("tel3");
    String userZipcode = request.getParameter("zipcode");
    String userAddr1 = request.getParameter("addr1");
    String userAddr2 = request.getParameter("addr2");

    String status = "error";
    String message = "";

    MemberDAO memberDAO = MemberDAO.getInstance();

    try {
        // 회원가입 처리
        if (userName != null && userId != null && userPwd != null) {
            // 회원 정보 DTO 생성
            MemberDTO memberDTO = new MemberDTO();
            memberDTO.setName(userName);
            memberDTO.setId(userId);
            memberDTO.setPwd(userPwd);
            memberDTO.setGender(userGender);
            memberDTO.setEmail1(userEmail1);
            memberDTO.setEmail2(userEmail2);
            memberDTO.setTel1(userTel1);
            memberDTO.setTel2(userTel2);
            memberDTO.setTel3(userTel3);
            memberDTO.setZipcode(userZipcode);
            memberDTO.setAddr1(userAddr1);
            memberDTO.setAddr2(userAddr2);

            // 회원가입
            boolean result = memberDAO.memberSignUp(memberDTO);
            if (result) {
                status = "success";
                message = "회원가입이 성공적으로 완료되었습니다.";
                // 페이지 이동 및 메시지 전달
                out.print("<script type='text/javascript'>"
                        + "window.onload = function() {"
                        + "    alert('" + message + "');"
                        + "    window.location.href = '../index.jsp';"
                        + "};"
                        + "</script>");
            } else {
                message = "회원가입 처리 중 문제가 발생했습니다.";
                out.print("<script type='text/javascript'>"
                        + "window.onload = function() {"
                        + "    alert('" + message + "');"
                        + "    window.location.href = './memberWriteForm.jsp';"
                        + "};"
                        + "</script>");
            }
        } else {
            message = "필수 필드를 정확히 입력해주세요.";
            out.print("<script type='text/javascript'>"
                    + "window.onload = function() {"
                    + "    alert('" + message + "');"
                    + "    window.location.href = './memberWriteForm.jsp';"
                    + "};"
                    + "</script>");
        }
    } catch (Exception e) {
        status = "error";
        message = "데이터베이스 오류가 발생했습니다.";
        e.printStackTrace(); // 로그에 에러 출력
        out.print("<script type='text/javascript'>"
                + "window.onload = function() {"
                + "    alert('" + message + "');"
                + "    window.location.href = './memberWriteForm.jsp';"
                + "};"
                + "</script>");
    }
%>
</body>
</html>