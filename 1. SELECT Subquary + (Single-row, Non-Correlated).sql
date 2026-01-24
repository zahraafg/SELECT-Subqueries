CREATE DATABASE IT_CompanyDB;

USE IT_CompanyDB;

-- SELECT Subquery + (Single-row, Non-Correlated)


/* Sual 1: 

Hər işçi üçün: full_name

Bütün işçilərin ən yüksək maaşını SELECT subquery ilə göstər. */

select full_name, 
	(select MAX(salary)
	from Employees) as max_salary
from Employees e;


/* Sual 2:

Hər layihə üçün: project_name

Bütün layihələrin orta büdcəsini SELECT subquery ilə göstər. */

select project_name, 
	(select AVG(budget)
	from Projects p)as avg_budget
from Projects p;


/* Sual 3:

Hər sifariş üçün: id, total_amount

Bütün sifarişlərin maksimum məbləğini SELECT subquery ilə göstər. */

select id, total_amount,
	(select MAX(total_amount)
	from Orders) as total_amount
from Orders o;


/* Sual 4:

Hər müştəri üçün: company_name

Bütün müştərilərin ortalama sifariş məbləğini SELECT subquery ilə göstər. */

select company_name, 
	(select AVG(total_amount)
	from Orders) as avg_total_amount
from Customers c;


/* Sual 5:

Hər işçi üçün: full_name

Bütün işçilərin ortalama iş saatını (Attendance) SELECT subquery ilə göstər. */

select full_name, 
	(select AVG(hours_worked)
	from Attendance a) as avg_hours_worked
from Employees e;


/* Sual 6:

Employees cədvəlində ümumilikdə bütün şirkətin 

ən yüksək maaşından yuxarı olmayan işçilərin adını və maaşını göstərən sorğunu yaz. */

select full_name, salary, max_salary
from (
    select full_name, salary,
           (select MAX(salary) from Employees) as max_salary
    from Employees
) t
where salary <= max_salary;


/* Sual 7:

Employees cədvəlində ümumilikdə şirkətin orta maaşından 

yüksək maaş alan işçilərin adını və maaşını göstərən sorğunu yaz. */

select full_name, salary, avg_salary
from (
    select full_name, salary,
           (select AVG(salary) from Employees) as avg_salary
    from Employees
) t
where salary > avg_salary;


/* Sual 8:

Employees cədvəlində ümumilikdə şirkətin ən aşağı maaşından az maaş alan işçilər varmı? 

Əgər varsa, həmin işçilərin adını və maaşını göstərən sorğunu yaz. */

select full_name, salary,
	(select MIN(salary) from Employees) as min_salary
from Employees;


/* Sual 9:

Employees cədvəlində ümumilikdə şirkətin 

orta maaşını hər işçinin yanında göstərən sorğunu yaz. */

select full_name, salary,
	(select AVG(salary)
	from Employees) as avg_salary
from Employees e;


/* Sual 10:

Employees cədvəlində hər işçinin maaşının

ümumilikdə şirkətin orta maaşından yüksək olub olmadığını göstərən sorğunu yaz. */

select full_name, salary,
	(select AVG(salary)
	from Employees e2) as avg_dept_salary
from Employees e; 


