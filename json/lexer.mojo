from json.types import JSON_QUOTE, JSON_WHITESPACE, JSON_SYNTAX, Value


@value
struct LexResult:
    var value: Value
    var is_null: Bool

    fn __init__(inout self, value: Value, is_null: Bool):
        self.value = value
        self.is_null = is_null


fn lex_string(inout string: String) raises -> LexResult:
    var json_string: String = ""

    if string[0] == JSON_QUOTE:
        string = string[1:]
    else:
        return LexResult(Value(None), True)

    for i in range(len(string)):
        if string[i] == JSON_QUOTE:
            string = string[i + 1 :]
            return LexResult(Value(json_string), False)
        else:
            json_string += string[i]

    raise Error("Expected end-of-string quote")


fn lex_number(inout string: String) raises -> LexResult:
    var json_number: String = ""
    var number_characters = "1234567890-e."

    for i in range(len(string)):
        var c = string[i]
        if c in number_characters:
            json_number += c
        else:
            break

    # Remove the number from the full JSON String
    string = string[len(json_number) :]

    if not len(json_number):
        return LexResult(Value(None), True)

    if "." in json_number:
        var float_string_split = json_number.split(".")
        var integer_part = atol(float_string_split[0])
        var decimal_part = atol(float_string_split[1])
        var num = integer_part + (decimal_part / 10)
        return LexResult(Value(num), False)

    return LexResult(Value(atol(json_number)), False)


fn lex_bool(inout string: String) -> LexResult:
    if string.startswith("true"):
        string = string[4:]
        return LexResult(Value(True), False)
    elif string.startswith("false"):
        string = string[5:]
        return LexResult(Value(False), False)
    else:
        return LexResult(Value(None), True)


fn lex_null(inout string: String) -> LexResult:
    if string.startswith("null"):
        string = string[4:]
        return LexResult(Value(None), True)
    else:
        return LexResult(Value(None), False)


fn lex(raw_string: String) raises -> List[Value]:
    var tokens = List[Value]()
    var string = raw_string

    while len(string):
        var json_string = lex_string(string)
        if json_string.is_null == False:
            tokens.append(json_string.value)
            continue

        var json_number = lex_number(string)
        if json_number.is_null == False:
            tokens.append(json_number.value)
            continue

        var json_bool = lex_bool(string)
        if json_bool.is_null == False:
            tokens.append(json_bool.value)
            continue

        var json_null = lex_null(string)
        if json_null.is_null == True:
            tokens.append(Value(None))
            continue

        if string[0] in JSON_WHITESPACE:
            string = string[1:]
        elif string[0] in JSON_SYNTAX:
            tokens.append(Value(string[0]))
            string = string[1:]
        else:
            raise Error(
                "Unexpected character: " + string[0] + " Near: " + string[1:]
            )

    return tokens
