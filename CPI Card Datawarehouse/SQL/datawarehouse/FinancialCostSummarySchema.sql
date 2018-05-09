-- drop existing tables
-- Only need to drop tables if you have previously created them

DROP TABLE W_FINANCIAL_SUMMARY_COST_F;
DROP TABLE W_MACHINE_TYPE_D;
DROP TABLE W_LOCATION_D;
DROP TABLE W_TIME_D;
DROP TABLE W_SALES_CLASS_D;

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
   
   