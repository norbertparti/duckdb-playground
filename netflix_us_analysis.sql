-- Load the CSV file.
SELECT * 
FROM read_csv_auto('data/netflix_daily_top_10.csv');

-- Create a table from a CSV file.
CREATE TABLE netflix_daily_top_10 AS
FROM read_csv_auto('data/netflix_daily_top_10.csv');

SHOW TABLES;

-- Savw the table to a CSV file.
COPY netflix_daily_top_10 TO 'output/netflix_daily_top_10.csv' (HEADER, DELIMITER ',');

-- Save the table to a Parquet file.
COPY netflix_daily_top_10 TO 'output/netflix_daily_top_10.parquet' (FORMAT PARQUET);

-- Load the Parquet file and output in markdown format.
.mode markdown
SELECT * FROM read_parquet('output/netflix_daily_top_10.parquet');

-- Convert the CSV file to a Parquet file.
COPY (FROM read_csv_auto('data/netflix_daily_top_10.csv'))
TO 'output/converted_netflix_daily_top_10.parquet' (FORMAT PARQUET);