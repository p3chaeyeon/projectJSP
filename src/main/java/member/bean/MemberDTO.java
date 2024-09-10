// projectJSP/src/main/java/member.bean.MemberDTO.java
package member.bean;

import java.util.Date;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Data
@NoArgsConstructor
public class MemberDTO {
	@NonNull
	private String name;
	@NonNull
	private String id;
	@NonNull
	private String pwd;
	private String gender;
	private String email1;
	private String email2;
	private String tel1;
	private String tel2;
	private String tel3;
	private String zipcode;
	private String addr1;
	private String addr2;
	private Date logtime;
}