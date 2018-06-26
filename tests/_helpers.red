Red [
  author: "Nędza Darek"
  site: https://github.com/nedzadarek/red_dependent_types_proposal
]
assert: func [
  expected
  returned [block!] "Code to execute"
  /string
  str [string!] "String to print"
  /local

  executed
] [
  print "#################"
  unless string [
    str: copy mold expected
    append str " || "
    append str mold returned
  ]
  executed: try returned
  either error? executed [
    print executed
  ][
    either expected = executed [
      print [str "=>"  "Equal"]
    ][
      print [
        either string [str "=>^/"] [""]
        "Expected is not equal returned value::^/"
        ">>> Expected: " expected "^/"
        ">>> Returned: " executed
      ]
    ]
  ]

]
; assert 2 [1 + 1]
; assert 2 [1 + 2]
;
; assert/string 2 [1 + 1] "good sum"
; assert/string 2 [1 + 2] "bad sum"

error-assert: function [
  code [block!] "Block of code to evaluate"
  expected [map!] "Expected keys with expected values"
][
  print "#################"
  given-error: try code ""

  print ["Code: " mold/all code]
  print "~~~~~~~~~~~~~~"
  unless error? given-error [
    print ">>> Not an error" return false
  ]

  foreach key keys-of expected [
    comparrission: [given-error/:key = expected/:key]
    either do comparrission [
      print compose [(comparrission/1) "=> Equal" ]
    ][
      print "Expected field is not equal returned field::"
      print ["> Field: " key]
      print [">>> Expected: " expected/:key]
      print [">>> Returned: " given-error/:key]
    ]
  ]
]
; error-assert [2 / 0] #(type: 'math id: 'zero-divide)
; #################
; math => Equal
; zero-divide => Equal

; error-assert [2 / 0] #(type: 'math1 id: 'zero-divide)
; #################
; Expected field is not equal returned field::
; > Field:  type
; >>> Expected:  math1
; >>> Returned:  math
; zero-divide => Equal
