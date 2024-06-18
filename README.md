# Json Mojo

## TODO

When recursive variants are available we should be able to expand on this further. Implementations in Rust uses a recursive enum.

Sure, JSON is a relatively simple data format, but there are still edge cases that can be tricky. Here are some examples that could potentially break a JSON parser:

### 1. Trailing Comma

```json
{
  "key1": "value1",
  "key2": "value2",
}
```

Trailing commas after the last key-value pair are not allowed in JSON.

### 2. Missing Quotes around Keys

```json
{
  key1: "value1",
  "key2": "value2"
}
```

Keys must always be strings enclosed in double quotes.

### 3. Single Quotes Instead of Double Quotes

```json
{
  'key1': 'value1',
  "key2": "value2"
}
```

JSON requires double quotes around strings, not single quotes.

### 4. Non-string Key

```json
{
  123: "value"
}
```

Keys must be strings enclosed in double quotes.

### 5. Invalid Unicode Characters

```json
{
  "key": "value\uZZZZ"
}
```

`\u` must be followed by four hexadecimal digits.

### 6. Unescaped Control Characters

```json
{
  "key": "value\u0001"
}
```

Control characters must be properly escaped.

### 7. Dangling Quotes

```json
{
  "key": "value"
"key2": "value2"
}
```

Missing commas between key-value pairs.

### 8. Special Numbers

```json
{
  "number": NaN
}
```

`NaN`, `Infinity`, and `-Infinity` are not valid values in JSON.

### 9. Nested Structures

```json
{
  "nested": {
    "nested2": {
      "nested3": {
        "nested4": {
          "nested5": "value"
        }
      }
    }
  }
}
```

Extreme nesting could potentially break a parser if recursion depth is not handled properly.

### 10. Mixed Array Types

```json
{
  "array": [1, "string", true, null, {"key": "value"}, [1, 2, 3]]
}
```

While this is valid JSON, it could cause issues in parsers that expect arrays to be homogenous.

### 11. Big Numbers

```json
{
  "bigNumber": 1234567890123456789012345678901234567890
}
```

Large numbers can cause precision loss issues in parsers that don't handle them correctly.

### 12. Circular References (though not valid JSON)

```json
{
  "key": "value",
  "self": { "$ref": "$" }
}
```

Circular references are not valid in JSON but if your parser encounters them, it could fail unless special handling is implemented.

### 13. Duplicate Keys

```json
{
  "key": "value1",
  "key": "value2"
}
```

JSON doesn’t technically disallow duplicate keys, but parsers should decide how to handle them (`value2` will overwrite `value1` in most parsers).

Test your parser against these examples to ensure it handles all edge cases robustly. Note that adhering strictly to the [JSON specification](http://www.json.org/) will avoid many of these issues.
