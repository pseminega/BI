-- drop existing table
-- Only need to drop table if you have previously created it


DROP TABLE LOCATION;

ALTER SESSION set nls_date_format = 'yyyy-mm-dd';

-- Create table

/*********************************
        LOCATION
**********************************/

CREATE TABLE LOCATION
(
 LOCATION_ID NUMBER(10,0) NOT NULL,
 LOCATION_NAME VARCHAR2(50) NOT NULL,
 CONSTRAINT PK_LOCATION PRIMARY KEY (LOCATION_ID) ,
 CONSTRAINT UNIQUE_LOCATION UNIQUE (LOCATION_NAME)
);