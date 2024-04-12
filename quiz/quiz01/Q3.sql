USE takeClassDB;

CREATE TABLE member (
	member_id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    address VARCHAR(45),
    phone_number VARCHAR(45)
);

CREATE TABLE trainer (
	trainer_id INT NOT NULL PRIMARY KEY,
    trainer_name VARCHAR(45),
    trainer_specialization VARCHAR(45)
);

CREATE TABLE class (
	class_id INT NOT NULL PRIMARY KEY,
    class_name VARCHAR(45),
    class_start_time TIME,
    class_end_time TIME,
    trainer_id INT,
    foreign key(trainer_id) references trainer(trainer_id)
);
drop table class;
CREATE TABLE registration (
	member_id INT,
    class_id INT,
    foreign key(member_id) references member(member_id),
    foreign key(class_id) references class(class_id),
    primary key (member_id, class_id)
);


	