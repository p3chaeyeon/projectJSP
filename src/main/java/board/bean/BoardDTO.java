// projectJSP/src/main/java/member.bean.BoardDTO.java
package board.bean;

import java.util.Date;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Data
@NoArgsConstructor
public class BoardDTO {
	@NonNull
    private int seq; // 글번호 9시퀀스 객체 seq_board_jsp 이용)
	@NonNull
	private String name;
	@NonNull
	private String id;
	private String email;
	@NonNull
	private String subject;
	@NonNull
	private String content;
	@NonNull
	private int ref; // 그룹번호
	@NonNull
	private int lev; // 단계
	@NonNull
	private int step; // 글순서
	private int pseq; // 원글번호; seq 와 똑같은 값이 들어감
	@NonNull
	private int reply; // 답변수
	private int hit; // 조회수
	private Date logtime;
}