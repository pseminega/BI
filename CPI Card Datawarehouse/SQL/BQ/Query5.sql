-- BQ5 in the quality control area
-- Jobs with delays in the last shipment date (Date_Promised)
-- Nested query in the FROM clause to determine last shipment date

SELECT W_JOB_F.job_ID,
  W_JOB_F.SALES_CLASS_ID, Sales_Class_Desc,
  W_JOB_F.LOCATION_ID, Location_Name,
  Date_Promised, Last_Shipment_Date,
  QUANTITY_ORDERED, SumDelayShipQty,
  GetBusDaysDiff ( date_promised, Last_Shipment_Date ) AS BusDaysDiff
FROM W_JOB_F , W_Location_D, W_Sales_Class_D,
  (SELECT W_SUB_JOB_F.JOB_ID,
    MAX(actual_ship_Date)   AS Last_Shipment_Date,
    SUM ( actual_Quantity ) AS SumDelayShipQty
  FROM W_JOB_SHIPMENT_F, W_SUB_JOB_F, W_Job_F
  WHERE W_SUB_JOB_F.SUB_JOB_ID = W_JOB_SHIPMENT_F.SUB_JOB_ID
    AND W_Job_F.Job_Id = W_SUB_JOB_F.JOB_ID
    AND Actual_Ship_Date > Date_Promised
  GROUP BY W_SUB_JOB_F.JOB_ID
  ) X1
WHERE date_promised < X1.Last_Shipment_Date
  AND W_JOB_F.JOB_ID  = X1.Job_Id
  AND W_Job_F.Location_Id = W_Location_D.Location_Id
  AND W_Job_F.Sales_Class_Id = W_Sales_Class_D.Sales_Class_Id;

-- CREATE VIEW statement using the base query
CREATE VIEW LastShipmentDelays AS
 SELECT W_JOB_F.job_ID ,
  W_JOB_F.SALES_CLASS_ID, Sales_Class_Desc,
  W_JOB_F.LOCATION_ID, Location_Name,
  Date_Promised, Last_Shipment_Date,
  QUANTITY_ORDERED, SumDelayShipQty,
  GetBusDaysDiff ( date_promised, Last_Shipment_Date ) AS BusDaysDiff
FROM W_JOB_F , W_Location_D, W_Sales_Class_D,
  (SELECT W_SUB_JOB_F.JOB_ID,
    MAX(actual_ship_Date)   AS Last_Shipment_Date,
    SUM ( actual_Quantity ) AS SumDelayShipQty
  FROM W_JOB_SHIPMENT_F, W_SUB_JOB_F, W_Job_F
  WHERE W_SUB_JOB_F.SUB_JOB_ID = W_JOB_SHIPMENT_F.SUB_JOB_ID
    AND W_Job_F.Job_Id = W_SUB_JOB_F.JOB_ID
    AND Actual_Ship_Date > Date_Promised
  GROUP BY W_SUB_JOB_F.JOB_ID
  ) X1
WHERE date_promised < X1.Last_Shipment_Date
  AND W_JOB_F.JOB_ID  = X1.Job_Id
  AND W_Job_F.Location_Id = W_Location_D.Location_Id
  AND W_Job_F.Sales_Class_Id = W_Sales_Class_D.Sales_Class_Id;