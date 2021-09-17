-- DML : 데이터 조작 언어
-- 테이블에 값 삽입(INSERT) / 수정(UPDATE) / 삭제(DELETE)

-- INSERT : 테이블에 데이터 추가 (행 개수 증가)
-- INSERT INTO 테이블명(컬럼명1, 컬럼명2, ...) VALUES(값1, 값2, ...)
INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE, DEPT_CODE, JOB_CODE,
                     SAL_LEVEL, SALARY, BONUS, MANAGER_ID, HIRE_DATE, ENT_DATE, ENT_YN)
VALUES(500, '송성실', '990111-1223344', 'SONG_SS@kh.or.kr', '01023456789', 'D1', 'J7', 'S3',
       3000000, 0.2, 200, SYSDATE, NULL, DEFAULT);
INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL)
VALUES(500, '송성실', '990111-1223344', 'J7', 'S3');
-- 정석 INSERT
-- 장점 : 내가 나열한 컬럼 순서대로 값을 집어넣을 수 있음(본 테이블의 컬럼 순서대로 안 해도 됨)
--     : 내가 원하는 컬럼만 뽑아서 값을 넣을 수 있음
-- 단점 : 쓰는 게 너무 많음
       
ROLLBACK;

INSERT INTO EMPLOYEE
VALUES(500, '송성실', '990111-1223344', 'SONG_SS@kh.or.kr', '01023456789', 'D1', 'J7', 'S3',
       3000000, 0.2, 200, SYSDATE, NULL, DEFAULT);
--INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL)
--VALUES(500, '송성실', '990111-1223344', 'J7', 'S3');
-- 값의 수가 충분하지 않습니다
-- 모든 컬럼에 다 추가한다면 컬럼명 생략 가능
-- 장점 : 쓰는 게 적음
-- 단점 : 모든 컬럼에 값을 집어넣어야 함
--       본 테이블의 컬럼 순서를 외우고 있어야 함

COMMIT;

CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_01;

INSERT INTO EMP_01(
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
         LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
);

SELECT * FROM EMP_01;

-- INSERT ALL : 여러 개 테이블에 한번에 삽입
CREATE TABLE EMP_DEPT_D1
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
   FROM EMPLOYEE
   WHERE 1 = 0; -- 항상 FALSE인 조건
   -- 내용 없이 틀만 뽑아오게 됨
   -- WHERE절에 1 = 0인 경우 모든 행에서 항상 FALSE가 나와서
   -- 아무 행도 조건을 충족시키지 못 하므로 값은 생성되지 않고 테이블 컬럼만 생성
   
SELECT * FROM EMP_DEPT_D1;

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
   FROM EMPLOYEE
   WHERE 1 = 0;
   
SELECT * FROM EMP_MANAGER;

-- EMP_DEPT_D1테이블에 EMPLOYEE테이블에 있는 부서코드가 D1인 직원을 조회해 사번, 이름, 소속부서, 입사일 삽입
-- EMP_MANAGER테이블에 EMPLOYEE테이블에 있는 부서코드가 D1인 직원을 조회해 사번, 이름, 관리자 사번 삽입

-- 따로따로 하나씩 만들기
INSERT INTO EMP_DEPT_D1(
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1'
);

SELECT * FROM EMP_DEPT_D1;

INSERT INTO EMP_MANAGER(
    SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1'
);

SELECT * FROM EMP_MANAGER;


ROLLBACK;

-- 한번에 만들기
INSERT ALL 
INTO EMP_DEPT_D1 VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1';
    
SELECT * FROM EMP_DEPT_D1;
SELECT * FROM EMP_MANAGER;

-- EMPLOYEE테이블의 구조를 복사하여 사번, 이름, 입사일, 급여를 기록할 수 있는 EMP_OLD, EMP_NEW테이블 생성
CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
   FROM EMPLOYEE
   WHERE 1 = 0;

CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
   FROM EMPLOYEE
   WHERE 1 = 0;
   
   
-- EMPLOYEE테이블의 입사일 기준으로 2000년 1월 1일 이전에 입사한 사원은 EMP_OLD로
-- 2000년 1월 1일 이후에 입사한 사원은 EMP_NEW로 사번, 이름, 입사일, 급여 삽입
INSERT INTO EMP_OLD(
    SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE HIRE_DATE < '2000/01/01'
);

INSERT INTO EMP_NEW(
    SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE HIRE_DATE >= '2000/01/01'
);
SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

ROLLBACK;

INSERT ALL
WHEN HIRE_DATE < '2000/01/01' THEN
    INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
WHEN HIRE_DATE >= '2000/01/01' THEN
    INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;

-- UPDATE : 테이블에 기록된 값 수정(행 개수 변화X)
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

-- DEPT_COPY테이블에서 DEPT_ID가 D9인 행의 DEPT_TITLE을 전략기획팀으로 수정
UPDATE DEPT_COPY
SET DEPT_TITLE = '전략기획팀'
WHERE DEPT_ID = 'D9'; -- 조건절을 설정하지 않을 시 모든 행에 대해 UPDATE 진행

ROLLBACK;

CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
    FROM EMPLOYEE;
    
SELECT * FROM EMP_SALARY
WHERE EMP_NAME IN ('방명수', '유재식');

UPDATE EMP_SALARY
SET SALARY = (SELECT SALARY
              FROM EMP_SALARY
              WHERE EMP_NAME = '유재식'), 
    BONUS = (SELECT BONUS
             FROM EMP_SALARY
             WHERE EMP_NAME = '유재식')
WHERE EMP_NAME = '방명수';

SELECT * FROM EMP_SALARY
WHERE EMP_NAME IN ('방명수', '유재식', '노옹철', '전형돈', '정중하', '하동운');

UPDATE EMP_SALARY
SET (SALARY, BONUS) = (SELECT SALARY, BONUS
                       FROM EMP_SALARY
                       WHERE EMP_NAME = '유재식')
WHERE EMP_NAME IN ('노옹철', '전형돈', '정중하', '하동운');

-- EMP_SALARY테이블에서 아시아지역에 근무하는 직원의 보너스를 0.3으로 변경

UPDATE EMP_SALARY
SET BONUS = 0.3
WHERE EMP_ID IN (SELECT EMP_ID
                FROM EMP_SALARY
                     JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
                     JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
                WHERE LOCAL_NAME LIKE 'ASIA%');

SELECT EMP_ID, EMP_NAME, SALARY, BONUS, LOCAL_NAME
FROM EMP_SALARY
     JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
     JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);

COMMIT;

-- UPDATE시 제약조건에 위배되지 않게 변경해야 함
UPDATE DEPARTMENT
SET LOCATION_ID = /*'112'*/ '77'
WHERE LOCATION_ID = 'L2';
--ORA-12899: "KH"."DEPARTMENT"."LOCATION_ID" 열에 대한 값이 너무 큼(실제: 3, 최대값: 2) (112로 넣었을 때)
--ORA-02291: 무결성 제약조건(KH.SYS_C007890)이 위배되었습니다- 부모 키가 없습니다 (77로 넣었을 때)

UPDATE EMPLOYEE
SET DEPT_CODE = '66'
WHERE DEPT_CODE = 'D6';

ROLLBACK;

ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT/*(DEPT_ID)*/;
-- 외래키 제약조건을 걸었으므로 이제 DEPT_CODE에 66을 넣을 수 없음

UPDATE EMPLOYEE
SET EMP_NAME = NULL;
--ORA-01407: NULL로 ("KH"."EMPLOYEE"."EMP_NAME")을 업데이트할 수 없습니다

-- DELETE : 테이블에 있는 행 삭제(행 개수 줄어듦)
COMMIT;

SELECT * FROM EMPLOYEE;

DELETE FROM EMPLOYEE
WHERE EMP_NAME = '송성실';

DELETE FROM EMPLOYEE;
ROLLBACK;

DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';
--ORA-02292: 무결성 제약조건(KH.SYS_C007903)이 위배되었습니다- 자식 레코드가 발견되었습니다
--> 위에서 EMPLOYEE - DEPARTMENT 외래키로 연결했기 때문에 참조되고 있는 값은 삭제 불가

ALTER TABLE EMPLOYEE
DISABLE CONSTRAINT SYS_C007903 CASCADE; -- 제약조건 비활성화

SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE WHERE DEPT_CODE = 'D1';
-- 제약조건 비활성화 한 뒤 위의 DELETE 실행시키면 DEPARTMENT에서는 D1이 사라지고 EMPLOYEE에는 남아있음

ROLLBACK;

ALTER TABLE EMPLOYEE
ENABLE CONSTRAINT SYS_C007903; -- 제약조건 활성화

COMMIT;

-- TRUNCATE : 테이블의 전체 행 삭제
-- DELETE보다 수행속도가 빠름, ROLLBACK을 통해 복구 불가능
SELECT * FROM EMP_SALARY;

DELETE FROM EMP_SALARY;

ROLLBACK;

TRUNCATE TABLE EMP_SALARY;
--Table EMP_SALARY이(가) 잘렸습니다.