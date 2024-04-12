USE takeClassDB;

-- 5-1
SELECT NAME, CLASS_NAME
	FROM member
    JOIN registration USING (member_id)
    JOIN class USING (class_id);

-- 5-2
SELECT trainer_name, count(class_id)
	FROM class
    JOIN trainer USING (trainer_id)
    GROUP BY trainer_id
    ORDER BY count(class_id) DESC;

-- 5-3
SELECT class_name, class_start_time, class_end_time
	FROM class
    WHERE class_start_time < '12:00'
    ORDER BY class_start_time;

-- 5-4
SELECT m.name, c.class_name, c.class_start_time
	FROM class c
    JOIN (select max(class_start_time) max FROM class) latest ON c.class_start_time = latest.max
    JOIN registration r ON c.class_id = r.class_id
    JOIN member m ON r.member_id = m.member_id;