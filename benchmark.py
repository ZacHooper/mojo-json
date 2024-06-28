import json
from datetime import datetime as time


def main():
    # with open("data/citm_catalog.json", "r") as f:
    # with open("data/twitter.json", "r") as f:
    with open("data/canada_data.json", "r") as f:
        text = f.read()
        start = time.now()
        raw_data = json.loads(text)
        end = time.now()
        print("Time taken to parse JSON: ", (end - start) / 1000000, "ms")
        print("Time taken to parse JSON: ", (end - start), "ns")


if __name__ == "__main__":
    main()
