-- Analytic query AQ9
-- Rank locations by sum of business days delayed 
-- Partition ranking by year of date promised
-- Use both rank and dense_rank functions
-- Uses FirstShipmentDelays view (based on BQ6)

SELECT Location_Name, W_Time_D.Time_Year, 
       SUM(BusDaysDiff) as SumDelayDays,
  RANK() OVER ( PARTITION BY W_Time_D.Time_Year 
    ORDER BY SUM(BusDaysDiff) DESC) AS RankSumDelayDays,
  DENSE_RANK() OVER ( PARTITION BY W_Time_D.Time_Year 
    ORDER BY SUM(BusDaysDiff) DESC) AS RankSumDelayDays
 FROM FirstShipmentDelays, W_Time_D
 WHERE W_Time_D.Time_Id = FirstShipmentDelays.Date_Ship_By
 GROUP BY Location_Name, W_Time_D.Time_Year;
 
 
 -- Analytic query AQ9
-- Rank locations by sum of business days delayed 
-- Partition ranking by year of shipped by date
-- Use both rank and dense_rank functions


-- Uses FirstShipmentDelays view (based on BQ6)

SELECT Location_Name, W_Time_D.Time_Year, 
       SUM(BusDaysDiff) as SumDelayDays,
  RANK() OVER ( PARTITION BY W_Time_D.Time_Year 
    ORDER BY SUM(BusDaysDiff) DESC) AS RankSumDelayDays,
  DENSE_RANK() OVER ( PARTITION BY W_Time_D.Time_Year 
    ORDER BY SUM(BusDaysDiff) DESC) AS RankSumDelayDays
 FROM FirstShipmentDelays, W_Time_D
 WHERE W_Time_D.Time_Id = FirstShipmentDelays.Date_Ship_By
 GROUP BY Location_Name, W_Time_D.Time_Year;