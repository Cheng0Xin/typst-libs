#let vspace-between-formula = 4pt
#let hspace-between-formula = 20pt

#let cons-obj(obj, styles) = if type(obj) == content {
  let c-content = align(center + horizon)[#obj]
  return (
    text: c-content,
    length: measure(c-content, styles).width,
  )
} else if type(obj) == dictionary {
  let up-content = cons-obj(obj.up, styles)
  let down-content = cons-obj(obj.down, styles)
  let label-size = if obj.keys().contains("label") {
    measure(obj.label, styles).width
  } else {
    15pt
  }
  let line-size = calc.max(up-content.length, down-content.length) + hspace-between-formula
  return (
    label: if obj.keys().contains("label") {obj.label} else {[]},
    up: up-content,
    down: down-content,
    line-length: line-size,
    length: line-size + label-size
  )
} else if type(obj) == array {
  let result = obj.map((x) => cons-obj(x, styles))
  let sum_result = result.fold(0pt, (acc, x) => { return acc + x.length })
  return (
    array: result,
    length: sum_result + (result.len() - 1) * hspace-between-formula,
  )
}

#let linewithlabel(length, name, style) = {
  let xdir = measure(name, style).width + 2pt

  line(length: length)
  place(
    dy: -5pt,
    dx: -xdir,
    align(right+horizon, text(name))
  )
}

#let generate(obj, style) = {
  if obj.keys().contains("text") {
    obj.text
  } else if obj.keys().contains("array") {
    stack(dir:ltr, spacing: hspace-between-formula, ..obj.array.map((x)=> generate(x, style)))
  } else if obj.keys().contains("up") {
    stack(dir:ttb, spacing: vspace-between-formula,
      align(center, generate(obj.up, style)),
      v(vspace-between-formula),
      linewithlabel(obj.line-length, obj.label, style),
      v(vspace-between-formula),
      align(center, generate(obj.down, style)),
    )
  }
}

#let rule(obj) = style(s => {
  let c-obj = cons-obj(obj, s)
  block(
    breakable: false,
    generate(c-obj, s)
  )
})
