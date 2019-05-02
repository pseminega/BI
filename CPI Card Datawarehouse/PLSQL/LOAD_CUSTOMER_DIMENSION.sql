CREATE OR REPLACE PROCEDURE LOAD_CUSTOMER_DIMENSION

AS

SQLSTMT  VARCHAR2(2000);
TBLCOUNT NUMBER :=0;
AS_OF_DATE DATE;
ERR_MSG  VARCHAR2(200);
MAX_KEY_CUSTOMER NUMBER;
NEXT_SEQ_VAL NUMBER;

BEGIN 

 --Log the begin of the job
 INSERT INTO ETL_JOB_STATUS( ID, ETL_JOB_NAME, STATUS_NAME, STATUS_TIMESTAMP )
 VALUES(SEQ_ETL_JOB_STATUS.NEXTVAL, 'LOAD_CUSTOMER_DIMENSION','IN PROGRESS',SYSTIMESTAMP);
 
 COMMIT;
 
 -- Make sure that the sequence that populates the key_customer is set to begin at the next integer
 
 SELECT NVL(MAX(KEY_CUSTOMER),0) INTO MAX_KEY_CUSTOMER FROM W_CUSTOMER_D;
 SELECT SEQ_DIM_CUSTOMER.NEXTVAL INTO NEXT_SEQ_VAL FROM DUAL;
 
   IF NEXT_SEQ_VAL <> MAX_KEY_CUSTOMER THEN SQLSTMT :='ALTER SEQUENCE SEQ_DIM_CUSTOMER INCREMENT BY'
     ||((NEXT_SEQ_VAL-MAX_KEY_CUSTOMER)*-1)
	 ||'MINVALUE 0';
	 EXECUTE IMMEDIATE SQLSTMT;
	 SELECT SEQ_DIM_CUSTOMER.NEXTVAL INTO NEXT_SEQ_VAL FROM DUAL;
	 SQLSTMT :='ALTER SEQUENCE SEQ_DIM_CUSTOMER INCREMENT BY 1 MINVALUE 0';
	 EXECUTE IMMEDIATE SQLSTMT;
   END IF;
   
   
   
 -- If the table exists, drop it. If not, do nothing. The table will be created below.
 
 SELECT COUNT(*) INTO TBLCOUNT FROM ALL_TABLES WHERE TABLE_NAME = 'STAGE_CUSTOMER_DATA' AND OWNER = (SELECT SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA') FROM DUAL);
 IF TBLCOUNT > 0 THEN
 EXECUTE IMMEDIATE 'DROP TABLE STAGE_CUSTOMER_DATA';
 END IF;
 
 -- The procedure will pull all records that were inserted into (or updated in ) the CUSTOMER table since the date of the last successful refresh
 -- date from the ETL_JOB_STATUS. The data from the source system dumped into STAGE_CUSTOMER_DATA table in the staging area.
 
 SELECT MAX(TRUNC(STATUS_TIMESTAMP)) INTO AS_OF_DATE FROM ETL_JOB_STATUS WHERE ETL_JOB_NAME = 'LOAD_CUSTOMER_DIMENSION' AND STATUS_NAME = 'SUCCESSFULLY COMPLETED';
 SQLSTMT :='CREATE TABLE STAGE_CUSTOMER_DATA'
 ||'AS('
 ||'SELECT'
 ||'CUST_KEY,'
 ||'CUST_NAME,'
 ||'CITY,'
 ||'COUNTRY,'
 ||'CREDIT_LIMIT,'
 ||'E_MAIL_ADDRESS,'
 ||'STATE,'
 ||'Terms_Code,'
 ||'ZIP'
 ||'FROM CUSTOMER';
 
 IF AS_OF_DATE IS NOT NULL THEN
 SQLSTMT := SQLSTMT||'AND (CUSTOMER.INSERT_DATE >= ''' || TO_CHAR(AS_OF_DATE,'DD-MON-YYYY')|| ''' '
 || 'OR CUSTOMER.UPDATE_DATE >= ''' || TO_CHAR(AS_OF_DATE,'DD-MON-YYYY') ||''' '
 || 'OR CUSTOMER.INSERT_DATE >= ''' || TO_CHAR(AS_OF_DATE,'DD-MON-YYYY') ||''' '
 || 'OR CUSTOMER.UPDATE_DATE >= ''' || TO_CHAR(AS_OF_DATE,'DD-MON-YYYY') ||''' ');
 END IF;
 
 
 SQLSTMT := SQLSTMT || ')';
 
 EXECUTE IMMEDIATE SQLSTMT;
 
 -- The full name field is created for each record. The data is then placed 
 -- into  the STAGE_CUSTOMER_DATA_TRANSFORM table(table is dropped if 
 -- it exists and then created below).
 
 SELECT COUNT(*) INTO TBLCOUNT FROM ALL_TABLES WHERE TABLE_NAME ='STAGE_CUSTOMER_DATA_TRANSFORM'
 AND OWNER = 
 (
   SELECT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') FROM DUAL);
   
   IF TBLCOUNT > 0 THEN
     EXECUTE IMMEDIATE 'DROP TABLE STAGE_CUSTOMER_DATA_TRANSFORM';
	 END IF;
 
 
 SQLSTMT := 'CREATE TABLE STAGE_CUSTOMER_DATA_TRANSFORM'
         || 'AS('
		 || 'SELECT'
		 || 'CUST_KEY,'
		 || 'CUST_NAME,'
		 || 'CITY,'
		 || 'COUNTRY,'
		 || 'CREDIT_LIMIT,'
		 || 'E_MAIL_ADDRESS,'
		 || 'STATE,'
		 || 'TERMS_CODE,'
		 || 'ZIP'
		 || 'FROM STAGE_CUSTOMER_DATA)';
		 
		 EXECUTE IMMEDIATE SQLSTMT;
		 
		 
-- Any records containing data that was updated (not new records) as compared
-- to  DIM_ are placed into the STAGE_APPT_DATA_LOAD_UPD

-- table (table is dropped if it exists and then created below).

SELECT COUNT(*) INTO TBLCOUNT
FROM ALL_TABLES WHERE TABLE_NAME = 'STAGE_CUSTOMER_DATA_LOAD_UPD' AND OWNER = 
(
SELECT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') FROM DUAL );

IF TBLCOUNT > 0 THEN
     EXECUTE IMMEDIATE 'DROP TABLE STAGE_CUSTOMER_DATA_LOAD_UPD';
	   END IF;
	   
	   
	   SQLSTMT :='CREATE TABLE STAGE_CUSTOMER_DATA_LOAD_UPD'
	   ||'AS ('
	   ||'SELECT'
	   || 'CUST_KEY,'
	   || 'CUST_NAME,'
	   || 'CITY,'
	   || 'COUNTRY,'
	   || 'CREDIT_LIMIT,'
	   || 'E_MAIL_ADDRESS,'
	   || 'STATE,'
	   || 'TERMS_CODE,'
	   || 'ZIP'
	   || 'FROM STAGE_CUSTOMER_DATA_TRANSFORM
	   || '));
	   
	   EXECUTE IMMEDIATE SQLSTMT;
	   
	   
-- Because the STAGE_EMPLOYEE_DATA_LOAD_UPD table is dropped and recreated
--each time, the index that is necessary to make the update statement work
-- must be rebuilt each time. An organizational role of some sort will need 
-- to make sure that there is no conflict with the name.

SQLSTMT := 'CREATE INDEX INDEX_STAGE_KEY_CUSTOMER ON'
|| 'STAGE_CUSTOMER_DATA_LOAD_UPD(CUST_KEY)';
EXECUTE IMMEDIATE SQLSTMT;


SQLSTMT := 'UPDATE W_CUSTOMER_D'
|| 'SET('CUST_KEY,'
	   || 'CUST_NAME,'
	   || 'CITY,'
	   || 'COUNTRY,'
	   || 'CREDIT_LIMIT,'
	   || 'E_MAIL_ADDRESS,'
	   || 'STATE,'
	   || 'TERMS_CODE,'
	   || 'ZIP') = '
	   || '(SELECT 
	   || 'CUST_KEY,'
	   || 'CUST_NAME,'
	   || 'CITY,'
	   || 'COUNTRY,'
	   || 'CREDIT_LIMIT,'
	   || 'E_MAIL_ADDRESS,'
	   || 'STATE,'
	   || 'TERMS_CODE,'
	   || 'ZIP'
	   || 'FROM STAGE_CUSTOMER_DATA_LOAD_UPD')';
	   
	   EXECUTE IMMEDIATE SQLSTMT;
	   COMMIT;
	   
	   
	   -- Any records containing new records (not data that was updated) are placed
	   --into the STAGE_APPT_DATA_LOAD_NEW table (table is dropped if it exists
	   -- and then created below). The KEY_APPOINT is created using the 
	   -- SEQ_DIM_APPOINTMENT sequence. This sequence is incremented directly in 
	   -- the ETL job (see below) as opposed to using a trigger so that it will be more efficient
	   
	   SELECT COUNT(*) INTO TBLCOUNT FROM ALL_TABLES WHERE TABLE_NAME = 'STAGE_EMPLOYEE_DATA_LOAD_NEW'
	   AND OWNER = 
	   (
	     SELECT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') FROM DUAL);
		 
		 IF TBLCOUNT > 0 THEN
		 EXECUTE IMMEDIATE 'DROP_TABLE STAGE_CUSTOMER_DATA_LOAD_NEW';
		 END IF;
		 
		 
		 
		 
		 
 SQLSTMT :='CREATE TABLE STAGE_CUSTOMER_DATA_LOAD_NEW'
 ||'AS('
 ||'SELECT'
 ||'SEQ_DIM_CUSTOMER.NEXTVAL AS KEY_CUSTOMER,'
 || 'CUST_KEY,'
 || 'CUST_NAME,'
 || 'CITY,'
 || 'COUNTRY,'
 || 'CREDIT_LIMIT,'
 || 'E_MAIL_ADDRESS,'
 || 'STATE,'
 || 'TERMS_CODE,'
 || 'ZIP'
 ||'FROM STAGE_CUSTOMER_DATA_TRANSFORM'
 
 
 EXECUTE IMMEDIATE SQLSTMT;
 
 
 
 -- The new records are added into the W_CUSTOMER_D table
 SQLSTMT :='INSERT INTO W_CUSTOMER_D'
 || '(CUST_KEY,'
 || 'CUST_NAME,'
 || 'CITY,'
 || 'COUNTRY,'
 || 'CREDIT_LIMIT,'
 || 'E_MAIL_ADDRESS,'
 || 'STATE,'
 || 'TERMS_CODE,'
 || 'ZIP'
 || 'SELECT * '
 || 'FROM STAGE_CUSTOMER_DATA_LOAD_NEW';
 
 EXECUTE IMMEDIATE SQLSTMT;
 COMMIT;
 
 
END;
 
	   