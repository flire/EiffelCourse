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
		require
			initValueIsCorrect: initValue=0 or initValue=1 or initValue=-1
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
		ensure
			valueIsNotModified: value = old value
		end
feature {GAME}
	set_value(arg_value:INTEGER)
	require
		valueIsCorrect: arg_value=0 or arg_value=1 or arg_value=-1
	do
		value := arg_value
	end

invariant
	valueIsCorrect: value=0 or value=1 or value=-1
end
