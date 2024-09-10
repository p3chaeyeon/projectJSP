// projectJSP/src/main/java/member.dao/MemberDAO.java
package member.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import member.bean.MemberDTO;

public class MemberDAO {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs; // SQL(select) 쿼리 결과를 저장하는 객체
	private DataSource ds;

	// 싱글톤 인스턴스 생성
	private static MemberDAO instance = new MemberDAO();

	public static MemberDAO getInstance() {
		return instance;
	}

	public MemberDAO() { // Driver Loading
		Context ctx;
		try {
			ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle"); // Tomcat 의 경우 "java:comp/env/" 필요
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private void closeAll() {
		try { // con --> pstmt --> rs 순서로 만들었으니 닫는건 반대로
			if (rs != null) rs.close();
			if (pstmt != null) pstmt.close();
			if (con != null) con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/** memberWriteForm.jsp */
	
	// id 중복검사
	public boolean isExistId(String id) {
        boolean exists = false;
        try {
        	con = ds.getConnection();
        	String sql = "select * from MEMBER where id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                exists = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeAll();
        }
        return exists;
	}
	
	// 회원가입
	public boolean memberSignUp(MemberDTO memberDTO) {
	    boolean result = false;
	    try {
	    	con = ds.getConnection();
	    	String sql = "INSERT INTO MEMBER VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE)";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, memberDTO.getName());
	        pstmt.setString(2, memberDTO.getId());
	        pstmt.setString(3, memberDTO.getPwd());
	        pstmt.setString(4, memberDTO.getGender());
	        pstmt.setString(5, memberDTO.getEmail1());
	        pstmt.setString(6, memberDTO.getEmail2());
	        pstmt.setString(7, memberDTO.getTel1());
	        pstmt.setString(8, memberDTO.getTel2());
	        pstmt.setString(9, memberDTO.getTel3());
	        pstmt.setString(10, memberDTO.getZipcode());
	        pstmt.setString(11, memberDTO.getAddr1());
	        pstmt.setString(12, memberDTO.getAddr2());

	        int rows = pstmt.executeUpdate();
	        if (rows > 0) {
	            result = true;
	        }
	    } catch (SQLException e) {
	        System.out.println("SQL Error: " + e.getMessage());
	        e.printStackTrace();
	    } finally {
	        closeAll();
	    }
	    return result;
	}
	
	/** memberLogInForm.jsp */
	// 로그인
	public Map<String, String> memberLogIn(String id, String pwd) {
	    Map<String, String> userInfo = new HashMap<>();
	    try {
	        con = ds.getConnection();
	        String sql = "SELECT name, email1, email2 FROM MEMBER WHERE id = ? AND pwd = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, id);
	        pstmt.setString(2, pwd);
	        rs = pstmt.executeQuery();
	        
	        // ID와 비밀번호가 일치하는 경우, name, email1, email2 값을 가져옴
	        if (rs.next()) {
	            userInfo.put("name", rs.getString("name"));
	            userInfo.put("email1", rs.getString("email1"));
	            userInfo.put("email2", rs.getString("email2"));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        closeAll();
	    }
	    return userInfo; // 일치하는 회원의 정보를 반환 (없으면 빈 Map)
	}

	
	/** memberUpdateForm.jsp */
	// 회원정보 불러오기
	public MemberDTO getMemberInfo(String id) {
	    MemberDTO memberDTO = null;
	    try {
	        con = ds.getConnection();
	        String sql = "SELECT * FROM MEMBER WHERE id = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, id);
	        rs = pstmt.executeQuery();
	
	        if (rs.next()) {
	            memberDTO = new MemberDTO();
	            memberDTO.setName(rs.getString("name"));
	            memberDTO.setId(rs.getString("id"));
	            memberDTO.setPwd(rs.getString("pwd"));
	            memberDTO.setGender(rs.getString("gender"));
	            memberDTO.setEmail1(rs.getString("email1"));
	            memberDTO.setEmail2(rs.getString("email2"));
	            memberDTO.setTel1(rs.getString("tel1"));
	            memberDTO.setTel2(rs.getString("tel2"));
	            memberDTO.setTel3(rs.getString("tel3"));
	            memberDTO.setZipcode(rs.getString("zipcode"));
	            memberDTO.setAddr1(rs.getString("addr1"));
	            memberDTO.setAddr2(rs.getString("addr2"));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        closeAll();
	    }
	    return memberDTO;
	}
	
	// 회원정보 수정
	public boolean memberUpdate(MemberDTO memberDTO) {
	    boolean result = false;
	    try {
	        con = ds.getConnection();
	        String sql = "UPDATE MEMBER SET pwd = ?, gender = ?, email1 = ?, email2 = ?, tel1 = ?, tel2 = ?, tel3 = ?, zipcode = ?, addr1 = ?, addr2 = ? WHERE id = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, memberDTO.getPwd());
	        pstmt.setString(2, memberDTO.getGender());
	        pstmt.setString(3, memberDTO.getEmail1());
	        pstmt.setString(4, memberDTO.getEmail2());
	        pstmt.setString(5, memberDTO.getTel1());
	        pstmt.setString(6, memberDTO.getTel2());
	        pstmt.setString(7, memberDTO.getTel3());
	        pstmt.setString(8, memberDTO.getZipcode());
	        pstmt.setString(9, memberDTO.getAddr1());
	        pstmt.setString(10, memberDTO.getAddr2());
	        pstmt.setString(11, memberDTO.getId());
	
	        int rows = pstmt.executeUpdate();
	        if (rows > 0) {
	            result = true;
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        closeAll();
	    }
	    return result;
	}
	
	/** memberDeleteForm.jsp */
	// 회원탈퇴
	public boolean memberDelete(String id, String pwd) {
		boolean result = false;
		try {
	        con = ds.getConnection();
	        String sql = "DELETE FROM MEMBER WHERE id = ? AND pwd =?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, id);
	        pstmt.setString(2, pwd);
	        int rows = pstmt.executeUpdate();
	        
	        if (rows > 0) { // 삭제된 행이 있으면 성공
	            result = true;
	        }
		} catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        closeAll();
	    }    
		return result;
	}
	
}