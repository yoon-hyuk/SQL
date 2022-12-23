# DML(Data manipulation language) : 데이터 조작어
# 테이블에 데이터를 추가(insert), 수정(update), 삭제(delete)

# insert
# 테이블에 새로운 행을 추가하는 구문
# insert into 테이블명(컬러명...) values(값...);
# 명시되지 않은 컬럼에는 null이 들어가게 된다.
# 만약 모든 컬럼에 값을 넣는다면, 컬럼명 작성은 생략할 수 있다.
# insert into 테이블명 values(모든 컬럼에 대한 값...);

# 인턴 직급을 추가해보자.
# job_code : 'J8', job_name : '인턴'
insert into job(job_code, job_name) values('J8','인턴');
select * from job;

# job_code : 'J9', job_name : '알바'
insert into job values('J9','알바');
select * from job;

# 서브쿼리로 데이터 추가
create table emp_dept(
	emp_id varchar(3)
    ,emp_name varchar(20)
    ,dept_title varchar(25)
);

# 직급이 'J5'인 사원의 사번, 이름, 부서명을 emp_dept 테이블에 추가
insert into EMP_DEPT(
		select emp_id, emp_name, dept_title
		from employee
        join department on(DEPT_CODE = DEPT_CODE)
        where job_code = 'J5'
);

SELECT * FROM EMP_DEPT;

# INSERT문으로 여러 행 집어넣기
# EMP_ID : 230, EMP_NAME : 강유리, DEPT_TITLE : 개발팀
# EMP_ID : 231, EMP_NAME : 경제원, DEPT_TITLE : 개발팀
INSERT INTO EMP_DEPT VALUES('230', '강유리', '개발팀'),('231','경제원','개발팀');
COMMIT;

#############################
# UPDATE
# 테이블에 저장된 데이터를 수정하는 구문
# update 테이블명 set 컬럼명=변경값[,컬럼명=변경값...] [WHERE절]
#UPDATE : 1. 먼저 변경할 데이터를 SELECT문을 사용해 확인한다.
#		  2. UPDATE문 작성이후 WHERE절 유심히 본다.
#		  3. 개발 디비에 먼저 실행해본다.

UPDATE EMP_DEPT
SET EMP_NAME = '대형사고'
WHERE EMP_In = 207;
COMMIT;

SELECT * FROM EMP_DEPT;
ROLLBACK;

#employee 테이블에서 아시아지역에 근무하는 직원의 보너스를 0.3으로 조정하시오
#rollback 처리합니다.

UPDATE employee
SET BONUS = 0.3
WHERE DEPT_CODE IN(
	select DEPT_id
	from department
	join location on ( local_code = LOCATION_ID)
	where local_name like 'ASIA%');
    
rollback;

# 강유리 사원의 부서를 대북혼 사원과 동일하게 변경해주세요.
update emp_dept a , (select dept_title from emp_dept where emp_name = '대북혼')
set dept_title = b.dept_title
where emp_id = 230;

####################################################
# delete
# 테이블 행을 삭제하는 구문
# delete from 테이블명 [where절]

delete from emp_dept;
select * FROM EMP_DEPT;
ROLLBACK;

DELETE
FROM EMP_DEPT
WHERE EMP_ID = 207;
ROLLBACK;

#TRUNCATE : 테이블 전체 행을 삭제할때 사용
# 장점 : DELETE보다 빠르게 전체행을 삭제
# 단점 : ROLLBACK이 안됨.

####################################

# TCL(transaction controll language)

# transaction : 논리적 최소 작업 단위

# commit / rollback
# commit : 테이블에서 발생한 변경사항을 확정
# rollback : 테이블을 이전 commit 상태로 되돌림

# 계좌이체
# a계좌 --- 5만원 ---> b계좌

# a계좌에 잔금을 5만원 차감한 금액으로 update
# b계좌에 잔금을 5만원 추가한 금액으로 update (사고발생!)

# 데이터베이스에는 각 쿼리의 결과를 즉시 반영하는 것이 아니라
# 하나의 논리적인 작업이 끝난 다음 반영.
# 하나의 논리적인 작업단위 중간에, 사고가 발생하면 논리적인 작업단위 내에서 발생한 모든 상태를 이전으로 되돌려야한다.