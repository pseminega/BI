-- Analytic query AQ8
-- Ratio to report for sales classes on sum of return quantity
-- Partition ratio to report by year

SELECT Time_Year, Sales_Class_Desc,
  SUM ( quantity_shipped - invoice_quantity ) as SumReturnQty,
  Ratio_To_Report(SUM ( quantity_shipped - invoice_quantity )) 
    OVER ( PARTITION BY Time_Year ) AS RatioReturnSum
 FROM W_INVOICELINE_F INNER JOIN W_TIME_D 
      ON W_INVOICELINE_F.INVOICE_SENT_DATE = W_TIME_D.TIME_ID
   INNER JOIN W_Sales_Class_D 
      ON W_INVOICELINE_F.Sales_Class_Id = W_Sales_Class_D.Sales_Class_Id
 WHERE quantity_shipped > invoice_quantity
 GROUP BY Sales_Class_Desc, Time_Year
 ORDER BY Time_Year, SUM( quantity_shipped - invoice_quantity );