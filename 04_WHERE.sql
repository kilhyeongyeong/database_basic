-- user_tbl 사용
SELECT * FROM user_tbl;
SELECT * FROM buy_tbl;

-- 수도권(서울, 경기)에 사는 사람들
SELECT * FROM user_tbl WHERE user_address='서울' OR user_address='경기';

-- IN문법 사용 : IN 괄호 내에 있는 리스트 목록에 포함된 요소만 출력
SELECT * FROM user_tbl WHERE user_address IN('서울', '경기');

-- 구매내역이 있는 유저만 출력(서브쿼리를 활용한 조회 구문)
SELECT * 
  FROM user_tbl 
 WHERE user_num IN (SELECT DISTINCT uesr_num 
					  FROM buy_tbl);
                      
/* like 구문은 패턴 일치 여부를 통해서 조회
	% : 와일드카드 문자 -> 모든 글자 허용
    _ : 와일드카드 문자 -> 글자수 처리 */
    
-- 이름이 '희'자로 끝나는 사람    
select * from user_tbl where user_name like '%희';

-- 'XX남도'에 거주하느 사람
SELECT * FROM user_tbl WHERE user_address LIKE '%남';
SELECT * FROM user_tbl WHERE user_address LIKE '_남';

-- 이름이 '자바'인 사람만 조회alter
SELECT * FROM user_tbl WHERE user_name LIKE '_자바';
SELECT * FROM user_tbl WHERE user_name LIKE '%자바';

-- 키가 165 ~ 175인 사람
SELECT * FROM user_tbl WHERE user_height BETWEEN 170 AND 180;
-- AND 이용
SELECT * FROM user_tbl WHERE user_height >= 165 AND user_height <= 175;

-- NULL을 갖는 데이터 생성
INSERT INTO user_tbl VALUES  (NULL, '박진영', 1990, '제주', NULL, '2020-10-01')
							,(NULL, '김혜경', 1992, '강원', NULL, '2020-10-02')
                            ,(NULL, '신지수', 1993, '서울', NULL, '2020-10-05');
                            
-- NULL인 자료들 조회 : IS NULL 사용
SELECT * FROM user_tbl WHERE user_height = NULL; -- 결과 x
SELECT * FROM user_tbl WHERE user_height IS NULL; -- 결과 x                            
                            