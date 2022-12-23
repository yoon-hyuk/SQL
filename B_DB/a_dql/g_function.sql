# function
# 1. 문자 관련 함수
# length, char_length, substr, instr, concat, replace, trim, lpad, rpad

select length('멀티캠퍼스'), length('multicampus'), 
char_length('멀티캠퍼스'), length('multicampus')
from dual;

# substr
select substr('multicampus',2);
select substr('multicampus',2,4);
select substr('multicampus',-5,4);
select substr('multicampus'from 2 for 4);

# employee 테이블에서 성별이 남자인 직원들만 조회하시오
select emp_name,EMP_NO
from employee
where substr(emp_no,8,1) = 1;

# employee 테이블에서 60년대생인 사원들을 출력하시오.
select emp_name,EMP_NO
from employee
where substr(emp_no,1,1) = 6;

# instr
select instr('MULTICAMPUS MYSQL', 'A');

# EMPLOYEE 테이블에서 사원들의 이름, 이메일, 이메일 아이디를 조회하시오.
SELECT EMP_NAME,EMAIL,SUBSTR(EMAIL FROM 1 FOR INSTR(EMAIL,'@')-1) AS EMAIL_ID
FROM EMPLOYEE;

#CONCAT
SELECT CONCAT('MULTICAMPUS', 'MYSQL', 'EASY');
SELECT 'MULTICAMPUS ' 'MYSQL ' 'EASY ';

#REPLACE
SELECT REPLACE('MULTICAMPUS MYSQL', 'MYSQL','YOON-HYUK');

#TRIM
SELECT trim('    multicampus        ');
SELECT trim('z' from'zzzzzzmulticampus  zzzzz');
SELECT trim(leading 'z' from 'zzzzzmulticampuszzzzz');
SELECT trim(trailing 'z' from 'zzzzzmulticampuszzzzz');
SELECT trim(both 'z' from 'zzzzzmulticampuszzzzz');

#LPAD, RPAD
SELECT LPAD('MULTICAMPUS', 20, '#');
SELECT RPAD('MULTICAMPUS', 20, '#');
SELECT RPAD(EMAIL, 30, '#')
FROM employee;

# EMPLOYEE 테이블에서 사원명과 주민번호를 조회하시오
# 단 주민번호는 생년월일까지만 표시하고 '-' 다음 자리수는 모두 '*'로 바꿔 출력하시오
# EX) 001111-1111111 => 001111-*******
# 3가지 방법으로 풀어보시오

# num1
select emp_name,rpad(substr(emp_no ,1,7),14,'*')as emp_private
from employee;

# num2
select emp_name, replace(emp_no,substr(emp_no ,8),'*******')
from employee;

# num3
select emp_name, concat(substr(emp_no,1,7),'*******')
from employee;

#2. 숫자 관련 함수
# abs, mod, floor, round, ceil, trunc

# abs
select abs(-100);

# mod
select mod(10, 3);

#floor
select floor(10.3);

#round 반올림
select round(10.15); 
select round(10.55,1);
select round(10.55,-1);

#ceil
select ceil(10.3);

#truncate
select truncate(10.55,1);
select truncate(10.55,-1);

# 3. 날짜 관련 함수
# now, datediff, date_add, date_sub, timestampdiff, date, month, year

# now
select now();

# date_add
select date_add(now(),interval 13 day);
select date_add(now(),interval '1 1:1:1' DAY_SECOND);

# date_sub
select date_sub(now(),interval 13 day);
select date_sub(now(),interval '1 1:1:1' DAY_SECOND);

# employee 테이블에서 사원들의 입사일로부터 30개월 이후의 날짜를 조회하시오.
# 사원들의 이름, 입사일, 30개월 이후 날짜를 조회합시다.

select emp_name,hire_date,date_add(hire_date,interval 30 month) as bonus_date
from employee;

#datediff
# employee테이블에 사람들의 근무일자를 구해보자.
# 퇴사한 사람은 빼자.
select emp_name, datediff(now(),hire_date)
from employee
where ent_yn = 'N';

#year, month, day, hour, minute, second
select
year(now());


# 형변환 함수
# cast
select cast('2022-12-21' as date);
#select cast(now() as year);
select cast(cast('2022-12-21' as datetime) as time);

# null처리함수
# ifnull

# 실습
#1. employee 테이블에서 d5부서이면서 급여가 3백만원 이상인 직원의 이름, 연봉, 보너스를 추가한 연봉을 조회하시오.
#연봉의 별칭은 [연봉]보너스를 포함한 연봉은 [총 연봉]alter

select emp_name, salary *12 as 연봉, salary*(1 + ifnull(bonus,0))*12
from employee
where dept_code = 'D5' and salary >= 3000000;

#case-when-then
#표현식
# case when 조건식 then 결과값
#		when 조건식 then 결과값
#		when 조건식 then 결과값
#       when 조건식 then 결과값
# else
# end


select emp_name, sal_level
, case when salary >= 6000000 and salary <= 10000000 then 'S1'
		WHEN salary >= 5000000 then 'S2'
		WHEN salary >= 4000000 then 'S3'
		WHEN salary >= 3000000 then 'S4'
		WHEN salary >= 2000000 then 'S5'
		WHEN salary >= 1000000 then 'S6'
		else 'S7'
end as sal_level2
from employee;