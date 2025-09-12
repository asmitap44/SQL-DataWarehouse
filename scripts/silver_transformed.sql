/*Transformations rules*/
INSERT INTO silver.crm_cust_info( 
cst_id,
cst_key,
cst_firstname,
cst_lastname,
cst_marital_status,
cst_gndr,
cst_create_date)

SELECT [cst_id]
      ,[cst_key]
      ,trim(cst_firstname) as cst_firstname
      ,trim(cst_lastname) as cst_lastname
     
      ,case when cst_marital_status='S' then 'Single'
	        when cst_marital_status='M' then 'Married'
			else 'n/a'
	   end as cst_marital_status
	  ,case when cst_gndr='M' then 'Male'
	        when cst_gndr='F' then 'Female'
			else 'n/a'
	   end as cst_gndr
      ,[cst_create_date]
  FROM (
  select *,
  ROW_NUMBER()over(partition by cst_id order by cst_create_date desc) as flag_last
  from bronze.crm_cust_info
  where cst_id IS NOT NULL)t
  where flag_last=1
