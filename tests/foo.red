Red [
  author: "Nędza Darek"
  site: https://github.com/nedzadarek/red_dependent_types_proposal
]
do %../main.red
do %_helpers.red

spec: [
  var
  /baz
]
deps: [
  fun [
    var = 2
    0 = mod 4 var
  ]
  fun/baz [
    var = 3
    0 = mod 6 var
    returns [return-value = 999]
  ]
]
body: [
  either baz [
    print "Hey, I found *baz*"
  ][
    print "Oh! You know what... there is no *baz* here."
  ]
  print ["This is your var: " var]
  return 999
]
foo: dependent-function spec deps body
error-assert [foo 1] #(
  type: 'dependent
  id: 'input
  arg1: [var = 2]
)

assert 999 [foo 2]


error-assert [foo/baz 1] #(
  type: 'dependent
  id: 'input
  arg1: [var = 3]
)

error-assert [foo/baz 2] #(
  type: 'dependent
  id: 'input
  arg1: [var = 3]
)

assert 999 [foo/baz 3]
