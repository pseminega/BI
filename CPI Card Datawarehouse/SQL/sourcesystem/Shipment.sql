
CREATE TABLE SHIPMENT

(
  Shipment_Id LONG PRIMARY KEY,
  Actual_Ship_Date DATE,
  Requested_Ship_Date DATE, 
  Actual_Quantity INTEGER, 
  Requested_Quantity INTEGER,
  Boxes INTEGER,
  Quantity_Per_Box INTEGER,
  Quantity_Per_Partial_Box INTEGER,
  Job_Id LONG,
  Shipment_Amount CURRENCY,
  Sub_Job_Id LONG,
  Invoice_Id LONG,
  Cust_Loc_Key LONG

);