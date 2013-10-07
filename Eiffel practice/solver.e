note
	description: "Summary description for {SOLVER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SOLVER
create
	solve
feature {ANY}
	solve(game: GAME)
		local
			current_number: INTEGER
			comparison_result: COMPARISON_RESULT
			current_response: STRING
		do
			create log.make
			section := [0, game.max_number]
			from
				current_number := (section.left + section.right) // 2
				comparison_result := game.guess (current_number)
				number_of_attempts:=1
			until
				comparison_result.value = {COMPARISON_RESULT}.isequal
			loop
				current_response := "Number is"
				inspect comparison_result.value
				when {COMPARISON_RESULT}.isLess then
					section.right := current_number - 1
					current_response.append (" less than ")
						--io.put_string ("Solver: less%N")
				else
					--io.put_string ("Solver: more%N")
					section.left := current_number + 1
					current_response.append (" more than ")
				end
				current_response.append_integer (current_number)
				current_response.append_character ('%N')
				log.extend(current_response)
				current_number := (section.left + section.right) // 2
				comparison_result := game.guess (current_number)
				number_of_attempts:= number_of_attempts + 1
			end
			current_response := "Number is equal to "
			current_response.append_integer (current_number)
			current_response.append_character ('%N')
			log.extend (current_response)
		end

	print_solution
		do
			across log as item loop io.put_string (item.item)  end
			io.put_string ("Number of attempts:")
			io.put_integer (number_of_attempts)
			io.new_line
		end
feature {NONE}
	number_of_attempts: INTEGER
	section: TUPLE[left, right:INTEGER]
	log: LINKED_LIST[STRING]
end
