-- JOIN 연습문제
USE sakila;

-- 문제 1: 고객(customer)의 이름과 그들이 대여(rental)한 영화(film)의 제목을 조회하세요.
-- 사용 테이블: customer(customer_id, first_name, last_name), rental(rental_id, customer_id, inventory_id), film(film_id, title), inventory(inventory_id, film_id)
SELECT first_name, last_name, f.title
	FROM customer c
    JOIN rental r ON c.customer_id = r.customer_id
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    WHERE r.return_date is NULL;

-- 문제 2: 각 영화(film)의 제목과 해당 영화가 속한 카테고리(category)의 이름을 조회하세요.
-- 사용 테이블: film(film_id, title), film_category(film_id, category_id), category(category_id, name)
SELECT f.title, c.name
	FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id;

-- 문제 3: 각 영화(film)에 대해 몇 명의 배우(actor)가 출연했는지, 영화 제목과 함께 조회하세요.
-- 사용 테이블: film(film_id, title), film_actor(film_id, actor_id)
SELECT f.title, count(fa.actor_id) 'number of performers'
	FROM film f
    JOIN film_actor fa ON f.film_id = fa.film_id
    GROUP BY fa.film_id;

-- 문제 4: 모든 대여(rental) 정보에 대해, 해당 대여가 이루어진 스토어(store)의 ID와 직원(staff)의 이름을 조회하세요.
-- 사용 테이블: rental(rental_id, staff_id), store(store_id), staff(staff_id, first_name, last_name, store_id)
SELECT r.rental_id, s.store_id, s.first_name, s.last_name
	FROM rental r
    JOIN staff s ON r.staff_id = s.staff_id;

-- 문제 5: 가장 많이 대여된 영화 5개의 제목과 대여 횟수를 조회하세요.
-- 사용 테이블: film(film_id, title), inventory(inventory_id, film_id), rental(rental_id, inventory_id)
SELECT f.title, count(r.rental_id) 'Number of rentals'
	FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    GROUP BY f.film_id
    ORDER BY count(r.rental_id) DESC
    LIMIT 5;

-- 문제 6: 각 고객(customer)별로 그들이 지불한 총 금액(payment)을 조회하세요.
-- 사용 테이블: customer(customer_id, first_name, last_name), payment(payment_id, customer_id, amount)
SELECT c.first_name, c.last_name, sum(amount) 'The total amount'
	FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id;

-- 문제 7: 각 카테고리(category)별로 대여된 영화의 총 수를 조회하세요.
-- 사용 테이블: category(category_id, name), film_category(film_id, category_id), inventory(inventory_id, film_id), rental(rental_id, inventory_id)
SELECT c.name, count(i.film_id) 'number of rentals'
	FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film_category fc ON i.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    WHERE r.return_date is NULL
    GROUP BY c.category_id;

-- 문제 8: 2005년 7월에 대여된 모든 영화의 제목과 대여 날짜를 조회하세요.
-- 사용 테이블: rental(rental_id, rental_date, inventory_id), inventory(inventory_id, film_id), film(film_id, title)
SELECT f.title, r.rental_date
	FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    WHERE r.rental_date BETWEEN '2005-07-01' AND '2005-07-31';

-- 문제 9: 'Comedy' 카테고리에 속하는 영화들의 평균 대여 기간(rental_duration)을 조회하세요.
-- 사용 테이블: category(category_id, name), film_category(film_id, category_id), film(film_id, title, rental_duration)
SELECT c.name 'category name', avg(f.rental_duration) 'Average rental period'
	FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    WHERE c.name = 'Comedy';

-- 문제 10: 모든 배우(actor)의 이름과 그들이 출연한 영화(film)의 수를 조회하세요. (LEFT JOIN 사용)
-- 사용 테이블: actor(actor_id, first_name, last_name), film_actor(actor_id, film_id), film(film_id)
SELECT a.first_name, a.last_name, count(f.film_id) 'Number of films featured'
	FROM actor a
    LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
    LEFT JOIN film f ON fa.film_id = f.film_id
    GROUP BY a.actor_id;
    