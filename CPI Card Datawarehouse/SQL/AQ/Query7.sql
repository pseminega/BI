-- Analytic query AQ7
-- Rank sales class by sum of return quantities
-- Partition rank by year

SELECT Sales_Class_Desc, Time_Year,
  SUM ( quantity_shipped - invoice_quantity ) as ReturnSum ,
  RANK() over ( PARTITION BY Time_Year 
    ORDER BY SUM ( quantity_shipped - invoice_quantity ) DESC ) 
     AS RankReturnSum
 FROM W_INVOICELINE_F INNER JOIN W_TIME_D
     ON W_INVOICELINE_F.INVOICE_SENT_DATE = W_TIME_D.TIME_ID
  INNER JOIN W_Sales_Class_D 
     ON W_INVOICELINE_F.Sales_Class_Id = W_Sales_Class_D.Sales_Class_Id
 WHERE quantity_shipped > invoice_quantity
 GROUP BY Sales_Class_Desc, Time_Year;