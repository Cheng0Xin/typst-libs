#let vspace-between-formula = 5pt
#let hspace-between-formula = 20pt

#let cons-obj(obj) = if type(obj) == content {
  let c-content = align(start+bottom)[#obj]
  return (
    text: c-content,
    length: measure(c-content).width,
  )
} else if type(obj) == dictionary {
  let up-content = cons-obj(obj.up)
  let down-content = cons-obj(obj.down)
  let label-size = if obj.keys().contains("label") {
    measure(obj.label).width
  } else {
    15pt
  }
  // let line-size = calc.max(up-content.length, down-content.length) + hspace-between-formula
  let line-size = calc.max(up-content.length, down-content.length)
  return (
    label: if obj.keys().contains("label") {obj.label} else {[]},
    up: up-content,
    down: down-content,
    line-length: line-size,
    length: line-size + label-size
  )
} else if type(obj) == array {
  let result = obj.map((x) => cons-obj(x))
  let sum_result = result.fold(0pt, (acc, x) => { return acc + x.length })
  return (
    array: result,
    length: sum_result + (result.len() - 1) * hspace-between-formula,
  )
}

#let linewithlabel(length, name) = {
  let xdir = measure(name).width + 2pt

  line(length: length)
  place(
    dy: -5pt,
    dx: -xdir,
    align(right+horizon, text(name))
  )
}

#let generate(obj) = {
  if obj.keys().contains("text") {
    obj.text
  } else if obj.keys().contains("array") {
    stack(dir:ltr, spacing: hspace-between-formula, ..obj.array.map((x)=> generate(x)))
  } else if obj.keys().contains("up") {
    stack(dir:ttb, spacing: vspace-between-formula,
      align(center+bottom, generate(obj.up)),
      v(vspace-between-formula),
      linewithlabel(obj.line-length, obj.label),
      v(vspace-between-formula),
      align(center+bottom, generate(obj.down)),
    )
  }
}

#let rule(obj) = context({
  let c-obj = cons-obj(obj)
  block(
    breakable: false,
    generate(c-obj)
  )
})
