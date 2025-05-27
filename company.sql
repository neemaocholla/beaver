CREATE SCHEMA company;
CREATE Table company.employees_table(
	employee_id BIGINT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    gender VARCHAR(10),
    department VARCHAR(100),
	hire_date DATE,
    salary DECIMAL (7,2) NOT NULL
		
);

INSERT INTO company.employees_table (employee_id,first_name, last_name,gender,department,hire_date,salary) 
VALUES
	(1,'John','Doe','Male','IT','2018-05-01',60000.00),
    (2,'Jane','Smith','Female','HR','2019-06-15',50000.00),
    (3,'Micheal','Johnson','Male','Finance','2017-03-10',75000.00),
    (4,'Emily','Davis','Female','IT','2020-11-20',70000.00),
    (5,'Sarah','Brown','Female','Marketing','2016-07-30',45000.00),
    (6,'David','Wilson','Male','Sales','2019-01-05',55000.00),
    (7,'Chris','Taylor','Male','IT','2022-02-25',65000.00);


CREATE Table company.products_table(
	product_id BIGINT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(100) NOT NULL,
    price DECIMAL (5,2) NOT NULL,
    stock INT

);

INSERT INTO company.products_table (product_id,product_name,category,price,stock) VALUES
	(1,'Laptop','Electronics',1200.00,30),
    (2,'Desk','Furniture',300.00,50),
    (3,'Chair','Furniture',150.00,200),
    (4,'Smartphone','Electronics',800.00,75),
    (5,'Monitor','Electronics',250.00,40),
    (6,'Bookshelf','Furniture',100.00,60),
    (7,'Printer','Electronics',200.00,25);


CREATE Table company.sales_table(
	sale_id BIGINT PRIMARY KEY,
    product_id BIGINT REFERENCES company.products_table(product_id),
    employee_id BIGINT REFERENCES company.employees_table(employee_id),
    sale_date DATE NOT NULL,
    quantity BIGINT NOT NULL,
    total DECIMAL (5,2) NOT NULL,

);

INSERT INTO company.sales_table (sale_id,product_id,employee_id,sale_date,quantity,total) VALUES
	(1,1,1,'2021-01-15',2, 2400.00,),
    (2,2,2,'2021-03-22',1, 300.00,),
    (3,3,3,'2021-05-10',4, 600.00,),
    (4,4,4,'2021-07-18',3, 2400.00,),
    (5,5,5,'2021-09-25',2, 500.00,),
    (6,6,6,'2021-11-30',1, 100.00,),
    (7,7,1,'2022-02-15',1, 200.00,),
    (8,1,2,'2022-04-10',1, 1200.00,),
    (9,2,3,'2022-06-20',2,  600.00,),
    (10,3,4,'2022-08-05',3, 450.00,),
    (11,4,5,'2022-10-11',1, 800.00,),
    (12,5,6,'2022-12-29',4, 1000.00,),


-- 1. Select all columns from the Employees table. 
SELECT * FROM  company.employees_table;

-- 2.Select the first names of all employees.
SELECT first_name  FROM company.employees_table;


-- 3.Select distinct departments from the Employees table.
SELECT DISTINCT department FROM company.employees_table;


-- 4.Select the total number of employees.
SELECT COUNT(*) AS total_employees FROM company.employees_table;


-- 5.Select the total salary paid to all employees.
SELECT SUM(salary) AS total_salary FROM company.employees_table;


-- 6.Select the average salary of all employees.
SELECT AVG(salary) AS average_salary FROM company.employees_table;


-- 7.Select the highest salary in the Employees table.                                                                              
SELECT MAX(salary) AS highest_salary FROM company.employees_table;


-- 8.Select the lowest salary in the Employees table.
SELECT MIN(salary) AS lowest_salary FROM company.employees_table;


-- 9.Select the total number of male employees.
SELECT COUNT(*) AS total_male_employees  FROM company.employees_table WHERE gender = 'Male';


-- 10.Select the total number of female employees.
SELECT COUNT(*) AS total_female_employees FROM company.employees_table WHERE gender = 'Female';


--11. Select the total number of employees hired in the year 2020.
SELECT COUNT(*) AS employees_hired_2020 
FROM company.employees_table
WHERE hire_date BETWEEN '2020-01-01' AND '2020-12-31';


--12. Select the average salary of employees in the 'IT' department.
SELECT AVG(salary) AS avg_salary_it 
FROM company.employees_table
WHERE department = 'IT';


--13. Select the number of employees in each department.
SELECT department, COUNT(*) AS employee_count 
FROM company.employees_table
GROUP BY department;


--14. Select the total salary paid to employees in each department.
SELECT department, SUM(salary) AS total_salary
FROM company.employees_table
GROUP BY department;


--15.Select the maximum salary in each department.
SELECT department, MAX(salary) AS max_salary
FROM company.employees_table
GROUP BY department;


-- 16.Select the minimum salary in each department.
SELECT department, MIN(salary) AS min_salary
FROM company.employees_table
GROUP BY department;

-- 17.Select the total number of employees, grouped by gender.
SELECT gender, COUNT(*) AS employee_count
FROM company.employees_table
GROUP BY gender;


-- 18.Select the average salary of employees, grouped by gender.
SELECT gender, AVG(salary) AS avg_salary
FROM company.employees_table
GROUP BY gender;


-- 19.Select the top 5 highest-paid employees.
SELECT * 
FROM company.employees_table
ORDER BY salary DESC 
LIMIT 5;

--20. Select the total number of unique first names in the Employees table.
SELECT COUNT(DISTINCT first_name) AS unique_first_names FROM company.employees_table;


-- 21.Select all employees and their corresponding sales.
SELECT e.*, s.sale_id, s.product_id, s.sale_date, s.quantity, s.total
FROM company.employees_table e
LEFT JOIN company.sales_table s ON e.employee_id = s.employee_id;


-- 22.Select the first 10 employees hired, ordered by their HireDate.
SELECT * 
FROM company.employees_table
ORDER BY hire_date ASC 
LIMIT 10;

-- 23.Select the employees who have not made any sales.
SELECT e.*
FROM company.employees_table e
LEFT JOIN company.sales_table s ON e.employee_id = s.employee_id
WHERE s.sale_id IS NULL;
-- WHERE s.employee_id IS NULL;

--24.Select the total number of sales made by each employee.
SELECT e.employee_id, e.first_name, e.last_name, COUNT(s.sale_id) AS num_sales
FROM company.employees_table e
LEFT JOIN company.sales_table s ON e.employee_id = s.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name;


-- 25.Select the employee who made the highest total sales.
SELECT e.employee_id, e.first_name, e.last_name, SUM(s.total) AS total_sales
FROM company.employees_table e
JOIN company.sales_table s ON e.employee_id = s.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY total_sales DESC
LIMIT 1;


--26. Select the average quantity of products sold by employees in each department.
SELECT e.department, AVG(s.quantity) AS avg_quantity_sold
FROM company.employees_table e
JOIN company.sales_table s ON e.employee_id = s.employee_id
GROUP BY e.department;


--27. Select the total sales made by each employee in the year 2021.
SELECT e.employee_id, e.first_name, e.last_name, SUM(s.total) AS total_sales_2021
FROM company.employees_table e
JOIN company.sales_table s ON e.employee_id = s.employee_id
WHERE s.sale_date BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY e.employee_id, e.first_name, e.last_name;


--28. Select the top 3 employees with the most sales in terms of quantity.
SELECT e.employee_id, e.first_name, e.last_name, SUM(s.quantity) AS total_quantity
FROM company.employees_table e
JOIN company.sales_table s ON e.employee_id = s.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY total_quantity DESC
 LIMIT 3;


-- 29.Select the total quantity of products sold by each department.
SELECT e.department, SUM(s.quantity) AS total_quantity_sold
FROM company.employees_table e
JOIN company.sales_table s ON e.employee_id = s.employee_id
GROUP BY e.department;


--30. Select the total revenue generated by sales of products in each category.
-- (Assuming Price is the unit price in the Products table)
SELECT p.category, SUM(s.total) AS total_revenue
FROM company.sales_table s
JOIN company.products_table p ON s.product_id = p.product_id
GROUP BY p.category;