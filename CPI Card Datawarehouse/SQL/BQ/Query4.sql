-- BQ4 in the quality control area
-- Return quantity and amount by location and sales class
-- Calculate unit price as invoice_amount/invoice_quantity

SELECT
  W_Location_D.Location_Id, Location_Name,
  W_Sales_Class_D.Sales_Class_Id, Sales_Class_Desc,
  Time_Year, Time_Month,
  SUM ( quantity_shipped - invoice_quantity ) as SumReturnQty,
  SUM ( (quantity_shipped - invoice_quantity) * 
      (invoice_amount/invoice_quantity) ) AS SumReturnAmt
 FROM W_INVOICELINE_F INNER JOIN W_TIME_D
     ON W_INVOICELINE_F.INVOICE_SENT_DATE = W_TIME_D.TIME_ID
   INNER JOIN W_Location_D 
     ON W_INVOICELINE_F.Location_Id = W_Location_D.Location_Id
   INNER JOIN W_Sales_Class_D 
     ON W_INVOICELINE_F.Sales_Class_Id = W_Sales_Class_D.Sales_Class_Id
 WHERE quantity_shipped > invoice_quantity
 GROUP BY W_Location_D.Location_Id, Location_Name,
 W_Sales_Class_D.Sales_Class_Id, Sales_Class_Desc, Time_Year, Time_Month;