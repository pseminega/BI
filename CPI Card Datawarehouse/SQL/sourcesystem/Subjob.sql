

CREATE TABLE SubJob
(

 Job_Id LONG PRIMARY KEY,
 Sub_Job_Id SHORT,
 Sub_Job_Desc CHAR(50),
 Cost_Labor CURRENCY,
 Cost_Material CURRENCY,
 Cost_Overhead CURRENCY,
 Machine_Hours DECIMAL,
 Date_Prod_Begin DATE, 
 Date_Prod_End DATE, 
 Quantity_Producted INTEGER, 
 Sub_Job_Amount CURRENCY,
 Machine_Type_Id LONG

);