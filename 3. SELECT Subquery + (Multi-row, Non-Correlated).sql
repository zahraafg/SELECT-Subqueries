CREATE DATABASE IT_CompantDB;

USE IT_CompanyDB;

-- SELECT Subquery + (Multi-row, Non-Correlated)


/* Sual 1:

Hər bir işçi üçün: full_name,salary

Junior Developer-lərin orta maaşını SELECT subquery ilə göstər. */

select full_name, salary,
	(select AVG(salary)
	from Employees e2
	join Positions p
	on p.id = e2.position_id
	where p.position_name = 'Junior Developer') as avg_salary
from Employees e1;


/* Sual 2:

Hər bir müştəri üçün: company_name

20000-dən böyük sifarişlərin sayını SELECT subquery ilə göstər. */

select company_name,
	(select count(*)
	from Orders o
	where total_amount > 20000)as total_amount
from Customers c1;


/* Sual 3:

Hər bir işçi üçün: full_name

bütün layihələrin orta büdcəsini SELECT subquery ilə göstər. */

select full_name, 
	(select AVG(budget)
	from Projects p) as avg_budget
from Employees e;


/* Sual 4:

Hər bir sifariş üçün: id, total_amount

bütün sifarişlərin maksimum məbləğini SELECT subquery ilə göstər. */

select id, total_amount,
	(select MAX(total_amount)
	from Orders o) as max_total_amount
from Orders o;


/* Sual 5:

Hər bir işçi üçün: full_name

şirkətdəki bütün işçilərin maksimum maaşını SELECT subquery ilə göstər. */

select full_name,
	(select MAX(salary)
	from Employees e) as max_salary
from Employees e;