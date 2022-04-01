USE albums_db;
SHOW TABLES;
-- shows tables in DB
DESCRIBE albums;
-- shows table attributes
SELECT * FROM albums;
-- shows all info in table
-- 3. Explore table structure
-- 3a. how many rows of data are in the albums table? 31
SELECT COUNT(*) FROM albums;
-- 3b. how many unique artist names in the table? 23
SELECT COUNT(DISTINCT artist) FROM albums;
-- 3c. what is the primary key for the albums in the table? ID
SHOW KEYS FROM albums where Key_name = 'Primary' ; -- column name = id
-- 3d. what is the oldest release for any albums in the albums table? most recent?
SELECT min(release_date) FROM albums; -- 1967
-- alt solution: SELECT min(release_date) AS earliest_album FROM albums; #uses alias
-- ways to solve for further process: provide entire row as output, or just release date value.
SELECT max(release_date) FROM albums; -- 2011
-- 4. Queries
-- a. The name of all albums by Pink Floyd
SELECT name
FROM albums
WHERE artist = ('Pink Floyd');
-- b. Year SGT Pepper released
SELECT release_date
FROM albums
WHERE name = ("Sgt. Pepper's Lonely Hearts Club Band");
-- c. Genre for nevermind
SELECT genre 
FROM albums 
WHERE name = ('Nevermind');
-- d. which albums were released in the 1990s
SELECT name
FROM albums
WHERE release_date BETWEEN 1990 AND 1999;
# alt solution: 
# WHERE release_date >= 1990
# AND release_date < 2000
-- CHECK the answer with the code below:
SELECT release_date FROM albums WHERE release_date BETWEEN 1990 and 1999;

-- e. albums with less than 20 million sales:
SELECT name 
FROM albums 
WHERE sales < 20;

-- f. albums in Rock genre
SELECT 
    name
FROM
    albums
WHERE
    genre = ('rock');
-- too constraining, ignores pop rock, etc
SELECT name, genre
FROM albums
WHERE genre LIKE '%rock%';
-- gives broader search
SELECT
    name, genre
FROM
    albums
WHERE
    genre = ‘Rock’
		or genre LIKE ‘Rock,%’
        or genre LIKE ‘%, Rock, %’
        or genre LIKE ‘%, Rock’
-- this yields the best search