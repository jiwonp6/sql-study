-- Ex. 
USE librarymanagement;
-- 문제 1:`Books` 테이블에 `ISBN` 열 추가하기
	-- `Books` 테이블에 국제 표준 도서 번호(`ISBN`)를 저장할 수 있는 열을 추가하세요. `ISBN`은 문자열이며, 고유해야 합니다.
ALTER TABLE books
	ADD COLUMN isbn VARCHAR(255) UNIQUE;

-- 문제 2: `Members` 테이블의 `Email` 열 고유 제약조건 삭제하기
	-- `Members` 테이블에서 `Email` 열의 고유 제약조건을 삭제하세요.
-- 1) members의 email 열의 고유 제약조건 확인 -> UNIQUE
SELECT * 
	FROM information_schema.table_constraints
	WHERE table_name = 'members';
-- 2) 제약조건 삭제
ALTER TABLE members
	DROP CONSTRAINT email;
-- 확인
DESC members;

-- 문제 3: `BorrowRecords` 테이블에 `Status` 열 추가하기
	-- `BorrowRecords` 테이블에 대출 상태를 나타내는 `Status` 열을 추가하세요. 가능한 값은 'Borrowed', 'Returned'입니다.
ALTER TABLE borrowrecords
	ADD COLUMN status ENUM('Borrowed', 'Returned');
SELECT * FROM borrowrecords;

-- 문제 4: `Books` 테이블의 `PublishedYear` 열의 CHECK 제약조건 변경하기
	-- `Books` 테이블에 `PublishedYear`이 1900 이상이 되도록 기존의 CHECK 제약조건을 변경하세요. 
    -- (MySQL에서는 기존의 CHECK 제약조건을 직접 수정할 수 없으므로, 제약조건을 삭제한 후 새로 추가해야 합니다.)
-- 1) books의  publishedYear 열의 고유 제약조건 이름 확인 -> books_chk_1
SELECT * 
	FROM information_schema.table_constraints
	WHERE table_name = 'books';
SHOW CREATE TABLE books;
SELECT * FROM books;
-- 2) CHECK 제약 조건 삭제
ALTER TABLE books
	DROP CONSTRAINT books_chk_1;
-- 3) 제약조건 추가
ALTER TABLE books
	ADD CONSTRAINT publishedYear
    CHECK (publishedYear >= 1900);

-- 문제 5: `Members` 테이블에서 `MembershipDate` 열의 기본값 변경하기
	-- `Members` 테이블의 `MembershipDate` 열에 대한 기본값을 현재 날짜에서 '2020-01-01'로 변경하세요.
ALTER TABLE members
	ALTER COLUMN membershipDate SET DEFAULT '2020-01-01';
	
-- 문제 6: `BorrowRecords` 테이블의 외래 키 제약조건의 레퍼런스 옵션 변경하기
	-- `BorrowRecords` 테이블의 `MemberID` 외래 키 제약조건에 대한 레퍼런스 옵션을 `ON DELETE NO ACTION`로 변경하세요. 
    -- 이를 위해서는 먼저 제약조건을 삭제하고, 새로운 옵션으로 다시 추가해야 합니다.
-- 1) borrowRecords의  memberID 열의 고유 제약조건 이름 확인 -> borrowrecords_ibfk_1
SHOW CREATE TABLE borrowRecords;
-- 2) FOREIGN KEY 제약 조건 삭제
ALTER TABLE borrowRecords
	DROP FOREIGN KEY borrowrecords_ibfk_1;
-- 3) 제약조건 추가
ALTER TABLE borrowRecords
	ADD CONSTRAINT fk_memberID
    FOREIGN KEY(memberID) REFERENCES members(memberID)  
    ON DELETE NO ACTION;
    