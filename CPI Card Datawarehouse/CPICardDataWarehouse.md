
# The CPI Card Datawarehouse

I have created a source system consisting of a primary data source, an ERP database and 2 secondary sources spreadsheets.


**Tools used in this project:**

*  SQL Developer
*  DBDesigner.net (For entity relationship diagrams)
*  Microstrategy 10
*  Oracle Database 12.2
*  Pentaho Data Integrator 8.1




[**Source System:**](#sourcesystem)

Primary source : The ERP Database
1. [Entity relationship Diagram](#erdss)
2. [Table Row Counts](#tcss)
3. [Table Descriptions](#tdss)
4. [Source System SQL Scripts](#ssss)

Secondary sources: The lead file and financial summaries



[**Star Schemas:**](#starschema)

1. [Job Star Schema](#jss)
2. [Shipment Star Schema](#sss)
3. [Subjob Star Schema](#sjss)
4. [Lead Star Schema](#lss)
5. [Invoice Schema](#iss)
6. [Financial Cost Summary Star Schema](#fcss)
7. [Financial Sales Summary Star Schema](#fsss)

[**Analysis**](#analysis)

1. [SQL Base Queries](#bq)
2. [Analytical Queries](#aq)
3. [Materialized View Design](#mv)
4. [Summary](#summary)




<a id="sourcesystem"></a>
# The Source System

<a id="erdss"></a>
### Entity Relationship Diagram

<a id="tcss"></a>
### Table Row Counts

<table>
<tr>
   <th>Table Name</th>
   <th>Number of Rows</th>
</tr>
<tr>
   <td>Customer</td>
   <td>3000</td>
</tr>
<tr>
   <td>CustLocation</td>
   <td>1000</td>
</tr>
<tr>
   <td>Invoice</td>
   <td>1000000</td>
</tr>
<tr>
   <td>Job</td>
   <td>100000</td>
</tr>
<tr>
   <td>Location</td>
   <td>10</td>
</tr>
<tr>
   <td>MachineType</td>
   <td>10</td>
</tr>
<tr>
   <td>SalesAgent</td>
   <td>50</td>
</tr>
<tr>
   <td>SalesClass</td>
   <td>6</td>
</tr>
<tr>
   <td>Shipment</td>
   <td>2500000</td>
</tr>
<tr>
   <td>SubJob</td>
   <td>500000</td>
</tr>
<tr>
   <td>LeadFile</td>
   <td>250000</td>
</tr>
<tr>
   <td>Financial Sales Summary</td>
   <td>1800</td>
</tr>
<tr>
   <td>Financial Cost Summary</td>
   <td>5400</td>
</tr>
</table>

<a id="tdss"></a>
### Table Descriptions

<a id="ssss"></a>
### Source System SQL Scripts

To recreate the ERP at once run the <a href=>SourceSystemCreateStatements.sql</a> file to create the tables and 
<a href=>SourceSystemInsertStatements.sql</a> to insert the data. These files were created and tested on Oracle Database 12.2.2

For individual table creations and population run the files in order:

*  <a href=>Customer.sql</a>
*  <a href=>Location.sql</a>
*  <a href=>CustLocation.sql</a>
*  <a href=>SalesAgent.sql</a>
*  <a href=>SalesClass.sql</a>
*  <a href=>MachineType.sql</a>
*  <a href=>Job.sql</a>
*  <a href=>Invoice.sql</a>
*  <a href=>Subjob.sql</a>
*  <a href=>Shipment.sql</a>

The lead file and Financial Summary csv files can be found here 

*  <a href=>Lead File spreadsheet</a>
*  <a href=>Financial Summaries spreadsheet</a>



<a id="starschema"></a>
# Star Schemas

<a id="jss"></a>
## Job Star Schema
**Business Process Description:**


**Technical Description:**

#### Entity Relationship Diagram

#### Table Descriptions

<table>
<tr>
    <th>Cube</th>
    <th>Dimensions</th>
    <th>Measures</th>
</tr>
<tr>
    <td></td>
    <td></td>
</tr>
</table>


<table>
<tr>
    <th>Cube</th>
    <th>Grain</th>
    <th>Unadjusted Size</th>
    <th>Sparsity</th>
</tr>
<tr>
    <td></td>
    <td></td>
</tr>
</table>


<table>
<tr>
    <th>Schema Type</th>
    <th>Dimension tables</th>
    <th>Fact table</th>
    <th>Comments</th>
</tr>
<tr>
    <td></td>
    <td></td>
</tr>
</table>

#### Scripts To Create Tables

#### ETL

#### Verify Against Source System

<a id="sss"></a>
## Shipment Star Schema
**Business Process Description:**


**Technical Description:**

#### Entity Relationship Diagram





#### Table Descriptions

<table>
<tr>
    <th>Cube</th>
    <th>Dimensions</th>
    <th>Measures</th>
</tr>
<tr>
    <td></td>
    <td></td>
</tr>
</table>


<table>
<tr>
    <th>Cube</th>
    <th>Grain</th>
    <th>Unadjusted Size</th>
    <th>Sparsity</th>
</tr>
<tr>
    <td></td>
    <td></td>
</tr>
</table>


<table>
<tr>
    <th>Schema Type</th>
    <th>Dimension tables</th>
    <th>Fact table</th>
    <th>Comments</th>
</tr>
<tr>
    <td></td>
    <td></td>
</tr>
</table>

#### Scripts To Create Tables

#### ETL

#### Verify Against Source System

<a id="sjss"></a>
## Subjob Star Schema
**Business Process Description:**


**Technical Description:**

#### Entity Relationship Diagram

#### Table Descriptions

<table>
<tr>
    <th>Cube</th>
    <th>Dimensions</th>
    <th>Measures</th>
</tr>
<tr>
    <td></td>
    <td></td>
</tr>
</table>


<table>
<tr>
    <th>Cube</th>
    <th>Grain</th>
    <th>Unadjusted Size</th>
    <th>Sparsity</th>
</tr>
<tr>
    <td></td>
    <td></td>
</tr>
</table>


<table>
<tr>
    <th>Schema Type</th>
    <th>Dimension tables</th>
    <th>Fact table</th>
    <th>Comments</th>
</tr>
<tr>
    <td></td>
    <td></td>
</tr>
</table>

#### Scripts To Create Tables

#### ETL

#### Verify Against Source System

<a id="lss"></a>
## Lead Star Schema
**Business Process Description:**


**Technical Description:**

#### Entity Relationship Diagram

#### Table Descriptions

<table>
<tr>
    <th>Cube</th>
    <th>Dimensions</th>
    <th>Measures</th>
</tr>
<tr>
    <td></td>
    <td></td>
</tr>
</table>


<table>
<tr>
    <th>Cube</th>
    <th>Grain</th>
    <th>Unadjusted Size</th>
    <th>Sparsity</th>
</tr>
<tr>
    <td></td>
    <td></td>
</tr>
</table>


<table>
<tr>
    <th>Schema Type</th>
    <th>Dimension tables</th>
    <th>Fact table</th>
    <th>Comments</th>
</tr>
<tr>
    <td></td>
    <td></td>
</tr>
</table>

#### Scripts To Create Tables

#### ETL

#### Verify Against Source System

<a id="iss"></a>
## Invoice Star Schema
**Business Process Description:**


**Technical Description:**

#### Entity Relationship Diagram

#### Table Descriptions

<table>
<tr>
    <th>Cube</th>
    <th>Dimensions</th>
    <th>Measures</th>
</tr>
<tr>
    <td></td>
    <td></td>
</tr>
</table>


<table>
<tr>
    <th>Cube</th>
    <th>Grain</th>
    <th>Unadjusted Size</th>
    <th>Sparsity</th>
</tr>
<tr>
    <td></td>
    <td></td>
</tr>
</table>


<table>
<tr>
    <th>Schema Type</th>
    <th>Dimension tables</th>
    <th>Fact table</th>
    <th>Comments</th>
</tr>
<tr>
    <td></td>
    <td></td>
</tr>
</table>

#### Scripts To Create Tables

#### ETL

#### Verify Against Source System

<a id="fcss"></a>
## Financial Cost Summary Schema
**Business Process Description:**


**Technical Description:**

#### Entity Relationship Diagram

#### Table Descriptions

<table>
<tr>
    <th>Cube</th>
    <th>Dimensions</th>
    <th>Measures</th>
</tr>
<tr>
    <td></td>
    <td></td>
</tr>
</table>


<table>
<tr>
    <th>Cube</th>
    <th>Grain</th>
    <th>Unadjusted Size</th>
    <th>Sparsity</th>
</tr>
<tr>
    <td></td>
    <td></td>
</tr>
</table>


<table>
<tr>
    <th>Schema Type</th>
    <th>Dimension tables</th>
    <th>Fact table</th>
    <th>Comments</th>
</tr>
<tr>
    <td></td>
    <td></td>
</tr>
</table>

#### Scripts To Create Tables

#### ETL

#### Verify Against Source System

<a id="fsss"></a>
## Financial Sales Summary Schema
**Business Process Description:**


**Technical Description:**

#### Entity Relationship Diagram

#### Table Descriptions

<table>
<tr>
    <th>Cube</th>
    <th>Dimensions</th>
    <th>Measures</th>
</tr>
<tr>
    <td></td>
    <td></td>
</tr>
</table>


<table>
<tr>
    <th>Cube</th>
    <th>Grain</th>
    <th>Unadjusted Size</th>
    <th>Sparsity</th>
</tr>
<tr>
    <td></td>
    <td></td>
</tr>
</table>


<table>
<tr>
    <th>Schema Type</th>
    <th>Dimension tables</th>
    <th>Fact table</th>
    <th>Comments</th>
</tr>
<tr>
    <td></td>
    <td></td>
</tr>
</table>

#### Scripts To Create Tables

#### ETL

#### Verify Against Source System

<a id="analysis"></a>
# Analysis

<a id="bq"></a>
#### SQL Base Queries

-  <a href=>Query1</a>
-  <a href=>Query2</a>
-  <a href=>Query3</a>
-  <a href=>Query4</a>
-  <a href=>Query5</a>
-  <a href=>Query6</a>

<a id="aq"></a>
#### Analytical Queries

-  <a href=>Query1</a>
-  <a href=>Query2</a>
-  <a href=>Query3</a>
-  <a href=>Query4</a>
-  <a href=>Query5</a>
-  <a href=>Query6</a>
-  <a href=>Query7</a>
-  <a href=>Query8</a>
-  <a href=>Query9</a>
-  <a href=>Query10</a>

<a id="mv"></a>
#### Material View Design

<a id="summary"></a>
# Summary

## Complete Dashboard 1

![D1Complete.png](attachment:D1Complete.png)

### Dashboard 1 Visualization 1

![D1V1.png](attachment:D1V1.png)

### Dashboard 1 Visualization 2

![D1V2.png](attachment:D1V2.png)

### Dashboard 1 Visualization 3

![D1V3.png](attachment:D1V3.png)

### Dashboard 1 Visualization 4

![D1V4.png](attachment:D1V4.png)

## Complete Dashboard 2

![D2Complete.png](attachment:D2Complete.png)

### Dashboard 2 Visualization 1

![D2V1.png](attachment:D2V1.png)

### Dashboard 2 Visualization 2

![D2V2.png](attachment:D2V2.png)

### Dashboard 2 Visualization 3

![D2V3.png](attachment:D2V3.png)

### Dashboard 2 Visualization 4

![D2V4.png](attachment:D2V4.png)

## Complete Dashboard 3

![D3Complete.png](attachment:D3Complete.png)

### Dashboard 3 Visualization 1

![D3V1.png](attachment:D3V1.png)

### Dashboard 3 Visualization 2

![D3V2.png](attachment:D3V2.png)
