

CREATE TABLE CUSTOMER
(

  Cust_Key LONG PRIMARY KEY,
  Cust_Name VARCHAR,
  Active BOOLEAN,
  Address_1 VARCHAR,
  Address_2 VARCHAR,
  Address_3 VARCHAR,
  City VARCHAR,
  Country VARCHAR,
  Credit_Limit CURRENCY,
  Date_First_Order DATE, 
  E_Mail_Address VARCHAR,
  Fax CHAR(10),
  Phone CHAR(10),
  Sales_Tax_Code CHAR(10),
  State CHAR(2),
  Terms_Code CHAR(10),
  ZIP CHAR(10)

);