#CHAR

insert into tb_type(t_char) values('Hello Char');
select * from tb_type;

#VARCHAR 타입의 데이터를 입력
#VARCHAR 가변길이데이터, 65535 byte
insert into tb_type(t_varchar) value('Hello varchar');
select * from tb_type;

#text
insert into tb_type(t_longtext) value('Hello longtext');
select * from tb_type;