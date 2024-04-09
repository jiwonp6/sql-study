-- Ex 서브쿼리 문제
USE sakila;

-- 문제1. 총 결제 금액이 $100을 초과하는 모든 고객의 이름과 성을 조회하세요.
-- 사용 테이블: customer (customer_id, first_name, last_name), payment (payment_id, customer_id, amount)
SELECT c.first_name, c.last_name, cp.sum
	FROM customer c, (SELECT customer_id, sum(amount) 'sum' FROM payment GROUP BY customer_id) cp
    WHERE c.customer_id = cp.customer_id AND cp.sum > 100;

-- 문제2. 5개 이상의 영화를 대여한 모든 고객의 이름과 성을 조회하세요.
-- 사용 테이블: customer (customer_id, first_name, last_name), rental (rental_id, customer_id)
SELECT c.first_name, c.last_name, cr.count
	FROM customer c, (SELECT customer_id, count(rental_id) 'count' FROM rental GROUP BY customer_id) cr
    WHERE c.customer_id = cr.customer_id AND cr.count > 5;

-- 문제3. 5편 이상의 영화에 출연한 모든 배우의 이름과 성을 조회하세요.
-- 사용 테이블: actor (actor_id, first_name, last_name), film_actor (actor_id, film_id)
SELECT a.first_name, a.last_name, fc.count
	FROM actor a, (SELECT actor_id, count(film_id) count FROM film_actor GROUP BY actor_id) fc
    WHERE a.actor_id = fc.actor_id AND fc.count >= 5;

-- 문제4. 평균 영화 길이보다 긴 모든 영화의 제목을 조회하세요.
-- 사용 테이블: film (film_id, title, length)
SELECT title
	FROM film
    WHERE length > (SELECT avg(length) FROM film);

-- 문제5. 평균 대여 비용보다 높은 대여 비용을 가진 모든 영화의 제목과 대여 비용을 조회하세요.
-- 사용 테이블: film (film_id, title, rental_rate)
SELECT title, rental_rate
	FROM film
    WHERE rental_rate > (SELECT avg(rental_rate) FROM film);

-- 문제6. 각 영화에 출연한 배우의 수와 함께 영화 제목을 조회하세요. (SELECT절 사용)
-- 사용 테이블: film (film_id, title), film_actor (actor_id, film_id)
SELECT f.title, fc.count
	FROM film f
    JOIN (SELECT film_id, count(actor_id) 'count' FROM film_actor GROUP BY film_id) fc
	USING (film_id);
    
-- 문제7. 영화를 제일 많이 빌린 고객의 총 영화 대여 횟수를 조회하세요. (FROM절 사용)
-- 사용 테이블: rental (rental_id, customer_id)
-- 서브쿼리
SELECT customer_id, count(rental_id)
	FROM rental
	GROUP BY customer_id;
-- 메인쿼리
SELECT max(rc.count)
	FROM (SELECT customer_id, count(rental_id) count FROM rental GROUP BY customer_id) rc;
