from parser import parse
from types import AnyJsonType, AnyJsonObject
from testing import assert_equal
from json import any_json_type_to_string


fn test_parse_array() raises -> None:
    var lex_array = List[AnyJsonType]()
    lex_array.append(String("["))
    lex_array.append(1)
    lex_array.append(String(","))
    lex_array.append(2)
    # lex_array.append(String(","))
    # lex_array.append(3)
    lex_array.append(String("]"))

    var res = parse(lex_array)
    print("Returned List")
    for i in range(len(res)):
        print("Item: ", any_json_type_to_string(res[i]))

    # var i1 = res[0].take[Int]()
    # assert_equal(i1, 1, "Item 1 should equal 1")


fn test_parse_object() raises -> None:
    var lex_array = List[AnyJsonType]()
    lex_array.append(String("{"))
    lex_array.append(String("key"))
    lex_array.append(String(":"))
    lex_array.append(1)
    lex_array.append(String(","))
    lex_array.append(String("key_2"))
    lex_array.append(String(":"))
    lex_array.append(String("hello"))
    lex_array.append(String(","))
    lex_array.append(String("key_3"))
    lex_array.append(String(":"))
    lex_array.append(False)
    lex_array.append(String(","))
    lex_array.append(String("key_4"))
    lex_array.append(String(":"))
    lex_array.append(1.2)
    lex_array.append(String("}"))

    var res = parse(lex_array)
    for i in res.keys():
        print("Key: ", i[], "Value: ", any_json_type_to_string(res[i[]]))


fn main() raises:
    test_parse_object()
