from utils.variant import Variant
from collections import List, Dict

alias JSON_QUOTE = '"'
alias JSON_WHITESPACE = " \t\n"
alias JSON_SYNTAX = "{}[],:"
alias JSON_NUMBER = "-0123456789"
alias JSON_ESCAPE = "\\"

alias JSON_LEFTBRACKET = "["
alias JSON_RIGHTBRACKET = "]"
alias JSON_LEFTBRACE = "{"
alias JSON_RIGHTBRACE = "}"
alias JSON_COMMA = ","
alias JSON_COLON = ":"



@value
struct JsonList:
    var _data: List[Value]


@value
struct JsonDict:
    var _data: Dict[String, Value]


alias AnyJsonObject = Variant[
    String, Int, Float64, Bool, NoneType, JsonList, JsonDict
]


@value
struct Value:
    var _variant: AnyJsonObject

    @always_inline
    fn __moveinit__(out self, owned existing: Self):
        self._variant = existing._variant

    @always_inline
    fn __copyinit__(out self, existing: Self):
        self._variant = existing._variant
