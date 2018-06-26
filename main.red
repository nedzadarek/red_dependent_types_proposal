Red [
  author: "Nędza Darek"
  site-info-license: https://github.com/nedzadarek/red_dependent_types_proposal
  version: 0.0.1
  subversion: 'alpha
]
do %errors.red

dependent-function: function [
  spec
  deps
  body
][
  refinements: copy []
  parse spec [
    any thru [
      set refinement refinement! (refinement append refinements to-word refinement)
    ]
    to end
  ]
  sort refinements

  checks: compose/only [
    ref-path: copy [fun]
    foreach ref (refinements) [
      if reduce ref [append ref-path ref]
    ]
    either 1 < length? ref-path [
      ref-path: to-path ref-path
    ][
      ref-path: first ref-path
    ]

    selected-dep: select/only (deps) :ref-path
    check-all: function [bl /extern return-checks] [
      current-position: old-position: bl
      current-position
      while [not tail? old-position][
        if 'returns = first current-position [
          return-checks: current-position/2
          break
        ]
        if false = do/next old-position 'current-position [
          cause-error 'dependent 'input reduce [copy/part old-position current-position]
          break
        ]
        old-position: current-position
      ]
    ]
    check-all selected-dep
  ]


  return-body: compose/deep [
    (checks)
    user-func: does
  ]
  append/only return-body body
  append return-body [set/any 'return-value user-func]
  append return-body [
    unless unset? get/any 'return-value [
      check-return-value: func [bl][
        if none? bl [bl: copy [true]]

        either all bl [
          return-value
        ][
          cause-error 'dependent 'return [bl]
        ]
      ]

      check-return-value return-checks
    ]
  ]

  return function spec return-body
]
