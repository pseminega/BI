-- Analytic query AQ6
-- Top performers of percent rank of job profit margins
-- Using SELECT statement of AQ5 in the FROM clause

SELECT Job_Id, Location_Name, Time_Year, Time_Month, 
       ProfitMargin, PercentRankProfitMargin
 FROM (
  SELECT X1.Job_Id, X1.Location_Name, X1.Time_Year, X1.Time_Month,
         (SumInvoiceAmt - TotalCosts) / SumInvoiceAmt AS ProfitMargin,
         PERCENT_RANK() OVER ( 
		 ORDER BY ( (SumInvoiceAmt - TotalCosts) / SumInvoiceAmt ) )  
          AS PercentRankProfitMargin
  FROM LocCostSummary X1, LocRevenueSummary X2 
  WHERE X1.Job_Id = X2.Job_Id )
 WHERE PercentRankProfitMargin > 0.95;