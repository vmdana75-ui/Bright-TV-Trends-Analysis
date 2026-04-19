select * from `workspace`.`default`.`viewership` limit 100;







-- Find distinct channels --
Select DISTINCT channel
FROM `workspace`.`default`.`viewership`;








-- Find the period of the dataset --
SELECT MIN (record_Date),
       MAX (record_Date)
FROM `workspace`.`default`.`viewership`;









-- Find the most viewed channel--
SELECT channel,
       COUNT (channel) AS `most viewed channels`
FROM `workspace`.`default`.`viewership`
GROUP BY channel
ORDER BY `most viewed channels` DESC;









-- FIND time of the the day the most content is viewed
SELECT HOUR (record_Date) AS hour,
       COUNT (*) AS views
FROM `workspace`.`default`.`viewership`
GROUP BY hour;









--Time segments of the day--
SELECT 
      CASE WHEN HOUR (record_Date) BETWEEN 0 AND 6 THEN 'Midnight to early morning'
           WHEN HOUR (record_Date) BETWEEN 6 AND 12 THEN 'Early morning to midday'
           WHEN HOUR (record_Date) BETWEEN 12 AND 18 THEN 'Midday to evening'
           WHEN HOUR (record_Date) BETWEEN 18 AND 24 THEN 'Evening to midnight' 
           ELSE 'Invalid'
           END AS `time classification`,
       COUNT(*) AS views
FROM `workspace`.`default`.`viewership`
GROUP BY `time classification`;










-- Find the time of the day each channel is most viewed --
SELECT channel,
       HOUR (record_Date) AS hour,
       COUNT (*) AS views
FROM `workspace`.`default`.`viewership`
GROUP BY channel, HOUR (record_Date);









-- Find the Province which has the most subscribers and remove blank row--
SELECT Province,
       COUNT (Province) AS subscribers
FROM `workspace`.`default`.`user_profiles`
GROUP BY Province
ORDER BY subscribers DESC;






-- Find the average age of users in each province--
SELECT Province,
       AVG (Age) AS avg_age
FROM `workspace`.`default`.`user_profiles`
GROUP BY Province;






-- FIND the days in a week where there is the highest consumption-- 
SELECT DAYOFWEEK (record_Date) AS day,
       COUNT (*) AS `number of views`
FROM `workspace`.`default`.`viewership`
GROUP BY DAYOFWEEK (record_Date);





-- Find the gender with the most subscribers--
SELECT Gender,
       COUNT (Gender) AS subscribers
FROM `workspace`.`default`.`user_profiles`
GROUP BY Gender;





-- Find the race with the most subscribers--
SELECT Race,
       COUNT (Race) AS subscribers
FROM `workspace`.`default`.`user_profiles`
GROUP BY Race;





-- Joint table to find the gender that consumes the most content--
SELECT Gender,
       channel,
       COUNT (*) AS `number of views`
FROM `workspace`.`default`.`user_profiles`
INNER JOIN `workspace`.`default`.`viewership`
        ON `workspace`.`default`.`user_profiles`.`UserID` = `workspace`.`default`.`viewership`.`userid`
GROUP BY Gender, Province, channel
ORDER BY `number of views` DESC
LIMIT 10;
