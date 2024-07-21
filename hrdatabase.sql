-- TO SELECT DATABASE (hr_analytics)
use hr_analytics;

-- to chech for NULL VALUES
SELECT *
FROM hremployeeattrition
WHERE COALESCE( ï»¿Age, Attrition, BusinessTravel, DailyRate, Department, DistanceFromHome, Education, EducationField, EmployeeCount, EmployeeNumber, EnvironmentSatisfaction, Gender, HourlyRate, JobInvolvement, JobLevel, JobRole, JobSatisfaction, MaritalStatus, MonthlyIncome, MonthlyRate, NumCompaniesWorked, Over18, OverTime, PercentSalaryHike, PerformanceRating, RelationshipSatisfaction, StandardHours, StockOptionLevel, TotalWorkingYears, TrainingTimesLastYear, WorkLifeBalance, YearsAtCompany, YearsInCurrentRole, YearsSinceLastPromotion, YearsWithCurrManager)is null;

-- OR

SELECT *
FROM hremployeeattrition
WHERE ï»¿Age IS NULL OR Attrition IS NULL OR BusinessTravel IS NULL OR
DailyRate IS NULL OR Department IS NULL OR DistanceFromHome IS NULL OR 
Education IS NULL OR EducationField IS NULL OR EmployeeCount IS NULL OR 
EmployeeNumber IS NULL OR EnvironmentSatisfaction IS NULL OR Gender IS NULL OR
HourlyRate IS NULL OR JobInvolvement IS NULL OR JobLevel IS NULL OR JobRole IS NULL OR 
JobSatisfaction IS NULL OR MaritalStatus IS NULL OR MonthlyIncome IS NULL OR MonthlyRate IS NULL OR 
NumCompaniesWorked IS NULL OR Over18 IS NULL OR OverTime IS NULL OR PercentSalaryHike IS NULL OR 
PerformanceRating IS NULL OR RelationshipSatisfaction IS NULL OR StandardHours IS NULL OR StockOptionLevel IS NULL OR 
TotalWorkingYears IS NULL OR TrainingTimesLastYear IS NULL OR WorkLifeBalance IS NULL OR YearsAtCompany IS NULL OR 
YearsInCurrentRole IS NULL OR YearsSinceLastPromotion IS NULL OR YearsWithCurrManager IS NULL;
-- no null values

-- check for duplicates using employeenumber being the unique value
select employeenumber, count(*) Total
from hremployeeattrition
group by employeenumber
order by Total desc;

-- NO DUPLICATES





-- To calculate the total number of employees
select count(*)
from hremployeeattrition;
-- Total of 1470 employees

-- To count the total number of male employee attrition
Select gender, count(*)
from hremployeeattrition
where attrition = 'Yes'
group by gender;


Select attrition, gender, count(*)
from hremployeeattrition
group by attrition, gender
having attrition = 'Yes' and gender = 'feMale';

-- Job role count
select jobrole, count(*)
from hremployeeattrition
-- gender = 'male' or 'female'
group by jobrole;

-- Attrition by job role
create table attritionbyjobrole(JobRole varchar(122), Sum_of_Attrition_Count INT);
insert into attritionbyjobrole
Select jobrole, count(*)
from hremployeeattrition
where attrition = 'Yes'
group by jobrole
order by count(*) desc;

-- Job role Count
select count(distinctrow jobrole) 'Job Role Count'
from hremployeeattrition;

select * from attritionbyjobrole;
-- order by Total_Attrition desc;

drop table attritionbyjobrole;

-- Total Attrition by Department
create table attritionbydepartment(Department varchar(122), Total_Attrition INT);
insert into attritionbydepartment
Select department, count(*)
from hremployeeattrition
where attrition = 'Yes'
group by department;

select * from attritionbydepartment;





select(count(ATTRITION ='Yes')/cast(COUNT(attrition) as float))*100
FROM hremployeeattrition;



create temporary table employeestotal
select count(*) as stafftotal
from hremployeeattrition;

select* from employeestotal;


drop table employeestotal;

select * 
from hremployeeattrition;

-- Total Attrition by Years in Current Role
create table Attrition_by_year_in_current_role(
Department VARCHAR(100),
DeptCount INT,
YearInCurrentRole INT);
insert into Attrition_by_year_in_current_role(department, DeptCount, yearincurrentrole)
select Department, count(*) deptcount, YearsInCurrentRole Yearno
FROM hremployeeattrition
where attrition ='Yes'
GROUP BY Department, Yearno
Order By yearno asc;

select * 
from Attrition_by_year_in_current_role;

-- Total Attrition by Business Travel
create table Attrition_by_business_travel(
BusinessTravel VARCHAR(100),
TravelCount INT,
Gender VARCHAR(6));
insert into Attrition_by_business_travel(BusinessTravel, TravelCount, Gender)
select BusinessTravel, count(*) TotalTravel, gender
FROM hremployeeattrition
where attrition ='Yes'
GROUP BY BusinessTravel, gender
Order By TotalTravel desc;

select * 
from Attrition_by_business_travel;

-- DEMOGRAPHICS STARTS
-- Attrition by Education Field
create table Attritioneducationfield(
EducationField VARCHAR(100),
TotalAttrition INT);
insert into Attritioneducationfield(educationfield, totalattrition)
select EDUCATIONFIELD, count(attrition)
FROM hremployeeattrition
where attrition ='Yes'
GROUP BY EDUCATIONFIELD
order by count(attrition) desc;

select * from Attritioneducationfield;

-- Total Attrition by Worklife Balance
create table Attrition_by_Worklife_Balance(
WorklifeBalance VARCHAR(10),
Total INT);
insert into Attrition_by_Worklife_Balance(WorklifeBalance, Total)
SELECT 
(CASE
    WHEN worklifebalance = 4 THEN 'Excellent'
    WHEN worklifebalance = 3 THEN 'Good'
    WHEN worklifebalance = 2 THEN 'Average'
    ELSE 'Bad'
END) As WorklifeBalance, Count(*) Total
FROM hremployeeattrition
Where Attrition = 'Yes'
Group By WorklifeBalance
Order By Total Desc;

drop table Attrition_by_Worklife_Balance;

select * 
from  Attrition_by_Worklife_Balance;

select distinct Age
from hremployeeattrition
order by age desc;

describe hremployeeattrition;

alter table hremployeeattrition change column ï»¿Age Age Int;

-- Total Attrition by Age
create table Total_Attrition_by_Age(
AgeGroup VARCHAR(10),
AgeCount INT);
insert into Total_Attrition_by_Age(AgeGroup, AgeCount)
SELECT 
(CASE
    WHEN Age >45 THEN '46-60'
    WHEN Age >=31 THEN '31-45'
    ELSE '18-30'
END) As AgeGroup, Count(*) AgeCount
FROM hremployeeattrition
Where Attrition = 'Yes'
Group By AgeGroup
Order by AgeCount Desc;

select * 
from  Total_Attrition_by_Age;

SELECT min(`DistanceFromHome`) FROM `hr_analytics`.`hremployeeattrition`;

-- Total Attrition by Distance From Home
create table Total_Attrition_by_DistanceFromHome(
DistanceRage VARCHAR(10),
Total INT);
insert into Total_Attrition_by_DistanceFromHome(DistanceRage, Total)
SELECT 
(CASE
    WHEN DistanceFromHome >20 THEN 'Very Far'
    WHEN DistanceFromHome >=11 THEN 'Far'
    ELSE 'Near by'
END) As DistanceRage, Count(*) Total
FROM hremployeeattrition
Where Attrition = 'Yes'
Group By DistanceRage
Order by Total Desc;

select * 
from  Total_Attrition_by_DistanceFromHome;


-- Total Attrition by Marital Status
create table Attrition_by_Marital_Status(
MaritalStatus VARCHAR(15),
Total INT,
Gender VARCHAR(6));
insert into Attrition_by_Marital_Status(MaritalStatus, Total, Gender)
select MaritalStatus, count(*) Total, gender
FROM hremployeeattrition
where attrition ='Yes'
GROUP BY MaritalStatus, gender
Order By MaritalStatus desc;

-- View the table
select * 
from Attrition_by_Marital_Status;

-- TOTAL ATTRITION COUNT
create table Total_Attrition_Vs_Active_Employee(
AttritionCount INT,
AttritionPercentage VARCHAR(4),
AE INT,
AEPercentage VARCHAR(4),
TotalEmployee INT);
insert into Total_Attrition_Vs_Active_Employee(AttritionCount, AttritionPercentage,AE,AEPercentage,TotalEmployee)
Select
sum(CASE
    WHEN attrition = 'Yes' THEN 1
    ELSE 0
END) As AttritionCount, Concat(Round((sum(CASE
    WHEN attrition = 'Yes' THEN 1
    ELSE 0
END)/count(EmployeeNumber))*100),'%') AttritioninPercentage,count(EmployeeNumber) - sum(CASE
    WHEN attrition = 'Yes' THEN 1
    ELSE 0
END) ActiveEmployee, Concat(Round((count(EmployeeNumber) - sum(CASE
    WHEN attrition = 'Yes' THEN 1
    ELSE 0
END))/ (count(EmployeeNumber))*100),'%') AEpercent, count(EmployeeNumber) TotalEmployee
FROM hremployeeattrition; 
describe Total_Attrition_Vs_Active_Employee;
Select* from Total_Attrition_Vs_Active_Employee;

-- TOTAL ATTRITION COUNT BY GENDER
create table Total_Attrition_COUNT_BY_GENDER(
Gender VARCHAR(6),
TotalAttrition INT);
insert into Total_Attrition_COUNT_BY_GENDER(Gender,TotalAttrition)
select gender, count(*) 'Total Attrition'
from hremployeeattrition
where attrition = 'Yes'
group by gender;
Select *
FROM Total_Attrition_COUNT_BY_GENDER;
-- DEMOGRAPHICS END
 
