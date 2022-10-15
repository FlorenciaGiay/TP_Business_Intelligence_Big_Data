DECLARE @TicketList TABLE(nro_ticket varchar(20))
DECLARE @nro_ticket varchar(20)
    
INSERT @TicketList(nro_ticket)
SELECT nro_ticket
FROM Venta
    
WHILE(1 = 1)
BEGIN
            
    SET @nro_ticket = NULL
    SELECT TOP(1) @nro_ticket = nro_ticket
    FROM @TicketList
    
    IF @nro_ticket IS NULL
        BREAK
            
    --- empieza el for interno
			
			DECLARE @itemList TABLE(codigo_item INT)
			DECLARE @codigo_item INT
			declare @tipo_visita int 
			DECLARE @numeros table(numero int)
			
			insert into @numeros 
			SELECT 1 as numero
			UNION
			SELECT 2
			UNION
			select 3
			UNION
			SELECT 4
			UNION
			SELECT 5
			UNION
			SELECT 6
			UNION
			select 7
			UNION
			SELECT 8
			UNION
			select 9

			INSERT @itemList(codigo_item)
			SELECT id_item_venta
			FROM Item_venta
			where nro_ticket = @nro_ticket
    
			WHILE(1 = 1)
			BEGIN
            
				SET @codigo_item = NULL
				SELECT TOP(1) @codigo_item = codigo_item
				FROM @itemList
    
				IF @codigo_item IS NULL
					BREAK
            
				--@tipo_visita = ABS(CAST(NEWID() as binary(6)) % 9) + 1
				SET @tipo_visita = NULL
				select top(1) @tipo_visita = numero
				from @numeros
				order by newid()
				update Item_venta set código_tipo_visita = @tipo_visita where id_item_venta = @codigo_item
				delete from @numeros where numero = @tipo_visita
    
				DELETE TOP(1) FROM @itemList
    
			END

	--- termina for interno
    
    DELETE TOP(1) FROM @TicketList
    
END

