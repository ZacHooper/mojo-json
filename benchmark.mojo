import json
from builtin.file import open
import time


fn main() raises:
    # with open("data/citm_catalog.json", "r") as f:
    # with open("data/twitter.json", "r") as f:
    with open("data/canada_data.json", "r") as f:
        var text = f.read()
        var start = time.now()
        var raw_data = json.loads(text)
        var end = time.now()
        print("Time taken to parse JSON: ", (end - start) / 1000000, "ms")
        # print(json.dumps(raw_data))
