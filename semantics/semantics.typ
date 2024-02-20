#let construct-rule-obj(obj, styles) = if obj.keys().contains("text") {
  let c-content = align(center + horizon)[#obj.text]
  return (
    text: c-content,
    length: measure(c-content, styles).width + 20pt,
  )
} else if obj.keys().contains("array") {
  let result = obj.array.map((x) => construct-rule-obj(x, styles))
  let sum_result = result.fold(0pt, (acc, x) => { return acc + x.length })
  return (
    array: result,
    length: sum_result + result.len() * 8pt,
  )
} else {
  let new-above = construct-rule-obj(obj.above, styles)
  let new-below = construct-rule-obj(obj.below, styles)
  let length = calc.max(new-above.length, new-below.length)
  return (
    name: obj.name,
    above: new-above,
    below: new-below,
    length: length,
  )
}

#let semantics-rule(obj) = style(styles =>{
  let obj = construct-rule-obj(obj, styles)

  if obj.keys().contains("text") {
    obj.text
  } else if obj.keys().contains("array") {
    stack(dir:ltr, spacing: 8pt, ..obj.array.map((x)=> semantics-rule(x)))
  } else {
    let text-label = text(8pt, weight: "bold")[#obj.name]
    let text-label-size = measure(text-label, styles).width
    grid(
      gutter: 5pt, columns: (auto, auto, auto), rows: 3,
      box(), semantics-rule(obj.above), box(),
      box(), line(length: obj.length, stroke: 0.5pt), place(dy:-3pt, dx: -2.5pt, box(width: text-label-size, text-label)),
      box(), semantics-rule(obj.below), box()
    )
  }
})
