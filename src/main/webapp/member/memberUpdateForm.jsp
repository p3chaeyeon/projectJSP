<%-- projectJSP/src/main/webapp/member/memberUpdateForm.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="member.bean.MemberDTO" %>
<%@ page import="member.dao.MemberDAO" %>

<%
	//세션에서 사용자 ID 가져오기
	String id = (String)session.getAttribute("memId"); 
	
    // 로그인 여부 확인
    if (id == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='../login.jsp';</script>");
        return;
    }
	
	MemberDAO memberDAO = MemberDAO.getInstance(); // DAO 인스턴스 생성
	MemberDTO memberDTO = memberDAO.getMemberInfo(id); // 회원 정보 가져오기

	if (memberDTO == null) {
	    out.println("<script>alert('회원정보를 불러오지 못했습니다.'); history.back();</script>");
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:,">
<title>회원정보수정</title>
<style type="text/css">
* {
	padding: 0px;
	margin: 0px;
	box-sizing: border-box;
}

#update-jsp {
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
	width: 800px;
}

th, td {
	border: 1px solid black;
	padding: 10px;
	vertical-align: middle;
}

.label {
	width: 20%;
}

.input {
    text-align: left;
    width: 80%;
}

input[type="text"], input[type="password"] {
	width: 200px;
	border-radius: 5px;
	height: 30px;
	padding: 0 5px;
}

input[type="radio"] {
	margin-right: 5px;
}

input[type="text"].input-email, select.input-email {
    width: 170px !important;
    border-radius: 5px;
    height: 30px;
    margin-right: 3px;
}

input[type="text"].input-tel, select.input-tel {
    width: 100px !important;
    border-radius: 5px;
    height: 30px;
}

input[name="addr1"], input[name="addr2"] {
    width: 100%;
    margin-top: 5px;
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

#nameDiv, #idDiv, #pwdDiv, #repwdDiv {
	display: none;
	padding: 5px 0 0 3px;
	color: red;
	font-size: 10pt;
}
</style>
</head>
<body>
<div id="update-jsp">
	<a href="../index.jsp"><img src="../image/mangom3.png" width="140" height="140" alt="mangom" /></a>
	<h2>회원정보수정</h2>
	<form name="memberUpdateForm" onsubmit="return memberUpdate()">
		<table>
			<tr>
		        <th class="label">이름</th>
		        <td class="input">
		           <input type="text" name="name" id="name" value="<%= memberDTO.getName() %> " />
		           <div id="nameDiv"></div>
		        </td>
		    </tr>
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
		        <th class="label">재확인</th>
		        <td class="input">
		           <input type="password" name="repwd" id="repwd" placeholder="비밀번호 입력" />
		           <div id="repwdDiv"></div>
		        </td>
		    </tr>
		    <tr>
		        <th class="label">성별</th>
		        <td class="input">
		        	<label><input type="radio" name="gender" value="M" <%= "M".equals(memberDTO.getGender()) ? "checked" : "" %>>남자</label>
        			<label><input type="radio" name="gender" value="F" <%= "F".equals(memberDTO.getGender()) ? "checked" : "" %>>여자</label>
		        </td>
		    </tr>
		    <tr>
		        <th class="label">이메일</th>
		        <td class="input">
		           <input type="text" name="email1" class="input-email" value="<%= memberDTO.getEmail1() %>" />@
		           <input type="text" name="email2" class="input-email" id="email-domain" value="<%= memberDTO.getEmail2() %>" />
		           <select name="email2" class="input-email" onchange="setEmailDomain(this.value)">
			            <option value="직접입력" <%= "직접입력".equals(memberDTO.getEmail2()) ? "selected" : "" %>>직접입력</option>
			            <option value="hanmail.net" <%= "hanmail.net".equals(memberDTO.getEmail2()) ? "selected" : "" %>>hanmail.net</option>
			            <option value="naver.com" <%= "naver.com".equals(memberDTO.getEmail2()) ? "selected" : "" %>>naver.com</option>
			            <option value="gmail.com" <%= "gmail.com".equals(memberDTO.getEmail2()) ? "selected" : "" %>>gmail.com</option>
		        	</select>
		        </td>
		    </tr>
		    <tr>
		        <th class="label">휴대전화</th>
		        <td class="input">
		        	<select name="tel1" class="input-tel" >
			            <option value="010" <%= "010".equals(memberDTO.getTel1()) ? "selected" : "" %>>010</option>
			            <option value="011" <%= "011".equals(memberDTO.getTel1()) ? "selected" : "" %>>011</option>
			            <option value="019" <%= "019".equals(memberDTO.getTel1()) ? "selected" : "" %>>019</option>
			        </select>
		           <input type="text" size="10" name="tel2" class="input-tel" value="<%= memberDTO.getTel2() %>" />
		           <input type="text" size="10" name="tel3" class="input-tel" value="<%= memberDTO.getTel3() %>" />
		        </td>
		    </tr>
		    <tr>
		        <th class="label">주소</th>
		        <td class="input">
		           <input type="text" id="zipcode" name="zipcode" value="<%= memberDTO.getZipcode() %>" readonly/>
		           <button type="button" onclick="checkPost()" id="searchBtn">우편번호 검색</button>
		           <input type="text" id="addr1" name="addr1" value="<%= memberDTO.getAddr1() %>" readonly/>
		           <input type="text" id="addr2" name="addr2" value="<%= memberDTO.getAddr2() %>"  />
		        </td>
		    </tr>
			<tr align="center">
		        <td colspan="2" height="20">
		            <button type="submit" id="updateBtn">회원정보수정</button>
		            <button type="reset" id="resetBtn">초기화</button>
		        </td>
		    </tr>
		</table>
	</form>
</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="../js/member.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    $('#updateBtn').click(function(event) {
    	event.preventDefault(); // 폼 제출 방지
        $('#pwdDiv').hide();
        $('#repwdDiv').hide();
        
        let isValid = true;
        let pwd = $('#pwd').val().trim();
        let repwd = $('#repwd').val().trim();

        if (pwd === "") {
            $('#pwdDiv').html("비밀번호를 입력하세요").show();
            isValid = false;
        }

        if (pwd !== "" && pwd !== repwd) {
            $('#repwdDiv').html("비밀번호가 일치하지 않습니다.").show();
            isValid = false;
        }

        if (isValid) {
	        console.log("폼 데이터:", $('form[name="memberUpdateForm"]').serialize());
	
	        $.ajax({
	            type: 'post',
	            url: './memberUpdate.jsp',
	            data: $('form[name="memberUpdateForm"]').serialize(),
	            success: function(data) {
	                console.log("서버 응답:", data);
	                let response = data.trim();
	                
	                if (response === "fail") {
	                    alert("회원정보 수정에 실패하였습니다.");
	                } else {
	                    alert("회원정보가 수정되었습니다.");
	                    location.href='../index.jsp';
	                }
	            },
	            error: function(xhr, status, error) {
	                console.log("회원정보수정 실패:", error);
	                console.log("상태 코드:", xhr.status);
	                console.log("응답 메시지:", xhr.responseText);
	            }
	        });
        }
    });
    
    // 입력 필드에 포커스가 갈 때 오류 메시지 숨기기
    $('#pwd').focus(function() {
        $('#pwdDiv').hide();
    });
    $('#repwd').focus(function() {
        $('#repwdDiv').hide();
    });
});

</script>
</body>
</html>
