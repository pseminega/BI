-- BQ6 in the quality control area
-- Jobs with delays in the first shipment date (Date_Ship_By)
-- Requires a nested query in the FROM clause to determine first shipment date

SELECT W_JOB_F.job_ID,
  W_JOB_F.SALES_CLASS_ID, Sales_Class_Desc,
  W_JOB_F.LOCATION_ID, Location_Name,
  Date_Ship_By, 
  FirstShipDate,
  GetBusDaysDiff ( date_ship_By, FirstShipDate ) AS BusDaysDiff
FROM W_JOB_F, W_Location_D, W_Sales_Class_D,
  (SELECT W_SUB_JOB_F.JOB_ID, MIN(actual_ship_Date) as FirstShipDate
   FROM W_JOB_SHIPMENT_F, W_SUB_JOB_F 
   WHERE W_SUB_JOB_F.SUB_JOB_ID = W_JOB_SHIPMENT_F.SUB_JOB_ID
   GROUP BY W_SUB_JOB_F.JOB_ID
   ) X1
WHERE date_ship_By < X1.FirstShipDate 
  AND W_JOB_F.JOB_ID = X1.Job_Id
  AND W_Job_F.Location_Id = W_Location_D.Location_Id
  AND W_Job_F.Sales_Class_Id = W_Sales_Class_D.Sales_Class_Id;

-- CREATE VIEW statement using the base query
CREATE VIEW FirstShipmentDelays AS
 SELECT W_JOB_F.job_ID,
  W_JOB_F.SALES_CLASS_ID, Sales_Class_Desc,
  W_JOB_F.LOCATION_ID, Location_Name,
  Date_Ship_By, 
  FirstShipDate,
  GetBusDaysDiff ( date_ship_By, FirstShipDate ) AS BusDaysDiff
FROM W_JOB_F , W_Location_D, W_Sales_Class_D,
  (SELECT W_SUB_JOB_F.JOB_ID, MIN(actual_ship_Date) as FirstShipDate
   FROM W_JOB_SHIPMENT_F, W_SUB_JOB_F 
   WHERE W_SUB_JOB_F.SUB_JOB_ID = W_JOB_SHIPMENT_F.SUB_JOB_ID
   GROUP BY W_SUB_JOB_F.JOB_ID
   ) X1
WHERE date_ship_By < X1.FirstShipDate AND W_JOB_F.JOB_ID = X1.Job_Id
  AND W_Job_F.Location_Id = W_Location_D.Location_Id
  AND W_Job_F.Sales_Class_Id = W_Sales_Class_D.Sales_Class_Id;