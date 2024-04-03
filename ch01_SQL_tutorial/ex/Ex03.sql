-- Ex.`HealthcareManagement` 데이터베이스는 병원 관리 시스템을 위한 데이터베이스입니다. 
	-- 이 시스템은 환자(Patients), 의사(Doctors), 예약(Appointments) 등 주요 정보를 관리합니다.
CREATE DATABASE healthcaremanagement;
USE healthcaremanagement;

/*
	1. Patients 테이블: 환자 정보를 저장합니다.
		- `PatientID` (정수형, 기본 키, 자동 증가): 환자의 고유 번호입니다.
		- `Name` (문자열, 필수): 환자의 전체 이름입니다.
		- `DOB` (날짜): 환자의 생년월일입니다.
		- `Gender` (ENUM('Male', 'Female')): 환자의 성별입니다.
		- `Phone` (문자열, 고유): 환자의 전화번호입니다.
*/
-- 문제 1: `Patients` 테이블을 생성하세요.
	-- 이때, 모든 환자의 생년월일(`DOB`)은 1900년 이후여야 한다는 제약조건을 추가합니다.
DROP TABLE patients;
CREATE TABLE patients (
	patientID INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    dob DATE CHECK (dob >= '1900-01-01'),
	gender ENUM('male', 'female'),
    phone VARCHAR(255) UNIQUE
);
SELECT * FROM patients;

/*
	2. Doctors 테이블: 의사 정보를 저장합니다.
		- `DoctorID` (정수형, 기본 키, 자동 증가): 의사의 고유 번호입니다.
		- `Name` (문자열, 필수): 의사의 전체 이름입니다.
        - `Email` (고유): 의사의 이메일입니다.
		- `Specialization` (문자열): 의사의 전문 분야입니다.
		- `HireDate` (날짜, 기본값 현재 날짜): 의사가 고용된 날짜입니다.
*/
-- 문제 2: `Doctors` 테이블을 생성하세요.
	-- `Specialization` 열은 비어 있지 않아야 하며(`NOT NULL`), 의사의 이메일(`Email`)은 고유해야 합니다(`UNIQUE`).
DROP TABLE doctors;
CREATE TABLE doctors (
	doctorID INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
	specialization VARCHAR(255) NOT NULL,
    hireDate DATE DEFAULT (CURRENT_DATE)
);
SELECT * FROM doctors;

/*
	3. Appointments 테이블: 예약 정보를 저장합니다.
		- `AppointmentID` (정수형, 기본 키, 자동 증가): 예약의 고유 번호입니다.
		- `PatientID` (정수형, 외래 키): 예약을 한 환자의 ID입니다.
		- `DoctorID` (정수형, 외래 키): 예약된 의사의 ID입니다.
		- `AppointmentDate` (날짜와 시간): 예약 날짜 및 시간입니다.
		- `Status` (ENUM('Scheduled', 'Completed', 'Cancelled')): 예약의 상태입니다.
*/
-- 문제 3: `Appointments` 테이블을 생성하세요. 이 테이블은 `Patients`와 `Doctors` 테이블에 대한 외래 키 제약 조건을 포함해야 합니다.
	-- `PatientID`와 `DoctorID`에 외래 키 제약 조건을 추가하고, 
    -- `AppointmentDate`는 현재 날짜 이후로 설정할 수 없지만, 예약 날짜는 2020년 이후여야 한다는 `CHECK` 제약조건을 추가합니다.
DROP TABLE appointments;
CREATE TABLE appointments (
	appointmentID INT PRIMARY KEY AUTO_INCREMENT,
	patientID INT,
	doctorID INT,
    appointmentDate DATETIME CHECK (appointmentDate >= '2020-01-01 00:00:00'),
    status ENUM('scheduled', 'completed', 'cancelled'),
    FOREIGN KEY (patientID) REFERENCES patients(patientID),
    FOREIGN KEY (doctorID) REFERENCES doctors(doctorID)
);
SELECT * FROM appointments;
