#import "@local/note:1.0.0": *
#import "semantics.typ": *

#let pr = sym.tack.r

// For debuging
#let printit(x) = style(s =>
{
  let res = cons-obj(x, s)
  res
})

#let x = (
  label: tt[contract],
  up: (
      up: (
        label: tt[$->$-E],
        up: (
          (
            label: tt[Id],
            up: [],
            down: $y : A pr y : A$
          ),
          (
            up: (
              (
                label: tt[Id],
                up: [],
                down: $f : A -> B pr f : A -> B$
              ),
              (
                label: tt[Id],
                up: [],
                down: $z : A pr z : A$
              )
            ),
            down: $f : A -> B, z : A pr f(z) : B$
          )
        ),
        down: ($y : A, f : A -> B, z : A pr (y, f(z)) : A times B$)
      ),
      down: ($f : A -> B, y : A, z : A #pr (y, f(z)) : A times B$)
    ),
  down: [$f : A -> B, x : A #pr A (x, f(x)) : A times B$],
)

#rule(x)
#rule(
  (
    label: tt[$->$E],
    up: ($Gamma, A pr B$, $Gamma pr A$),
    down: $Gamma pr B$
  )
)
