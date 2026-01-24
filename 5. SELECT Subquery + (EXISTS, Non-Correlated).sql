 CREATE DATABASE IT_ComponyDB;
 
 USE IT_CompanyDB;

 -- SELECT Subquery + (EXISTS, Non-Correlated)


 /* 1️. EXISTS (Non-correlated)

Hər işçinin full_name-ini göstər, əgər Assignments cədvəlində 

heç bir sətir varsa (yəni Assignments cədvəli boş deyil). */

select full_name
from Employees e
where exists 
	(select 1 
	from Assignments);


/* 2️. EXISTS (Non-correlated)

Hər sifarişin id və total_amount-ını göstər, əgər Orders cədvəli boş deyilsə. */

select id, total_amount
from Orders o
where exists 
	(select 1 
	from Orders);


/* 3️. EXISTS (Non-correlated)

Hər müştərinin company_name-ni göstər, əgər Projects cədvəlində sətir varsa. */

select company_name
from Customers c
where exists 
	(select 1 
	from Projects);


/* 4️. NOT EXISTS (Non-correlated)

Hər işçinin full_name-ni göstər, əgər Assignments cədvəli boşdursa. */

select full_name
from Employees e
where not exists 
	(select 1 
	from Assignments);


/* 5️. NOT EXISTS (Non-correlated)

Hər müştərinin company_name-ni göstər, əgər Orders cədvəlində heç sifariş yoxdursa. */

select company_name
from Customers c
where not exists 
	(select 1 
	from Orders);


/* 6️. NOT EXISTS (Non-correlated)

Hər layihənin project_name-ini göstər, əgər Employees cədvəlində heç kim yoxdursa. */

select project_name
from Projects p
where not exists 
	(select 1 
	from Employees);

