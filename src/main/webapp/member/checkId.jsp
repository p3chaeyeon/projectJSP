<%-- projectJSP/src/main/webapp/member/checkId.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.dao.MemberDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:,">
<title>중복검사</title>
<style type="text/css">
input[type="text"] {
	width: 150px;
	border-radius: 5px;
	height: 30px;
	padding: 0 5px;
}
button {
    width: 130px;
    height: 30px;
    text-align: center;
    vertical-align: middle; 
    padding: 3px 10px;
    background: white;
    border: 1px solid #5A5A5A;
    color: #5A5A5A;
    text-decoration: none;
    border-radius: 5px;
    font-size: 14px;
    transition: background-color 0.3s ease;
    cursor: pointer;
}

button:hover {
    background: #5A5A5A;
    color: white;
}
</style>
</head>
<body>
<%
    String id = request.getParameter("id");

    MemberDAO memberDAO = MemberDAO.getInstance();
    boolean exist = memberDAO.isExistId(id);

    if (exist) {
%>
    <%=id %>은(는) 이미 사용중인 아이디입니다.
    <br><br>
    <form action="checkId.jsp">
	    아이디 <input type="text" name="id"/>
	    <button type="submit">중복체크</button>
    </form>
<%
    } else {
%>
    <%=id %>은(는) 사용 가능한 아이디입니다.
    <br><br>
    <button type="button" onclick="checkIdClose('<%=id %>')">사용하기</button>
<%
    }
%>

<script type="text/javascript">
function checkIdClose(id) {
	opener.document.getElementById("id").value = id;
	window.close();
	opener.document.getElementById("pwd").focus();
}
</script>
</body>
</html>