# 테이블 수정

# 테이블 이름 변경
# 이름 변경 : RENAME TO
ALTER TABLE employee_DEPT RENAME TO CP_EMP_DEPT;

# 테이블 컬럼 수정
# ALTER TABLE 테이블명 ADD | MODIFY | DROP 컬럼명

#컬럼 추가
ALTER TABLE OUR_EMP ADD(JOB_CODE CHAR(2));

#컬럼 삭제
#ALTER TABLE OUR_EMP DROP JOB_CODE;

#컬럼 이름변경
ALTER TABLE our_emp RENAME COLUMN JOB_CODE TO JOB;

# 컬럼 변경
# 1. 컬럼의 타입은 변경이 불가능하다. 단, 해당 컬럼에 값이 하나도 없으면 변경 가능
# 2. 컬럼의 크기는 현재보다 큰 크기로만 변경이 가능하다.
# 3. 제약조건은 현재 데이터가 충돌하지 않는 제약조건만 지정이 가능
# 		기존 컬럼에 null값이 하나라도 존재하면 not null 불가
#		기존 컬럼에 중복값이 존재한다면 unique불가
#		기존 컬럼에 check의 범위를 벗어나는 데이터가 존재하면 check 불가능

#alter table our_emp modify emp_name varchar(2); 불가능
alter table our_emp modify emp_name varchar(20);
alter table our_emp modify emp_name varchar(20) unique;
delete from our_emp where emp_id = 6;
commit;

#alter table our_emp modify age int check(age >= 20);
alter table our_emp modify age int check(age >= 10);

# 제약조건 변경
# alter table 테이블명 add | drop constraint 제약조건명alter

#기본키 삭제
alter table our_emp  drop primary key;
#기본키 추가
alter table our_emp add primary key(emp_id);

# 외래키 삭제
alter table our_emp drop constraint our_emp_ibfk_1;

# 외래키 추가
# 	외래키 제약조건에 대한 옵션
#	ON DELETE CASCADE	: 부모테이블에서 자식테이블이 참조학 있는 행이 삭제될 경우, 자식테이블의 행도 함께 삭제
# 	ON DELETE SET NULL	: 부모테이블에서 자식테이블이 참조학 있는 행이 삭제될 경우, 자식테이블의 외래키를 null 처리
# 	ON DELETE RESTRICT  : 부모테이블에서 자식테이블이 참조학 있는 행을 삭제 할 수 없음 (default)

#	ON update CASCADE	: 부모테이블에서 자식테이블이 참조학 있는 행이 수정될 경우, 자식테이블의 행도 함께 수정
# 	ON update SET NULL	: 부모테이블에서 자식테이블이 참조학 있는 행이 수정될 경우, 자식테이블의 외래키를 null 처리
# 	ON update RESTRICT  : 부모테이블에서 자식테이블이 참조학 있는 행을 수정 할 수 없음 (default)

alter table our_emp add constraint FK_OUR_DEPT
foreign key(dept_code) references our_dept(dept_code) on delete set null;

select * from our_dept;
select * from our_emp;
delete from our_dept where dept_code = 'D01';
rollback;