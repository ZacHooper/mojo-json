from types import *
from json import any_json_type_to_string


def is_special_token(token: AnyJsonType, special_token: String) -> Bool:
    if token.isa[String]():
        var t = token.get[String]()[]
        return t == special_token
    return False


# def parse_array(inout tokens: List[AnyJsonObject]) -> List[AnyJsonObject]:
#     var json_array = List[AnyJsonObject]()

#     t = tokens[0]
#     if is_special_token(t, JSON_RIGHTBRACKET):
#         tokens = tokens[1:]
#         return json_array

#     while True:
#         json = parse(tokens)
#         json_array.append(json)

#         t = tokens[0]
#         if is_special_token(t, JSON_RIGHTBRACKET):
#             tokens = tokens[1:]
#             return json_array
#         elif is_special_token(t, JSON_COMMA):
#             raise Error("Expected comma after object in array")
#         else:
#             tokens = tokens[1:]

#     raise Error("Expected end-of-array bracket")


# def parse_array(inout tokens: List[AnyJsonType]) -> List[AnyJsonType]:
#     var json_array = List[AnyJsonType]()
#     var t = tokens[0]
#     if is_special_token(t, JSON_RIGHTBRACKET):
#         tokens = tokens[1:]
#         return json_array

#     while len(tokens) > 0:
#         t = tokens[0]
#         # var obj = parse(tokens)
#         json_array.append(t)

#         tokens = tokens[1:]
#         if is_special_token(t, JSON_RIGHTBRACKET):
#             tokens = tokens[1:]
#             return json_array
#         elif is_special_token(t, JSON_COMMA):
#             tokens = tokens[1:]
#         else:
#             tokens = tokens[1:]

#     return json_array


# def parse(inout tokens: List[AnyJsonType]) -> List[AnyJsonType]:
#     """Testing to work out JSON list"""
#     var t = tokens[0]

#     for i in range(len(tokens)):
#         print(any_json_type_to_string(tokens[i]))

#     if is_special_token(t, JSON_LEFTBRACKET):
#         print("parse_array")
#         tokens = tokens[1:]
#         for i in range(len(tokens)):
#             print(any_json_type_to_string(tokens[i]))
#         return parse_array(tokens)
#     return t
#     # # elif t == JSON_LEFTBRACE:
#     # #     return parse_object(tokens[1:])
#     # else:
#     #     return t


def parse_object(inout tokens: List[AnyJsonType]) -> Dict[String, AnyJsonObject]:
    var t = tokens[0]
    var json_object = Dict[String, AnyJsonObject]()
    # if t.isa[String]():
    #     json_object[t.get[String]()[]] = 1
    json_object[String("key")] = 1

    return json_object


fn parse(inout tokens: List[AnyJsonType]) raises -> Dict[String, AnyJsonType]:
    """testing to workout JSON object."""
    var output = Dict[String, AnyJsonType]()
    var t = tokens[0]
    tokens = tokens[1:]
    if is_special_token(t, JSON_LEFTBRACE):
        while len(tokens) > 0:
            if is_special_token(tokens[0], JSON_RIGHTBRACE):
                tokens = tokens[1:]
                return output
            if is_special_token(tokens[0], JSON_COMMA):
                tokens = tokens[1:]
                continue
            var key = tokens[0]
            tokens = tokens[1:]
            if is_special_token(tokens[0], JSON_COLON) == False:
                raise Error("Expected colon after key in object")
            tokens = tokens[1:]
            var value = tokens[0]
            tokens = tokens[1:]
            output[key.get[String]()[]] = value
    return output

