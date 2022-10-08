create procedure InsertarFecha
   @CurrentDate datetime
as
insert into DT_Tiempo(
	   dia,
	   semana,
       mes, 
	   trimestre, 
	   anio)
   values(
      DATEPART(day , @CurrentDate), 
	  datediff(ww,datediff(d,0,dateadd(m,datediff(m,7,@CurrentDate),0))/7*7,dateadd(d,-1,@CurrentDate))+1, 
	  DATEPART(month , @CurrentDate),
      CASE WHEN DATEPART(month, @CurrentDate) < 5 then 1 when DATEPART(month, @CurrentDate) > 8 then 3 else 2 end,
      DATEPART(year , @CurrentDate)
   )
GO

declare @StartDate datetime, @EndDate datetime
set @StartDate = '20190101'
set @EndDate = GETDATE()
while @StartDate <= @EndDate begin
   exec InsertarFecha @StartDate
   set @StartDate = dateadd(day,1,@StartDate)
end;