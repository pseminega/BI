-- drop existing table
-- Only need to drop table if you have previously created it


DROP TABLE SALESCLASS;

ALTER SESSION set nls_date_format = 'yyyy-mm-dd';

-- Create table

/*********************************
        SALESCLASS
**********************************/

CREATE TABLE SALESCLASS
(
 SALES_CLASS_ID NUMBER(10,0) NOT NULL,
 SALES_CLASS_DESC VARCHAR2(250),
 BASE_PRICE NUMBER(8,4) NOT NULL,
 CONSTRAINT PK_SALESCLASS PRIMARY KEY (SALES_CLASS_ID)
);