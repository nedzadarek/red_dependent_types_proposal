Red [
  author: "Nędza Darek"
  site: https://github.com/nedzadarek/red_dependent_types_proposal
]
system/catalog/errors: make system/catalog/errors [
  dependent: make object! [
    code: 12000
    type: "Dependent type error"
    input: ["Assertion of the inputs are wrong:" :arg1]
    return: [
      "Assertion of the result is wrong:" :arg1
      "^/*** It should be:" :arg2
    ]
  ]
]
; cause-error 'dependent 'input [[a = b]]
; cause-error 'dependent 'return [42 44]
