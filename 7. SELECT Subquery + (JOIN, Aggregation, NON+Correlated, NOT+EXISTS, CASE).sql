CREATE DATABASE IT_CompanyDB;

USE IT_CompanyDB;

-- SELECT Subquery + (JOIN, Aggregation, NON/Correlated, NOT/EXISTS)



/* TASK 1:

Hər department üçün aşağıdakıları çıxar:

1️. department_name
2️. işçi sayı
3️. ortalama maaş
4️. SELECT subquery ilə — department daxilində maksimum maaş
5️. SELECT subquery ilə — maaşı department ortalamasından yuxarı olan işçi sayı
6️. SELECT subquery ilə — projectdə iştirak edən işçi sayı (EXISTS istifadə et) */

select 
	d.department_name,
	COUNT(distinct e.id) as emp_count,
	AVG(salary) as avg_salary,

	(select MAX(salary)
	from Employees e2
	where e2.department_id = d.id) as max_salary,

	(select COUNT(*)
	from Employees e3
	where e3.department_id = d.id
	and salary > (
		select AVG(e4.salary)
		from Employees e4
		where e4.department_id = d.id
		)
	) as above_avg_count,

	(select COUNT(*)
	from Employees e5
	where e5.department_id = d.id
	and exists(
		select 1
		from Assignments a
		where a.employee_id = e5.id
		)
    ) as project_emp_count
	
from Departments d
join Employees e
on d.id = e.department_id
group by d.department_name, d.id;


/* TASK 2:

Hər department üçün bu məlumatları çıxar:

1️. department_name
2️. işçi sayı
3️. ortalama maaş
4️. SELECT subquery ilə — həmin departmentdə ən yüksək maaş alan işçinin adı (correlated subquery)
5️. SELECT subquery ilə — departmentdə projectdə işləyən işçi sayı (EXISTS istifadə et) */

select 
	d.department_name,
	COUNT(distinct e.id) as emp_count,
	AVG(salary) as avg_salary,

	(select top 1 e2.full_name
	from Employees e2
	where e2.department_id = d.id
	order by e2.salary desc
	) as max_salary,

	(select COUNT(*)
	from Employees e3
	where e3.department_id = d.id
	and exists (
		select 1
		from Assignments a
		where a.employee_id = e3.id
		)
	) as project_emp_count

from Departments d
join Employees e
on d.id = e.department_id
group by d.department_name, d.id;


/* TASK 3:

Hər department üçün aşağıdakı məlumatları çıxar:

1️. department_name
2️. işçi sayı
3️. department üzrə ortalama maaş
4️. SELECT subquery ilə — maaşı department ortalamasından yüksək olan işçilərin sayı (correlated subquery)
5️. SELECT subquery ilə — əgər department ortalama maaşı şirkət ortalamasından yüksəkdirsə → 
'HIGH_PAY_DEPT' əks halda 'NORMAL' */

select 
	d.department_name,
	COUNT(distinct e.id) as emp_count,
	AVG(salary) as avg_salary,

	(select COUNT(*)
	from Employees e2
	where e2.department_id = d.id
	and salary > (
		select AVG(salary)
		from Employees e3
		where e3.department_id = d.id
		)
	) as count_avg_salary,
	
	(select  
	case 
		when AVG(salary) > ( select AVG(salary) from Employees e5) then 'HIGH_PAY_DEPT'
		else 'NORMAL'
	end as level
	from Employees e4
	where e4.department_id = d.id)

from Departments d
join Employees e
on d.id  = e.department_id
group by department_name, d.id;


/* TASK 4:

Yalnız o departmentləri çıxar ki:

🔹 işçi sayı ≥ 2 olsun
🔹 həmin departmentdə ən azı 1 projectdə işləyən işçi var (EXISTS ilə yoxla)

Və nəticədə bunları göstər:

1️. department_name
2️. işçi sayı
3️. ortalama maaş
4️. SELECT subquery ilə — department üzrə maksimum maaş
5️. SELECT subquery ilə — projectdə işləyən işçi sayı (EXISTS istifadə et) */


select 
	department_name,
	COUNT(distinct e.id) as emp_count,
	AVG(salary) as avg_salary,

	(select MAX(salary) as max_salary
	from Employees e2
	where e2.department_id = d.id),

	(select COUNT(*) as count_emp
	from Employees e3
	where e3.department_id = d.id
	and exists (
		select 1
		from Assignments a
		where a.employee_id = e3.id
		)
	) as count_exists

from Departments d
join Employees e
on d.id = e.department_id
group by d.department_name, d.id

having COUNT(distinct e.id) >= 2
and exists (
	select 1
	from Employees e4
	where e4.department_id = d.id
	and exists (
		select 1
		from Assignments a2
		where a2.employee_id = e4.id
		)
	);


/* TASK 5:

Hər department üçün aşağıdakını çıxar:

1️. department_name
2️. işçi sayı
3️. ortalama maaş
4️. SELECT subquery ilə — department üzrə ən yüksək maaş
5️. SELECT subquery ilə — departmentdə heç bir projectdə işləməyən işçi sayı (NOT EXISTS istifadə et)

💡 Filter: yalnız 1-dən çox işçi olan departmentlər çıxmalıdır (HAVING ilə) */


select 
	d.department_name,
	COUNT(distinct e.id) as emp_count,
	AVG(e.salary) as avg_salary,

	(select MAX(e2.salary) as max_salary
	from Employees e2
	where e2.department_id = d.id),

	(select COUNT(*)
	from Employees e3
	where e3.department_id = d.id
	and not exists (
		select 1
		from Assignments a
		where a.employee_id = e3.id
		)
	) as not_exists

from Departments d
join Employees e
on d.id = e.department_id
group by d.department_name, d.id
having COUNT(distinct e.id) > 1;


/* TASK 6:

Hər department üçün çıxar:

1️. department_name
2️. işçi sayı
3️. ortalama maaş
4️. SELECT subquery ilə — department üzrə maksimum maaş
5️. SELECT subquery ilə — projectdə işləyən işçi sayı (EXISTS)
6️. SELECT subquery ilə — projectdə işləməyən işçi sayı (NOT EXISTS)
7️. SELECT subquery + CASE ilə — əgər avg_salary > company_avg_salary → 'HIGH_PAY_DEPT' yoxsa 'NORMAL'

💡 Filter: yalnız 1-dən çox işçi olan departmentlər çıxsın (HAVING) */


select 
	d.department_name,
	COUNT(distinct e.id) as emp_count,
	AVG(e.salary) as avg_salary,

	(select MAX(e2.salary) 
	from Employees e2
	where e2.department_id = d.id)as max_salary,

	(select COUNT(*)
	from Employees e3
	where e3.department_id = d.id
	and exists (
		select 1
		from Assignments a
		where a.employee_id = e3.id
		)
	) as exists_emp,

	(select COUNT(*)
	from Employees e4
	where e4.department_id = d.id
	and not exists (
		select 1
		from Assignments a2
		where a2.employee_id = e4.id
		)
	) as not_exists_emp,

	(select 
		case
		when AVG(e6.salary) > (select AVG(e5.salary) from Employees e5) then 'HIGH_PAY_DEPT'
		else 'NORMAL'
	end as pay
	from Employees e6
	where e6.department_id = d.id
	) as pay

from Departments d
join Employees e
on d.id = e.department_id
group by d.department_name, d.id
having COUNT(distinct e.id) > 1;


/* TASK 7:

Hər department üçün çıxar:

1️. department_name
2️. işçi sayı
3️. ortalama maaş
4️. department üzrə ən yüksək maaş (SELECT subquery)
5️. departmentdə projectdə işləyən işçi sayı (EXISTS)
6️. departmentdə projectdə işləməyən işçi sayı (NOT EXISTS)
7️. department üzrə maaşın şirkət ortalamasından yüksək olub-olmaması (CASE + non-correlated subquery)
8️. departmentdə maaşı ortalamadan yüksək işçi sayı, 
amma yalnız projectdə iştirak edənlər (correlated + EXISTS + subquery)

💡 Filter: yalnız 5-dən çox işçi olan departmentlər çıxsın (HAVING) */

select 
	department_name,
	COUNT(distinct e.id) as emp_count,
	AVG(e.salary) as avg_salary,

	(select MAX(salary)
	from Employees e2
	where e2.department_id = d.id) as max_salary,

	(select COUNT(*)
	from Employees e3
	where e3.department_id = d.id
	and exists (
		select 1
		from Assignments a
		where a.employee_id = e3.id
		)
	) as exists_emp,

	(select COUNT(*)
	from Employees e4
	where e4.department_id = d.id
	and not exists (
		select 1
		from Assignments a2
		where a2.employee_id = e4.id
		)
	) as not_exists_emp,

(select case
	when e6.salary > (select AVG(e5.salary) from Employees e5) then 'Hight salary'
	else 'Low salary'
end as level_salary
from Employees e6) as level_salary

from Departments d
join Employees e
on d.id = e.department_id
group by d.department_name, d.id
having COUNT(distinct e.id) > 5;



