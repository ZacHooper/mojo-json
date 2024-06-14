# This file shows the the variant bug being fixed. It also provides an example of a recursive function going down the variant tree on itself.
# This would be useful in building out the recursive parsing of the JSON tree

from utils.variant import Variant
from collections import List


@value
struct Delegate(CollectionElement):
    var _data: List[Value]


alias T = Variant[Float64, Delegate]


@value
struct Value(CollectionElement):
    var _variant: T

    @always_inline
    fn __moveinit__(inout self, owned existing: Self):
        self._variant = existing._variant

    @always_inline
    fn __copyinit__(inout self, existing: Self):
        self._variant = existing._variant


fn recursive_print_delegate(delegate: Delegate) -> None:
    print("In recursive_print_delegate")
    for i in range(len(delegate._data)):
        var item = delegate._data[i]
        if item._variant.isa[Float64]():
            print("Float64 item: ", str(item._variant[Float64]))
        elif item._variant.isa[Delegate]():
            print("Delegate")
            recursive_print_delegate(item._variant[Delegate])
        else:
            print("Unknown")


fn main() raises:
    var my_sub_sub_sub_list = Delegate(List[Value]())
    my_sub_sub_sub_list._data.append(Value(1.0))

    var my_sub_sub_list = Delegate(List[Value]())
    my_sub_sub_list._data.append(Value(1.1))
    my_sub_sub_list._data.append(Value(my_sub_sub_sub_list))

    var my_sub_list = Delegate(List[Value]())
    my_sub_list._data.append(Value(1.2))
    my_sub_list._data.append(Value(my_sub_sub_list))

    var my_main_list = Delegate(List[Value]())
    my_main_list._data.append(Value(1.3))
    my_main_list._data.append(Value(my_sub_list))

    recursive_print_delegate(my_main_list)
