#let vspace-between-formula = 2pt
#let hspace-between-formula = 25pt

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
    0pt
  }
  return (
    label: if obj.keys().contains("label") {obj.label} else {[]},
    up: up-content,
    down: down-content,
    length: calc.max(up-content.length, down-content.length) + label-size
  )
} else if type(obj) == array {
  let result = obj.map((x) => cons-obj(x, styles))
  let sum_result = result.fold(0pt, (acc, x) => { return acc + x.length })
  return (
    array: result,
    length: sum_result + result.len() * 2pt,
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
      generate(obj.up, style),
      v(vspace-between-formula),
      linewithlabel(obj.length, obj.label, style),
      v(vspace-between-formula),
      generate(obj.down, style),
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
