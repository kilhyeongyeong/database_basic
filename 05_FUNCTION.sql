SELECT * FROM user_tbl;

INSERT INTO user_tbl VALUES  (NULL, 'alex', 1986, 'NY', 173, '2020-11-01')
							,(NULL, 'Smith', 1992, 'Texas', 181, '2020-11-05')
                            ,(NULL, 'Emma', 1995, 'Tempa', 168, '2020-12-13')
                            ,(NULL, 'JANE', 1996, 'LA', 157, '2020-12-15');
                            
-- 문자열 함수를 활용하여 조회
SELECT 	user_name,
		UPPER(user_name) AS 대문자유저명,
        LOWER(user_name) AS 소문자유저명,
        LENGTH(user_name) AS 문자길이,
        SUBSTR(user_name, 2, 3) AS A번째글자부터B개글자,
        CONCAT(user_name, '회원이 존재합니다.') AS 회원목록
  FROM user_tbl;
  
-- 이름이 4글자 이상인 유저만 출력
SELECT * 
  FROM user_tbl 
 WHERE CHAR_LENGTH( user_name) >= 4;
 
-- 함수 없이 이름이 4글자이상인 유저만 출력
SELECT * 
  FROM user_tbl 
 WHERE user_name LIKE "____%";
 
-- user_tbl에 소수점 아래를 저장받을 수 있는 컬럼 추가
-- DECIMAL(A, B) : 총 A자릿수 중 소수점 아래 B개
ALTER TABLE user_tbl ADD (user_weigth DECIMAL(3,2));
ALTER TABLE user_tbl MODIFY user_weigth DECIMAL(5,2);

SELECT * FROM user_tbl;

UPDATE user_tbl SET user_weigth = 52.12 WHERE user_num=10;

-- 숫자함수
SELECT 	user_name,
		user_weigth,
        ROUND(user_weigth, 0) AS 반올림,
        TRUNCATE(user_weigth, 1) AS 소수점아래_1자리절사,
        MOD(user_height, 150) AS 키_150으로나눈나머지,
        CEIL(user_weigth) AS 키올림,
        FLOOR(user_weigth) AS 양수음수_0여부,
        SQRT(user_height) AS 키_제곱근
  FROM 	user_tbl;

-- 날짜함수
SELECT 	user_name,
		entry_date,
        DATE_ADD(entry_date, INTERVAL 3 MONTH) AS _3개월후,
        LAST_DAY(entry_date) as 해당월마지막날짜,
        TIMESTAMPDIFF(MONTH, entry_date, NOW()) AS 오늘과의개월수차이
        -- TRUNCATE(entry_date) AS 날짜절사 -- (이거 오라클 함수네 날짜-Truncate)
  FROM	user_tbl;
  
-- 변환함수
select user_num,
	   user_name,
       entry_date,
       date_format(entry_date, '%Y%m%d') as 일자표현변경,
       cast(user_num as char) as 문자로바꾼회원조회
  from user_tbl;
  
-- user_height, user_weight이 NULL인 자료 추가
insert into user_tbl values(null, '임쿼리', 1986, '제주', null, '2021-01-03', null);

SELECT * FROM user_tbl;

-- null에다가 특정 숫자 곱하기
SELECT 0 * NULL;
SELECT 1000000 * 0.1;
SELECT NULL + 5000000;
SELECT 1000000 + 5000000;

-- IFNULL()
SELECT user_name,
	   IFNULL(user_height, 167) as _null대체값넣은키,
       IFNULL(user_weigth, 65) as _null대체값넣은체중
  from user_tbl;
  
-- user_tbl : 165 미만 => 평균미만, 165 => 평균, 165 이상 => 평균이상
SELECT user_name,
	   user_height,
       CASE WHEN user_height < 164 THEN '평균미만'
			WHEN user_height = 164 THEN '평균'
            WHEN user_height > 164 THEN '평균초과'
	   END AS 키분류,
       user_weigth
  FROM user_tbl;
  
/* 	사용테이블 : user_tbl  
	BMI 지수 구하기 : BMI = 체중 / 키^2
    BMI 지수가 18미만 : 저체중, 18~24 : 일반체중, 25이상 : 고체중
    BMI지수 AS BMI_RESULT, BMI분류 AS BMI_CASE */
SELECT user_name,
	   user_height,
       user_weigth,
       user_weigth / pow(user_height/100, 2) AS BMI_RESULT,
       CASE WHEN (user_weigth / pow(user_height/100, 2)) < 18 THEN '저체중'
			WHEN (user_weigth / pow(user_height/100, 2)) BETWEEN 18 AND 25 THEN '일반체중'
            WHEN (user_weigth / pow(user_height/100, 2)) >= 25 THEN '고체중'
       END AS BMI_CASE
  FROM user_tbl;
  
SELECT * FROM user_tbl;  

    