/*********************************
        SHIPMENT
**********************************/

CREATE TABLE SHIPMENT
(
  SHIPMENT_ID NUMBER(10,0) PRIMARY KEY,
  ACTUAL_SHIP_DATE DATE NOT NULL,
  REQUESTED_SHIP_DATE DATE NOT NULL, 
  ACTUAL_QUANTITY NUMBER(8,0) NOT NULL, 
  REQUESTED_QUANTITY NUMBER(8,0) NOT NULL,
  BOXES NUMBER(4,0) NOT NULL,
  QUANTITY_PER_BOX NUMBER(5,0) NOT NULL,
  QUANTITY_PER_PARTIAL_BOX NUMBER(5,0) NOT NULL,
  JOB_ID NUMBER(10,0),
  SHIPMENT_AMOUNT NUMBER(8,2) NOT NULL,
  SUB_JOB_ID NUMBER(10,0) NOT NULL,
  INVOICE_ID NUMBER(10,0) NOT NULL,
  CUST_LOC_KEY NUMBER(10,0) NOT NULL,
  CONSTRAINT FK_JOB_SHIPMENT FOREIGN KEY(JOB_ID) REFERENCES JOB(JOB_ID),
  CONSTRAINT FK_SUBJOB_SHIPMENT FOREIGN KEY(SUB_JOB_ID) REFERENCES SUBJOB(SUB_JOB_ID),
  CONSTRAINT FK_INVOICE_SHIPMENT FOREIGN KEY(INVOICE_ID) REFERENCES INVOICE(INVOICE_ID),
  CONSTRAINT FK_CUSTLOCATION_SHIPMENT FOREIGN KEY(CUST_LOC_KEY) REFERENCES CUSTLOCATION(CUST_LOC_KEY)
);