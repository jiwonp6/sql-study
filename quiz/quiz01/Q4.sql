USE takeClassDB;

-- 4-1
INSERT INTO member (member_id, name, address, phone_number)
	VALUES (1, '김지수', '서울시 강남구 역삼동', '010-1234-5678');
INSERT INTO member (member_id, name, address, phone_number)
	VALUES (2, '이태민', '서울시 서초구 반포동', '010-8765-4321');
    
-- 4-2
INSERT INTO trainer (trainer_id, trainer_name, trainer_specialization)
	VALUES (1, '박서준', '필라테스');
INSERT INTO trainer (trainer_id, trainer_name, trainer_specialization)
	VALUES (2, '최유리', '에어로빅');
    
-- 4-3
INSERT INTO class (class_id, class_name, class_start_time, class_end_time, trainer_id)
	VALUES (1, '오전 요가', '9:00', '10:00', '1');
INSERT INTO class (class_id, class_name, class_start_time, class_end_time, trainer_id)
	VALUES (2, '저녁 웨이트 트레이닝', '20:00', '21:00', '2');

-- 4-4
INSERT INTO registration (member_id, class_id)
	VALUES (1, 1);
INSERT INTO registration (member_id, class_id)
	VALUES (2, 2);