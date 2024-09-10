<%-- projectJSP/src/main/webapp/member/boardWrite.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.dao.BoardDAO" %>
<%@ page import="board.bean.BoardDTO" %>
<%@ page import="java.util.Map" %>

<%
    // 1. Data
    request.setCharacterEncoding("UTF-8");
	session = request.getSession();
	String userId = (String) session.getAttribute("memId");
	String userName = (String) session.getAttribute("memName");
	String userEmail = (String) session.getAttribute("memEmail");
    String subject = request.getParameter("subject");
    String content = request.getParameter("content");


    // 2. DB
    BoardDTO boardDTO = new BoardDTO();
    boardDTO.setId(userId);
    boardDTO.setName(userName);
    boardDTO.setEmail(userEmail); 
    boardDTO.setSubject(subject);
    boardDTO.setContent(content);

    BoardDAO boardDAO = BoardDAO.getInstance();
    Map<String, String> resultMap = boardDAO.boardWrite(boardDTO);

    // 3. Response
    String status = resultMap.get("status");
    if ("success".equals(status)) {
        out.print("success");
    } else {
        out.print("fail");
    }
%>