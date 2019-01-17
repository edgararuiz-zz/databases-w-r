-- !preview conn=DBI::dbConnect(odbc(), Driver = "SQL Server", Server = "localhost\\SQLEXPRESS", Database = "datawarehouse", Trusted_Connection = "True")

select top 100 * from airports 