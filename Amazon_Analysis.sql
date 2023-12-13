use amazon;
select * from orders;
select * from returns;

--1.)Joining TWO TABLES RETURNS AND ORDERS that have columns such as order id,order date and returned.

SELECT o.order_id,o.order_date, r.return_reason from orders o join returns r on o.order_id = r.order_id;

--2.)write a sql to get all the orders where customers name has "a" as second character and "d" as fourth character

select * from orders where Customer_Name like '_a_d%';

--3.)write a query to get all the orders where ship_mode is neither in 'Standard Class' nor 
--in 'First Class' and ship_date is after nov 2020

select * from orders where Ship_Mode not in ('Standard Class', 'First Class') and Ship_Date > '2020-11-30';

--4.)write a query to get all the orders where customer name neither start with "A" and nor ends with "n"

select * from orders where Customer_Name not like 'A%n';

--5.)write a query to get all the orders where profit is negative

select * from orders where profit <0;

--6.)write a query to get all the orders where either quantity is less than 3 or profit is 0

select * from orders where profit = 0 and quantity <3;

--7.) Your manager handles the sales for South region and he wants you to create a report 
--of all the orders in his region where some discount is provided to the customers

select * from orders where region = 'South' and discount >0;

--8.) Write a query to find top 5 orders with highest sales in furniture category

select top 5 * from orders where category = 'Furniture' order by sales DESC;

--9.)write a query to find all the records in technology and furniture category
--for the orders placed in the year 2020 only

select * from orders where category in ('Technology','Furniture') and
Order_date between '2020-01-01' and '2020-12-31';

--10.)write a query to find all the orders where order date is in year 2020 but ship date is in 2021

select * from orders where Order_Date between
'2020-01-01' and '2020-12-31' and ship_date between '2021-01-01' and '2021-12-31';

--11.)write a query to get total profit, first order date and latest order date for each category

select category, sum(profit) as Total_profit, min(Order_Date) as First_Order_date,
max(Order_Date) as Latest_Order_date from orders group by category;

--12.)write a query to find sub-categories where average profit is more than the half
--of the max profit in that sub-category

select sub_category from orders group by sub_category having avg(profit) > max(profit)/2;

--13.)create the exams table with below script;

create table exams (student_id int, subject varchar(20), marks int);

insert into exams values(1,'Chemistry',91),(1,'Physics',91),(1,'Maths',92)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80),(3,'Maths',80)
,(4,'Chemistry',71),(4,'Physics',54)
,(5,'Chemistry',79);

--14.)Write a query to find students who have got same marks in Physics and Chemistry.

select student_id,marks from exams where subject in ('Physics','Chemistry')
group by student_id, marks having count(1)=2;

--15.)Write a query to find total number of products in each category.

select category, count(distinct product_id) as Number_of_Products
from orders group by category;

--16.)Write a query to find top 5 sub categories in west region by total quantity sold

select top 5 sub_category, sum(quantity) as Total_Quantity from orders
where region ='West' group by sub_category order by Total_Quantity;

--17.) write a query to find total sales for each region and ship mode combination for orders in year 2020

select region, Ship_Mode,sum(sales)as Total_Sales from orders
where order_date between '2020-01-01' and '2020-12-31'
group by region,Ship_Mode;

--18.)Write a query to get region wise count of return orders

select region,count(distinct o.order_id) as Number_of_returned_Orders
from orders o inner join returns r on o.order_id=r.order_id
group by region;

--19.)Write a query to get category wise sales of orders that were not returned

select category, sum(o.sales) as Total_sales from orders o left join 
returns r on o.order_id = r.order_id where r.order_id is null
group by category;

--20.)Write a query to print sub categories where we have all 3 kinds of returns (others,bad quality,wrong items)

select o.sub_category from orders o inner join returns r
on o.order_id = r.order_id group by o.sub_category
having count(distinct r.return_reason)=3;

--21.)Write a query to find cities where not even a single order was returned.

select o.city from orders o left join returns r 
on o.order_id=r.order_id 
group by city
having count(r.order_id)=0;

--22.)Write a query to find top 3 subcategories by sales of returned orders in east region

select top 3 sub_category,sum(o.sales) as return_sales
from orders o
inner join returns r on o.order_id=r.order_id
where o.region='East'
group by sub_category
order by return_sales  desc;


create table employee(
    emp_id int,
    emp_name varchar(20),
    dept_id int,
    salary int,
    manager_id int,
    emp_age int
);


insert into employee values(1,'Ankit',100,10000,4,39);
insert into employee values(2,'Mohit',100,15000,5,48);
insert into employee values(3,'Vikas',100,10000,4,37);
insert into employee values(4,'Rohit',100,5000,2,16);
insert into employee values(5,'Mudit',200,12000,6,55);
insert into employee values(6,'Agam',200,12000,2,14);
insert into employee values(7,'Sanjay',200,9000,2,13);
insert into employee values(8,'Ashish',200,5000,2,12);
insert into employee values(9,'Mukesh',300,6000,6,51);
insert into employee values(10,'Rakesh',500,7000,6,50);
select * from employee;

create table dept(
    dep_id int,
    dep_name varchar(20)
);
insert into dept values(100,'Analytics');
insert into dept values(200,'IT');
insert into dept values(300,'HR');
insert into dept values(400,'Text Analytics');
select * from dept;

select * from employee;
select * from dept;


--23.)write a query to print dep name and average salary of employees in that dep

select d.dep_name, avg(e.salary)as avg_salary from employee e inner join dept d on
d.dep_id = e.dept_id group by d.dep_name;

--24.)Write a query to print dep names where none of the emplyees have same salary.

select d.dep_name from employee e join dept d
on e.dept_id = d.dep_id
group by d.dep_name
having count(e.emp_id)=count(distinct e.salary);

--25.)Write a query to print dep name for which there is no employee

select * from employee;
select * from dept;

select d.dep_id,d.dep_name
from dept d 
left join employee e on e.dept_id=d.dep_id
group by d.dep_id,d.dep_name
having count(e.emp_id)=0;

--26.)Write a query to print employees name for which dep id is not avaiable in dept table

select e.*
from employee e 
left join dept d  on e.dept_id=d.dep_id
where d.dep_id is null;

--27.)Run the following command to add and update dob column in employee table
alter table  employee add dob date;
update employee set dob = dateadd(year,-1*emp_age,getdate());

--28.) write a query to print emp name , their manager name and diffrence in their age (in days) 
--for employees whose year of birth is before their managers year of birth

select e1.emp_name,e2.emp_name as manager_name , DATEDIFF(day,e1.dob,e2.dob) as diff_in_age
from employee e1
inner join employee e2 on e1.manager_id=e2.emp_id
where DATEPART(year,e1.dob)< DATEPART(year,e2.dob);

--29.)write a query to find subcategories who never had any return orders in the month of november (irrespective of years)

select sub_category
from orders o
left join returns r on o.order_id=r.order_id
where DATEPART(month,order_date)=11
group by sub_category
having count(r.order_id)=0;

--30.)orders table can have multiple rows for a particular order_id when customers buys more than 1 product in an order.
--write a query to find order ids where there is only 1 product bought by the customer.

select order_id
from orders 
group by order_id
having count(1)=1;

--31.)write a query to get number of business days between order_date and ship_date (exclude weekends). 
--Assume that all order date and ship date are on weekdays only

select order_id,order_date,ship_date ,datediff(day,order_date,ship_date)-2*datediff(week,order_date,ship_date)
as no_of_business_days
from 
orders;

--32.)write a query to print 3 columns : category, total_sales and (total sales of returned orders)

select o.category,sum(o.sales) as total_sales
,sum(case when r.order_id is not null then sales end) as return_orders_sales
from orders o
left join returns r on o.order_id=r.order_id
group by category;

--33.)write a query to print below 3 columns
--category, total_sales_2019(sales in year 2019), total_sales_2020(sales in year 2020)

select category,sum(case when datepart(year,order_date)=2019 then sales end) as total_sales_2019
,sum(case when datepart(year,order_date)=2020 then sales end) as total_sales_2020
from orders 
group by category;


--34.)write a query print top 5 cities in west region by average no of days between order date and ship date.

select top 5 city, avg(datediff(day,order_date,ship_date) ) as avg_days
from orders
where region='West'
group by city
order by avg_days desc;

--35.)write a query to print emp name, manager name and senior manager name (senior manager is manager's manager)

select e1.emp_name,e2.emp_name as manager_name,e3.emp_name as senior_manager_name
from employee e1
inner join employee e2 on e1.manager_id=e2.emp_id
inner join employee e3 on e2.manager_id=e3.emp_id;

--36.)Run below table script to create icc_world_cup table:

create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);

INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');


--37.)write a query to print customer name and no of occurence of character 'n' in the customer name.

select 
'category' as hierarchy_type,category as hierarchy_name
,sum(case when region='West' then sales end) as total_sales_in_west_region
,sum(case when region='East' then sales end) as total_sales_in_east_region
from orders
group by category
union all
select 
'sub_category',sub_category
,sum(case when region='West' then sales end) as total_sales_in_west_region
,sum(case when region='East' then sales end) as total_sales_in_east_region
from orders
group by sub_category
union all
select 
'ship_mode ',ship_mode 
,sum(case when region='West' then sales end) as total_sales_in_west_region
,sum(case when region='East' then sales end) as total_sales_in_east_region
from orders
group by ship_mode;

--38.)--the first 2 characters of order_id represents the country of order placed . write a query to print total no of orders placed in each country
--(an order can have 2 rows in the data when more than 1 item was purchased in the order but it should be considered as 1 order)

select left(order_id,2) as country, count(distinct order_id) as total_orders
from orders 
group by left(order_id,2);

--39.)write a query to find premium customers from orders data.
--Premium customers are those who have done more orders than average no of orders per customer.

with no_of_orders_each_customer as (
select customer_id,count(distinct order_id) as no_of_orders
from orders 
group by customer_id)
select * from 
no_of_orders_each_customer where no_of_orders > (select avg(no_of_orders) from no_of_orders_each_customer);

--40.)write a query to find employees whose salary is more than average salary of employees in their department

select e.* from employee e
inner join (select dept_id,avg(salary) as avg_sal from employee group by dept_id)  d
on e.dept_id=d.dept_id
where salary>avg_sal;

--41.)write a query to find employees whose age is more than average age of all the employees.

select * from employee 
where emp_age > (select avg(emp_age) from employee);

--42.)write a query to print emp name, salary and dep id of highest salaried employee in each department.

select e.* from employee e
inner join (select dept_id,max(salary) as max_sal from employee group by dept_id)  d
on e.dept_id=d.dept_id
where salary=max_sal;

--43.)write a query to print emp name, salary and dep id of highest salaried employee overall.

select * from employee 
where salary = (select max(salary) from employee);

--44.)write a query to print product id and total sales of highest selling products
--(by no of units sold) in each category

with product_quantity as (
select category,product_id,sum(quantity) as total_quantity
from orders 
group by category,product_id)
,cat_max_quantity as (
select category,max(total_quantity) as max_quantity from product_quantity 
group by category
)
select *
from product_quantity pq
inner join cat_max_quantity cmq on pq.category=cmq.category
where pq.total_quantity  = cmq.max_quantity;

--45.)write a query to print 3rd highest salaried employee details for each department 
--(give preferece to younger employee in case of a tie). 
--In case a department has less than 3 employees then print the details of highest salaried employee 
--in that department.


with rnk as (
select *, dense_rank() over(partition by dept_id order by salary desc) as rn
from employee)
,cnt as (select dept_id,count(1) as no_of_emp from employee group by dept_id)
select
rnk.*
from 
rnk 
inner join cnt on rnk.dept_id=cnt.dept_id
where rn=3 or  (no_of_emp<3 and rn=1);

