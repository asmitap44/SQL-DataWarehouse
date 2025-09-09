/*This script creates bronze layer DDL tables.*/
IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;
create table bronze.crm_cust_info(
cst_id              INT,
    cst_key             NVARCHAR(50),
    cst_firstname       NVARCHAR(50),
    cst_lastname        NVARCHAR(50),
    cst_marital_status  NVARCHAR(50),
    cst_gndr            NVARCHAR(50),
    cst_create_date     DATE
	);
	Go
	IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;
	CREATE TABLE bronze.crm_prd_info (
    prd_id       INT,
    prd_key      NVARCHAR(50),
    prd_nm       NVARCHAR(50),
    prd_cost     INT,
    prd_line     NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt   DATETIME
);
go

IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;
CREATE TABLE bronze.crm_sales_details (
    sls_ord_num  NVARCHAR(50),
    sls_prd_key  NVARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt INT,
    sls_ship_dt  INT,
    sls_due_dt   INT,
    sls_sales    INT,
    sls_quantity INT,
    sls_price    INT
);
GO
IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;
GO

CREATE TABLE bronze.erp_loc_a101 (
    cid    NVARCHAR(50),
    cntry  NVARCHAR(50)
);
IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;
GO


    CREATE TABLE bronze.erp_cust_az12 (
    cid    NVARCHAR(50),
    bdate  DATE,
    gen    NVARCHAR(50)
);


IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;
GO

CREATE TABLE bronze.erp_px_cat_g1v2 (
    id           NVARCHAR(50),
    cat          NVARCHAR(50),
    subcat       NVARCHAR(50),
    maintenance  NVARCHAR(50)
);
GO

truncate table bronze.crm_cust_info;
bulk insert bronze.crm_cust_info 
from 'C:\User_Data\Asmita\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
with (
firstrow=2,
FIELDTERMINATOR=',',
TABLOCK
);

truncate table bronze.crm_prd_info
bulk insert bronze.crm_prd_info
from 'C:\User_Data\Asmita\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
with 
(
firstrow=2,
FIELDTERMINATOR=',',
TABLOCK
);

truncate table bronze.crm_sales_details
bulk insert bronze.crm_sales_details
from 'C:\User_Data\Asmita\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
with 
(
firstrow=2,
FIELDTERMINATOR=',',
TABLOCK
);

truncate table [bronze].[erp_cust_az12]
bulk insert [bronze].[erp_cust_az12]
from 'C:\User_Data\Asmita\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
with 
(
firstrow=2,
FIELDTERMINATOR=',',
TABLOCK
);


truncate table [bronze].[erp_loc_a101]
bulk insert [bronze].[erp_loc_a101]
from 'C:\User_Data\Asmita\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
with 
(
firstrow=2,
FIELDTERMINATOR=',',
TABLOCK
);

truncate table [bronze].[erp_px_cat_g1v2]
bulk insert [bronze].[erp_px_cat_g1v2]
from 'C:\User_Data\Asmita\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
with 
(
firstrow=2,
FIELDTERMINATOR=',',
TABLOCK
);

