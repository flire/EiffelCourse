note
	description: "Summary description for {COMPARISON_RESULT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COMPARISON_RESULT
create {GAME}
	make_with_value
feature {GAME}
	make_with_value(arg_value:INTEGER)
	 do
	 	value := arg_value
	 end
feature {ANY}
	isLess: INTEGER = -1
	isMore: INTEGER = 1
	isEqual: INTEGER = 0
	value: INTEGER
end
