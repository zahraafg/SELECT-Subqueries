CREATE DATABASE IT_ComponyDB;

USE IT_CompanyDB;

-- SELECT Subquery + (EXISTS, Correlated)


/* 1️. EXISTS (Correlated)

Hər işçinin full_name-ni göstər, əgər o işçi Assignments-da tapılır (yəni hansısa layihəyə təyin olunub). */

select full_name
from Employees e
where exists (
    select 1
    from Assignments a
    where a.employee_id = e.id
);


/* 2️. EXISTS (Correlated)

Hər sifarişin id-ni göstər, əgər o sifarişə aid OrderDetails varsa. */

select id
from Orders o
where exists (
    select 1
    from OrderDetails od
    where od.order_id = o.id
);


/* 3️. EXISTS (Correlated)

Hər müştərinin company_name-ni göstər, əgər o müştərinin Projects-ləri varsa. */

select company_name
from Customers c
where exists (
    select 1
    from Projects p
    where p.customer_id = c.id
);


/* 4️. NOT EXISTS (Correlated)

Hər işçinin full_name-ni göstər, əgər o işçi heç bir layihəyə təyin olunmayıb. */

select full_name
from Employees e
where not exists (
    select 1
    from Assignments a
    where a.employee_id = e.id
);


/* 5️. NOT EXISTS (Correlated)

Hər sifarişin id-ni göstər, əgər o sifarişə aid OrderDetails yoxdur. */

select id
from Orders o
where not exists (
    select 1
    from OrderDetails od
    where od.order_id = o.id
);


/* 6️. NOT EXISTS (Correlated)

Hər müştərinin company_name-ni göstər, əgər o müştərinin heç bir layihəsi yoxdursa. */

select company_name
from Customers c
where not exists (
    select 1
    from Projects p
    where p.customer_id = c.id
);
