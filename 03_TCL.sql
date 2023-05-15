-- 트랜잭션은 2개 이상의 각종 쿼리문의 실행을 되돌리거나 영구히 반영할 때 사용합니다.
-- 연습 테이블 생성
CREATE TABLE bank_account(
	act_num INT(5) PRIMARY KEY AUTO_INCREMENT, /* 계좌번호 */
    act_owner VARCHAR(10) NOT NULL, 	/* 계좌주 */
    balance INT(10) NOT NULL DEFAULT 0	/* 잔고 */
);

INSERT INTO bank_account VALUES  (NULL, '나구매', 50000)
								,(NULL, '가판매', 0);

-- 트랜잭션 시작(시작점, ROLLBACK; 수행시 이 지점 이후의 내용을 전부 취소)
START TRANSACTION;

-- 나구매의 돈 30000원 차감
UPDATE bank_account SET balance = (balance-30000) WHERE act_owner = '나구매';
-- 가판매의 돈 30000원 증가
UPDATE bank_account SET balance = (balance+30000) WHERE act_owner = '가판매';

rollback;

-- 예제2
START TRANSACTION;

-- 나구매의 돈 25000원 차감
UPDATE bank_account SET balance = (balance-25000) WHERE act_owner = '나구매';
-- 가판매의 돈 25000원 증가
UPDATE bank_account SET balance = (balance+25000) WHERE act_owner = '가판매';

COMMIT;
rollback; -- 커밋한 이후에는 롤백을 실행해도 돌아갈 지점이 사라짐

-- 예제 3
START TRANSACTION;

-- 나구매의 돈 3000원 차감
UPDATE bank_account SET balance = (balance-3000) WHERE act_owner = '나구매';
-- 가판매의 돈 3000원 증가
UPDATE bank_account SET balance = (balance+3000) WHERE act_owner = '가판매';

SAVEPOINT first_tx; -- first_tx라는 저장지점 생성

-- 나구매의 돈 5000원 차감
UPDATE bank_account SET balance = (balance-5000) WHERE act_owner = '나구매';
-- 가판매의 돈 5000원 증가
UPDATE bank_account SET balance = (balance+5000) WHERE act_owner = '가판매';

ROLLBACK TO first_tx;
                                
SELECT * FROM bank_account;                  