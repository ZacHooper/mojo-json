from types import Value, JSON_SYNTAX, JsonList, JsonDict


fn any_json_type_to_string(value: Value) raises -> String:
    """
    Recursively convert a JsonValue to a string.
    If a discrete value, return the string representation.
    If a list, convert each element to a string and join them with commas.
        NOTE: we recursively call this function as the elements of the list can be of any JSON type.
    If a dictionary, convert each key-value pair to a string and join them with commas.
        NOTE: Same as list we recursively call this function as the values of the dictionary can be of any JSON type.
    """
    if value._variant.isa[String]():
        var string_value = value._variant[String]
        if len(string_value) == 0:
            return '""'
        elif string_value in JSON_SYNTAX:
            return string_value
        else:
            return '"' + value._variant[String] + '"'
    elif value._variant.isa[Int]():
        return str(value._variant[Int])
    elif value._variant.isa[Float64]():
        return str(value._variant[Float64])
    elif value._variant.isa[Bool]():
        return str(value._variant[Bool])
    elif value._variant.isa[NoneType]():
        return "null"
    elif value._variant.isa[JsonList]():
        var array = value._variant[JsonList]._data
        var result: String = "["
        for i in range(len(array)):
            result += any_json_type_to_string(array[i])
            if i < len(array) - 1:
                result += ","
        result += "]"
        return result
    elif value._variant.isa[JsonDict]():
        # Get the data from the JsonDict
        var obj = value._variant[JsonDict]._data
        var result: String = "{"
        var keys = List[String]()
        for key in obj:
            keys.append(key[])
        for key in obj:
            var key_str = key[]
            result += '"' + key_str + '":' + any_json_type_to_string(obj[key[]])
            if key[] != keys[-1]:
                result += ","
        result += "}"
        return result
    else:
        raise Error("Unknown type")


fn stringify(value: Value) raises -> String:
    """
    Convert a JsonValue to a string.
    """
    return any_json_type_to_string(value)
