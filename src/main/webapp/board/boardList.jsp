<%-- projectJSP/src/main/webapp/member/boardList.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.bean.BoardDTO" %>
<%@ page import="board.bean.BoardPaging" %>
<%@ page import="board.dao.BoardDAO" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>


<%
	int pg = 1; // 기본값 설정
	if (request.getParameter("pg") != null) {
	    pg = Integer.parseInt(request.getParameter("pg"));
	}


	// 1 페이지당 5개씩
	int endNum = pg * 5;
	int startNum = endNum - 4;
	
	// DB
	BoardDAO boardDAO = BoardDAO.getInstance();
	List<BoardDTO> list = boardDAO.boardList(startNum, endNum);
	
	// 페이징 처리
	int totalA = boardDAO.getTotalA();
	
	BoardPaging boardPaging = new BoardPaging();
	boardPaging.setCurrentPage(pg);
	boardPaging.setPageBlock(3);
	boardPaging.setPageSize(5);
	boardPaging.setTotalA(totalA);
	
	boardPaging.makePagingHTML();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:,">
<title>글 목록</title>
<style type="text/css">
* {
	padding: 0px;
	margin: 0px;
	box-sizing: border-box;
}

#list-jsp {
    text-align: center; 
    margin-top: 20px; 
}

a {
	margin: 10px 0;
	text-align: center;
	display: inline-block;
}

table {
	margin: 20px auto;
	border-collapse: collapse;
	border-spacing: 0px;
	text-align: center;
}

th, td {
	border-bottom: 1px solid black;
	padding: 10px;
	vertical-align: middle;
}

th {
	border-bottom: 3px solid black;
}

#page-block {
	width: 900px;
	margin: 10px auto;
	font-size: 13pt;
}

#currentPaging {
    background-color: #e5e7ea;
	border-radius: 5px;
	padding: 5px 8px;
	font-weight: bold;
}

#paging {
	border-radius: 5px;
	padding: 5px 8px;
}

span:hover {
	text-decoration: underline;
	cursor: pointer;
}
</style>
</head>
<body>
<div id="list-jsp">
	<a href="../index.jsp"><img src="../image/mangomCom.jpg" width="150" height="150" alt="mangomCom" /></a>
    <h2>글 목록</h2>
    <table>
    	<tr>
    		<th width="100">글번호</th>
    		<th width="400">제목</th>
    		<th width="150">작성자</th>
    		<th width="150">작성일</th>
    		<th width="100">조회수</th>
    	</tr>
    <% 
    if(list != null) { 
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
    	for(BoardDTO boardDTO : list) { 
	%>
         <tr>
             <td><%= boardDTO.getSeq() %></td>
             <td align="left"><%= boardDTO.getSubject() %></td>
             <td><%= boardDTO.getId() %></td>
             <td><%= sdf.format(boardDTO.getLogtime()) %></td>
             <td><%= boardDTO.getHit() %></td>
         </tr>
     <% 
	    }
	} else {
	%>
	<tr>
	    <td colspan="5">글이 없습니다.</td>
	</tr>
	<% } %>
    </table>
    <div id="page-block"><%=boardPaging.getPagingHTML() %></div>
</div>
<script type="text/javascript">
function boardPaging(pg){
    location.href = "boardList.jsp?pg=" + pg;
}
</script>
</body>
</html>