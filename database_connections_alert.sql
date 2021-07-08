CREATE TABLE #blocking_limit (
    spid INT,  
    status VARCHAR(100) NULL,  
    login SYSNAME NULL,  
    hostname SYSNAME NULL,  
    blkby VARCHAR(10) NULL,  
    dbName SYSNAME NULL,  
    command VARCHAR(1000) NULL,  
    cputime INT NULL,  
    diskio INT NULL,  
    lastbatch VARCHAR(50) NULL,  
    programname VARCHAR(100) NULL,  
    spid_b INT,
    requestid INT)
 
INSERT INTO #blocking_limit
EXEC sp_who2
 
IF (SELECT COUNT(*) FROM #blocking_limit) > 1000
BEGIN
EXEC msdb.dbo.sp_send_dbmail
     @profile_name = 'sql',
     @recipients = 'SQLServerDBA@ci.charlotte.nc.us; kenneth.magee@charlottenc.gov',
     @subject = 'Munis Connections Exceeding 1000'
END
   
DROP TABLE #blocking_limit