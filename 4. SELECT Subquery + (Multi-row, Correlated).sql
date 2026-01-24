CREATE DATABASE IT_CompantDB;

USE IT_CompanyDB;

-- SELECT Subquery + (Multi-row, Correlated)


/* Sual 1:

Hər bir işçi üçün: full_name

onun işlədiyi layihələrin sayını SELECT subquery ilə göstər. */

select full_name,
	(select COUNT(a.employee_id)
	from Assignments a
	where e.id = a.employee_id)as count_emp
from Employees e;


/* Sual 2:

Hər bir departamentdə çalışan işçilər üçün: full_name

öz departamentindəki işçilərin orta maaşını SELECT subquery ilə göstər. */

select full_name,
	(select AVG(salary)
	from Employees e2
	where e.department_id = e2.department_id) as avg_salary
from Employees e;


/* Sual 3:

Hər bir sifariş üçün: id, total_amount

həmin sifarişə aid məhsulların ümumi sayını (quantity) SELECT subquery ilə göstər. */

select id, total_amount,
	(select SUM(quantity)
	from OrderDetails od
	where o.id = od.order_id) as sum_quantity
from Orders o;


/* Sual 4:

Hər bir müştəri üçün: company_name

yalnız öz sifarişlərinin maksimum məbləğini SELECT subquery ilə göstər. */

select company_name,
	(select MAX(total_amount)
	from Orders o
	where c.id = o.customer_id)as max_total_amount
from Customers c;


/* Sual 5:

Hər bir işçi üçün: full_name

yalnız öz işlədiyi günlər üzrə orta iş saatını SELECT subquery ilə göstər. */

select full_name,
	(select AVG(a.hours_worked)
	from Attendance a
	where a.employee_id = e.id) as avg_hours_worked
from Employees e;