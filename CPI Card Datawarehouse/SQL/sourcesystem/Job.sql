
CREATE TABLE JOB
(

 Job_Id LONG PRIMARY KEY, 
 Job_Desc CHAR(50),
 Contract_Date DATE,
 Date_Promised DATE, 
 Number_Of_Subjobs INTEGER,
 PO_Number CHAR(10),
 Record_Active BOOLEAN,
 Date_Ship_By DATE,
 Job_Complete BOOLEAN,
 Print_Flow_Status CHAR(10),
 Contact_Name CHAR(50),
 Unit_Price CURRENCY,
 Quantity_Ordered SHORT,
 Quotation_Amount CURRENCY,
 Quotation_Ordered SHORT,
 Location_Id LONG,
 Sales_Class_Id LONG,
 Sales_Agent_Id LONG,
 Cust_Key LONG
 
);