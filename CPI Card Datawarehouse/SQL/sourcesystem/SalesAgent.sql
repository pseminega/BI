-- drop existing table
-- Only need to drop table if you have previously created it


DROP TABLE SALESAGENT;

ALTER SESSION set nls_date_format = 'yyyy-mm-dd';

-- Create table

/*********************************
        SALESAGENT
**********************************/

CREATE TABLE SALESAGENT
(
  SALES_AGENT_ID NUMBER(10,0) NOT NULL,
  SALES_AGENT_NAME VARCHAR2(60) NOT NULL,
  STATE VARCHAR2(2) NOT NULL,
  COUNTRY VARCHAR2(25) NOT NULL,
  RECORD_ACTIVE CHAR(1) NOT NULL,
  CONSTRAINT PK_SALESAGENT PRIMARY KEY (SALES_AGENT_ID)
);