-- Analytic query 2 (AQ2)
-- Moving average over current row and 11 preceding rows of average amount 
-- Partitioned by location name
-- Ordering criteria by year and month

SELECT Location_Name, Time_Year, Time_Month,
  AVG( QUANTITY_ORDERED * Unit_Price ) AS AvgJobAmount ,
  AVG( AVG( QUANTITY_ORDERED * Unit_Price ) )
   OVER ( PARTITION BY  Location_Name 
   ORDER BY Time_Year, Time_Month 
   ROWS BETWEEN 11 PRECEDING AND CURRENT ROW ) AS MovAvgAmtOrdered
 FROM W_JOB_F, W_Location_D, W_TIME_D
 WHERE W_Location_D.Location_ID = W_Job_F.Location_Id
   AND W_JOB_F.CONTRACT_DATE = W_TIME_D.Time_ID
 GROUP BY Location_Name, Time_Year, Time_Month;