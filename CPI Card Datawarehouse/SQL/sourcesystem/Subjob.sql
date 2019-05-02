-- drop existing table
-- Only need to drop table if you have previously created it


DROP TABLE SUBJOB;

ALTER SESSION set nls_date_format = 'yyyy-mm-dd';

-- Create table

/*********************************
        SUBJOB
**********************************/

CREATE TABLE SUBJOB
(
 SUB_JOB_ID NUMBER(10,0) NOT NULL,
 JOB_ID NUMBER(10,0) NOT NULL,
 SUB_JOB_DESC VARCHAR2(50),
 COST_LABOR NUMBER(8,2) NOT NULL,
 COST_MATERIAL NUMBER(8,2) NOT NULL,
 COST_OVERHEAD NUMBER(8,2) NOT NULL,
 MACHINE_HOURS NUMBER(8,2) NOT NULL,
 DATE_PROD_BEGIN DATE NOT NULL, 
 DATE_PROD_END DATE NOT NULL, 
 QUANTITY_PRODUCED NUMBER(8,0) NOT NULL, 
 SUB_JOB_AMOUNT NUMBER(11,2) NOT NULL,
 MACHINE_TYPE_ID NUMBER(10,0) NOT NULL,
 CONSTRAINT PK_SUBJOB PRIMARY KEY(SUB_JOB_ID, JOB_ID),
 CONSTRAINT FK_MACHINETYPE_SUBJOB FOREIGN KEY(MACHINE_TYPE_ID) REFERENCES MACHINETYPE(MACHINE_TYPE_ID),
 CONSTRAINT FK_JOB_SUBJOB FOREIGN KEY(JOB_ID) REFERENCES JOB(JOB_ID)
);