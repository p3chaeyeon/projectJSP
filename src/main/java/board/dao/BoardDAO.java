//projectJSP/src/main/java/member.dao/BoardDAO.java
package board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import board.bean.BoardDTO;

public class BoardDAO {
    private Connection con;
    private PreparedStatement pstmt;
    private ResultSet rs; // SQL(select) 쿼리 결과를 저장하는 객체
    private DataSource ds;

    // 싱글톤 인스턴스 생성
    private static BoardDAO instance = new BoardDAO();

    public static BoardDAO getInstance() {
        return instance;
    }
    
    public BoardDAO() { // Driver Loading
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

    /** boardWriteForm.jsp */
	// 글쓰기
	public Map<String, String> boardWrite(BoardDTO boardDTO) {
		Map<String, String> resultMap = new HashMap<>();
	    try {
	        con = ds.getConnection();
	        // 시퀀스 사용하여 seq 생성
	        String sql = """
	        		INSERT INTO board_jsp (seq, id, name, email, subject, content, ref) 
	                VALUES (seq_board_jsp.NEXTVAL, ?, ?, ?, ?, ?, seq_board_jsp.CURRVAL)
	                     """;
	        
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, boardDTO.getId());
	        pstmt.setString(2, boardDTO.getName());
	        pstmt.setString(3, boardDTO.getEmail());
	        pstmt.setString(4, boardDTO.getSubject());
	        pstmt.setString(5, boardDTO.getContent());
	        
	        int result = pstmt.executeUpdate();
	        
	        if (result > 0) {
	            resultMap.put("status", "success");
	        } else {
	            resultMap.put("status", "fail");
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	        resultMap.put("status", "error");
	        resultMap.put("message", e.getMessage());
	    } finally {
	        closeAll();
	    }
	
	    return resultMap;
	}
	
	/** boardList.jsp */
	// 글 목록
	public List<BoardDTO> boardList(int startNum, int endNum) {
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		
		String sql = """
					    SELECT * FROM (
					    SELECT ROWNUM rn, tt.* 
					    FROM (SELECT * FROM board_jsp ORDER BY ref DESC, step ASC) tt
					    ) WHERE rn >= ? AND rn <= ?
					""";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startNum);
			pstmt.setInt(2, endNum);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDTO boardDTO = new BoardDTO();
				boardDTO.setSeq(rs.getInt("seq"));
				boardDTO.setName(rs.getString("name"));
				boardDTO.setId(rs.getString("id"));
				boardDTO.setEmail(rs.getString("email"));
				boardDTO.setSubject(rs.getString("subject"));
				boardDTO.setContent(rs.getString("content"));
				boardDTO.setRef(rs.getInt("ref"));
				boardDTO.setLev(rs.getInt("lev"));
				boardDTO.setStep(rs.getInt("step"));
				boardDTO.setPseq(rs.getInt("pseq"));
				boardDTO.setReply(rs.getInt("reply"));
				boardDTO.setHit(rs.getInt("hit"));
				boardDTO.setLogtime(rs.getDate("logtime"));
				
				list.add(boardDTO);
			} // while
		} catch (SQLException e) {
	        e.printStackTrace();
	        list = null;
	    } finally {
	        closeAll();
	    }
		return list;
	}
	
	// 글 개수
	public int getTotalA() {
		int totalA = 0;
		
		String sql = "SELECT COUNT(*) FROM board_jsp";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalA = rs.getInt(1); // 첫 번째 열(여기서는 COUNT(*))의 값을 가져옴
			}
		} catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        closeAll();
	    }
		return totalA;
	}
}
