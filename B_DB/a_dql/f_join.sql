# join
# 관계형 데이터베이스에서는 데이터의 중복을 최소화하고, 이상현상을 방지하기 위해
# 연관된 데이터들을 분리하여 저장하도록 설계한다.
# 필요할 때 테이블간 join을 통해 원하는 형태의 데이터를 조회한다.

# 모든 직원의 직원번호, 이름, 부서코드, 부서명을 조회
select 
emp_id,emp_name,dept_code
,(select dept_title from department where DEPT_ID = e.DEPT_CODE) as 부서명
from employee e ;

select
emp_id, emp_name, dept_code, DEPT_TITLE
from employee e 
join department d on(e.dept_code = d.dept_id);

# join
# cross join, inner join, outer join(left join, right join, full other join)
# 1.cross join
# cross join : 조인 조건절의 결과가 무조건 참인 join
# 30만개의 상품데이터와 300만개의 주문데이터를 cross join하면... 9천억개...
select*
from employee cross join department
order by emp_id;

# 2. inner join(equals join, 등가 조인)
# 사번, 이름, 직급코드, 직급명을 출력하시오.
select emp_id, emp_name,JOB_CODE, job_name
from employee e
#join job j on (e.job_code = j.job_code);
join job j using(job_code); #join하는 테이블 이름이 같을때 using사용하면 편리!

# 여러 테이블 join하기
# 모든 사월들의 사번, 이름, 부서명, 근무지이름을 출력하시오
select emp_id, emp_name, dept_title, local_name
from employee
join department on(DEPT_CODE = dept_id)
join location on(LOCATION_ID = local_code);

# ASIA 지역에서 근무하는 급여 500만원 미만의 직원들을 조회
SELECT EMP_NAME, SALARY, LOCAL_NAME
FROM EMPLOYEE
join department on(DEPT_CODE = dept_id)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
WHERE SALARY < 5000000 AND LOCAL_NAME like 'ASIA%';

# outer join
# 특정 테이블을 기준으로 join을 수행
# 특정 테이블을 기준으로 join 조건절이 false를 반환하더라도 특정 테이블의 컬럼은 result set에 포함시킨다.
# left join, right join, full outer join

# 부서별 사원수를 조회해보자.
select dept_id, dept_title,count(emp_id)
from department left join employee on (DEPT_CODE = DEPT_ID)
group by dept_id, DEPT_TITLE
order by dept_id;

select dept_id, dept_title,count(emp_id)
from employee right join department on (DEPT_CODE = DEPT_ID)
group by dept_id, DEPT_TITLE
order by dept_id;

# union : 합집합
# 두 result set의 합집합을 반환
select dept_id, dept_title,count(emp_id)
from department left join employee on (DEPT_CODE = DEPT_ID)
group by dept_id, DEPT_TITLE
union
select dept_id, dept_title,count(emp_id)
from department right join employee  on (DEPT_CODE = DEPT_ID)
group by dept_id, DEPT_TITLE;

# self join
# 자기 자신과 join
# employee 테이블에서 이름, 부서코드, 관리자 사번, 관리자 이름을 출력하세요

SELECT EMP_NAME, DEPT_CODE, MANAGER_ID
, (SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_ID = E.MANAGER_ID)
FROM EMPLOYEE E;

SELECT E.EMP_NAME, E.DEPT_CODE, E.MANAGER_ID, E2.EMP_NAME AS MANAGER_NAME
FROM employee E 
LEFT JOIN employee E2 ON(E2.EMP_ID = E.MANAGER_ID)
ORDER BY MANAGER_NAME;
