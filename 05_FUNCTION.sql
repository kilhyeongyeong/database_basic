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