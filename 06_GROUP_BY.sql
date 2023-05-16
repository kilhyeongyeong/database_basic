/* 	GROUP BY는 제시한 기준 컬럼들에서 동일한 값을 갖는 것 끼리 한 집단으로 묶고 집계
	SELECT 집계 컬럼명 FROM 테이블명 GROUP BY 기준컬럼명 */
SELECT AVG(user_height) AS 평균키,
	   user_address,
       count(*)
  FROM user_tbl
 GROUP BY user_address;
 
-- 생년별 체중 평균
SELECT AVG(user_weigth) AS 평균체중,
	   user_birth_year,
       count(user_num) as 인원수
  FROM user_tbl
 GROUP BY user_birth_year
 order by user_birth_year;
 
-- user_tbl의 가장 큰 키, 가장 빠른 출생년도
select max(user_height),
	   min(user_birth_year)
  from user_tbl;
  
-- 거주자가 2명 이상인 지역만 카운팅
SELECT AVG(user_birth_year) AS 생년평균,
	   user_address
  FROM user_tbl
 GROUP BY user_address
HAVING count(*) >= 2;

-- 생년 기준으로 평균키가 160이상인 생년만 출력
SELECT user_birth_year  AS 생년,
	   AVG(user_height) AS 평균키
  FROM user_tbl
 GROUP BY user_birth_year
HAVING AVG(user_height) >= 160;