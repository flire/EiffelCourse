note
	description: "Summary description for {GAME}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GAME

create {ANY}
	make_with_max
feature {ANY}
	make_with_max(max_number_arg: INTEGER)
		local
			random_number: INTEGER
			random: RANDOM
			time: TIME
		do
			max_number := max_number_arg
			create time.make_now
			create random.set_seed (time.second)
			random.forth
			random_number := random.item
			random_number := random_number \\ max_number
			number_to_guess := random_number
		end

	guess(user_number:INTEGER):COMPARISON_RESULT
		local
			comp_result: COMPARISON_RESULT
		do
			if user_number<number_to_guess then
				create comp_result.make_with_value(1)
			elseif user_number>number_to_guess then
				create comp_result.make_with_value(-1)
			else
				create comp_result.make_with_value(0)
			end
			Result:=comp_result
		end

	print_number
		do
			io.put_integer (number_to_guess)
		end
feature {SOLVER}
	max_number: INTEGER
feature {NONE}
	number_to_guess: INTEGER
end
