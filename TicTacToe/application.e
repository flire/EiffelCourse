note
	description : "TicTacToe application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			game: GAME
			move_item: INTEGER
			user_row, user_column: INTEGER
			user_response: INTEGER
			game_response: INTEGER
		do
			from
				create game.init
				move_item := {FIELD_ITEM}.X
			until
				game.is_finished
			loop
				io.put_string ("Enter the coordinates of your move:")
				io.read_integer
				user_response := io.last_integer
				user_row := user_response // 10
				user_column := user_response \\ 10
				game_response := game.make_move (move_item, user_row, user_column)
				game.print_game_field
				if game_response = {GAME}.is_filled then
					io.put_string("Drawgame.%N")
				elseif game_response = {GAME}.is_won then
					if move_item = {FIELD_ITEM}.x then
						io.put_string ("Crosses have won!%N")
					else
						io.put_string ("Noughts have won!%N")
					end
				end
				if move_item = {FIELD_ITEM}.x then
					move_item := {FIELD_ITEM}.o
				else
					move_item := {FIELD_ITEM}.x
				end

			end
		end

end
