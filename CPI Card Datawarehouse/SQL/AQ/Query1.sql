-- Analytic Query 1 (AQ1)
-- Cumulative amount ordered by location, year, and month 

SELECT
  Location_Name, Time_Year, Time_Month,
  SUM ( QUANTITY_ORDERED * Unit_Price ) AS SumJobAmt,
  SUM ( SUM ( QUANTITY_ORDERED * Unit_Price ) ) 
    OVER ( PARTITION BY Location_Name, Time_Year 
      ORDER BY Time_Month
      ROWS UNBOUNDED PRECEDING ) AS CumSumAmt
FROM W_JOB_F, W_Location_D, W_TIME_D
WHERE W_Location_D.Location_ID = W_Job_F.Location_Id
  AND W_JOB_F.CONTRACT_DATE = W_TIME_D.Time_ID
GROUP BY Location_Name, Time_Year, Time_Month;