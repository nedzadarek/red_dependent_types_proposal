# Red dependent types

## Info
I have tried to implement something described [here](https://github.com/red/red/wiki/Proposal-__-user-defined-types-%28UDT%29-and-dependent-types#dependent-types).

## Usage:
```
fun: dependent-function spec deps body
```
Where `spec` and `body` is has the same form as with `function spec body`.

For more information see [tests/](tests) folder.

## Notes:
When I have written proposal `deps` and `spec` was one block. After many thought I split them into 2 blocks. I think it would be too complex to put everything in the `spec` block. For example you have function like this:
```
foo: function [
  a
  /baz
  b
  /bar
  c
][
    if all [baz bar] [return to-float a * b * c]
    if baz [return to-string a + b]
    if bar [return to-integer a / c
    return reduce [a]
]
```
As you can see it would be too complex to put every check into `spec` block.   
Of course, as pointed by Gregg Irwin, functions without refinements can return value of any type (e.g. `do [1]` vs `do ["foo"]`) but refinements are another kind of **beasts**. They are like another functions. 

I want to make a function like `dependent-function spec body` for simple cases.
## License

See [license.md](license.md)
