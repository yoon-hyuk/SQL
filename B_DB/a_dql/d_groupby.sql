# group by
# 특정 컬럼을 기준으로 그룹핑하여 그룹함수를 사용해 원하는 데이터를 추출할 목적으로 사용
# group 함수 : sum(), count(), avg(), max(), min()
# select절에는 그룹핑한 기준이 되는 컬럼과, 그외 함수의 결과만 올 수 있다.

# 부서별 급여의 총액과 평균급여를 보자
select dept_code, sum(salary), avg(salary)
from employee
group by dept_code;

# 직급별 급여 평균, 직급별 최고급여, 최저급여, 사원수를 조회하시오
select job_CODE, avg (salary), max(salary), min(salary), count(*)
from employee
group by JOB_CODE;

# 급여가 300만원 이상인 사원들의 부서별 급여 총액을 구하시오.
select dept_code,sum(salary)
from employee
where salary >= 3000000
group by DEPT_CODE;

# 부서의 평균급여가 3000000이상인 부서를 조회하시오.
select dept_code, avg(salary)
from employee
#where avg(salary) >= 3000000 아직 그룹핑되어있지 않기때문에 where절 사용 불가능
group by dept_code
having avg(salary) >= 3000000; #그룹핑 후에만 having사용가능

# 부서내, 직급별 급여의 최소 최대값을 구해보자.
select dept_code,job_code,max(salary),min(salary),count(*)
from employee
group by DEPT_CODE, JOB_CODE;

# 집계함수(rollup)
# 그룹별 중간 집계와 총 집계를 계산
select dept_code, job_code, sal_level, sum(salary),count(*)
from employee
where DEPT_CODE is not null
group by DEPT_CODE, job_code, SAL_LEVEL with rollup
order by 
dept_code is null asc
,job_code is null asc
,sal_level is null asc
, dept_code asc
, job_code asc
, sal_level asc;

# grouping 함수
# 해당 row의 집계값이 인자로 전달받은 컬럼집합의 산출물이면 0, 아니면 1
select dept_code, job_code, sal_level, sum(salary), count(*)
		,grouping(dept_code)
        ,grouping(job_code)
        ,grouping(sal_level)
        , sum(salary), count(*)
        
from employee
where DEPT_CODE is not null
group by DEPT_CODE, job_code, SAL_LEVEL with rollup
order by 
dept_code is null asc
,job_code is null asc
,sal_level is null asc
, dept_code asc
, job_code asc
, sal_level asc;