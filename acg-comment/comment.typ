#let create-comment-img(img-src) = image(img-src, height: 1.5cm)
#let create-comment(img-src, text-src) = stack(
  dir: ltr,
  create-comment-img(img-src),
  align(start+horizon, [#text-src])
)

#let pm-comment(text) = create-comment("figure/pm.jpg", text)
#let toothless-comment(text) = create-comment("figure/toothless.jpg", text)
#let cat-comment(text) = create-comment("figure/ddm.jpg", text)

