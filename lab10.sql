

/*TUTORIAL 0 SELECT BASICS*/

/*selects population tuple from world table when population== 'Germany'*/

SELECT population FROM world
  WHERE name = 'Germany'



/*selects population and name tuple from world where name is IN the list. */

SELECT name, population FROM world
  WHERE name IN ('Sweden', 'Norway', 'Denmark');


/*Selects country and area tuple from world table where the area is between the values 250000 and 300000*/

SELECT country, area FROM world
  WHERE area BETWEEN 250000 AND 300000








/*TUTORIAL 1 SELECT names*/

/*Selects name from the world table where the name starts in Y. The percent sign is a placeholder for any character/number of characters*/

SELECT name FROM world
  WHERE name LIKE 'Y%'



/*Selects name from the world table where the name ends in Y. The percent sign is a placeholder for any character/number of characters*/

SELECT name FROM world
  WHERE name LIKE '%Y'



/*Selects name from the world table where there is an x in the country name.*/
/*The percent sign is a placeholder for any character/number of characters. I place the x inbetween two percents so it finds countries with an x in the middle of the name.*/

SELECT name FROM world
  WHERE name LIKE '%x%'



/*selects name from world table. Use percent sign to say we want countries ending in land, % can be any other character or string of characters, it just has to end in land*/

SELECT name FROM world
  WHERE name LIKE '%land'



/*selects name from world table where countries start with C and end with ia. put percent sign in between to account for other characters*/

SELECT name FROM world
  WHERE name LIKE 'C%ia'


/*finds countries with oo in the name*/

SELECT name FROM world
  WHERE name LIKE '%oo%'



/*finds countries with 3 or more 'a's by using the wildcard percent character. This means the countries dont start or end with 'a'.*/

SELECT name FROM world
  WHERE name LIKE '%a%a%a%'




/*underscore acts as a wildcard for a single character so we can be more precise now. This finds countries that have 2 as the second character.*/

SELECT name FROM world
 WHERE name LIKE '_t%'
ORDER BY name



/*This finds countries that have two o's separated by two other characters. We dont care about the beginning character(s) or the end character(s)*/
/*We use underscores to say we only want two separations between the o's*/

SELECT name FROM world
 WHERE name LIKE '%o__o%'


/*This finds all countries that are exactly 4 characters long. Use the single wildcard 4 times.*/

SELECT name FROM world
 WHERE name LIKE '____'









/*TUTORIAL 2 SELECT from WORLD*/


/*selects the name, continent and population tuple from world table.*/

SELECT name, continent, population FROM world



/*Selects countries from world table that have a population of atleast 200 million*/

SELECT name FROM world
WHERE population >= 200000000




/*selects the country name and per capita gdp by dividing the gdp by the population*/

SELECT name, gdp/population FROM world
WHERE population >= 200000000



/*selects the name and population in millions of countries in south america.*/


SELECT name, population/1000000 
FROM world
WHERE continent = 'South America'



/*selects name and population where name is in the list france germany or italy.*/

SELECT name, population 
FROM world
WHERE name IN ('France', 'Germany', 'Italy');



/*Selects countries from world table that have 'United' in their name. We utilize the wildcard character and the LIKE keyword*/

SELECT name
FROM world
WHERE name LIKE '%United%'



/*Selects name population and area from world table when area is greater than 3 mil or population is greate than 250 mil*/

SELECT name, population, area
FROM world
WHERE area > 3000000 OR population > 250000000



/*Selects name population and area from world table when area is greater than 3 mil or population is greate than 250 mil BUT not both.*/

SELECT name, population, area
FROM world
WHERE area > 3000000 XOR population > 250000000



/*Selects name, pop by millions, gpd by billions from thr world table from countries in south america. We use the round function to round the pop and gdp*/

SELECT name, ROUND(population/1000000,2), ROUND(gdp/1000000000,2)
FROM world
WHERE continent = 'South America'




/*Selects the name and rounded GDP for the countries with a gdp of atleast 1 trillion. We use negative numbers in the rounding function to round to the nearest Thousandths place*/

SELECT name, ROUND(gdp/population,-3)
FROM world
WHERE gdp >= 1000000000000


/*selects the name and capital tuples when the name and capital have the same length of characters. We use the LENGTH function to achieve this*/

SELECT name, capital 
  FROM world
 WHERE LENGTH(name) = LENGTH(capital)




/*Selects name and capital where name and capital both start with the same letter but arent the same entirely.*/
/*We use LEFT function which isolates characters. 1 isolates the first character, 2 isolates the first two characters and so on.*/

SELECT name, capital
FROM world 
WHERE LEFT(name,1) = LEFT(capital,1) AND name <> capital




/*selects all countries that have all the vowels in their name but no spaces. We use the NOT LIKE function to get rid of the space*/

SELECT name
   FROM world
WHERE name LIKE '%a%' AND name LIKE '%e%' AND name LIKE '%i%' AND name LIKE '%o%' AND name LIKE '%u%'
  AND name NOT LIKE '% %'







/*TUTORIAL 3 SELECT from Nobel*/





/*selects year, subject and winner for winners in year 1950*/


SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950



/*Selects the winner from nobel table where year is 1962 and subject is literature*/

SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature'



/*Selects the year and subject that albert einstein won*/

SELECT yr, subject
  FROM nobel
 WHERE winner = 'Albert Einstein'



/*Selects peace winners*/

SELECT winner
  FROM nobel
 WHERE yr >=2000 AND subject = 'Peace'


/*Selects all tuples from the years 1980 to 1989 where subject is literature*/

SELECT *
  FROM nobel
 WHERE yr >=1980 AND yr <=1989 AND subject = 'Literature'




/*selecting from a list of presidents. We use the IN function.*/

SELECT * FROM nobel
 WHERE winner IN ('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter', 'Barack Obama');




/* selecting winners with first name john using the wildcard character*/

SELECT winner FROM nobel
 WHERE winner LIKE 'John%'



/*Selecting winners from year 1980 for physics and year 1984 for chem.*/

SELECT yr,subject,winner
FROM nobel
WHERE yr = 1980 AND subject = 'Physics' OR yr = 1984 AND subject = 'Chemistry'




/*Selects year subject and name for winners of 1980 exlcuding chem and medicine*/

SELECT yr,subject,winner
FROM nobel
WHERE yr = 1980 AND subject <> 'Chemistry' AND subject <> 'Medicine'




/*Selects winner before 1910 for medicine and after 2004 inlcuding 2004 for lit*/

SELECT yr,subject,winner
FROM nobel
WHERE yr < 1910 AND subject = 'Medicine' OR yr >= 2004 AND subject = 'Literature'





/*TUTORIAL 4 SELECT within SELECT*/



/*selects countries that have a larger population than russia. We use select to get the population of russia to plug into our where clause*/

SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')




/*select within a select. We use the second select to get our gdp/pop that we want to filter by*/


SELECT name FROM world
  WHERE continent = 'Europe' AND gdp/population >
     (SELECT gdp/population FROM world
      WHERE name='United Kingdom')



/*Here our inner select clause returns more than one row so our outer select will be picking from a list so we need to use the IN keyword*/

SELECT name, continent 
FROM world
WHERE continent IN 
     (SELECT continent FROM world
      WHERE name='Argentina' OR name ='Australia')
ORDER BY name



/*Here we have to do two inner select statements to get the population for canada and poland since we are using both to filter the name and pop table we are trying to return*/

SELECT name, population
FROM world
WHERE population > (SELECT population FROM world WHERE name = 'Canada') AND population < (SELECT population FROM world WHERE name = 'Poland')




/*Here we multiply pop by 100 and divide it by germanys population to get a percentage*/
/*we have to use concat to add the percentage symbol, just basically adding the percentage symbol to the end.*/

SELECT name, CONCAT(ROUND(100*POPULATION/(SELECT population FROM world WHERE name='Germany')),'%')
FROM world
WHERE continent = 'Europe'



/*Here we just need to use the MAX function to get the largest gdp in europe*/

SELECT name
FROM world
WHERE gdp > (SELECT MAX(gdp) FROM world WHERE continent = 'Europe')



/*Here we need to use correlated subqueries to essentially loop through*/

SELECT x.continent, x.name, x.area
FROM world AS x
WHERE x.area = (
  SELECT MAX(y.area)
  FROM world AS y
  WHERE x.continent = y.continent)



/*Here we need to use correlated subqueries again to loop through continents*/

Select  x.continent, x.name
From world x
Where x.name <= ALL (select y.name from world y where x.continent=y.continent)
ORDER BY continent




/*TUTORIAL 5 SUM and COUNT*/

/*shows total pop of the world*/

SELECT SUM(population)
FROM world


/*shows each continent once by using DISTINCT function*/

SELECT DISTINCT(continent)
FROM world


/*used the SUM function to get total gdp of africa*/

SELECT SUM(gdp)
FROM world
WHERE continent = 'Africa'


/*Counts the number of countries with an area of atleast 1000000*/

SELECT COUNT(name)
FROM world
WHERE area >= 1000000



/*Gets total pop of 'Estonia', 'Latvia', 'Lithuania' by using a list and the SUM function*/

SELECT SUM(population)
FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania');


/*gets all the continents and the number of countries by using COUNT on name and then we group by continent*/

SELECT continent, COUNT(name) 
FROM world 
GROUP BY continent



/*Here we do essentially the same thing except we filter by only taking countries with pop over 10 mil*/

SELECT continent, COUNT(name) 
FROM world
WHERE population > 10000000
GROUP BY continent


/*Here we filter by pop being over 100 mil for the contintinents by using the HAVING function in conjunction with the SUM function*/

SELECT continent 
FROM world
GROUP BY continent
HAVING SUM(population) >= 100000000






