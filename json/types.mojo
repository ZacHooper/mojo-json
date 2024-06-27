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
struct JsonList(CollectionElement):
    var _data: List[Value]


@value
struct JsonDict(CollectionElement):
    var _data: Dict[String, Value]


alias AnyJsonObject = Variant[
    String, Int, Float64, Bool, NoneType, JsonList, JsonDict
]


@value
struct Value(CollectionElement):
    var _variant: AnyJsonObject

    @always_inline
    fn __moveinit__(inout self, owned existing: Self):
        self._variant = existing._variant

    @always_inline
    fn __copyinit__(inout self, existing: Self):
        self._variant = existing._variant
