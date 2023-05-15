/* 	DB 선택 방법
	1. 좌측의 SCHEMAS를 더블클릭하여 DB선택
	2. 마우스 우클릭 Set as Default Schemas로 DB선택
	3. use DB명; 으로 DB선택 */
    
-- Workbench(윈도우)에서 수행가능한 구문은 거의 모두 CLI환경에서 수행 가능
use sys; -- use bitcamp06

/* Database 정보 조회 */
SHOW DATABASES;

/* 테이블 생성 */
CREATE TABLE user_tbl (
	user_num int(5) PRIMARY KEY	AUTO_INCREMENT, -- INSERT시 숫자 자동배정
    user_name VARCHAR(10) NOT NULL,
    user_birth_year INT NOT NULL,
    user_address char(5) not null,
    user_height int, -- 자리수 제한 X
	entry_date date -- 회원가입일
);

/* 	기본적인 테이블은 조회
	SELECT * FROM 데이터베이스명.테이블명
    use 구문 등을 이용해 데이터베이스를 지정한 경우 '데이터베이스명.' 생략가능 */
SELECT * FROM bitcamp06.user_tbl;

-- AUTO_INCREMENT가 되어있는 컬럼은 null주면 자동 숫자 배정
INSERT INTO user_tbl VALUES(NULL, '김자바', '1987', '서울', 180, '2020-05-03');
INSERT INTO user_tbl VALUES(NULL, '이연희', '1992', '경기', 164, '2020-05-12');
INSERT INTO user_tbl VALUES(NULL, '박종현', '1990', '부산', 177, '2020-06-01');
INSERT INTO user_tbl(user_name, user_birth_year, user_address, user_height, entry_date) 
	VALUES('신영웅', '1995', '광주', 172, '2020-07-15');
    
/* 	WHERE 조건
	90년대 이후 출생자만 조회 */
SELECT * 
  FROM user_tbl
 WHERE user_birth_year > 1989;
 
 -- 키 175 미만 조회
SELECT *
  FROM user_tbl
 WHERE user_height < 175;
 
-- AND 혹은 OR을 이용하여 다중 조건 가능
SELECT *
  FROM user_tbl
 WHERE user_num > 2 OR user_height < 178;
 
 -- UPDATE 테이블명 SET 컬럼명1 = 대입값1, 컬럼명2 = 대입값2...;
 -- 주의 : WHERE이 없으면 해당 컬럼의 모든 값이 다 동일값으로 변경
 UPDATE user_tbl SET user_address = '서울';
 
 -- WHERE절 없는 UPDATE 구문 실행 방지, SAFE UPDATE를 일시적으로 해제 -> 1175오류 발생X
 SET SQL_SAFE_UPDATES=0;
 
 -- 테이블이 존재할 경우 테이블 삭제
 DROP TABLE IF EXISTS user_tbl;
 
 -- 김자바씨 지역 강원으로 변경
 UPDATE user_tbl 
    SET user_address = '강원' 
  WHERE user_num = 1;

-- 삭제는 특정컬럼만 떼서 삭제할 일이 없으므로 SELECT와는 달리 * 등을 사용X
-- safty 모드를 우회하거나 CLI에서 삭제
DELETE 
  FROM user_tbl
 WHERE user_name = '박종현';

-- where없이 삭제시 truncate와 동일 기능 수행
DELETE
  FROM user_tbl;
  
-- 다중 INSERT 구문 사용  
/* 	INSERT INTO 테이블명(컬럼1, 컬럼2, 컬럼3,...)
	VALUES(값1, 값2, 값3,...),
		  (값4, 값5, 값6,...),
		  (값7, 값8, 값9,...),
          ...;
	컬럼명은 모든 컬럼에 값을 넣을 경우 생략 가능 */
INSERT INTO user_tbl
	 VALUES(NULL, '강개발', 1994, '경남', 178, '2020-08-02'),
		   (NULL, '최지선', 1998, '전북', 170, '2020-08-03'),
           (NULL, '류가연', 2000, '전남', 158, '2020-08-20');
    
CREATE TABLE user_tbl2 (
	user_num int(5) PRIMARY KEY	AUTO_INCREMENT, -- INSERT시 숫자 자동배정
    user_name VARCHAR(10) NOT NULL,
    user_birth_year INT NOT NULL,
    user_address char(5) not null,
    user_height int, -- 자리수 제한 X
	entry_date date -- 회원가입일
);

-- user_tbl2에 user_tbl의 자료 중 생년 1995년 이후인 자료만 복사해서 삽입
INSERT INTO user_tbl2
	 SELECT * 
	   FROM user_tbl
	  WHERE user_birth_year > 1995;
      
-- 두 번째 테이블 : 구매내역
-- user_tbl에 존재하는 유저만 추가 가능(join key)
CREATE TABLE buy_tbl(
	buy_num 		INT AUTO_INCREMENT PRIMARY KEY,
    uesr_num 		INT(5) NOT NULL,
    prod_name 		VARCHAR(10) NOT NULL,
    prod_category 	VARCHAR(10) NOT NULL,
    price			INT NOT NULL,
    amount			INT NOT NULL
);

-- 외래키 설정 없이 추가
INSERT INTO buy_tbl VALUES(NULL, 4, '아이패드', '전자기기', 100, 1);
INSERT INTO buy_tbl VALUES(NULL, 5, '애플펜슬', '전자기기', 15, 1);
INSERT INTO buy_tbl 
	 VALUES(NULL, 6, '트레이닝복', '의류', 10, 2),
		   (NULL, 5, '안마의자', '의료기기', 400, 1),
           (NULL, 2, 'SQL책', '도서', 2, 1);

INSERT INTO buy_tbl VALUES(NULL, 99, '애플펜슬', '핵미사일', 100000, 5);
delete from buy_tbl where buy_num = 5;

-- 외래키 설정
ALTER TABLE buy_tbl ADD CONSTRAINT FK_buy_tbl 
FOREIGN KEY (uesr_num)  REFERENCES user_tbl(user_num);

-- 만약 user_tbl에 있는 요소를 삭제시, buy_tbl에 구매내역이 남은 user_num을 삭제한다면
-- 특별히 on_delete를 걸지 않은 경우 참조 무결성 원칙에 위배되어 삭제 불가
DELETE FROM user_tbl WHERE user_num = 6;

-- 추가적인 설정 없이 user_tbl의 4번 유저를 삭제하기 위해서는
-- buy_tbl의 4번 유저가 남긴 구매내역을 모두 삭제
DELETE FROM buy_tbl WHERE buy_num=2;

select * from buy_tbl;     
SELECT * FROM user_tbl;
SELECT * FROM user_tbl2;

-- user_tbl2의 2020-08-15 이후 가입자 삭제
DELETE FROM user_tbl2 WHERE entry_date > '2020-08-15';

-- user_tbl2의 2020-08-03 가입자 삭제
DELETE FROM user_tbl2 WHERE entry_date = '2020-08-03';

insert into user_tbl values  (null, '이자바', '1994', '서울', 178, '2020-09-01')
							,(null, '신디비', '1992', '경기', 164, '2020-09-01')
                            ,(null, '최다희', '1998', '경기', 158, '2020-09-01');
                            
-- DISTINCT는 특정 컬럼에 들어있는 데이터의 '종류'만 한 번씩 나열해 보여줍니다.
SELECT DISTINCT user_birth_year FROM user_tbl;

-- Alias
SELECT user_name as 유저명 FROM user_tbl;
SELECT  user_name  AS 유저명,
		entry_date AS 가입날짜
  FROM user_tbl;
                            

