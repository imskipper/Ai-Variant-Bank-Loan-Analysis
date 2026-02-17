create database bank_analysis;
use bank_analysis;



alter table cleaned_data
add column mths_since_last_delinq_num int;

update cleaned_data 
set mths_since_last_delinq_num = nullif(mths_since_last_delinq, 'NA');

SET sql_safe_updates = 1;

#TOTAL LOANS
select count(*) as TOTAL_LOANS 
from cleaned_data;

#TOTAL LOAN AMOUNT
select sum(loan_amnt) as TOTAL_LOAN_AMOUNT
from cleaned_data;

#TOTAL AMOUNT RECOVERED
select sum(funded_amnt) as TOTAL_AMOUNT_RECOVERED
from cleaned_data;

#AVERAGE INTEREST RATE
select round(avg(int_rate)* 10000,2) as AVG_INTEREST_RATE
from cleaned_data;

#LOAN STATUS DISTRIBUTION
select loan_status_group, count(*) as TOTAL_LOANS_DISTRIBUTED
from cleaned_data
group by loan_status_group;

#LOANS STATUS BY AMOUNT
select loan_status, SUM(loan_amnt) as TOTAL_AMOUNT
from cleaned_data
group by loan_status;

#LOANS ISSUED BY YEAR
select loan_year, count(*) as TOTAL_LOANS_BY_YEARS
from cleaned_data
group by loan_year
order by loan_year;

#LOAN AMOUNT TREND BY YEAR
select loan_year, sum(loan_amnt) as TOTAL_AMOUNT_BY_YEAR
from cleaned_data
group by loan_year
order by loan_year;

#LOANS BY GRADE
select grade, count(*) as LOANS_BY_GRADE
from cleaned_data
group by grade
order by grade;

#LOAN AMOUNT BY GRADE
select grade, sum(loan_amnt) as LOAN_AMOUNT_BY_GRADE
from cleaned_data
group by grade
order by grade;

#PURPOSE-WISE ANALYSIS
select purpose, count(*) as PURPOSE_WISE_LOANS
from cleaned_data
group by purpose
order by PURPOSE_WISE_LOANS desc;

select purpose, sum(loan_amnt) as PURPOSE_WISE_LOAN_AMT
from cleaned_data
group by purpose
order by PURPOSE_WISE_LOAN_AMT desc;

#STATE WISE LOAN DISTRIBUTION
select addr_state, count(*) as STATE_WISE_LOANS
from cleaned_data
group by addr_state
order by STATE_WISE_LOANS desc;

#AVERAGE INCOME BY LOAN STATUS
select loan_status, round(avg(annual_inc), 0) as AVG_INCOME
from cleaned_data
group by loan_status;

#AVERAGE DTI BY LOAN STATUS
select loan_status, round(avg(dti), 2) AS AVG_DTI
from cleaned_data
group by loan_status;

#CHARGED OFF LOAN PERCENTAGE
select round(sum(case when loan_status = 'Charged Off' then 1 else 0 end) * 100 / count(*),2)
as CHARGED_OFF_PERCENTAGE
from cleaned_data;

#TOP 10 HIGHEST LOANS 
select id, loan_amnt, annual_inc, grade, loan_status
from cleaned_data
order by loan_amnt desc 
limit 10;
