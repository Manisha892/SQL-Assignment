/* Question(1) Create a table called employees with the following structure: 
   - emp_id (integer, should not be NULL and should be a primary key).
   - emp_name (text, should not be NULL).
   - age (integer, should have a check constraint to ensure the age is at least 18).
   - email (text, should be unique for each employee).
   - salary (decimal, with a default value of 30,000).
   - Write the SQL query to create the above table with all constraints.*/

-- Answer :
create database Assignment;
use Assignment;
create Table employees(
emp_id int not null primary key,
emp_name varchar(30) not null,
age int check(age >=18),
email varchar(30) unique,
salary Decimal default 30000);

select * from employees;

/* Question(2) Explain the purpose of constraints and how they help maintain data integrity in a database.Provide 
            examples of common types of constraints.*/
/* Answer : Constraints in a database are rules that ensure data quality and integrity.They help prevent errors and
            enforce business rules.*/
-- How constraints work
/* - Constraints limit the types of data that can be entered into a table. 
   - They set boundaries for data values, relationships between entities, and uniqueness requirements. 
   - Constraints enforce business rules, such as ensuring that data reflects real-world entities and relationships.*/

-- Why constraints are important 
/*  - Constraints help ensure that data is accurate, consistent, and valid.
    - They help maintain relationships between tables.
    - Constraints help prevent invalid data entry.
    - Constraints help ensure that data adheres to specified formats and values.

-- Types of constraints 
/* - Domain constraints: Limit the values that can be placed in a column.
   - Key constraints: Ensure that every tuple in a relation is unique.
   - Check constraints: Limit the value range that can be placed in a column.
   - Data Integrity: The relational database model enforces data integrity through various constraints such as
                      primary keys, foreign keys, and unique constraints.
                      This ensures that the data in the database is accurate, consistent, and valid.*/

/* Question(3) Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values?
               Justify your answer.*/
/*  Answer : A primary key uniquely identifies each record in a table, while the NOT NULL constraint simply ensures 
             that a column cannot have empty or undefined values.*/ 
/*  Key Points: NOT NULL is used to enforce mandatory fields.It prevents NULL values from being inserted or updated.
-- The NOT NULL constraint is applied to a column to ensure that:
    1.Mandatory Data: The column must always have a value, preventing NULL values (which represent unknown or missing data).
	   Example: A "username" column in a user table must always contain a value for identification purposes.
    2.Data Integrity: It ensures the data's reliability by enforcing the presence of meaningful values in critical columns.        Example: A "price" column in a product table should not be NULL because every product must have a defined price.
    3.Logic Enforcement: Some columns have inherent business rules that mandate their presence.
       Example: An "order_date" column in an order table must always have a date to track when the order was placed.*/
/* Can a Primary Key Contain NULL Values?
--  No, a primary key cannot contain NULL values. Here's why:
   - 1.Uniqueness Requirement: A primary key uniquely identifies each record in a table. NULL values indicate the 
                  absence of a value, which undermines uniqueness since multiple NULLs are considered equal in SQL.
   - 2.Mandatory Data: A primary key ensures that every record is identifiable. If a primary key column were allowed
       to contain NULLs, those rows would lack proper identification, violating the concept of a unique identifier.
   - 3.Enforced Constraints: In SQL, when a column is designated as a primary key, the database system automatically applies:
				               -  A NOT NULL constraint to prevent NULL values.
                               -  A UNIQUE constraint to prevent duplicate values.*/
-- Example Justification
/* Consider a "students" table with a student_id as the primary key. If NULLs were allowed:
     - Two records could have NULL as their student_id.
     - The database would fail to distinguish between them, violating the principle of unique identification.
- Thus, primary keys are inherently NOT NULL to ensure data consistency and integrity.*/

/* Question(4) Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an
              example for both adding and removing a constraint.*/
-- Answer: They are some Basic Types of Constrains : Primary key,Forgein key,Not Null,Unique,Check,Default.
use Assignment;
select * from employees;
create Table employees(
emp_id int not null primary key,
emp_name varchar(30) not null,
age int check(age >=18),
email varchar(30) unique,
salary Decimal default 30000);
INSERT INTO employees VALUES
(001,'John Doe', 30, 'john.doe@example.com', 75000.00),
(002,'Jane Smith', 35, 'jane.smith@example.com', 85000.00),
(003,'Alice Brown', 28, 'alice.brown@example.com', 62000.00),
(004,'Bob Davis', 40, 'bob.davis@example.com', 90000.00),
(005,'Eve Johnson', 25, 'eve.johnson@example.com', 55000.00);
select * from employees;
INSERT INTO employees (emp_id,emp_Name,age,email)VALUES
(006,'Devid', 45, 'Dev.doe@example.com');
select * from employees;
-- add or remove constraints on an existing table.
-- Adding Constraints : To add a constraint to an existing table, use the ALTER TABLE command along with the appropriate constraint type.
-- Constraints like NOT NULL can be directly modified with MODIFY, while others(e.g., UNIQUE or CHECK) require explicit names for removal.
ALTER TABLE employees
MODIFY emp_name varchar(30) Not NULL;

-- If the email column doesn't already have a UNIQUE constraint, we can add it to ensure no duplicate emails.
ALTER TABLE employees
ADD CONSTRAINT unique_email UNIQUE (email);

-- Removing Constraints : To remove a constraint, use the ALTER TABLE command with the DROP CONSTRAINT clause.
-- Remove a UNIQUE Constraint : To remove the unique_email constraint:
ALTER TABLE employees
DROP CONSTRAINT unique_email;

-- Remove a NOT NULL Constraint : If I want to allow NULL values in the emp_name column:
ALTER TABLE employees
MODIFY emp_name varchar(30) NULL;

/* Question(5) Explain the consequences of attempting to insert, update, or delete data in a way that violates 
              constraints.Provide an example of an error message that might occur when violating a constraint.*/
-- Answer : Consequences of Violating Constraints
/*  When a database constraint is violated during an INSERT, UPDATE, or DELETE operation, the database rejects the
    operation and returns an error. The specific consequences depend on the type of constraint violated.*/
select * from employees;
Insert into employees (emp_id,emp_name,age,email)values    ## In this case CHECK constraint is violated because age should be 18 or >18.
(007,'Ravi',16,'ravi@gmail.com');

update employees
set email = "eve.johnson@example.com"             ## IN this case unique constraint violates because email has a unique constraint not put duplicates values. 
where emp_id = 006;

-- Delete
delete from employees                    ## emp_id 001 deleted.
where emp_id =001;
select * from employees;
INSERT INTO employees VALUES
(001,'John Doe', 30, 'john.doe@example.com', 75000.00);
select * from employees;

/* Question(6) You created a products table without constraints as follows:
  CREATE TABLE products (product_id INT,product_name VARCHAR(50),price DECIMAL(10, 2));
  Now, you realise that : 1.The product_id should be a primary key.2.The price should have a default value of 50.00 */
-- Answer: 
CREATE TABLE products 
(product_id INT,
product_name VARCHAR(50),
price DECIMAL(10, 2));

Select * from products;
-- Add PRIMARY KEY directly to the column definition when The product_id should be a primary key.
ALTER TABLE products
ADD PRIMARY KEY (product_id);

-- Question(7)You have two tables:
Create table Students(
student_id int primary key,
student_name varchar(30),
class_id int) ;
select * from students;

insert into students(student_id,student_name,class_id) values (1,'Alice',101);
insert into students(student_id,student_name,class_id) values (2,'Bob',102);
insert into students(student_id,student_name,class_id) values (3,'Charlie',101);
select * from students;

create table classes(class_id int primary key ,class_name varchar(30));
insert into classes (class_id,class_name) values (101,"Math");
insert into classes (class_id,class_name) values (102,"Science");
insert into classes (class_id,class_name) values (103,"History");
select * from classes;

select student_name,class_name from students inner join classes
on
students.class_id = classes.class_id;

-- Question(8) Consider the following three tables:
create table orders(order_id int ,order_date date,customer_id int);
Insert into orders (order_id,order_date,customer_id) values (1,"2024-01-01",101);
Insert into orders (order_id,order_date,customer_id) values (2,"2024-01-03",102);
select * from orders;

create table customers(customer_id int primary key,customer_name varchar(30));
Insert into customers(customer_id,customer_name) values (101,"Alice");
Insert into customers(customer_id,customer_name) values (102,"Bob");
select * from customers;

create table Products(Product_id int primary key,Product_Name varchar(30),Order_id int);
Insert into products(product_id,product_name,order_id) values (1,"Laptop",1);
Insert into products(product_id,product_name,order_id) values (2,"Phone",NULL);

select * from products;

select Customer_Name,Product_Name,Order_id from customers 
inner join orders 
on
customers.customer_id=orders.customer_id
inner join products 
on
orders.order_id=Products.order_id;
-- Other method
select Order_id,Customer_Name,Product_Name
from customers,Orders,Products
where customers.customer_id=Orders.customer_id 
AND orders.order_id=Products.order_id;

-- Question (9) Given the following tables:
create table Sales (Sale_id int primary Key,Product_id int,Amount int);
Insert into Sales (Sale_id,Product_id,Amount) values (1,101,500);
Insert into Sales (Sale_id,Product_id,Amount) values (2,102,300);
Insert into Sales (Sale_id,Product_id,Amount) values (3,101,700);
select * from Sales;

create table Products1(Product_id int ,Product_Name varchar(30));
Insert into products1(product_id,product_name) values (101,"Laptop");
Insert into products1(product_id,product_name) values (102,"Phone");
select * from products1;

select Product_Name,Amount from sales inner join products1
on
sales.product_id=products1.product_id;

select sum(Amount) as Total_Sales_Amount from Sales
where product_id=101;

-- Question (10) You are given three tables:
-- Orders1,Customers1,Order_Details
Create table Orders1(Order_id int,Order_date date,Customer_id int);
Insert into Orders1(Order_id,Order_Date,Customer_id) values (1,"2024-01-02",1),(2,"2024-01-05",2);
select * from Orders1;

create table customers1(customer_id int,Customer_name varchar(30));
Insert into customers1(customer_id,customer_name) values (1,"Alice"),(2,"Bob") ;
select * from customers1;

create table Order_Details (Order_id int,Product_id int,Quantity int);
Insert into Order_Details (Order_id,Product_id,Quantity) values (1,101,2),(1,102,1),(2,101,3);
select * from Order_details;

select Order_id,Customer_Name  from Customers1 Inner join Orders1
on 
Customers1.customer_id=Orders1.customer_id;

select Order_id,sum(Quantity) as Quantity_of_Product from order_details
where order_id=1;


-- SQL Commands
-- Question (1) Identify the primary keys and foreign keys in maven movies db. Discuss the differences.
/* Answer :A primary key is a unique identifier for each record in a table. A foreign key establishes a relationship 
           between tables by referencing the primary key of another table.Ensures uniqueness and data integrity within
           a single table.*/
-- Query For Primary Key
SELECT 
    TABLE_NAME, 
    COLUMN_NAME 
FROM 
    information_schema.KEY_COLUMN_USAGE 
WHERE 
    CONSTRAINT_NAME = 'PRIMARY' 
    AND TABLE_SCHEMA = 'mavenmovies';
    
-- Query For Foreign Key
SELECT 
    TABLE_NAME, 
    COLUMN_NAME, 
    CONSTRAINT_NAME, 
    REFERENCED_TABLE_NAME, 
    REFERENCED_COLUMN_NAME
FROM 
    information_schema.KEY_COLUMN_USAGE
WHERE 
    REFERENCED_TABLE_SCHEMA = 'Mavenmovies';

-- Question (2) List all details of actors.
use mavenmovies;
select * from actor;
select * from actor_info;
select a.actor_id,a.First_name,a.Last_name,ai.Film_info,a.last_update from actor a join actor_info ai
on
a.actor_id=ai.actor_id;

-- Question (3) List all customer information from DB.
select * from customer_list;
select * from customer;
select c.Customer_id,c.store_id,cl.Name,c.email,c.address_id,cl.address,cl.`Zip code`,cl.Phone,cl.City,cl.Country,cl.Notes,cl.SID,c.Active,c.Create_date,c.last_update from customer c join customer_list cl
on 
c.customer_id=cl.ID;

-- Question (4) List different countries.
select * from country;

-- Question (5) Display all active customers.
select c.Customer_id,c.store_id,cl.Name,c.email,c.address_id,cl.address,cl.`Zip code`,cl.Phone,cl.City,cl.Country,cl.Notes,cl.SID,c.Active,c.Create_date,c.last_update from customer c join customer_list cl
on 
c.customer_id=cl.ID
where Active=1;

-- Question (6) List of all rental IDs for customer with ID 1.
select cl.ID as `Rental IDs`,c.store_id,cl.Name,c.email,c.address_id,cl.address,cl.`Zip code`,cl.Phone,cl.City,cl.Country,cl.Notes,cl.SID,c.Active,c.Create_date,c.last_update from customer c join customer_list cl
on 
c.customer_id=cl.ID
where SID=1;

-- Question (7)  Display all the films whose rental duration is greater than 5 .
select * from film
where rental_duration > 5;

-- Question (8) List the total number of films whose replacement cost is greater than $15 and less than $20.
select * from film
where replacement_cost  between 15 and 20;

-- Question (9)  Display the count of unique first names of actors.
select distinct(first_name) from actor;

-- Question (10) Display the first 10 records from the customer table .
select * from customer
limit 10;

-- Question (11) Display the first 3 records from the customer table whose first name starts with ‘b’.
select * from customer
where first_name like "b%"
limit 3;

-- Question (12) Display the names of the first 5 movies which are rated as ‘G’.
select * from film
where Rating="G"
limit 5;

-- Question (13) Find all customers whose first name starts with "a".
select * from customer
where First_name like "a%";

-- Question (14) Find all customers whose first name ends with "a".
select * from customer
where First_name like "%a";

-- Question (15) Display the list of first 4 cities which start and end with ‘a’ .
select * from city
where city like "a%a";

-- Question (16) Find all customers whose first name have "NI" in any position.
select * from customer
where First_name REGEXP "NI\.";

-- Question (17) Find all customers whose first name have "r" in the second position .
select * from customer
where First_name like "_r%";

-- Question (18) Find all customers whose first name starts with "a" and are at least 5 characters in length.
select * from customer
where First_name like "a____%";

-- Question (19) Find all customers whose first name starts with "a" and ends with "o".
select * from Customer
where First_name like "A%O";

-- Question (20) Get the films with pg and pg-13 rating using IN operator.
select * from film
where Rating in ("pg","pg-13");

-- Question (21) Get the films with length between 50 to 100 using between operator.
select * from film
where length between 50 and 100;

-- Question (22) Get the top 50 actors using limit operator.
select * from actor
limit 50;

-- Question (23) Get the distinct film ids from inventory table.
select distinct(film_id)  from inventory;         -- Distinct film ids from inventory table is 958.
select * from inventory;                          -- Total inventory film_id is 1000.


-- Functions
-- Basic Aggregate Functions:
-- Question 1: Retrieve the total number of rentals made in the Sakila database.
use sakila;
select count(rental_id) from rental;

-- Question 2: Find the average rental duration (in days) of movies rented from the Sakila database.
select avg(rental_duration) as `Rental Duration(in days)` from film;

-- String Functions:
-- Question 3: Display the first name and last name of customers in uppercase.
select upper(First_name) as First_name,upper(Last_name) as Last_name from customer;

-- Question 4: Extract the month from the rental date and display it alongside the rental ID.
select Rental_id,month(Rental_date) Rental_Month,Rental_date from rental;

-- GROUP BY:
-- Question 5: Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
select * from rental;
select count(rental_id) from rental;
select customer_id,count(rental_id) as `Count of Rentals`,Rental_id from rental
group by rental_id;

-- Question 6: Find the total revenue generated by each store.
select * from payment;
select staff_id as Store,sum(Amount) as `Total Revenue` from payment
group by staff_id ;

-- Question 7: Determine the total number of rentals for each category of movies.
select * from category;
select * from film_category;
select * from film;
select * from inventory;
select * from Rental;
select c.Name as Category_Name,count(r.rental_id) as Total_Rentals from category c join film_category fc
on c.category_id=fc.category_id
join film f on fc.film_id=f.film_id 
join inventory i on f.film_id=i.film_id
join rental r on i.inventory_id=r.inventory_id
group by c.name 
order by  Total_Rentals desc;

-- Question 8: Find the average rental rate of movies in each language.
use mavenmovies;
select * from film;
select * from language;
select l.Name,avg(f.rental_rate ) as `Average Rental Rate` from film f join language l
on f.language_id=l.language_id
group by l.Name;

-- Joins
-- Questions 9 : Display the title of the movie, customer s first name, and last name who rented it.
select * from film;
select * from inventory;
select * from rental;
select * from customer;
select f.Title,c.First_Name,c.Last_Name from film f join inventory i
on f.film_id=i.film_id
join rental r on i.inventory_id=r.inventory_id
join customer c on r.customer_id=c.customer_id;

-- Question 10: Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
select * from film_actor;
select * from film;
select * from actor;
select a.first_name as `Actor's Name`,f.title as `Film Name` from film f join film_actor fa
on f.film_id=fa.film_id join actor a on fa.actor_id=a.actor_id
where f.title ="Gone with the Wind"; 

-- Question 11: Retrieve the customer names along with the total amount they've spent on rentals.
select * from customer;
select * from payment;
select * from rental;
select concat(c.first_name," ",c.last_name) as `Customer Name`,sum(p.amount) as `Total Amount spent` from customer c join payment p
on c.customer_id=p.customer_id
group by c.customer_id,c.first_name,c.last_name
order by `Total Amount spent` desc ;

-- Question 12: List the titles of movies rented by each customer in a particular city (e.g., 'London').
select * from film;
select * from customer;
select * from city;
select * from address;
select * from inventory;
select * from rental;
select f.title as `Movies Title`,concat(c.first_name," ",c.last_name) as `Customer Name`,ct.City from film f
join inventory i on f.film_id=i.film_id 
join rental r on i.inventory_id=r.inventory_id
join customer c on r.customer_id=c.customer_id
join address a on c.address_id=a.address_id
join city ct on a.city_id=ct.city_id
ORDER BY 
   ct.City, `Customer Name`,`Movies Title`;

-- Advanced Joins and GROUP BY:
-- Question 13: Display the top 5 rented movies along with the number of times they've been rented.
select * from film;
select * from inventory;
select * from rental;
select f.title as `Movies Name`,count(r.rental_id)as rental_count from film f join inventory i 
on f.film_id=i.film_id join rental r on i.inventory_id=r.inventory_id
group by f.title
order by rental_count desc
limit 5;

-- Question 14: Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
select * from rental;
select * from inventory;
select * from customer;
select concat(c.first_name," ",c.last_name) as Customer_Name ,c.customer_Id,c.store_id  from customer c join rental r 
on c.customer_Id=r.customer_id join inventory i on r.inventory_id=i.inventory_id
group by c.customer_Id,customer_name
HAVING 
 COUNT(DISTINCT i.store_id) = 2 ;

-- Windows Function:
-- Question (1) Rank the customers based on the total amount they've spent on rentals.
select * from customer;
select * from payment;
select row_number() over(order by p.Amount desc) as Customer_Rank,concat(c.first_name," ",c.last_name) as `Customer Name`,p.Amount as `Total Amount` 
from customer c join payment p
on c.customer_id=p.customer_id ;

-- Question (2) Calculate the cumulative revenue generated by each film over time.
select f.title as `Film Title`,date(p.payment_date) as `Payment Date`,sum(p.amount) over (partition by f.film_id 
order by  date(p.Payment_date ) 
rows between unbounded preceding and current row)
as `Cumulative Revenue` from payment p join rental r on p.rental_id=r.rental_id join inventory i on 
r.inventory_id=i.inventory_id join film f on i.film_id=f.film_id 
ORDER BY 
    f.title, payment_date;
    
-- Question (3) Determine the average rental duration for each film, considering films with similar lengths.
select * from film;
SELECT title,length,rental_duration FROM film;
select
case 
	when length <=30 then '0-30 min'
	when length <=60 then '31-60 min'
	when length <=90 then '61-90 min'
	when length <=120 then '91-120 min'
	else '120+ min'
End as length_category,
avg(Rental_duration) as `AVG Rental Duration`  from film
group by length_category
order by length_category;

-- Question (4) Identify the top 3 films in each category based on their rental counts.
select * from film;
select * from category;
select Category_Name,Title,Rental_Count from
(select C.Name as  Category_Name,f.title,count(r.rental_id) as Rental_Count,
Rank() over (partition by c.name order by count(r.rental_id) desc) as Rank_within_Category
from film f join film_category fc on f.film_id=fc.film_id join category c on fc.category_id=c.category_id 
join inventory i on f.film_id=i.film_id join rental r on i.inventory_id=r.inventory_id
group by c.name,f.title
) ranked 
where Rank_within_Category <=3
order by  Category_Name,Rental_Count DESC;
   
-- Question (6) Find the monthly revenue trend for the entire rental store over time.
select * from payment;
select date_format(Payment_date,"%Y-%M") as Month,sum(amount) as Total_revenue from payment
group by date_format(payment_date,"%Y-%M") 
order by month desc;
 
-- Question (7) Identify the customers whose total spending on rentals falls within the top 20% of all customers.
select * from customer;
select * from payment;
with Customer_spending As
(select customer_id,sum(amount) as Total_spent from payment
group by customer_id), 
Ranked_customers As 
(select Customer_id,Total_spent,row_number() over (order by total_spent desc) as rn,
count(*) over () as Total_customers from customer_spending)
select customer_id,Total_spent from Ranked_customers  where rn<=Total_customers*0.2;

-- Question (8) Calculate the running total of rentals per category, ordered by rental count.
select * from inventory;
select * from film;
select * from film_category;
select * from category;
select * from rental; 
with category_rental_count as
(select name as Category_name,count(rental_id) as Rental_count from rental r
join inventory i on r.inventory_id=i.inventory_id
join film f on i.film_id=f.film_id
join film_category fc on f.film_id=fc.film_id
join category c on fc.category_id=c.category_id
group by Category_name
),
Running_total As
(select Category_name,Rental_count,sum(rental_count) over(order by rental_count desc) as Running_total
from category_rental_count)
select * from Running_total; 

-- Question (9) Find the films that have been rented less than the average rental count for their respective categories.
with Films_rental_count as(
select f.title,c.name as category_name,count(r.rental_id) as rental_count,avg(r.rental_id) as Avg_rental_count  
from  rental r
join inventory i on r.inventory_id=i.inventory_id
join film f on i.film_id=f.film_id
join film_category fc on f.film_id=fc.film_id
join category c on fc.category_id=c.category_id
group by f.title,c.name)
select * from Films_rental_count fr
where rental_count < Avg_rental_count
order by fr.category_name, fr.Avg_rental_count desc;

-- Question (10) Identify the top 5 months with the highest revenue and display the revenue generated in each month.
select * from payment;
with Highest_revenue as (select date_format(payment_date,"%Y-%M") as Month
,Amount 
from payment)
select Month,sum(Amount) as Total_Revenue from  Highest_revenue
group by Month
order by Total_Revenue DESC
limit 5 ;
use mavenmovies;
select * from film;
-- Normalisation & CTE
-- First Normal Form (1NF):
-- a. Identify a table in the Sakila database that violates 1NF. Explain how you would normalize it to achieve 1NF.
   /*Answer : In the Sakila database (or the MavenMovies dataset which is based on it), the address table is a 
 example that violates First Normal Form (1NF).
 Let’s examine the address table. Here is a simplified version of its schema:

/*What is 1NF : 
First Normal Form (1NF) requires that:     -- Each column must contain atomic (indivisible) values.
                                           -- No repeating groups or arrays in a single column.*/
										   -- Each field contains only one value per record.

CREATE TABLE address_table (
  address_id INT PRIMARY KEY,
  address VARCHAR(50),
  address2 VARCHAR(50),
  district VARCHAR(20),
  city_id INT,
  postal_code VARCHAR(10),
  phone VARCHAR(20)
);
select * from address;
select * from address_table;
/* The address and address2 fields could be considered a violation of 1NF because they represent multiple address 
lines in the same table — potentially implying a repeating group for addresses (line 1, line 2, etc.)*/

/* Step-by-Step Normalization:To fully comply with 1NF, we would split the address lines into separate rows in a new
 table, thus ensuring that each field holds only one piece of atomic data:*/
 -- Step 1: Create a new table address_line:
 CREATE TABLE address_line (
  address_line_id INT PRIMARY KEY,
  address_id INT,
  line_number INT,
  line_text VARCHAR(50),
  FOREIGN KEY (address_id) REFERENCES address_table(address_id)
);
-- Step 2: Remove address and address2 from the original address table:
CREATE TABLE address_table1 (
  address_id INT PRIMARY KEY,
  district VARCHAR(20),
  city_id INT,
  postal_code VARCHAR(10),
  phone VARCHAR(20),
FOREIGN KEY (address_id) REFERENCES address_table(address_id),
FOREIGN KEY (address_id) REFERENCES address_line(address_id)
);  
-- Step 3: Populate address_line with one row per line:
INSERT INTO address_line (address_line_id, address_id, line_number, line_text)
VALUES 
  (1, 100, 1, '123 Main St'),
  (2, 100, 2, 'Apt 4B');

-- Question (5) CTE Basics:
/*  a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they 
have acted in from the actor and film_actor tables.*/

select * from actor;
select * from film_actor;
with actor_film_count AS(
select actor_id,count(distinct(film_id)) as Film_count from film_actor fa
group by actor_id)
select a.first_name,a.last_name,film_count from actor a join actor_film_count afc on a.actor_id=afc.actor_id
order by afc.film_count desc,a.last_name,a.first_name;

-- Question (6) CTE with Joins:
/* a. Create a CTE that combines information from the film and language tables to display the film title,
       language name, and rental rate.*/
select * from language;
with film_info as (
select film_id,Title,language_id,rental_rate from film)
select fi.title as Film_title,L.name as Language_name,fi.rental_rate from language l join film_info fi
on  l.language_id=fi.language_id
order by fi.title;

-- Question (7) CTE for Aggregation:
/* a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) 
       from the customer and payment tables.*/
select * from customer;
select * from payment;
with customers_revenue as (
select customer_id,sum(amount) as Total_revenue from payment 
group by customer_id)
select c.customer_id,concat(c.first_name,' ',c.last_name) as Customer_name,cr.Total_revenue from customer c 
join customers_revenue cr on c.customer_id=cr.customer_id
order by cr.Total_revenue desc;

-- Question (8) CTE with Window Functions:
-- a. Utilize a CTE with a window function to rank films based on their rental duration from the film table.
select * from film;
with film_rank as (
select row_number() over(order by rental_duration desc) as Rental_rank ,Film_id,Title,rental_duration from film)
select * from film_rank
order by rental_rank,title;

-- Question (9) CTE and Filtering:
 /* a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the 
		customer table to retrieve additional customer details.*/
select * from rental;
with rental_counts as (
select customer_id,count(rental_id) as rental_counts from rental
group by customer_id
having count(rental_id)>2
)
select c.customer_id,c.first_name,c.last_name,c.email,rc.rental_counts from customer c join rental_counts rc
on c.customer_id=rc.customer_id
order by rc.rental_counts DESC, c.last_name;
 
-- Question (10) CTE for Date Calculations:
/* a. Write a query using a CTE to find the total number of rentals made each month, considering the 
 rental_date from the rental table.*/
 select * from rental;
 with Monthly_rentals as (
 select count(*) as Total_rentals,date_format(rental_date,"%Y-%M") as rental_Month from rental
 group by rental_month)
 select rental_month,Total_rentals from monthly_rentals
 order by rental_month;
 
-- Question (11) CTE and Self-Join:
/* a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film 
		together, using the film_actor table.*/
select * from film_actor;
select film_id,count(actor_id) as total_actor from film_actor
group by film_id;
WITH actor_film_pairs AS (
    SELECT
        fa1.film_id,
        fa1.actor_id AS actor1_id,
        fa2.actor_id AS actor2_id
    FROM
        film_actor fa1
    JOIN
        film_actor fa2
        ON fa1.film_id = fa2.film_id
       AND fa1.actor_id < fa2.actor_id -- prevents duplicate and self-pairs
)
SELECT
    afp.film_id,
    concat(a1.first_name," ",a1.last_name) AS actor1_name,
    concat(a2.first_name," ",a2.last_name) AS actor2_name
FROM
    actor_film_pairs afp
JOIN
    actor a1 ON afp.actor1_id = a1.actor_id
JOIN
    actor a2 ON afp.actor2_id = a2.actor_id
ORDER BY
    afp.film_id, actor1_name, actor2_name;

