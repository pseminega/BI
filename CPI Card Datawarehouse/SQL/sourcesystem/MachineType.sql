-- drop existing table
-- Only need to drop table if you have previously created it


DROP TABLE MACHINETYPE;

ALTER SESSION set nls_date_format = 'yyyy-mm-dd';

-- Create table


/*********************************
        MACHINETYPE
**********************************/

CREATE TABLE MACHINETYPE
(
 MACHINE_TYPE_ID NUMBER(10,0) NOT NULL, 
 MANUFACTURER VARCHAR2(50) NOT NULL,
 MODEL VARCHAR2(10) NOT NULL,
 RATE_PER_HOUR NUMBER(7,2) NOT NULL,
 NUMBER_OF_MACHINES NUMBER(4,0) NOT NULL,
 CONSTRAINT PK_MACHINETYPE PRIMARY KEY(MACHINE_TYPE_ID)
);