CREATE DATABASE IT_CompanyDB;

USE IT_CompanyDB;

-- SELECT Subquery + (Single-row, Correlated)


/* Sual 1:

Hər işçi üçün: full_name

Yalnız öz departamentindəki maksimum maaşı SELECT subquery ilə göstər. */

select full_name,
	(select MAX(salary)
	from Employees e2
	where e.department_id = e2.department_id) as max_salary
from Employees e;


/* Sual 2:

Hər müştəri üçün: company_name

Yalnız öz sifarişlərinin maksimum məbləğini SELECT subquery ilə göstər. */

select company_name,
	(select MAX(total_amount)
	from Orders o
	where c.id = o.customer_id) as max_total_amount
from Customers c;


/* Sual 3:

Hər layihə üçün: project_name

Yalnız layihəyə aid olan maksimum büdcə SELECT subquery ilə göstər. */

select project_name,
	(select MAX(budget)
	from Projects p2
	where p.customer_id = p2.customer_id) as max_budget
from Projects p;


/* Sual 4:

Hər sifariş üçün: id, total_amount

Yalnız sifarişə aid məhsulların maksimum qiymətini SELECT subquery ilə göstər. */

select id, total_amount,
	(select MAX(total_amount)
	from Orders o2
	where o.customer_id = o2.customer_id) as max_total_amount
from Orders o;


/* Sual 5:

Hər işçi üçün: full_name

Yalnız öz iş günləri üzrə orta iş saatını SELECT subquery ilə göstər. */

select full_name,
	(select AVG(hours_worked)
	from Attendance a
	where e.id = a.employee_id) as avg_hours_worked
from Employees e


/* Sual 6:

Employees cədvəlində hər işçinin öz departamentindəki 

ən yüksək maaşdan yuxarı olmayan işçilərin adını və maaşını göstərən sorğunu yaz. */

select full_name, salary, max_salary
from (
    select full_name, salary,
           (select MAX(salary) from Employees e2
		   where e.department_id = e2.department_id) as max_salary
    from Employees e
) t
where salary <= max_salary;


/* Sual 7:

Employees cədvəlində hər işçinin öz departamentindəki ortalama maaşdan 

yüksək maaş alan işçilərin adını və maaşını göstərən sorğunu yaz. */ 

select full_name, salary, avg_salary
from (
    select full_name, salary,
           (select AVG(salary) from Employees e2
		   where e.department_id = e2.department_id) as avg_salary
    from Employees e
) t
where salary > avg_salary;


/* Sual 8:

Employees cədvəlində hər departament üzrə ən aşağı maaşdan az maaş alan işçilər varmı?

Əgər varsa, həmin işçilərin adını və maaşını göstərən sorğunu yaz. */

select full_name, salary, min_dept_salary
from (
    select full_name, salary,
           (select MIN(salary)
            from Employees e2
            where e.department_id = e2.department_id) as min_dept_salary
    from Employees e
) t
where salary < min_dept_salary;


/* Sual 9:

Employees cədvəlində hər işçinin öz departamentinin 

orta maaşını həmin işçinin yanında göstərən sorğunu yaz. */

select 
    full_name,
    salary,
    (select AVG(salary)
     from Employees e2
     where e.department_id = e2.department_id) as avg_dept_salary
from Employees e;


/* Sual 10:

Employees cədvəlində hər işçinin maaşının öz departamentindəki 

ortalama maaşdan yüksək olub olmadığını göstərən sorğunu yaz.

Nəticədə belə sütunlar olmalıdır: full_name, salary, avg_dept_salary */

select full_name, salary,
	(select AVG(salary)
	from Employees e2
	where e.department_id = e2.department_id) as avg_dept_salary
from Employees e; 
