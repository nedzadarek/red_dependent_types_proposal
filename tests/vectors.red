Red [
  author: "Nędza Darek"
  site: https://github.com/nedzadarek/red_dependent_types_proposal
]
do %../main.red
do %_helpers.red

spec: [
  vect1 [vector!]
  vect2 [vector!]
]
deps: [
  fun [
    (length? vect1) = (length? vect2)
    ; redundant - vect1/vect2's types are specified in the spec
    vector? vect1
    vector? vect2
  ]
]
body: [
  vect1 + vect2
]
sum: dependent-function spec deps body
v: func [bl] [make vector! bl]
assert v [3] [sum v [1] v [2] ]
error-assert [sum v [1] v [2 3]] #(
  type: 'dependent
  id: 'input
  arg1: [
    (length? vect1) = (length? vect2)
  ]
)
