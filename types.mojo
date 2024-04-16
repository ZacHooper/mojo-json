from utils.variant import Variant

alias JSON_QUOTE = '"'
alias JSON_WHITESPACE = " \t\n"
alias JSON_SYNTAX = "{}[],:"

alias JSON_LEFTBRACKET = "["
alias JSON_RIGHTBRACKET = "]"
alias JSON_LEFTBRACE = "{"
alias JSON_RIGHTBRACE = "}"
alias JSON_COMMA = ","
alias JSON_COLON = ":"

alias AnyJsonType = Variant[String, Int, Float64, Bool, NoneType]
alias AnyJsonObject = Variant[
    String, Int, Float64, Bool, NoneType, List[AnyJsonType], Dict[String, AnyJsonType]
]
