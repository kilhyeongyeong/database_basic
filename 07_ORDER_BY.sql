/*	ORDER BY는 SELECT문의 질의 결과를 정렬시 사용
	ORDER BY 절 다음에는 어떤 컬럼을 기준으로 어떤 방식으로 정렬할지 기입 */
    
-- user_tbl 테이블에서 키순 내림차순 정렬
SELECT *
  FROM user_tbl
 ORDER BY user_height DESC;
 
/*	테이블 : user_tbl
	정렬 : 1. 키순으로 오름차순 정렬 2. 체중순으로 내림차순 정렬 */
SELECT *
  FROM user_tbl
 ORDER BY user_height ASC, 
		  user_weigth DESC;
          
/*	테이블 : user_tbl
	정렬 : 1. 이름-내림차순 */
SELECT user_num,
	   user_name AS un,
       user_birth_year,
       user_address
  FROM user_tbl
 ORDER BY un DESC;

/*	테이블 : user_tbl
	정렬 : 1. 세 번째 컬럼 - 내림차순 */
SELECT user_num,
	   user_name AS un,
       user_birth_year,
       user_address
  FROM user_tbl
 ORDER BY 3 DESC, 2 DESC;
 
/*	테이블 : user_tbl
	지역별 키 평균
	정렬 : 1. 키 평균 - 내림차순 */
SELECT user_address,
	   AVG(user_height) AS AVG_H
  FROM user_tbl
 GROUP BY user_address
 ORDER BY AVG_H DESC;

-- 경기 지역 사람들만 체중을 기준으로 내림차순
SELECT *
  FROM user_tbl
 ORDER BY 
  CASE user_address
	   WHEN '경기' THEN user_weigth
	   else null
   end DESC;
   
-- 생년도가 1992 사람은 키 기준 오름차순
-- 새연ㄴ도가 1998인 사람은 이름 기준 오름차순
SELECT *
  FROM user_tbl
 ORDER BY
  CASE user_birth_year WHEN 1992 THEN user_height
					   WHEN 1998 THEN user_name
                       ELSE NULL
   END ASC;
