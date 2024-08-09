-- Install the HTTPS extension.
INSTALL https;
LOAD httpfs;

SET s3_region='us-east-1';

DROP TABLE IF EXISTS netflix_daily_top_10;
CREATE TABLE netflix_daily_top_10 AS 
SELECT * 
FROM read_parquet('s3://duckdb-md-dataset-121/netflix_daily_top_10.parquet');

SHOW netflix_daily_top_10;

-- List the top 5 TV shows by the number of days they were in the top 10.
SELECT Title, MAX("Days In Top 10")
FROM netflix_daily_top_10
WHERE Type = 'TV Show'
GROUP BY Title
ORDER BY MAX("Days In Top 10") DESC
LIMIT 5;

-- List the top 5  movies by the number of days they were in the top 10 and save the results to a CSV file.
COPY (
SELECT Title, MAX("Days In Top 10") AS "Days In Top 10"
FROM netflix_daily_top_10
WHERE Type = 'Movie'
GROUP BY Title
ORDER BY MAX("Days In Top 10") DESC
LIMIT 5
) TO 'output/netflix_top_5_movies.csv' (HEADER, DELIMITER ',');