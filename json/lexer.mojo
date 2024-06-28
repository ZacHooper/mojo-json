from json.types import (
    JSON_QUOTE,
    JSON_WHITESPACE,
    JSON_SYNTAX,
    Value,
    JSON_NUMBER,
    JSON_ESCAPE,
)


fn lex_string(string: String, inout position: Int) raises -> String:
    var json_string: String = ""
    var start_of_string = position

    var skip = False

    for i in range(len(string) - position):
        if skip:
            skip = False
            continue
        var c = string[i + start_of_string]
        # Handle empty string
        if c == JSON_QUOTE and len(json_string) == 0:
            position += 1
            return json_string
        elif c == JSON_ESCAPE:
            # Add the escape character and the next character
            json_string += c
            json_string += string[i + start_of_string + 1]
            # Then skip the next character
            skip = True
            continue
        # Handle end of string
        elif c == JSON_QUOTE:
            position += i + 1
            return json_string
        # Handle escape characters
        else:
            json_string += c

    raise Error("Expected end-of-string quote")


fn lex_number(string: String, inout position: Int) raises -> Value:
    var json_number: String = ""
    var number_characters = "1234567890-e."
    var original_position = position

    for i in range(len(string) - position):
        var c = string[i + original_position]
        if c in number_characters:
            json_number += c
        else:
            break

    # Remove the number from the full JSON String
    position += len(json_number)

    if "." in json_number:
        var num = atof(json_number)
        return Value(num)

    return Value(atol(json_number))


fn lex(raw_string: String) raises -> List[Value]:
    var tokens = List[Value]()
    var string = raw_string
    var position: Int = 0

    while position < len(string):
        if string[position] in JSON_WHITESPACE:
            position += 1
            continue
        elif string[position] == JSON_QUOTE:
            position += 1
            var json_string = lex_string(string, position)
            tokens.append(Value(json_string))
        elif string[position] in JSON_NUMBER:
            var json_number = lex_number(string, position)
            tokens.append(json_number)
        elif string[position] == "t":
            tokens.append(Value(True))
            position += 4
        elif string[position] == "f":
            tokens.append(Value(False))
            position += 5
        elif string[position] == "n":
            tokens.append(Value(None))
            position += 4
        elif string[position] in JSON_SYNTAX:
            tokens.append(Value(string[position]))
            position += 1
        else:
            raise Error(
                "Unexpected character: "
                + string[position]
                + " Near: "
                + string[position - 10 : position + 10]
            )

    return tokens
