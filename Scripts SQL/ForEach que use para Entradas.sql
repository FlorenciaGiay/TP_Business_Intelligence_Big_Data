DECLARE @TicketList TABLE(nro_ticket varchar(20))
DECLARE @nro_ticket varchar(20)
    
INSERT @TicketList(nro_ticket)
SELECT numero_ticket
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
			declare @producto int 
			declare @control int
			DECLARE @productosUsados table(codigo int)
			
			/*insert into @numeros 
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
			select 9*/

			INSERT @itemList(codigo_item)
			SELECT id_item_venta
			FROM tabla_backup
			where numero_ticket = @nro_ticket
    
			WHILE(1 = 1)
			BEGIN
            
				SET @codigo_item = NULL
				SELECT TOP(1) @codigo_item = codigo_item
				FROM @itemList
    
				IF @codigo_item IS NULL
					BREAK
            
				
				SET @producto = NULL
				select top(1) @producto = id_producto
				from tabla_backup
				where id_item_venta = @codigo_item
				
				--set @control = 0
				while (1=1)
				begin
					if @producto not in (select codigo from @productosUsados)
						begin
							insert into @productosUsados select @producto
							break
							--set @control = 1
						end
					else
						begin
							if @producto < 44
								begin
									update tabla_backup set id_producto = @producto + 5 where id_item_venta = @codigo_item
									set @producto = @producto + 5
								end
							else
								begin
									update tabla_backup set id_producto = @producto - 5 where id_item_venta = @codigo_item
									set @producto = @producto - 5
								end
						end
						--update tabla_backup set id_producto = case when id_producto < 44 then id_producto + 5 else id_producto - 5 end where id_item_venta = @codigo_item
				end
    
				DELETE TOP(1) FROM @itemList
    
			END

	--- termina for interno
    
    DELETE TOP(1) FROM @TicketList
    
END
