from parser import parse
from types import Value, JsonDict, JsonList
from testing import assert_equal
from stringify import any_json_type_to_string, stringify
from lexer import lex


fn test_parse_array() raises -> None:
    var tokens = List[Value]()
    tokens.append(Value(String("[")))
    tokens.append(Value(1))
    tokens.append(Value(String(",")))
    tokens.append(Value(2))
    tokens.append(Value(String(",")))
    tokens.append(Value(3))
    tokens.append(Value(String("]")))

    var res = parse(tokens)
    print(stringify(res))

    var json_list = res._variant[JsonList]._data
    assert_equal(len(json_list), 3, "Length should be 3")

    fn check_element(index: Int, value: Int) raises -> None:
        assert_equal(
            json_list[index]._variant.take[Int](),
            value,
            "Element should be " + str(value),
        )

    check_element(0, 1)
    check_element(1, 2)
    check_element(2, 3)


fn test_parse_object() raises -> None:
    var lex_array = List[Value]()
    lex_array.append(Value(String("{")))
    lex_array.append(Value(String("key")))
    lex_array.append(Value(String(":")))
    lex_array.append(Value(1))
    lex_array.append(Value(String(",")))
    lex_array.append(Value(String("key_2")))
    lex_array.append(Value(String(":")))
    lex_array.append(Value(String("hello")))
    lex_array.append(Value(String(",")))
    lex_array.append(Value(String("key_3")))
    lex_array.append(Value(String(":")))
    lex_array.append(Value(False))
    lex_array.append(Value(String(",")))
    lex_array.append(Value(String("key_4")))
    lex_array.append(Value(String(":")))
    lex_array.append(Value(1.2))
    lex_array.append(Value(String("}")))

    var res = parse(lex_array)
    print(stringify(res))

    var json_dict = res._variant[JsonDict]._data
    assert_equal(len(json_dict), 4, "Length should be 4")

    fn check_element(key: String, value: Value) raises -> None:
        assert_equal(
            any_json_type_to_string(json_dict[key]),
            any_json_type_to_string(value),
            "Element should be " + any_json_type_to_string(value),
        )

    check_element("key", Value(1))
    check_element("key_2", Value(String("hello")))
    check_element("key_3", Value(False))
    check_element("key_4", Value(1.2))


fn test_parse_object_with_array() raises -> None:
    var lex_array = List[Value]()
    lex_array.append(Value(String("{")))
    lex_array.append(Value(String("key")))
    lex_array.append(Value(String(":")))
    lex_array.append(Value(1))
    lex_array.append(Value(String(",")))
    lex_array.append(Value(String("key_2")))
    lex_array.append(Value(String(":")))
    lex_array.append(Value(String("hello")))
    lex_array.append(Value(String(",")))
    lex_array.append(Value(String("key_3")))
    lex_array.append(Value(String(":")))
    lex_array.append(Value(False))
    lex_array.append(Value(String(",")))
    lex_array.append(Value(String("key_4")))
    lex_array.append(Value(String(":")))
    lex_array.append(Value(1.2))
    lex_array.append(Value(String(",")))
    lex_array.append(Value(String("key_5")))
    lex_array.append(Value(String(":")))
    lex_array.append(Value(String("[")))
    lex_array.append(Value(1))
    lex_array.append(Value(String(",")))
    lex_array.append(Value(2))
    lex_array.append(Value(String(",")))
    lex_array.append(Value(3))
    lex_array.append(Value(String("]")))
    lex_array.append(Value(String("}")))

    var res = parse(lex_array)
    print(stringify(res))

    var json_dict = res._variant[JsonDict]._data
    assert_equal(len(json_dict), 5, "Length should be 5")

    fn check_element(key: String, value: Value) raises -> None:
        assert_equal(
            any_json_type_to_string(json_dict[key]),
            any_json_type_to_string(value),
            "Element should be " + any_json_type_to_string(value),
        )

    check_element("key", Value(1))
    check_element("key_2", Value(String("hello")))
    check_element("key_3", Value(False))
    check_element("key_4", Value(1.2))
    var expected_list = List[Value]()
    expected_list.append(Value(1))
    expected_list.append(Value(2))
    expected_list.append(Value(3))
    check_element("key_5", Value(JsonList(expected_list)))



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


fn test_lexor_array() raises -> None:
    var v1: String = "[1, 2, 3]"
    var tokens = lex(v1)
    # for i in range(len(tokens)):
    #     print("Item: ", any_json_type_to_string(tokens[i]))
    assert_equal(len(tokens), 7, "Length should be 5")


fn test_lexor_object() raises -> None:
    var v1: String = '{"key": 1, "key_2": "hello", "key_3": false, "key_4": 1.2}'
    var tokens = lex(v1)
    # for i in range(len(tokens)):
    #     print("Item: ", any_json_type_to_string(tokens[i]))
    assert_equal(len(tokens), 17, "Length should be 17")


fn test_lexor_sub_lists_and_objects() raises -> None:
    var v1: String = '{ "key": [1, 2, 3], "key_2": { "name": "John", "age": 30 } }'
    var tokens = lex(v1)
    # for i in range(len(tokens)):
    #     print("Item: ", any_json_type_to_string(tokens[i]))
    assert_equal(len(tokens), 23, "Length should be 23")


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
    run_test(test_lexor_array)
    run_test(test_lexor_object)
    run_test(test_lexor_sub_lists_and_objects)
    run_test(test_parse_array)
    run_test(test_parse_object)
    run_test(test_parse_object_with_array)

    print("==== FINISHED TESTS ====")
