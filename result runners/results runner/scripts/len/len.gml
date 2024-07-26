// scrip
function len(thing){
	if typeof(thing) == "number" {
		return string_length(string(thing));
	} else if typeof(thing) == "string" {
		return string_length(thing);
	} else if typeof(thing) == "array" {
		return array_length(thing);
	}
}