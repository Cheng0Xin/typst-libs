/**
* Typst template for Noting
* Author: Cheng XIN
* Mail: claudexin@outlook.com
*/

/**
* Fonts
* */
#let section-font = "Latin Modern Roman"
#let body-font = "BlexMono Nerd Font Propo"
#let spec-font = "DejaVuSansMono Nerd Font Mono"
#let chinese-font = "Adobe Heiti Std"

/**
* bold text,
* italic text,
* code text
*/
#let bt(t) = text(weight: "bold")[#t]
#let it(t) = text(style: "italic")[#t]
#let tt(t) = text(rgb("#055D9F"), weight: 50, font: spec-font, tracking: 0pt)[#t]
#let blink(url, txt) = link(url)[#text(rgb("#055D9F"))[#txt]]

/**
* TODO list
*/
#let todo = text(14pt, red, weight: "bold")[TODO ......]
#let done = $checkmark$
#let wont = $times$
#let deadline(year, month, day) = text(10pt, red,
font: spec-font, weight: "bold")[
  \[DEADLINE: #datetime(year: year, month: month, day: day).display()\]
]

/**
* Show code from file
*/
#let show-code-file(file, lang) = raw(file, block: true, lang: lang)

/**
* Theorem-like box;
* Just for reusing, not recommended for directly using.
*/
#let thbox(name: none, color: gray, cate: "Theorem", refs: none, body) = block(
  width: 100%,
  fill: color,
  inset: 5pt)[
    #align(left, text[
      #text(weight: "bold")[#cate #text(rgb("#D0104C"))[#refs]:] #name.
      #label(refs)
  ])
  #body
]


#let theorem(name: none, refs: none, body) = thbox(
  name: name,
  color: luma(230),
  cate: "Theorem",
  refs: refs,
  body
)

#let definition(name: none, refs: none, body) = thbox(
  name: name,
  color: rgb("#91B493"),
  cate: "Definition",
  refs: refs,
  body
)

#let proposition(name: none, refs: none, body) = thbox(
  name: name,
  color: rgb("#E493B3"),
  cate: "Proposition",
  refs: refs,
  body
)

/**
* Showing link with hyperlink
*/
#let ref-link(l) = link(l, text(rgb("#D0104C"))[*#l*])
#let rref(key) = text(rgb("#D0104C"))[*#key*]

/**
* For showing some important facts.
* Dotted form is recommended.
*/
#let card(name, body) = block(fill: rgb("#EEA9A9"), inset: 10pt, width: 100%, stroke: black)[
  #set enum(numbering: x => text(rgb("#1B813E"))[#sym.square.filled #x])

  #align(left, text(14pt)[*#name*])
  #body
]

/**
* For shoing quota
*/
#let quota(body) = block(fill: gray, inset: 10pt, width: 100%, stroke: black)[
  #it(body)
]

/**
* For showing paragraph
*/
#let parat(name) = text(11pt, weight: "bold", font: section-font)[#sym.dagger #name]


/**
* Heading, `show` rules
*/
#let report(info, body, title_bar: none) = {

  set heading(numbering: "1.1.1")
  set text(10pt, font: (body-font, chinese-font), fallback: true)

  set par(justify: true)
  set page(
    paper: "us-letter",
    margin: (top: 1cm, bottom: 1cm),
    numbering: "1/1"
  )

  block(width: 100%,
    fill: rgb("#EDEAE7"),
    clip: true,
    // stroke: black,
    // radius: (
    //   top-left: 5pt,
    //   top-right: 5pt,
    //   bottom-left: 5pt,
    //   bottom-right: 5pt
    // ),
    inset: 10pt
    )[

    #align(left, text(14pt, font: section-font)[*#info.title*])

    #align(right, text(9pt, font: section-font)[
      *written by*
      #if "author" in info [
        #info.author
      ] else [
        Cheng
      ] *on*
      #if "date" in info [
        #info.date.display()
      ] else [
        #datetime.today().display()
      ]
    ])

    #align(center+horizon, title_bar)
  ]

  /**
  * Put keywords
  */
  if "keywords" in info [
    #align(left, text(9pt, font: section-font)[
      *Keywords:*
      #info.keywords.join("; ")
    ])
  ]

  /**
  * Outline
  */
  line(length: 100%)
  outline()
  line(length: 100%)
  v(1.5cm)

  /**
  * Programming Language Syntax Highlight
  */
  show raw.where(lang: "promela"): it => {
    let keywords = (
      "proctype", "chan", "of", "do", "od",
      "typedef", "byte", "int", "inline",
      "active", "bit", "bool", "short", "unsigned",
      "pid", "mtype", "break", "skip", "else", "goto"
      ).join("|")

      let functions = (
        "printf",
      ).join("|")

      let wrap_str(ks) = "\b(" + ks + ")\b"

      show regex(wrap_str(keywords)): set text(blue)
      show regex(wrap_str(functions)): set text(blue)
      show regex("\"(.*?)\""): set text(green)
      show regex("/\*(.*?)\*/"): set text(gray)
      show regex("//(.*?)\n"): set text(gray)

      block()[
        #it.text
      ]
  }


  // Display inline code in a small box
  // that retains the correct baseline.
  show raw.where(block: false): box.with(
    fill: luma(240),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )

  // Display block code in a larger block
  // with more padding.
  show raw.where(block: true): block.with(
    fill: luma(240),
    inset: 10pt,
    radius: 4pt,
    width: 100%
  )

  // show raw.where(block: true): it => { set par(justify: false); grid(
    //   columns: (100%, 100%),
    //   column-gutter: -100%,
    //   block(width: 100%, inset: 1em, for (i, line) in it.text.split("\n").enumerate() {
      //       box(width: 0pt, align(right, str(i + 1) + h(2em)))
  //       hide(line)
  //       linebreak()
  //     }),
  //   block(radius: 1em, fill: luma(246), width: 100%, inset: 1em, it),
  // )}

  /**
  * Emph and strong
  */
  show emph: it => {
    text(rgb("#42602D"), weight: "bold", it.body)
  }

  show strong: it => {
    text(rgb("#8E354A"), weight: "bold", it.body)
  }

  /**
  * Heading level 1 and level 2
  */
  show heading.where(level: 1): it => [
    #set align(center)
    #set text(font: section-font, fallback: true)
    #smallcaps(it)
  ]
  show heading.where(level: 2): it => [
    #set text(font: section-font, fallback: true)
    #text(weight: "bold", it)
  ]

  /**
  * Main body
  */
  body
}
