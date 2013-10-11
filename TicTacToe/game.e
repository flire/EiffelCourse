note
	description: "Summary description for {GAME}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GAME
create
	init
feature {ANY}
	is_running: INTEGER = 0
	is_filled: INTEGER = 1
	is_won: INTEGER = 2
	is_finished: BOOLEAN
	init
		local
			fieldPlaceholder: FIELD_ITEM
			row, column: INTEGER
		do
			is_finished:=FALSE
			create fieldPlaceholder.make({FIELD_ITEM}.empty)
			create field.make_filled(fieldPlaceholder, 3, 3)
			from
				row:=1
			until
				row > field.height
			loop
				from
					column:=1
				until
					column > field.width
				loop
					field.put (fieldPlaceholder.twin, row, column)
					column := column + 1
				end
				row:=row+1
			end
		end
	make_move(item, row, column: INTEGER): INTEGER
		do
			field.item(row, column).value:=item
			Result:=check_field.status
			if Result/=is_running then
				is_finished:=TRUE
			end
		end
	print_game_field
		local
			row, column: INTEGER
		do
			from
				row:=1
			until
				row > field.height
			loop
				from
					column:=1
				until
					column > field.width
				loop
					field.item (row, column).print_value
					column := column + 1
				end
				row:=row+1
				io.new_line
			end
			io.new_line
		end
feature {NONE}
	field: ARRAY2[FIELD_ITEM]
	check_field: TUPLE [status, winner: INTEGER]
	--контракт: если игра выиграна, есть победитель, если игра закончилась или идёт, победитель не задан
		local
			row_sum: ARRAY[INTEGER]
			column_sum: ARRAY[INTEGER]
			diagonal_sum: TUPLE[straight,reverse: INTEGER]
			row, column: INTEGER
			element: INTEGER
			counter: INTEGER
		do
			--init
			create row_sum.make_filled (0, 1, 3)
			create column_sum.make_filled (0, 1, 3)
			diagonal_sum:=[0,0];
			counter := 0
			Result:= [is_running,{FIELD_ITEM}.empty]
			--count
			from
				row:=1
			until
				row > field.height
			loop
				from
					column:=1
				until
					column > field.width
				loop
					element := field.item (row, column).value

					row_sum[row] := row_sum[row] + element
					column_sum.put(column_sum.item (column) + element , column)
					if column = row then
						diagonal_sum.straight := diagonal_sum.straight + element
					end
					if column+row = 4 then
						diagonal_sum.reverse := diagonal_sum.reverse + element
					end
					if element/={FIELD_ITEM}.empty then counter := counter + 1 end

					column := column + 1
				end
				row:=row+1
			end
			--check for result
			if across row_sum as item_counter some item_counter.item = {FIELD_ITEM}.x*3 end then
				Result.status := is_won
				Result.winner := {FIELD_ITEM}.x
			end
			if across row_sum as item_counter some item_counter.item = {FIELD_ITEM}.O*3 end then
				Result.status := is_won
				Result.winner := {FIELD_ITEM}.O
			end
			if across column_sum as item_counter some item_counter.item = {FIELD_ITEM}.x*3 end then
				Result.status := is_won
				Result.winner := {FIELD_ITEM}.x
			end
			if across column_sum as item_counter some item_counter.item = {FIELD_ITEM}.O*3 end then
				Result.status := is_won
				Result.winner := {FIELD_ITEM}.O
			end
			if diagonal_sum.straight = {FIELD_ITEM}.x*3 then
				Result.status := is_won
				Result.winner := {FIELD_ITEM}.X
			elseif diagonal_sum.straight = {FIELD_ITEM}.O*3 then
				Result.status := is_won
				Result.winner := {FIELD_ITEM}.O
			end
			if diagonal_sum.reverse = {FIELD_ITEM}.x*3 then
				Result.status := is_won
				Result.winner := {FIELD_ITEM}.X
			elseif diagonal_sum.reverse = {FIELD_ITEM}.O*3 then
				Result.status := is_won
				Result.winner := {FIELD_ITEM}.O
			end
			if Result.status = is_running and counter = 9 then
				Result.status := is_filled
			end
		end

end
