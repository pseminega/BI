-- BQ3 in the revenue/costs area
-- Location subjob cost summary
-- Use contract year and month to match revenues/costs

SELECT W_Sub_Job_F.Job_Id, 
       W_Location_D.LOCATION_ID ,W_LOCATION_D.LOCATION_NAME,  
       W_TIME_D.TIME_YEAR,  W_TIME_D.TIME_MONTH, 
       SUM(Cost_Labor) AS SumLaborCosts, 
       SUM(Cost_Material) AS SumMaterialCosts,
       SUM(Cost_Overhead) AS SumOvrhdCosts, 
       SUM(Machine_Hours * Rate_Per_Hour) AS SumMachineCosts,
       SUM(Quantity_Produced) AS SumQtyProduced,
       SUM(Cost_Labor + Cost_Material + Cost_Overhead + 
            (Machine_Hours * Rate_Per_Hour) ) AS TotalCosts,
       SUM( Cost_Labor + Cost_Material + Cost_Overhead + (Machine_Hours *   
            Rate_Per_Hour) ) / SUM(Quantity_Produced)  AS UnitCosts   
 FROM W_Job_F, W_Sub_Job_F, W_Location_D, W_Time_D, W_Machine_Type_D
 WHERE W_Job_F.Location_Id = W_Location_D.Location_Id
   AND W_Sub_Job_F.Machine_Type_Id = W_Machine_Type_D.Machine_Type_Id
   AND W_Time_D.Time_Id = Contract_Date
   AND W_Job_F.Job_Id = W_Sub_Job_F.Job_Id
 GROUP BY W_Sub_Job_F.Job_Id, W_Location_D.LOCATION_ID, 
          W_LOCATION_D.LOCATION_NAME, W_TIME_D.TIME_YEAR, 
          W_TIME_D.TIME_MONTH;

CREATE VIEW LocCostSummary AS
SELECT W_Sub_Job_F.Job_Id, 
       W_Location_D.LOCATION_ID ,W_LOCATION_D.LOCATION_NAME,  
       W_TIME_D.TIME_YEAR,  W_TIME_D.TIME_MONTH, 
       SUM(Cost_Labor) AS SumLaborCosts, 
       SUM(Cost_Material) AS SumMaterialCosts,
       SUM(Cost_Overhead) AS SumOvrhdCosts, 
       SUM(Machine_Hours * Rate_Per_Hour) AS SumMachineCosts,
       SUM(Quantity_Produced) AS SumQtyProduced,
       SUM(Cost_Labor + Cost_Material + Cost_Overhead + 
            (Machine_Hours * Rate_Per_Hour) ) AS TotalCosts,
       SUM( Cost_Labor + Cost_Material + Cost_Overhead + (Machine_Hours *   
            Rate_Per_Hour) ) / SUM(Quantity_Produced)  AS UnitCosts   
 FROM W_Job_F, W_Sub_Job_F, W_Location_D, W_Time_D, W_Machine_Type_D
 WHERE W_Job_F.Location_Id = W_Location_D.Location_Id
   AND W_Sub_Job_F.Machine_Type_Id = W_Machine_Type_D.Machine_Type_Id
   AND W_Time_D.Time_Id = Contract_Date
   AND W_Job_F.Job_Id = W_Sub_Job_F.Job_Id
 GROUP BY W_Sub_Job_F.Job_Id, W_Location_D.LOCATION_ID, 
          W_LOCATION_D.LOCATION_NAME, W_TIME_D.TIME_YEAR, 
          W_TIME_D.TIME_MONTH;