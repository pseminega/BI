-- BQ2 in the revenue/costs area
-- Location invoice revenue summary
-- Use contract year and month

SELECT W_Sub_Job_F.Job_Id, 
       W_Location_D.LOCATION_ID, W_LOCATION_D.LOCATION_NAME,
       Quantity_Ordered, Unit_Price,  
       W_TIME_D.TIME_YEAR, W_TIME_D.TIME_MONTH,
       SUM (Invoice_Quantity) AS SumInvoiceQty,
       SUM (Invoice_Amount) AS SumInvoiceAmt
 FROM W_Job_Shipment_F, W_Sub_Job_F, W_Location_D, W_Time_D, 
      W_InvoiceLine_F, W_Job_F
 WHERE W_Sub_Job_F.Sub_Job_Id = W_Job_Shipment_F.Sub_Job_Id
   AND W_Job_Shipment_F.Invoice_Id = W_InvoiceLine_F.Invoice_Id
   AND W_Time_D.Time_Id = Contract_Date
   AND W_Location_D.Location_Id = W_InvoiceLine_F.Location_Id
   AND W_Job_F.Job_Id = W_Sub_Job_F.Job_Id
 GROUP BY W_Sub_Job_F.Job_Id, W_Location_D.Location_Id, 
          W_LOCATION_D.LOCATION_NAME, Quantity_Ordered, Unit_Price, 
          W_Time_D.Time_Year, W_Time_D.Time_Month;

-- CREATE VIEW statement
CREATE VIEW LocRevenueSummary AS
 SELECT W_Sub_Job_F.Job_Id, 
        W_Location_D.LOCATION_ID, W_LOCATION_D.LOCATION_NAME,
        Quantity_Ordered, Unit_Price,  
        W_TIME_D.TIME_YEAR, W_TIME_D.TIME_MONTH,
        SUM (Invoice_Quantity) AS SumInvoiceQty,
        SUM (Invoice_Amount) AS SumInvoiceAmt
  FROM W_Job_Shipment_F, W_Sub_Job_F, W_Location_D, W_Time_D, 
       W_InvoiceLine_F, W_Job_F
  WHERE W_Sub_Job_F.Sub_Job_Id = W_Job_Shipment_F.Sub_Job_Id
    AND W_Job_Shipment_F.Invoice_Id = W_InvoiceLine_F.Invoice_Id
    AND W_Time_D.Time_Id = Contract_Date
    AND W_Location_D.Location_Id = W_InvoiceLine_F.Location_Id
    AND W_Job_F.Job_Id = W_Sub_Job_F.Job_Id
  GROUP BY W_Sub_Job_F.Job_Id, W_Location_D.Location_Id, 
           W_LOCATION_D.LOCATION_NAME, Quantity_Ordered, Unit_Price, 
           W_Time_D.Time_Year, W_Time_D.Time_Month;
