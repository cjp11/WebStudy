CREATE TABLE MEMBER2(
    IDX NUMBER(5) PRIMARY KEY,
    ID VARCHAR2(10),
    PWD VARCHAR2(10),
    NAME VARCHAR2(30),
    AGE NUMBER(3),
    ADDRESS VARCHAR2(300),
    REG DATE
);

CREATE SEQUENCE MEMBER2_SEQ;
INSERT INTO MEMBER2(
    IDX, ID, PWD, NAME, AGE, ADDRESS, REG)
VALUES(MEMBER2_SEQ.NEXTVAL, 'ADMIN', 'ADMIN', '관리자', NULL, NULL, SYSDATE);

INSERT INTO MEMBER2(
    IDX, ID, PWD, NAME, AGE, ADDRESS, REG)
VALUES(MEMBER2_SEQ.NEXTVAL, 'TEST1', 'TEST1', '홍길동', 27, '서울', SYSDATE);
commit;