#let create-comment-img(img-src) = image(img-src, height: 1.5cm)
#let create-comment(img-src, text-src) = block(
  breakable: false,
  stroke: 0.5pt + rgb("#5E1675"),
  radius: 5pt,
  inset: (x: 2pt, y: 4pt),
  stack(
    dir: ltr,
    create-comment-img(img-src),
    align(start+horizon, box(width: 90%, text[#text-src]))
  )
)

#let pm-comment(text) = create-comment("figure/pm.jpg", text)
#let toothless-comment(text) = create-comment("figure/toothless.jpg", text)
#let cat-comment(text) = create-comment("figure/ddm.jpg", text)

