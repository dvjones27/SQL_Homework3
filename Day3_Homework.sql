/*1. List all customers who live in Texas (use
JOINs)*/
select customer_id , first_name , last_name , city
from customer 
full join address on customer.address_id = address.address_id 
full join city on address.city_id = city.city_id 
where district = 'Texas';

/*2. Get all payments above $6.99 with the Customer's Full
Name*/
select customer.customer_id, customer.first_name , customer.last_name , payment.amount 
from customer
full join payment on customer.customer_id = payment.customer_id 
group by customer.customer_id , customer.first_name , customer.last_name , payment.amount 
having payment.amount > 6.99
order by amount  desc;


/*3. Show all customers names who have made payments over $175(use
subqueries)*/

select store_id, first_name, last_name
from customer 
where customer_id in (
	select customer_id
	from payment
	where amount in (
		select amount
		from payment
		group by  amount
		having amount > 175 
		order by amount desc )
)

/*4. List all customers that live in Nepal (use the city
table)*/

select customer_id, first_name, last_name, city, district, country
from customer, city
full join country
on city.country_id = city.country_id 
full join address 
on city.city_id = address.city_id 
where country = 'Nepal';


--5. Which staff member had the most transactions?
select  distinct(staff.staff_id), first_name, last_name ,  
count(payment_id)
from payment
full join staff
on payment.staff_id = staff.staff_id 
group by staff.staff_id
order by count(payment_id) desc;


--6. How many movies of each rating are there?

select distinct(rating), count(distinct(rating)) as "Distinct Movie Ratings", 
count(distinct(title)) as "Distinct Movie Titles"
from film 
group by rating 
order by count(distinct(rating)) desc;


/*7.Show all customers who have made a single payment
above $6.99 (Use Subqueries)*/

select customer_id, first_name, last_name
from customer
where customer_id  in (
	select count(customer_id)
	from payment 
	where customer_id  in (
		select  amount
		from payment
		group by  amount 
		having amount > 6.99 and count(customer_id) = 1
	)
)





--8. How many free rentals did our stores give a way?
select title, rental_rate 
from film
group by rental_rate , title
having rental_rate = null or rental_rate = 0.00



