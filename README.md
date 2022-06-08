# Testable

A XCUITest Wrapper to run .feature files as ui tests.

# Features

- Open to extend

# Examples

- Examples Universal links
- Examples of network state
- Examples of push notifications
- Injection as possibly an extension?

# Language

- Feature:
- Scenario:



# Things to think about

I want to write:

```
and the user taps on "I'm Ready"
```

In this case, "I'm Ready" is the text on a button,
The underlying accessibility identifier could be different like "btn_ready"

If the tests are to be `Human Readable`, how would one make the mapping?

Ideas:
- Could there be a seperate mapping.feature file, that other files can inherit?
- Is it a problem if the person writing the tests uses the Text on screen?
- Think about the concepts of blocks, Background, Scenario - we don't want to pass line by line
in those cases


## Usefull Links

https://www.swiftbysundell.com/articles/async-sequences-streams-and-combine/
