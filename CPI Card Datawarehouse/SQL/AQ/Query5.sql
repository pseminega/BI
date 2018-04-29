-- Analytic query AQ5
-- Percent rank jobs by annual profit margin
-- Extends BQ2 and BQ3
-- Using views for location revenue and location cost summaries

SELECT X1.Job_Id, X1.Location_Name, X1.Time_Year, X1.Time_Year,
       (SumInvoiceAmt - TotalCosts) / SumInvoiceAmt AS ProfitMargin,
       PERCENT_RANK() OVER ( 
        ORDER BY ( (SumInvoiceAmt - TotalCosts) / SumInvoiceAmt ) )  
         AS PercentRankProfitMargin
 FROM LocCostSummary X1, LocRevenueSummary X2 
 WHERE X1.Job_Id = X2.Job_Id;

-- Using base queries for location revenue and location cost summaries

SELECT X1.Job_Id, X1.Location_Name, X1.Time_Year, X1.Time_Month,
      (SumInvoiceAmt - TotalCosts) / SumInvoiceAmt AS ProfitMargin,        
      PERCENT_RANK() OVER ( 
        ORDER BY ( (SumInvoiceAmt - TotalCosts) / SumInvoiceAmt ) )
         AS PercentRankProfitMargin
 FROM 
 ( 
 SELECT W_Sub_Job_F.Job_Id, W_Location_D.LOCATION_ID, 
        W_LOCATION_D.LOCATION_NAME,  
        W_TIME_D.TIME_YEAR,  W_TIME_D.TIME_MONTH, 
        SUM (Invoice_Quantity) AS SumInvoiceQty,
        SUM (Invoice_Amount) AS SumInvoiceAmt
  FROM W_Job_Shipment_F, W_Sub_Job_F, W_Location_D, W_Time_D, 
       W_InvoiceLine_F, W_Job_F
  WHERE W_Sub_Job_F.Sub_Job_Id = W_Job_Shipment_F.Sub_Job_Id
    AND W_Job_Shipment_F.Invoice_Id = W_InvoiceLine_F.Invoice_Id
    AND W_Time_D.Time_Id = Contract_Date
    AND W_Location_D.Location_Id = W_InvoiceLine_F.Location_Id
    AND W_Job_F.Job_Id = W_Sub_Job_F.Job_Id
  GROUP BY W_Sub_Job_F.Job_Id, W_Location_D.LOCATION_ID, 
     W_LOCATION_D.LOCATION_NAME, W_TIME_D.TIME_YEAR, W_TIME_D.TIME_MONTH
 ) X1,
 ( 
 SELECT W_Sub_Job_F.Job_Id, W_Location_D.LOCATION_ID, 
        W_LOCATION_D.LOCATION_NAME,  
        W_TIME_D.TIME_YEAR,  W_TIME_D.TIME_MONTH, 
        SUM(Cost_Labor) AS SumLaborCosts, 
        SUM(Cost_Material) AS SumMaterialCosts,
        SUM(Cost_Overhead) AS SumOvrhdCosts, 
        SUM(Machine_Hours * Rate_Per_Hour) AS SumMachineCosts,
        SUM(Quantity_Produced) AS SumQtyProduced,
        SUM(Cost_Labor + Cost_Material + Cost_Overhead + 
           (Machine_Hours * Rate_Per_Hour)) AS TotalCosts
  FROM W_Job_F, W_Sub_Job_F, W_Location_D, W_Time_D, W_Machine_Type_D
  WHERE W_Job_F.Location_Id = W_Location_D.Location_Id
    AND W_Sub_Job_F.Machine_Type_Id = W_Machine_Type_D.Machine_Type_Id
    AND W_Time_D.Time_Id = Contract_Date
    AND W_Job_F.Job_Id = W_Sub_Job_F.Job_Id
  GROUP BY W_Sub_Job_F.Job_Id, W_Location_D.LOCATION_ID, 
    W_LOCATION_D.LOCATION_NAME, W_TIME_D.TIME_YEAR, W_TIME_D.TIME_MONTH
  ) X2
 WHERE X1.Job_Id = X2.Job_Id;