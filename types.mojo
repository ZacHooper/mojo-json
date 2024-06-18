from utils.variant import Variant
from collections import List, Dict

alias JSON_QUOTE = '"'
alias JSON_WHITESPACE = " \t\n"
alias JSON_SYNTAX = "{}[],:"

alias JSON_LEFTBRACKET = "["
alias JSON_RIGHTBRACKET = "]"
alias JSON_LEFTBRACE = "{"
alias JSON_RIGHTBRACE = "}"
alias JSON_COMMA = ","
alias JSON_COLON = ":"

# alias AnyJsonType = Variant[String, Int, Float64, Bool, NoneType]
# alias AnyJsonObject = Variant[
#     String,
#     Int,
#     Float64,
#     Bool,
#     NoneType,
#     List[AnyJsonType],
#     Dict[String, AnyJsonType],
# ]


@value
struct JsonList(CollectionElement):
    var _data: List[JsonValue]


@value
struct JsonDict(CollectionElement):
    var _data: Dict[String, JsonValue]


alias AnyJsonObject = Variant[
    String, Int, Float64, Bool, NoneType, JsonList, JsonDict
]


@value
struct JsonValue(CollectionElement):
    var _variant: AnyJsonObject

    @always_inline
    fn __moveinit__(inout self, owned existing: Self):
        self._variant = existing._variant

    @always_inline
    fn __copyinit__(inout self, existing: Self):
        self._variant = existing._variant
