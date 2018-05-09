-- drop existing tables
-- Only need to drop tables if you have previously created them

DROP TABLE W_FINANCIAL_SUMMARY_COST_F;
DROP TABLE W_FINANCIAL_SUMMARY_SALES_F;
DROP TABLE W_INVOICELINE_F;
DROP TABLE W_JOB_SHIPMENT_F;
DROP TABLE W_SUB_JOB_F;
DROP TABLE W_JOB_F;
DROP TABLE W_LEAD_F;
DROP TABLE W_MACHINE_TYPE_D;
DROP TABLE W_LOCATION_D;
DROP TABLE W_TIME_D;
DROP TABLE W_SALES_CLASS_D;
DROP TABLE W_SALES_AGENT_D;
DROP TABLE W_CUST_LOCATION_D;
DROP TABLE W_CUSTOMER_D;

ALTER SESSION set nls_date_format = 'yyyy-mm-dd';

-- create tables

/*********************************
        W_CUSTOMER_D
**********************************/

  CREATE TABLE W_CUSTOMER_D
   (	CUST_KEY 	NUMBER(8,0) 		NOT NULL , 
	CUST_NAME 	VARCHAR2(50 BYTE) 	NOT NULL , 
	CITY 		VARCHAR2(25 BYTE) 	NOT NULL , 
	COUNTRY 	VARCHAR2(25 BYTE) 	NOT NULL , 
	CREDIT_LIMIT 	NUMBER(10,2), 
	E_MAIL_ADDRESS 	VARCHAR2(50 BYTE) 	NOT NULL , 
	CUST_STATE 	VARCHAR2(2 BYTE) 	NOT NULL , 
	ZIP 		VARCHAR2(10 BYTE) 	NOT NULL , 
	TERMS_CODE 	VARCHAR2(10 BYTE) 	NOT NULL , 
	 CHECK ( REGEXP_LIKE(e_mail_address, '[a-zA-Z0-9._%-]+@[a-zA-Z0-9._%-]+\.[a-zA-Z]{2,4}')) , 
	 CONSTRAINT W_CUSTOMER_D_PK PRIMARY KEY (CUST_KEY)
 );
 
 
/*********************************
        W_CUST_LOCATION_D
**********************************/

  CREATE TABLE W_CUST_LOCATION_D 
   (	
   
  CUST_LOC_KEY NUMBER(10,0) NOT NULL , 
	CITY VARCHAR2(25 BYTE) NOT NULL , 
	COUNTRY VARCHAR2(25 BYTE) NOT NULL , 
	CREDIT_LIMIT NUMBER(10,2) NOT NULL , 
	E_MAIL_ADDRESS VARCHAR2(50 BYTE) NOT NULL , 
	CUST_LOCATION_STATE VARCHAR2(2 BYTE) NOT NULL , 
	ZIP VARCHAR2(10 BYTE) NOT NULL , 
	CUST_KEY NUMBER(10,0) NOT NULL , 
	CUST_NAME VARCHAR2(50 BYTE) NOT NULL , 
  
  CONSTRAINT W_CUST_LOCATION_D_PK PRIMARY KEY (CUST_LOC_KEY) ,
  CONSTRAINT CUST_NAME_UNIQUE UNIQUE (CUST_NAME) ,
  CONSTRAINT CUST_KEY_FK FOREIGN KEY (CUST_KEY)  REFERENCES W_CUSTOMER_D (CUST_KEY) ON DELETE CASCADE  
   );
   
/*********************************
        W_SALES_AGENT
**********************************/   

  CREATE TABLE W_SALES_AGENT_D 
   (	SALES_AGENT_ID 		NUMBER(10,0) 		NOT NULL , 
	SALES_AGENT_NAME 	VARCHAR2(60 BYTE) 	NOT NULL , 
	SALES_AGENT_STATE 	VARCHAR2(2 BYTE) 	NOT NULL , 
	COUNTRY 		VARCHAR2(25 BYTE) 	NOT NULL ENABLE, 
  
  CONSTRAINT W_SALES_AGENT_D_PK PRIMARY KEY (SALES_AGENT_ID)
  );


/*********************************
        W_SALES_CLASS_D
**********************************/

  CREATE TABLE W_SALES_CLASS_D 
   (	SALES_CLASS_ID 		NUMBER(10,0) 		NOT NULL , 
	SALES_CLASS_DESC 	VARCHAR2(250 BYTE), 
	BASE_PRICE 		NUMBER(8,4) 		NOT NULL , 
  
	 CONSTRAINT W_SALES_CLASS_D_PK PRIMARY KEY (SALES_CLASS_ID)
  );
  
/*********************************
        W_TIME_D
**********************************/   

  CREATE TABLE W_TIME_D 
   (	TIME_ID 	NUMBER(8,0) 	NOT NULL , 
	TIME_YEAR 	NUMBER(4,0) 	NOT NULL , 
	TIME_QUARTER 	NUMBER(1,0) 	NOT NULL , 
	TIME_MONTH 	NUMBER(2,0) 	NOT NULL , 
	TIME_DAY 	NUMBER(3,0) 	NOT NULL , 
	TIME_WEEK 	NUMBER(2,0) 	NOT NULL , 
  
  CONSTRAINT W_TIME_D_PK PRIMARY KEY (TIME_ID) ,
  CONSTRAINT W_TIME_D_UNIQUEGOUP1 UNIQUE (TIME_YEAR, TIME_MONTH, TIME_DAY)
  
 );

/*********************************
        W_LOCATION_D
**********************************/  

  CREATE TABLE W_LOCATION_D 
   (	LOCATION_ID 	NUMBER(10,0) 		NOT NULL , 
	LOCATION_NAME 	VARCHAR2(50 BYTE) 	NOT NULL , 
  
	 CONSTRAINT W_LOCATION_PK PRIMARY KEY (LOCATION_ID) ,
 	 CONSTRAINT W_LOCATION_UNIQUE1 UNIQUE (LOCATION_NAME)
  );

/*********************************
        W_MACHINE_TYPE_D
**********************************/  

  CREATE TABLE W_MACHINE_TYPE_D 
   (	
   
  MACHINE_TYPE_ID NUMBER(10,0) NOT NULL , 
	MANUFACTURER VARCHAR2(50 BYTE) NOT NULL , 
	MACHINE_MODEL VARCHAR2(10 BYTE) NOT NULL , 
	RATE_PER_HOUR NUMBER(7,2) NOT NULL , 
	NUMBER_OF_MACHINES NUMBER(4,0) NOT NULL , 
  
	CONSTRAINT W_MACHINE_TYPE_D_PK PRIMARY KEY (MACHINE_TYPE_ID)
  
  );


/*********************************
        W_LEAD_F
**********************************/    

  CREATE TABLE W_LEAD_F 
   (	LEAD_ID 	NUMBER(10,0) 		NOT NULL , 
	QUOTE_QTY 	NUMBER(8,0) 		NOT NULL , 
	QUOTE_PRICE 	NUMBER(11,2) 		NOT NULL , 
	LEAD_SUCCESS 	VARCHAR2(1 BYTE) 	NOT NULL , 
	JOB_ID 		NUMBER(10,0), 
	CREATED_DATE 	NUMBER(10,0) 		NOT NULL , 
	CUST_ID 	NUMBER(10,0) 		NOT NULL , 
	LOCATION_ID 	NUMBER(10,0) 		NOT NULL , 
	SALES_AGENT_ID 	NUMBER(10,0) 		NOT NULL , 
	SALES_CLASS_ID 	NUMBER(10,0) 		NOT NULL , 
  
	 CONSTRAINT W_LEAD_F_PK PRIMARY KEY (LEAD_ID), 
	 CONSTRAINT W_LEAD_JOB_ID_UNIQUE UNIQUE (JOB_ID)  ,
	 CONSTRAINT W_LEAD_CREATED_DATE_FK FOREIGN KEY (CREATED_DATE) REFERENCES W_TIME_D (TIME_ID) , 
	 CONSTRAINT W_LEAD_CUST_ID_FK FOREIGN KEY (CUST_ID)  REFERENCES W_CUSTOMER_D (CUST_KEY) , 
	 CONSTRAINT W_LEAD_LOCATION_ID_FK FOREIGN KEY (LOCATION_ID)  REFERENCES W_LOCATION_D (LOCATION_ID) , 
	 CONSTRAINT W_LEAD_SALES_AGENT_ID_FK FOREIGN KEY (SALES_AGENT_ID)	REFERENCES W_SALES_AGENT_D (SALES_AGENT_ID) , 
	 CONSTRAINT W_LEAD_SALES_CLASS_ID_FK FOREIGN KEY (SALES_CLASS_ID) REFERENCES W_SALES_CLASS_D (SALES_CLASS_ID) 
   ) ;


/*********************************
        W_JOB_F
**********************************/    

    CREATE TABLE W_JOB_F 
   (	JOB_ID 			NUMBER(10,0) 	NOT NULL , 
	CONTRACT_DATE 		NUMBER(10,0), 
	SALES_AGENT_ID 		NUMBER(10,0) 	NOT NULL , 
	SALES_CLASS_ID 		NUMBER(10,0), 
	LOCATION_ID 		NUMBER(10,0) 	NOT NULL , 
	CUST_ID_ORDERED_BY 	NUMBER(10,0) 	NOT NULL , 
	DATE_PROMISED 		NUMBER(10,0), 
	DATE_SHIP_BY 		NUMBER(10,0), 
	NUMBER_OF_SUBJOBS 	NUMBER(4,0) 	NOT NULL , 
	UNIT_PRICE 		NUMBER(6,2) 	NOT NULL , 
	QUANTITY_ORDERED 	NUMBER(8,0) 	NOT NULL , 
	QUOTE_QTY 		NUMBER(8,0) 	NOT NULL , 
  
  CONSTRAINT W_JOB_F_PK PRIMARY KEY (JOB_ID) , 
  CONSTRAINT W_JOB_CONTRACT_DATE_FK FOREIGN KEY (CONTRACT_DATE)	  REFERENCES W_TIME_D (TIME_ID) , 
	 CONSTRAINT W_JOB_SALES_AGENT_ID_FK FOREIGN KEY (SALES_AGENT_ID)   REFERENCES W_SALES_AGENT_D (SALES_AGENT_ID)  , 
	 CONSTRAINT W_JOB_SALES_CLASS_ID_FK FOREIGN KEY (SALES_CLASS_ID) 	  REFERENCES W_SALES_CLASS_D (SALES_CLASS_ID) , 
	 CONSTRAINT W_JOB_LOCATION_ID_FK FOREIGN KEY (LOCATION_ID) 	 REFERENCES W_LOCATION_D (LOCATION_ID)  , 
	 CONSTRAINT W_JOB_CUST_ID_ORDERED_BY_FK FOREIGN KEY (CUST_ID_ORDERED_BY) REFERENCES W_CUSTOMER_D (CUST_KEY) , 
	 CONSTRAINT W_JOB_DATE_PROMISED_FK FOREIGN KEY (DATE_PROMISED) REFERENCES W_TIME_D (TIME_ID)  , 
	 CONSTRAINT W_JOB_DATE_SHIP_BY_FK FOREIGN KEY (DATE_SHIP_BY) REFERENCES W_TIME_D (TIME_ID)  
   );
   
/*********************************
        W_SUB_JOB_F
**********************************/  

  CREATE TABLE W_SUB_JOB_F 
   (	
   
  SUB_JOB_ID NUMBER(10,0) NOT NULL , 
	COST_LABOR NUMBER(8,2) NOT NULL , 
	COST_MATERIAL NUMBER(8,2) NOT NULL , 
	COST_OVERHEAD NUMBER(8,2) NOT NULL , 
	MACHINE_HOURS NUMBER(8,2) NOT NULL , 
	QUANTITY_PRODUCED NUMBER(8,0) NOT NULL , 
	SUB_JOB_AMOUNT NUMBER(11,2) NOT NULL , 
	JOB_ID NUMBER(10,0) NOT NULL , 
	MACHINE_TYPE_ID NUMBER(10,0) NOT NULL , 
	SALES_CLASS_ID NUMBER(10,0) NOT NULL , 
	DATE_PROD_BEGIN NUMBER(10,0) NOT NULL , 
	DATE_PROD_END NUMBER(10,0) NOT NULL , 
	LOCATION_ID NUMBER(10,0) NOT NULL , 
	CUST_ID_ORDERED_BY NUMBER(10,0) NOT NULL , 
  
  CONSTRAINT W_SUB_JOB_F_PK PRIMARY KEY (SUB_JOB_ID), 
	 CONSTRAINT SUBJOB_MACHINE_TYPE_ID FOREIGN KEY (MACHINE_TYPE_ID) REFERENCES W_MACHINE_TYPE_D (MACHINE_TYPE_ID) , 
	 CONSTRAINT SUBJOB_SALES_CLASS_ID FOREIGN KEY (SALES_CLASS_ID)  REFERENCES W_SALES_CLASS_D (SALES_CLASS_ID) , 
	 CONSTRAINT SUBJOB_DATE_PROD_BEGIN FOREIGN KEY (DATE_PROD_BEGIN) REFERENCES W_TIME_D (TIME_ID) , 
	 CONSTRAINT SUBJOB_DATE_PROD_END FOREIGN KEY (DATE_PROD_END) REFERENCES W_TIME_D (TIME_ID) , 
	 CONSTRAINT SUBJOB_LOCATION_ID_FK FOREIGN KEY (LOCATION_ID) REFERENCES W_LOCATION_D (LOCATION_ID) , 
	 CONSTRAINT SUBJOB_CUST_ID_ORDERED_BY FOREIGN KEY (CUST_ID_ORDERED_BY)  REFERENCES W_CUSTOMER_D (CUST_KEY) 
   ) ;

   
/*********************************
        W_JOB_SHIPMENT_F
**********************************/   

  CREATE TABLE W_JOB_SHIPMENT_F 
   (	
   
  JOB_SHIPMENT_ID NUMBER(10,0) NOT NULL , 
	ACTUAL_QUANTITY NUMBER(8,0) NOT NULL , 
	REQUESTED_QUANTITY NUMBER(8,0) NOT NULL , 
	BOXES NUMBER(4,0) NOT NULL , 
	QUANTITY_PER_BOX NUMBER(5,0) NOT NULL , 
	QUANTITY_PER_PARTIAL_BOX NUMBER(4,0), 
	SHIPPED_AMOUNT NUMBER(8,2) NOT NULL , 
	SUB_JOB_ID NUMBER(10,0) NOT NULL , 
	SALES_CLASS_ID NUMBER(10,0) NOT NULL , 
	LOCATION_ID NUMBER(10,0) NOT NULL , 
	CUST_ID_SHIP_TO NUMBER(10,0) NOT NULL , 
	ACTUAL_SHIP_DATE NUMBER(10,0) NOT NULL , 
	REQUESTED_SHIP_DATE NUMBER(10,0) NOT NULL , 
	INVOICE_ID NUMBER(10,0), 
  
  CONSTRAINT W_JOB_SHIPMENT_F_PK PRIMARY KEY (JOB_SHIPMENT_ID), 
	 CONSTRAINT SHIPMENT_SALES_CLASS_ID_FK FOREIGN KEY (SALES_CLASS_ID) REFERENCES W_SALES_CLASS_D (SALES_CLASS_ID) , 
	 CONSTRAINT SHIPMENT_LOCATION_ID_FK FOREIGN KEY (LOCATION_ID) REFERENCES W_LOCATION_D (LOCATION_ID) , 
	 CONSTRAINT SHIPMENT_CUST_ID_SHIP_TO_FK FOREIGN KEY (CUST_ID_SHIP_TO) REFERENCES W_CUST_LOCATION_D (CUST_LOC_KEY) , 
	 CONSTRAINT SHIPMENT_ACTUAL_SHIP_DATE_FK FOREIGN KEY (ACTUAL_SHIP_DATE) REFERENCES W_TIME_D (TIME_ID) , 
	 CONSTRAINT SHIPMENT_REQUESTED_SHIP_DATEFK FOREIGN KEY (REQUESTED_SHIP_DATE) REFERENCES W_TIME_D (TIME_ID) 
   )  ;


/*********************************
        W_INVOICELINE_F
**********************************/   

  CREATE TABLE W_INVOICELINE_F 
   (	
   
   INVOICE_ID NUMBER(10,0) NOT NULL , 
	INVOICE_QUANTITY NUMBER(8,0) NOT NULL , 
	INVOICE_AMOUNT NUMBER(10,2) NOT NULL , 
	QUANTITY_SHIPPED NUMBER(8,0) NOT NULL , 
	SALES_CLASS_ID NUMBER(10,0) NOT NULL , 
	INVOICE_SENT_DATE NUMBER(10,0) NOT NULL , 
	INVOICE_DUE_DATE NUMBER(10,0) NOT NULL , 
	CUST_KEY NUMBER(10,0) NOT NULL , 
	SALES_AGENT_ID NUMBER(10,0) NOT NULL , 
	LOCATION_ID NUMBER(10,0) NOT NULL , 
  
	 CONSTRAINT W_INVOICELINE_F_PK PRIMARY KEY (INVOICE_ID), 
	 CONSTRAINT SALES_CLASS_ID_FK2 FOREIGN KEY (SALES_CLASS_ID) REFERENCES W_SALES_CLASS_D (SALES_CLASS_ID) , 
	 CONSTRAINT INVOICE_SENT_DATE_FK FOREIGN KEY (INVOICE_SENT_DATE) REFERENCES W_TIME_D (TIME_ID) , 
	 CONSTRAINT INVOICE_DUE_DATE_FK FOREIGN KEY (INVOICE_DUE_DATE) REFERENCES W_TIME_D (TIME_ID) , 
	 CONSTRAINT CUST_KEY_FK2 FOREIGN KEY (CUST_KEY) REFERENCES W_CUSTOMER_D (CUST_KEY) , 
	 CONSTRAINT SALES_AGENT_ID_FK2 FOREIGN KEY (SALES_AGENT_ID) REFERENCES W_SALES_AGENT_D (SALES_AGENT_ID) , 
	 CONSTRAINT INV_LOCATION_ID_FK FOREIGN KEY (LOCATION_ID) REFERENCES W_LOCATION_D (LOCATION_ID) 
   ) ;

/*********************************
     FINANCIAL_SUMMARY_SALES_F
**********************************/ 
    
  CREATE TABLE W_FINANCIAL_SUMMARY_SALES_F 
   (	
  FINANCIAL_SUMMARY_SALES_ID NUMBER(10,0) NOT NULL , 
	ACTUAL_UNITS NUMBER(12,0) NOT NULL , 
	ACTUAL_AMOUNT NUMBER(18,2) NOT NULL , 
	FORCAST_UNIT NUMBER(12,0) NOT NULL , 
	FORCAST_AMOUNT NUMBER(18,2) NOT NULL , 
	LOCATION_ID NUMBER(10,0) NOT NULL , 
	SALES_CLASS_ID NUMBER(10,0) NOT NULL , 
	REPORT_BEGIN_DATE_ID NUMBER(10,0) NOT NULL , 
	REPORT_END_DATE_ID NUMBER(10,0) NOT NULL , 
  
  CONSTRAINT W_FINANC_SUM_F_PK PRIMARY KEY (FINANCIAL_SUMMARY_SALES_ID), 
	 CONSTRAINT LOCATION_ID_FINANC_FK FOREIGN KEY (LOCATION_ID) REFERENCES W_LOCATION_D (LOCATION_ID) , 
	 CONSTRAINT SALES_CLASS_ID_FINANC_FK FOREIGN KEY (SALES_CLASS_ID) REFERENCES W_SALES_CLASS_D (SALES_CLASS_ID) , 
	 CONSTRAINT REPORT_BEGIN_DATE_ID_FINANC_FK FOREIGN KEY (REPORT_BEGIN_DATE_ID) REFERENCES W_TIME_D (TIME_ID) , 
	 CONSTRAINT REPORT_END_DATE_ID_FINANC_FK FOREIGN KEY (REPORT_END_DATE_ID) REFERENCES W_TIME_D (TIME_ID) 
   ) ;


/*********************************
     FINANCIAL_SUMMARY_COST_F
**********************************/ 

  CREATE TABLE W_FINANCIAL_SUMMARY_COST_F 
   (	
   
  FINANCIAL_SUMMARY_COST_ID NUMBER(13,0) NOT NULL , 
	ACTUAL_UNITS NUMBER(12,0) NOT NULL , 
	ACTUAL_LABOR_COST NUMBER(12,0) NOT NULL , 
	ACTUAL_MATERIAL_COST NUMBER(18,2) NOT NULL , 
	ACTUAL_MACHINE_COST NUMBER(12,0) NOT NULL , 
	ACTUAL_OVERHEAD_COST NUMBER(18,2) NOT NULL , 
	BUDGET_UNITS NUMBER(12,0) NOT NULL , 
	BUDGET_LABOR_COST NUMBER(12,0) NOT NULL , 
	BUDGET_MATERIAL_COST NUMBER(18,2) NOT NULL , 
	BUDGET_MACHINE_COST NUMBER(12,0) NOT NULL , 
	BUDGET_OVERHEAD_COST NUMBER(18,2) NOT NULL , 
	LOCATION_ID NUMBER(10,0) NOT NULL , 
	MACHINE_TYPE_ID NUMBER(10,0) NOT NULL , 
	SALES_CLASS_ID NUMBER(10,0) NOT NULL , 
	REPORT_BEGIN_DATE_ID NUMBER(10,0) NOT NULL , 
	REPORT_END_DATE_ID NUMBER(10,0) NOT NULL , 
  
  CONSTRAINT W_FINANC_COST_F_PK PRIMARY KEY (FINANCIAL_SUMMARY_COST_ID), 
	 CONSTRAINT LOCATION_ID_COST_FK FOREIGN KEY (LOCATION_ID) REFERENCES W_LOCATION_D (LOCATION_ID) , 
	 CONSTRAINT SALES_CLASS_ID_COST_FK FOREIGN KEY (SALES_CLASS_ID) REFERENCES W_SALES_CLASS_D (SALES_CLASS_ID) , 
	 CONSTRAINT REPORT_BEGIN_DATE_ID_COST_FK FOREIGN KEY (REPORT_BEGIN_DATE_ID) REFERENCES W_TIME_D (TIME_ID) , 
	 CONSTRAINT REPORT_END_DATE_ID_COST_FK FOREIGN KEY (REPORT_END_DATE_ID) REFERENCES W_TIME_D (TIME_ID) , 
	 CONSTRAINT MACHINE_TYPE_ID_COST_FK FOREIGN KEY (MACHINE_TYPE_ID) REFERENCES W_MACHINE_TYPE_D (MACHINE_TYPE_ID) 
   ) ;
