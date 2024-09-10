<%-- projectJSP/src/main/webapp/member/memberDeleteForm.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="member.bean.MemberDTO" %>
<%@ page import="member.dao.MemberDAO" %>
<%
    // 세션에서 사용자 ID 가져오기
    String id = (String)session.getAttribute("memId");

    // 로그인 여부 확인
    if (id == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='../login.jsp';</script>");
        return;
    }
    
    MemberDAO memberDAO = MemberDAO.getInstance(); // DAO 인스턴스 생성
	MemberDTO memberDTO = memberDAO.getMemberInfo(id); // 회원 정보 가져오기
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:,">
<title>회원탈퇴</title>
<style type="text/css">
* {
	padding: 0px;
	margin: 0px;
	box-sizing: border-box;
}

#delete-jsp {
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
	width: 750px;
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

input[type="text"], input[type="password"] {
	width: 200px;
	border-radius: 5px;
	height: 30px;
	padding: 0 5px;
}

input[type="checkbox"] {
    margin-right: 10px;
    margin-left: 5px;
	transform: scale(1.7);
	cursor: pointer;
	display: inline;
}

div.delete-input {
	display: flex;
	flex-direction: column;
}

div.delete-input label {
	margin-bottom:10px;
}

div.delete-input label:last-child {
	margin-bottom: 0px;
}

button {
    width: 130px;
    height: 30px;
    text-align: center;
    vertical-align: middle; 
    padding: 3px 10px;
    background: white;
    border: 1px solid #FF6B6B;
    color: #FF6B6B;
    text-decoration: none;
    border-radius: 5px;
    font-size: 14px;
    transition: background-color 0.3s ease;
    cursor: pointer;
}

button:hover {
    background: #FF6B6B;
    color: white;
}

#pwdDiv, #confirmDiv {
	display: none;
	padding: 5px 0 0 3px;
	color: red;
	font-size: 10pt;
}
</style>
</head>
<body>
<div id="delete-jsp">
	<a href="../index.jsp"><img src="../image/buang.jpg" width="130" height="140" alt="부아앙 망곰" /></a>
	<h2>회원탈퇴</h2>
	<form name="memberDeleteForm">
		<table>
		    <tr>
		        <th class="label">아이디</th>
		        <td class="input">
		           <input type="text" name="id" id="id" value="<%= memberDTO.getId() %>" readonly />
		        </td>
		    </tr>
		    <tr>
		        <th class="label">비밀번호</th>
		        <td class="input">
		           <input type="password" name="pwd" id="pwd" placeholder="비밀번호 입력" />
		           <div id="pwdDiv"></div>
		        </td>
		    </tr>
		    <tr>
		    	<th class="label">탈퇴 사유 (선택)</th>
		    	<td class="input">
		    		<div class="delete-input">
		                <label>
		                	<input class="delete-reason-list" type="checkbox"/>
		                	<strong>서비스 불만족:</strong> "서비스 품질이 기대에 미치지 못했습니다."
						</label>
						<label>
		                	<input class="delete-reason-list" type="checkbox"/>
		                	<strong>사용 빈도 감소:</strong> "이용 빈도가 적어졌습니다."
						</label>
	                	<label>
		                	<input class="delete-reason-list" type="checkbox"/>
		                	<strong>개인정보 우려:</strong> "개인정보 보호에 대한 우려가 있습니다."
						</label>
						<label>
		                	<input class="delete-reason-list" type="checkbox"/>
		                	<strong>사용자 인터페이스 불편:</strong> "웹사이트/앱의 인터페이스가 불편합니다."
						</label>
						<label>
		                	<input class="delete-reason-list" type="checkbox"/>
		                	<strong>기타 개인 사유:</strong> "개인적인 사유로 더 이상 이용하지 않기로 했습니다."
						</label>
		        	</div>
		        </td>
		    </tr>
		    <tr>
		    	<td colspan="2" height = "20">
		        	<label for="confirm">
		                <input type="checkbox" id="confirm">
	                	모든 정보를 삭제하는 데 동의합니다.
	                	<div id="confirmDiv"></div>
		            </label>
		    	</td>
 		    </tr>
			<tr align="center">
		        <td colspan="2" height="20">
		            <button type="submit" id="deleteBtn" >회원탈퇴</button>
		        </td>
		    </tr>
		</table>
	</form>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    $('#deleteBtn').click(function(event) {
    	event.preventDefault(); // 폼 제출 방지
        $('#pwdDiv').hide(); // 오류 메시지 숨기기

        let isValid = true;
        let pwd = $('#pwd').val().trim();
        let confirmChecked = $('#confirm').is(':checked');
        
        // 비밀번호 입력 및 체크박스 체크 여부 확인
        if (pwd === '') {
            $('#pwdDiv').html("비밀번호를 입력하세요").show();
            isValid = false;
        }
        if (!confirmChecked) {
        	 $('#confirmDiv').html('동의 체크박스를 체크해주세요.').show();  
        	 isValid = false;
        }

        if (isValid) {
	        // AJAX 요청
	        $.ajax({
	            type: 'POST',
	            url: './memberDelete.jsp',
	            data: {
	                'id': $('#id').val(),
	                'pwd': $('#pwd').val()
	            },
	            dataType: 'text',
	            success: function(data) {
	                if (data === "fail") {
	                	alert("회원탈퇴 실패하였습니다.");
	                } else {
	                	alert("회원탈퇴되었습니다.");
	                	location.href='../index.jsp';
	                }
	            },
	            error: function(xhr, status, error) {
	                console.log("회원탈퇴 실패:", error);
	                console.log("상태 코드:", xhr.status);
	                console.log("응답 메시지:", xhr.responseText);
	            }
	        });
        }
    });

    // 입력 필드에 포커스가 가면 오류 메시지 숨기기
    $('#pwd').focus(function() {
        $('#pwdDiv').hide();
    });
    $('#confirm').focus(function(){
        $('#confirmDiv').hide();
    });
});
</script>
</body>
</html>