<%-- projectJSP/src/main/webapp/member/memberUpdate.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="member.bean.MemberDTO" %>
<%@ page import="member.dao.MemberDAO" %>

<%
// 1. Data 받기 & Request
request.setCharacterEncoding("UTF-8");    
String id = request.getParameter("id");
String pwd = request.getParameter("pwd");
String gender = request.getParameter("gender");
String email1 = request.getParameter("email1");
String email2 = request.getParameter("email2");
String tel1 = request.getParameter("tel1");
String tel2 = request.getParameter("tel2");
String tel3 = request.getParameter("tel3");
String zipcode = request.getParameter("zipcode");
String addr1 = request.getParameter("addr1");
String addr2 = request.getParameter("addr2");

// 2. DB 
MemberDTO memberDTO = new MemberDTO();
memberDTO.setId(id);
memberDTO.setPwd(pwd);
memberDTO.setGender(gender);
memberDTO.setEmail1(email1);
memberDTO.setEmail2(email2);
memberDTO.setTel1(tel1);
memberDTO.setTel2(tel2);
memberDTO.setTel3(tel3);
memberDTO.setZipcode(zipcode);
memberDTO.setAddr1(addr1);
memberDTO.setAddr2(addr2);
    
MemberDAO memberDAO = MemberDAO.getInstance();
boolean result = memberDAO.memberUpdate(memberDTO);

// 3. Response
if (result) {
    session.invalidate(); // 세션 만료
    out.print("success");
} else {
    out.print("fail");
}
%>
