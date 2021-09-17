-- DDL (ALTER, DROP)
-- ALTER : 객체 수정 / DROP : 객체 삭제
-- 컬럼 추가/수정/삭제
SELECT * FROM DEPT_COPY;

-- 컬럼 추가
ALTER TABLE DEPT_COPY
ADD (CNAME VARCHAR2(20));

ALTER TABLE DEPT_COPY
ADD (LNAME VARCHAR2(40) DEFAULT '한국');

-- 컬럼 수정 
/*
DEPT_ID	CHAR(2 BYTE)
DEPT_TITLE	VARCHAR2(35 BYTE)
LOCATION_ID	CHAR(2 BYTE)
CNAME	VARCHAR2(20 BYTE)
LNAME	VARCHAR2(40 BYTE)
*/
ALTER TABLE DEPT_COPY
MODIFY DEPT_ID CHAR(3);

ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(30)
MODIFY LOCATION_ID VARCHAR2(2)
MODIFY CNAME CHAR(20)
MODIFY LNAME DEFAULT '미국'; -- DEFAULT 값도 변경 가능

INSERT INTO DEPT_COPY
VALUES('D10', '총괄부', 'L1', NULL, DEFAULT);

ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(10);
--ORA-01441: 일부 값이 너무 커서 열 길이를 줄일 수 없음

-- 컬럼 삭제(데이터가 들어 있어도 가능)
CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

SELECT * FROM DEPT_COPY2;

ALTER TABLE DEPT_COPY2
DROP COLUMN CNAME;

ALTER TABLE DEPT_COPY2
DROP COLUMN LOCATION_ID;

ALTER TABLE DEPT_COPY2
DROP COLUMN LNAME;

ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_ID;

ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_TITLE; --ORA-12983: 테이블에 모든 열들을 삭제할 수 없습니다
-- 테이블은 최소 한 개 이상의 컬럼을 가져야 해서 더 이상 삭제 불가능

ROLLBACK; -- DML 관련만 롤백 가능 (그래서 DDL은 커밋 따로 불요)

CREATE TABLE TB1(
    PK1 NUMBER PRIMARY KEY,
    COL1 NUMBER,
    CHECK(PK1 > 0 AND COL1 > 0)
);

CREATE TABLE TB2(
    PK2 NUMBER PRIMARY KEY,
    COL2 NUMBER,
    FK2 NUMBER REFERENCES TB1,
    CHECK(PK2 > 0 AND COL2 > 0)
);

ALTER TABLE TB1
DROP COLUMN PK1; --ORA-12992: 부모 키 열을 삭제할 수 없습니다

ALTER TABLE TB2
DROP COLUMN PK2; --ORA-12991: 열이 다중-열 제약 조겅에 참조되었습니다

ALTER TABLE TB1
DROP COLUMN PK1 CASCADE CONSTRAINTS; -- 제약조건까지 같이 지워서 제대로 실행됨

SELECT * FROM TB1;

-- 제약조건 추가
-- DEPT_COPY테이블에 제약조건 추가
-- PRIMARY KEY를 DEPT_ID에 추가 (PK_DCOPY_DID)
-- UNIQUE를 DEPT_TITLE에 추가 (UQ_DCOPY_DTITLE)
-- NOT NULL을 LNAME에 추가 (NN_DCOPY_LNAME)

--ALTER TABLE DEPT_COPY ADD CONSTRAINT PK_DCOPY_DID PRIMARY KEY(DEPT_ID);
--ALTER TABLE DEPT_COPY ADD CONSTRAINT UQ_DCOPY_DTITLE UNIQUE(DEPT_TITLE);
--ALTER TABLE DEPT_COPY MODIFY LNAME CONSTRAINT NN_DCOPY_LNAME NOT NULL;

ALTER TABLE DEPT_COPY 
ADD CONSTRAINT PK_DCOPY_DID PRIMARY KEY(DEPT_ID)
ADD CONSTRAINT UQ_DCOPY_DTITLE UNIQUE(DEPT_TITLE) -- 빨간줄 신경 안 써도 됨
MODIFY LNAME CONSTRAINT NN_DCOPY_LNAME NOT NULL;

-- 제약조건 삭제
ALTER TABLE DEPT_COPY
DROP CONSTRAINT PK_DCOPY_DID;

ALTER TABLE DEPT_COPY
DROP CONSTRAINT UQ_DCOPY_DTITLE
DROP CONSTRAINT SYS_C007899
MODIFY LNAME NULL;

-- 이름 변경
SELECT * FROM DEPT_COPY;

ALTER TABLE DEPT_COPY
RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

ALTER TABLE DEPT_COPY
RENAME CONSTRAINT SYS_C007900 TO NN_DCOPY_LID;

ALTER TABLE DEPT_COPY
RENAME /*TABLE DEPT_COPY*/ TO DEPT_TEST; -- 어차피 바로 윗줄에 명시했기 때문에 삭제

-- 테이블 삭제
DROP TABLE DEPT_TEST;

DROP TABLE DEPT_TEST
CASCADE CONSTRAINTS;