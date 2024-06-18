# from parser import parse, parse_2
from types import Value, JsonDict, JsonList
from testing import assert_equal
from json import any_json_type_to_string
from lexer import lex


# fn test_parse_array() raises -> None:
#     var lex_array = List[AnyJsonType]()
#     lex_array.append(String("["))
#     lex_array.append(1)
#     lex_array.append(String(","))
#     lex_array.append(2)
#     # lex_array.append(String(","))
#     # lex_array.append(3)
#     lex_array.append(String("]"))

#     var res = parse(lex_array)
#     print("Returned List")
#     for i in range(len(res)):
#         print("Item: ", any_json_type_to_string(res[i]))

#     # var i1 = res[0].take[Int]()
#     # assert_equal(i1, 1, "Item 1 should equal 1")


# fn test_parse_object() raises -> None:
#     var lex_array = List[AnyJsonType]()
#     lex_array.append(String("{"))
#     lex_array.append(String("key"))
#     lex_array.append(String(":"))
#     lex_array.append(1)
#     lex_array.append(String(","))
#     lex_array.append(String("key_2"))
#     lex_array.append(String(":"))
#     lex_array.append(String("hello"))
#     lex_array.append(String(","))
#     lex_array.append(String("key_3"))
#     lex_array.append(String(":"))
#     lex_array.append(False)
#     lex_array.append(String(","))
#     lex_array.append(String("key_4"))
#     lex_array.append(String(":"))
#     lex_array.append(1.2)
#     lex_array.append(String("}"))

#     var res = parse(lex_array)
#     for i in res.keys():
#         print("Key: ", i[], "Value: ", any_json_type_to_string(res[i[]]))


# fn test_parse_lex() raises -> None:
#     var lex_array = List[AnyJsonType](
#         String("{"),
#         String("key"),
#         String(":"),
#         1,
#         String(","),
#         String("key_2"),
#         String(":"),
#         String("hello"),
#         String(","),
#         String("key_3"),
#         String(":"),
#         False,
#         String(","),
#         String("key_4"),
#         String(":"),
#         1.2,
#         String("}"),
#     )
#     var res = parse_2(lex_array)
#     print(res)
#     # for i in res.keys():
#     #     print("Key: ", i[], "Value: ", any_json_type_to_string(res[i[]]))


fn test_json_type_to_string() raises -> None:
    var v1 = Value(str("json"))
    print(any_json_type_to_string(v1))

    var v2_list = List[Value]()
    v2_list.append(Value(str("json")))
    v2_list.append(Value(1))
    v2_list.append(Value(1.1))
    v2_list.append(Value(True))
    v2_list.append(Value(False))
    v2_list.append(Value(None))

    var v2 = Value(JsonList(v2_list))
    print(any_json_type_to_string(v2))

    var v3_dict = Dict[String, Value]()
    v3_dict["name"] = Value(str("John"))
    v3_dict["age"] = Value(30)
    v3_dict["wage"] = Value(25.4)
    v3_dict["is_student"] = Value(False)
    v3_dict["has_job"] = Value(True)
    v3_dict["is_null"] = Value(None)

    var v3 = Value(JsonDict(v3_dict))
    print(any_json_type_to_string(v3))

    var job1 = Dict[String, Value]()
    job1["title"] = Value(str("Software Engineer"))
    job1["company"] = Value(str("Google"))
    job1["years"] = Value(2)

    var job2 = Dict[String, Value]()
    job2["title"] = Value(str("Product Manager"))
    job2["company"] = Value(str("Facebook"))
    job2["years"] = Value(3)

    var job3 = Dict[String, Value]()
    job3["title"] = Value(str("Data Scientist"))
    job3["company"] = Value(str("Amazon"))
    job3["years"] = Value(1)

    var john = Dict[String, Value]()
    john["name"] = Value(str("John"))
    john["age"] = Value(30)
    john["wage"] = Value(25.4)
    var john_jobs = List[Value]()
    john_jobs.append(Value(JsonDict(job1)))
    john_jobs.append(Value(JsonDict(job2)))
    john["jobs"] = Value(JsonList(john_jobs))

    var sam = Dict[String, Value]()
    sam["name"] = Value(str("Sam"))
    sam["age"] = Value(25)
    sam["wage"] = Value(20.4)

    var people = List[Value]()
    people.append(Value(JsonDict(john)))
    people.append(Value(JsonDict(sam)))

    var v4_dict = Dict[String, Value]()
    v4_dict["people"] = Value(JsonList(people))
    v4_dict["count"] = Value(2)

    var v4 = Value(JsonDict(v4_dict))
    print(any_json_type_to_string(v4))


fn test_lexor() raises -> None:
    var v1: String = "[1, 2, 3]"
    var tokens = lex(v1)
    # for i in range(len(tokens)):
    #     print("Item: ", any_json_type_to_string(tokens[i]))
    assert_equal(len(tokens), 7, "Length should be 5")


fn run_test(test_fn: fn () raises -> None) -> None:
    print("Running test...")
    try:
        test_fn()
    except e:
        print("Test failed: " + str(e))
    else:
        print("Test passed!")


fn main() raises:
    print("==== STARTING TESTS ====")
    run_test(test_json_type_to_string)
    run_test(test_lexor)

    print("==== FINISHED TESTS ====")
