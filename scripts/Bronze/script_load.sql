/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/
create or alter procedure bronze.load_bronze as
BEGIN
	 DECLARE @start_time DATETIME,@end_time DATETIME;
	BEGIN TRY
				set @start_time=getdate()
				truncate table bronze.crm_cust_info;
				bulk insert bronze.crm_cust_info 
				from 'C:\User_Data\Asmita\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
				with (
				firstrow=2,
				FIELDTERMINATOR=',',
				TABLOCK
				);
				set @end_time=getdate()

				print 'Time to Load: ' + cast(DATEDIFF(second,@start_time,@end_time) as varchar);

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
			END TRY
			BEGIN CATCH
				PRINT '======================================'
				PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
				PRINT 'ERROR NUMBER' + cast (ERROR_NUMBER() as varchar);
				PRINT '======================================'
			END CATCH
END;
