 -- projectJSP/src/main/webapp/sql/boardJSP.sql
 
 -- Oracle
 CREATE TABLE board_jsp(
     seq NUMBER NOT NULL,               -- 글번호 (시퀀스 객체 이용)
     id VARCHAR2(20) NOT NULL,          -- 아이디
     name VARCHAR2(40) NOT NULL,        -- 이름
     email VARCHAR2(40),                -- 이메일
     subject VARCHAR2(255) NOT NULL,    -- 제목
     content VARCHAR2(4000) NOT NULL,   -- 내용 
     ref NUMBER NOT NULL,               -- 그룹번호 (글번호와 같은 값 가짐) (seq_board_jsp.CURRVAL)
     lev NUMBER DEFAULT 0 NOT NULL,     -- 단계
     step NUMBER DEFAULT 0 NOT NULL,    -- 글순서
     pseq NUMBER DEFAULT 0 NOT NULL,    -- 원글번호
     reply NUMBER DEFAULT 0 NOT NULL,   -- 답변수
     hit NUMBER DEFAULT 0,              -- 조회수
     logtime DATE DEFAULT SYSDATE
 );

 CREATE SEQUENCE seq_board_jsp  NOCACHE NOCYCLE;



 