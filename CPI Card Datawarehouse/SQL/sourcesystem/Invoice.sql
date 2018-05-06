
CREATE TABLE INVOICE
(
 Invoice_Id LONG PRIMARY KEY,
 Date_Invoiced DATE,
 Date_Due DATE,
 Posting_Date DATE,
 Invoice_Desc VARCHAR,
 Invoice_Amount CURRENCY,
 Invoice_Quantity INTEGER,
 Invoice_Shipped INTEGER,
 Cust_Key LONG
 );