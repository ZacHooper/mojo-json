from json.lexer import lex
from json.parser import parse
from json.types import Value
from json.stringify import stringify


fn loads(raw_json: String) raises -> Value:
    var tokens = lex(raw_json)
    return parse(tokens)


fn dumps(value: Value) raises -> String:
    return stringify(value)
