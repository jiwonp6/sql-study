-- Ex
DROP SCHEMA IF EXISTS HealthcareManagement2; 
CREATE SCHEMA HealthcareManagement2;
USE HealthCareManagement2;

CREATE TABLE Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    BirthDate DATE NOT NULL,
    Gender CHAR(1) CHECK (Gender IN ('M', 'F')),
    PhoneNumber VARCHAR(15)
);

CREATE TABLE Appointments (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,
    Type VARCHAR(50) NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE MedicalRecords (
    RecordID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    VisitDate DATE NOT NULL,
    Diagnosis VARCHAR(255) NOT NULL,
    Prescription VARCHAR(255),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

-- 문제 1: 'Patients' 테이블에 새로운 환자 추가하기
	-- 이름: "John Smith", 생년월일: "1985-02-20", 성별: "M", 전화번호: "123-456-7890"
DESC patients;
INSERT INTO patients (Name, BirthDate, Gender, PhoneNumber)
	VALUES ('John Smith', '1985-02-20', 'M', '123-456-7890');
SELECT * FROM patients;

-- 문제 2: 'Appointments' 테이블에 새로운 예약 추가하기
	-- 환자 ID: 1, 예약 날짜: "2023-04-20", 예약 시간: "10:00", 진료 유형: "General Checkup"
DESC appointments;
INSERT INTO appointments (PatientID, AppointmentDate, AppointmentTime, Type)
	VALUES (1, '2023-04-20', '10:00', 'General Checkup');
SELECT * FROM appointments;

-- 문제 3: 'MedicalRecords' 테이블에 새로운 의료 기록 추가하기
	-- 환자 ID: 1, 방문 날짜: "2023-04-10", 진단: "Common Cold", 처방: "Rest and hydration"
DESC medicalRecords;
INSERT INTO medicalRecords (PatientID, VisitDate, Diagnosis, Prescription)
	VALUES (1, '2023-04-10', 'Common Cold', 'Rest and hydration');
SELECT * FROM medicalRecords;

-- 문제 4: 'Patients' 테이블에서 환자의 전화번호 업데이트하기
	-- 환자 ID가 1인 환자의 전화번호를 "987-654-3210"으로 변경하기
UPDATE patients
	SET PhoneNumber = '987-654-3210'
    WHERE PatientID = 1;

-- 문제 5: 'Appointments' 테이블에서 예약 시간 변경하기
	-- 환자 ID가 1이고 예약 날짜가 "2023-04-20"인 예약의 시간을 "14:00"으로 변경하기
UPDATE appointments
	SET AppointmentTime = '14:00'
    WHERE PatientID = 1 AND AppointmentDate = '2023-04-20';

-- 문제 6: 'MedicalRecords' 테이블에서 진단 정보 업데이트하기
	-- 환자 ID가 1이고 방문 날짜가 "2023-04-10"인 기록의 진단을 "Seasonal Allergies"로 변경하기
UPDATE medicalRecords
	SET Diagnosis = 'Seasonal Allergie'
    WHERE PatientID = 1 AND VisitDate = '2023-04-10';

-- 문제 7: 'Appointments' 테이블에서 특정 날짜의 모든 예약 삭제하기
	-- 예약 날짜가 "2023-04-20"인 모든 예약 삭제하기
DELETE FROM appointments
	WHERE AppointmentDate = '2023-04-20';


-- 문제 8: 'MedicalRecords' 테이블에서 특정 진단을 가진 모든 기록 삭제하기
	-- 진단이 "Seasonal Allergies"인 모든 의료 기록 삭제하기
DELETE FROM medicalRecords
	WHERE Diagnosis = 'Seasonal Allergie';

-- 문제 9: 'Patients' 테이블에서 특정 환자 삭제하기
	-- 환자 ID가 1인 환자 삭제하기
DELETE FROM patients
	WHERE patientID = 1;

-- 문제 10: 'Patients' 테이블에 여러 환자 동시에 추가하기
	-- 환자 정보: ("Alice Johnson", "1992-08-24", "F", "555-1234"), ("Bob Williams", "1980-03-15", "M", "555-5678")
DESC patients;
INSERT INTO patients (Name, BirthDate, Gender, PhoneNumber)
	VALUES ('Alice Johnson', '1992-08-24', 'F', '555-1234'),
			('Bob William', '1980-03-15', 'M', '555-5678');
SELECT * FROM patients;
    