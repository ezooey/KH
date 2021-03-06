-- SEQUENCE : 자동 번호 발생기
CREATE SEQUENCE SEQ_EMPID
START WITH 300 -- 시작 숫자
INCREMENT BY 5 -- 증가 숫자
MAXVALUE 310 -- 최대 값
NOCYCLE -- 사이클을 돌지 않음
NOCACHE; -- 메모리 상에서 관리 안 함

SELECT * FROM USER_SEQUENCES;

-- 시퀀스명.CURRVAL(CURRENT VALUE) : 현재 생성된 시퀀스 값(NEXTVAL에 의해 마지막으로 리턴된 값)
-- 시퀀스명.NEXTVAL(NEXT VALUE) : 시퀀스를 증가시킴 또는 최초로 시퀀스를 실행시킴
SELECT SEQ_EMPID.CURRVAL FROM DUAL;
--ORA-08002: 시퀀스 SEQ_EMPID.CURRVAL은 이 세션에서는 정의 되어 있지 않습니다
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 300
SELECT SEQ_EMPID.CURRVAL FROM DUAL; -- 300
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 305
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 310
SELECT SEQ_EMPID.CURRVAL FROM DUAL; -- 310

SELECT SEQ_EMPID.NEXTVAL FROM DUAL;
--ORA-08004: 시퀀스 SEQ_EMPID.NEXTVAL exceeds MAXVALUE은 사례로 될 수 없습니다
--> 최대값을 310으로 설정했기 때문

CREATE SEQUENCE SEQ_EID
START WITH 300
--1씩 증가할 거라 INCREMENT MAXVALUE 따로 안 썼음
NOCYCLE
NOCACHE;

INSERT INTO EMPLOYEE
VALUES(SEQ_EID.NEXTVAL, '강건강', '111111-1111111', 'kang_kk@kh.or.kr', '01011112222',
        'D2', 'J3', 'S1', 5000000, 0.1, 200, SYSDATE, NULL, DEFAULT);
SELECT * FROM EMPLOYEE;

ROLLBACK;

-- 시퀀스 변경 : ALTER
-- START WITH는 변경 불가능 -> DROP 후 재생성 해야 함
ALTER SEQUENCE SEQ_EMPID
INCREMENT BY 10
MAXVALUE 400
CYCLE
NOCACHE;

SELECT SEQ_EMPID.NEXTVAL FROM DUAL;
-- 계속 실행하면 400까지 갔다가 1로 돌아가 10씩 증가하게 됨

-- 인덱스 배우지 않았지만 중요함. 연습 필요(인덱스가 더 빠르게 검색 가능)