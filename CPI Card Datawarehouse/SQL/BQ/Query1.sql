-- Base query BG1 in the revenue/costs area
-- Location and sales class summary of job quantity and amount 

SELECT W_Location_D.Location_Id, Location_Name,
       W_Sales_Class_D.Sales_Class_Id, Sales_Class_Desc,
       Base_Price, Time_Year, Time_Month,
       SUM ( QUANTITY_ORDERED ) AS Sum_Job_Qty,
       SUM ( QUANTITY_ORDERED * Unit_Price ) AS Sum_Job_Amount
 FROM W_JOB_F, W_Location_D, W_TIME_D, W_Sales_Class_D
 WHERE W_Location_D.Location_ID = W_Job_F.Location_Id
   AND W_JOB_F.CONTRACT_DATE = W_TIME_D.Time_ID
   AND W_Job_F.Sales_Class_Id = W_Sales_Class_D.Sales_Class_Id
 GROUP BY W_Location_D.Location_Id, Location_Name,
          W_Sales_Class_D.Sales_Class_Id, Sales_Class_Desc,
          Base_Price, Time_Year, Time_Month;