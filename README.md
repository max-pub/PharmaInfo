# PharmaInfo

## Initialization
```pub get```
to update dependencies


## Command Line Interface
```dart main.dart de amoxicillin```    
-> result   


## Web Server
``` dart main.dart 8080```    
```http://localhost:8080/de/amoxicillin```    
-> result  

## Test
```dart test.dart```   
compares web-results with templates in "test"-folder    
should all pass


## Result
```json
{
        "INN": "amoxicillin",
        "tradeNames": [],
        "ATC": [
                "J01CA04"
        ],
        "CAS": [
                "26787-78-0",
                "61336-70-7",
                "34642-77-8"
        ],
        "formula": "C16H19N3O5S"
}
```