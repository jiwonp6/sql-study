-- Ex. 그룹화 연습문제(world 스키마)
USE world;
SELECT * FROM country;
SELECT * FROM city;
SELECT * FROM countryLanguage;

-- 문제 1: Country 테이블에서 각 대륙(Continent)별 국가 수를 계산하세요.
SELECT continent, count(*) 
	FROM country
    GROUP BY continent;

-- 문제 2: Country 테이블에서 각 대륙별 총 인구수(Population)를 계산하고, 총 인구수가 많은 대륙부터 내림차순으로 정렬하세요.
SELECT continent, sum(population) 
	FROM country
    GROUP BY continent
    ORDER BY sum(population) DESC;

-- 문제 3: City 테이블에서 각 국가 코드(CountryCode)별로 가장 인구가 많은 도시의 인구수를 조회하세요. 상위 5개 결과만 보여주세요.
SELECT countryCode, max(population) 
	FROM city
    GROUP BY countryCode
    ORDER BY max(population) DESC
    LIMIT 5;

-- 문제 4: CountryLanguage 테이블에서 각 언어(Language)가 사용되는 국가 수를 계산하고, 가장 많이 사용되는 언어부터 내림차순으로 정렬하여 상위 3개 언어를 조회하세요.
SELECT language, count(countryCode) 
	FROM countryLanguage
    GROUP BY language
    ORDER BY count(countryCode) DESC
    LIMIT 3;

-- 문제 5: Country 테이블에서 모든 국가의 총 인구수(Population)를 계산하세요.
SELECT sum(population)
	FROM country;
    
-- 문제 6: Country 테이블에서 GDP(국내 총생산, GNP * Population)가 가장 높은 상위 5개 국가를 조회하세요.
SELECT name, gnp * population 'GDP'
	FROM country
    ORDER BY GDP DESC
    LIMIT 5;

-- 문제 7: Country 테이블에서 정부 형태(GovernmentForm)별 평균 생명 기대치(LifeExpectancy)를 계산하고, 생명 기대치가 높은 순으로 정렬하세요.
SELECT governmentForm, avg(lifeExpectancy)
	FROM country
    GROUP BY governmentForm
    ORDER BY governmentForm DESC;

-- 문제 8: Country 테이블에서 각 대륙별로 평균 인구수가 5000만 이상인 대륙과 해당 평균 인구수를 조회하세요.
SELECT continent, avg(population)
	FROM country
    GROUP BY continent
    HAVING avg(population) >= 50000000;

-- 문제 9: CountryLanguage 테이블에서 언어별로 사용하는 국가 수가 5개 이상인 언어와 해당 국가 수를 조회하세요.
SELECT language, count(countryCode)
	FROM countryLanguage
    GROUP BY language
    HAVING count(countryCode) >= 5;

-- 문제 10: Country 테이블에서 각 대륙별로 총 GNP가 100만 이상인 대륙과 해당 총 GNP를 조회하세요.
SELECT continent, sum(gnp)
	FROM country
    GROUP BY continent
    HAVING sum(gnp) >= 1000000;

-- 문제 11: Country 테이블에서 대륙(Continent)과 정부 형태(GovernmentForm)별로 국가 수를 집계하고, 
-- 대륙별 국가 수 및 전체 국가 수를 포함한 결과를 조회하세요.
SELECT continent, governmentForm, count(name)
	FROM country
    GROUP BY continent, governmentForm
    WITH ROLLUP;
