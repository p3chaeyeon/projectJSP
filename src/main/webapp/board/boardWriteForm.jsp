<%-- projectJSP/src/main/webapp/member/boardWriteForm.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="member.bean.MemberDTO" %>
<%@ page import="member.dao.MemberDAO" %>
<%
	//세션에서 사용자 ID 가져오기
	String name = (String)session.getAttribute("memName");
	String id = (String)session.getAttribute("memId"); 
	String email = (String)session.getAttribute("memEmail");
	
    // 로그인 여부 확인
    if (id == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='../login.jsp';</script>");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:,">
<title>글쓰기</title>
<style type="text/css">
* {
	padding: 0px;
	margin: 0px;
	box-sizing: border-box;
}

#write-jsp {
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
	border: 2px solid black;
	border-collapse: collapse;
	border-spacing: 0px;
	text-align: center;
	width: 500px;
}

th, td {
	border: 1px solid black;
	padding: 10px;
	vertical-align: middle;
}

.label {
	width: 25%;
}

.input {
   text-align: left;
   width: 75%;
}

input[type="text"], textarea {
	width: 100%;
	box-sizing: border-box;
	border-radius: 5px;
	padding: 5px;
}

input[type="text"] {
	height: 30px;
}

textarea {
	height: 200px;
}

button {
    width: 150px;
    height: 40px;
    text-align: center;
    vertical-align: middle; 
    padding: 5px 30px;
    background: white;
    border: 1px solid #5A5A5A;
    color: #5A5A5A;
    text-decoration: none;
    border-radius: 5px;
    font-size: 16px;
    transition: background-color 0.3s ease;
    cursor: pointer;
}

button:hover {
    background: #5A5A5A;
    color: white;
}

#subjectDiv, #contentDiv{
	display: none;
	padding-top: 5px;
	color: red;
	font-size: 10pt;
}

</style>
</head>
<body>
<div id="write-jsp">
	<a href="../index.jsp"><img src="../image/mangomCom.jpg" width="150" height="150" alt="mangomCom" /></a>
    <h2>글쓰기</h2>
    <form name="boardWriteForm">
		<table>
			<tr>
		        <th class="label">이름</th>
		        <td class="input">
		            <input type="text" name="name" id="name" value="<%= name %>" readonly/>
		        </td>
		    </tr>
		    <tr>
		        <th class="label">아이디</th>
		        <td class="input">
		            <input type="text" name="id" id="id" value="<%= id %>" readonly/>
		        </td>
		    </tr>
		    <tr>
		        <th class="label">이메일</th>
		        <td class="input">
		            <input type="text" name="email" id="email" value="<%= email %>" readonly/>
		        </td>
		    </tr>
		    <tr>
		        <th class="label">제목</th>
		        <td class="input">
		            <input type="text" name="subject" id="subject" />
		            <div id="subjectDiv"></div>
		        </td>
		    </tr>
		    <tr>
		        <th class="label">내용</th>
		        <td class="input">
		            <textarea name="content" id="content" rows="5" cols="40"></textarea>
		            <div id="contentDiv"></div>
		        </td>
		    </tr>
		    
		    <tr>
		        <td colspan="2" height="20">
		            <button type="submit" id="writeBtn">글 작성</button>
		            <button type="reset" id="resetBtn">초기화</button>
		            <button type="button" onclick="window.location.href='./boardList.jsp'" id="listBtn">글 목록</button>
		        </td>
		    </tr>
		</table>
    </form>
</div>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
$(function(){
    $('#writeBtn').click(function(event){
    	event.preventDefault(); // 폼 제출 방지

        // 변수 선언 및 초기화
        let subject = $('#subject').val().trim();
        let content = $('#content').val().trim();

        // 디버깅: 변수 값 출력
        console.log(subject, content);
        
        // 오류 메시지 초기화 및 숨김
        $('#subjectDiv').hide();
        $('#contentDiv').hide();
        $('#messageDiv').hide();
        
        let isValid = true;

        // 제목 입력 검사
        if (subject === ''){
            $('#subjectDiv').html('제목 입력').show(); // 오류 메시지 표시
            isValid = false;
        }
        
        // 내용 입력 검사
        if (content === '') {
            $('#contentDiv').html('내용 입력').show(); // 오류 메시지 표시
            isValid = false;
        }
        
        if (isValid) {
            // AJAX로 데이터 전송
            $.ajax({
                type: 'POST',
                url: './boardWrite.jsp',
                data: {
                    subject: subject,
                    content: content
                },
                success: function(response) {
                    alert("글을 등록했습니다.");
                    window.location.href = './boardList.jsp?pg=1';
                },
                error: function(xhr, status, error) {
                    alert("글 등록에 실패했습니다.");
                    console.error("AJAX Error: " + status + " - " + error);
                }
            });
        }
    }); 

    $('#resetBtn').click(function(){
        $('#subjectDiv').hide();
        $('#contentDiv').hide();
        $('form[name="boardWriteForm"]')[0].reset(); // 폼 필드 초기화
    });
    
	// 입력 필드에 포커스가 갈 때 오류 메시지 숨기기
	$('#subject').focus(function(){
			$('#subjectDiv').hide();
	});
	$('#content').focus(function(){
		$('#contentDiv').hide();
	});

});
</script>
</body>
</html>