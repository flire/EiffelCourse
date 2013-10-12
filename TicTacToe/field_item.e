note
	description: "Summary description for {FIELD_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FIELD_ITEM
create {ANY}
	make
feature {ANY}
	value: INTEGER assign set_value
	X: INTEGER = 1
	O: INTEGER = -1
	empty: INTEGER = 0
	make(initValue:INTEGER)
		do
			value := initValue
		end
	print_value
		do
			inspect value
			when X then
				io.put_character ('X')
			when O then
				io.put_character ('O')
			else
				io.put_character (' ')
			end
		end
feature {GAME}
	set_value(arg_value:INTEGER)
		do
			value := arg_value
		end
end
