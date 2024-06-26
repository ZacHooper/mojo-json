from json.types import *
from json.stringify import any_json_type_to_string, stringify


fn is_special_token(token: Value, special_token: String) -> Bool:
    if token._variant.isa[String]():
        var t = token._variant[String]
        return t == special_token
    return False


fn parse_array(tokens: List[Value], inout position: Int) raises -> Value:
    # First check if this is the end of the array
    var first_token = tokens[position]
    var json_array = List[Value]()
    if is_special_token(first_token, JSON_RIGHTBRACKET):
        return Value(JsonList(json_array))

    # Loop through each token in the array. If Comma move to the next token
    # If RightBracket, return the array
    while len(tokens) > 0:
        var next_token = tokens[position]
        if is_special_token(next_token, JSON_RIGHTBRACKET):
            return Value(JsonList(json_array))
        elif is_special_token(next_token, JSON_COMMA):
            # tokens = tokens[1:]
            position += 1
        else:
            var parsed_token = parse(tokens, position)
            json_array.append(parsed_token)
            # tokens = tokens[1:]
            position += 1

    return Value(JsonList(json_array))


fn parse_object(tokens: List[Value], inout position: Int) raises -> Value:
    # Make sure it's not an empty object
    var first_token = tokens[position]
    var json_object = Dict[String, Value]()
    if is_special_token(first_token, JSON_RIGHTBRACE):
        return Value(JsonDict(json_object))

    # Loop through each key-value pair in the object
    while len(tokens) > 0:
        # Get the key
        var key = tokens[position]

        # Check if key is special token
        if is_special_token(key, JSON_RIGHTBRACE):
            return Value(JsonDict(json_object))
        if is_special_token(tokens[position], JSON_COMMA):
            # tokens = tokens[1:]
            position += 1
            continue

        # Check next token is a colon
        # tokens = tokens[1:]
        position += 1
        if is_special_token(tokens[position], JSON_COLON) == False:
            raise Error("Expected colon after key in object")

        # Get the value of the key
        # tokens = tokens[1:]
        position += 1
        var value = parse(tokens, position)
        json_object[key._variant[String]] = value
        # tokens = tokens[1:]
        position += 1

    return Value(JsonDict(json_object))


fn parse(tokens: List[Value], inout position: Int) raises -> Value:
    var first_token = tokens[position]

    if is_special_token(first_token, JSON_LEFTBRACE):
        # tokens = tokens[1:]
        position += 1
        return parse_object(tokens, position)
    if is_special_token(first_token, JSON_LEFTBRACKET):
        # tokens = tokens[1:]
        position += 1
        return parse_array(tokens, position)

    return first_token
