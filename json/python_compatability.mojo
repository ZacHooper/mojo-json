from json.lexer import lex
from json.parser import parse
from json.types import Value
from json.stringify import stringify


fn loads(raw_json: String) raises -> Value:
    print("Lexing JSON")
    var tokens = lex(raw_json)

    print("Parsing JSON")
    var initial_position = 0
    return parse(tokens, initial_position)


fn dumps(value: Value) raises -> String:
    return stringify(value)
