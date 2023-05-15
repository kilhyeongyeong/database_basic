/* 	다 날라갔네.. 에라잇...*/

/*	사용자에게 권한 부여 : GRANT 주고싶은 기능1, 기능2, ...
	만약 모든 권한을 주고 싶다면 ALL PRIVILEGES(모든권한) TO 부여 받을 권한명 */
GRANT ALL PRIVILEGES ON bitcamp06.* TO 'adminid';

/*	테이블 생성 명령
	PRIMARY KEY : 컬럼의 주요 키를 뜻하고, 중복 데이터 방지도 겸함
				  모든 테이블의 컬럼 중 하나는 반드시 PK속성이 부여되어 있어야 함.
    NOT NULL : 해당 컬럼을 비워둘 수 없다는 의미
    UNIQUE : 중복 데이터가 입력되는 것을 방지 */
CREATE TABLE users(
	u_number INT(3) PRIMARY KEY,
	u_id VARCHAR(20) UNIQUE NOT NULL,
    u_name VARCHAR(30) NOT NULL,
    email VARCHAR(80)
);

/*	데이터 적재
	INSERT INTO 테이블명(컬럼1, 컬럼2,...) VALUES(값1, 값2...)
    만약 모든 컬럼에 값을 넣는다면 위 구문에서 테이블명 다음 오는 컬럼명들은 생략 가능 */
INSERT INTO users(u_number, u_id, u_name, email) VALUES(1, 'abc1234', '가나다', NULL);    
INSERT INTO users(u_number, u_id, u_name, email) VALUES(2, 'abc3456', '마바사', 'abc@ab.com');    

/*	데이터 조회
	SELECT * FROM 테이블명;
    특정 컬럼명의 데이터 조회
    SELECT (컬럼명1, 컬럼명2, ...) FROM 테이블명; */
SELECT * FROM users;

/* 	문제
	1. 3번 유저 임의 생성
    2. 조회 : 이메일, 회원번호, 아이디 */
INSERT INTO users VALUES(3, 'abc5678', '아자차', 'efg@gamil.com');
SELECT email, u_number, u_id FROM users;

/*	계정 하나 더 생성 - select 권한만 부여 */
CREATE USER 'adminid2' IDENTIFIED BY '2023502';
GRANT SELECT ON bitcamp06.* TO 'adminid2';

-- uesers 주소 컬럼 추가
-- ALTER TABLE 테이블명 ADD (추카컬럼명 자료타입(크기));
ALTER TABLE users ADD(u_address VARCHAR(30));

-- users 테이블에서 이메일 컬럼 삭제
ALTER TABLE users DROP COLUMN email;

-- u_address 컬럼에 UNIQUE 제약조건 별칭 부여해서 걸기
ALTER TABLE users ADD CONSTRAINT u_address_unique UNIQUE (u_address);

-- 유저 7,8번 insert
INSERT INTO users VALUES(7, 'idid7', 'name7', '강남구');
INSERT INTO users VALUES(8, 'idid8', 'name8', '강남구');

-- 위에서 설정한 UNIQUE 제약조건 없어기
ALTER TABLE users DROP CONSTRAINT u_address_unique;

-- users 테이블명 -> members로 변경
RENAME TABLE users TO members;
SELECT * FROM members;

-- TRUNCATE TABLE은 내부 데이터만 소각(=빈테이블)
TRUNCATE TABLE members;

-- DROP TABLE은 냅 데이터 및 테이블 구조 자체를 삭제
DROP TABLE members;