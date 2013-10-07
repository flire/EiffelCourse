note
	description : "project application root class"
	date        : "$Date$"
	revision    : "$Revision$"
	author: "Dmitry Tishchenko"

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
			random_number: INTEGER
			comparison_result: COMPARISON_RESULT
			user_number: INTEGER
			game: GAME
			solver: SOLVER
			number_of_attempts: INTEGER
		do
			create game.make_with_max(1000)

			from
				io.read_integer
				user_number := io.last_integer
				comparison_result := game.guess (user_number)
				number_of_attempts := 1
			until
				comparison_result.value = {COMPARISON_RESULT}.isequal
			loop
				inspect comparison_result.value
				when {COMPARISON_RESULT}.isMore then
					io.put_string ("More!%N")
				else
					io.put_string ("Less!%N")
				end
				io.read_integer
				user_number := io.last_integer
				comparison_result := game.guess (user_number)
				number_of_attempts := number_of_attempts + 1
			end

			io.put_string ("Equal!%N")
			game.print_number
			io.new_line
			io.put_string ("Number of attempts:")
			io.put_integer (number_of_attempts)
			io.new_line

			create solver.solve (game)
			solver.print_solution
		end
end
