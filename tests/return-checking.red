Red [
  author: "Nędza Darek"
  site: https://github.com/nedzadarek/red_dependent_types_proposal
]
do %../main.red
do %_helpers.red

spec: [
  var
  /bigger
]
deps: [
  fun [
    integer? var
    var < 100
    returns [
      return-value < 999
    ]
  ]

  fun/bigger [
    returns [
      return-value >= 999
    ]
  ]
]
body: [
  either bigger [
    return var * 1000
  ][
    return var * 2
  ]
]
foo: dependent-function spec deps body

assert 4  [ foo 2 ]
assert 40 [ foo 20 ]
assert 2000 [ foo/bigger 2 ]
assert 20'000 [ foo/bigger 20 ]

error-assert [ foo 100 ] #(
  type: 'dependent
  id: 'input
  arg1: [var < 100]
)

error-assert [ foo "not an integer" ] #(
  type: 'dependent
  id: 'input
  arg1: [integer? var]
)

error-assert [foo/bigger 0.0001] #(
  type: 'dependent
  id: 'return
  arg1: [
    return-value >= 999
  ]
)
