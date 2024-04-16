/* BCNF */
DROP TABLE IF EXISTS StudentCourse;
-- 한 학생은 한 개이상의 특강을 신청할 수 있고,
-- 한 강사는 하나의 특강만 담당할 수 있다고 가정.
CREATE TABLE StudentCourse (
	StudentId Int,
    CourseName VARCHAR(255),
    InstructorName VARCHAR(255),
    PRIMARY KEY (StudentId, CourseName)
);
INSERT INTO StudentCourse VALUES
	(501, '소셜네트워크', '김교수'), (401, '소셜네트워크', '김교수'),
    (402, '인간과동물', '성교수'), (502, '창업전략', '박교수'), (501, '창업전략', '홍교수');
SELECT * FROM StudentCourse;
-- 1, 2, 3정규형 모두 만족
-- StudentCourse ( StudentId(PK), CourseName(PK), InstructorName )
-- InstructorName( 교수이름, 기본키가 아님 ) -> CourseName

-- 함수 종속성 분석
-- ( StudentId, CourseName ) -> InstructorName
-- InstructorName -> CourseName
-- 모든 결정자가 후보키(기본키가 될 수 있는 속성 집합)

-- 이상현상
-- 삭제이상 : 402번 학생이 수강을 취소하면 '인간과동물' 특강 정보와 교수 정보가 사라짐
-- 삽입이상 : 새로운 특강 정보를 개설해서 최교수가 담당하면 학생정보 null값 삽입 문제 발생
-- 수정이상 : 김교수의 특강 제목을 '빅데이터분석'으로 바꾸면 데이터 불일치 가능성 발생

-- 테이블 분해
-- Enroll ( StudentId(PK), InstructorName(PK) )
-- Instructor ( InstructorName(PK), CourseName )
DROP TABLE IF EXISTS Enroll;
DROP TABLE IF EXISTS Instructor;

-- 1. 특강 참여 릴레이션
CREATE TABLE Enroll (
	StudentId INT,
    InstructorName VARCHAR(255),
    PRIMARY KEY ( StudentId, InstructorName )
);
INSERT INTO Enroll
	SELECT StudentId, InstructorName FROM StudentCourse;

-- 2. 교수 특강 릴레이션
CREATE TABLE Instructor (
    InstructorName VARCHAR(255),
	CourseName VARCHAR(255),
    PRIMARY KEY ( InstructorName )
);
INSERT INTO Instructor
	SELECT DISTINCT InstructorName, CourseName FROM StudentCourse;	-- 중복제거