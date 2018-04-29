-- Analytic query AQ10
-- Rank locations by delay rate for the contract promised date
-- Partition ranking by year of date promised
-- Delay rate calculated as SUM(Quantity_Ordered - SumDelayShipQty) / 
--                          SUM(Quantity_Ordered)
-- Uses LastShipmentDelays view (based on BQ5)

SELECT Location_Name, W_Time_D.Time_Year, 
       COUNT(*) AS NumJobs,
       SUM(BusDaysDiff) as SumDelayDays,
       SUM(Quantity_Ordered - SumDelayShipQty) / SUM(Quantity_Ordered) 
        AS PromisedDelayRate,
  RANK() OVER ( PARTITION BY W_Time_D.Time_Year 
    ORDER BY SUM(Quantity_Ordered - SumDelayShipQty) / 
             SUM(Quantity_Ordered) DESC) AS RankDelayRate
 FROM LastShipmentDelays, W_Time_D
 WHERE W_Time_D.Time_Id = LastShipmentDelays.Date_Promised
 GROUP BY Location_Name, W_Time_D.Time_Year;
