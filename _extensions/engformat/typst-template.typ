
// This is an example typst template (based on the default template that ships
// with Quarto). It defines a typst function named 'article' which provides
// various customization options. This function is called from the 
// 'typst-show.typ' file (which maps Pandoc metadata function arguments)
//
// If you are creating or packaging a custom typst template you will likely
// want to replace this file and 'typst-show.typ' entirely. You can find 
// documentation on creating typst templates and some examples here: 
//   - https://typst.app/docs/tutorial/making-a-template/
//   - https://github.com/typst/templates

#let engformat(
  title: none,
  authors: none,
  date: none,
  cols: 1,
  margin: (inside: 2.5cm, outside: 1.5cm, top: 1.5cm, bottom: 1.5cm),
  paper: "a4",
  lang: "en",
  region: "AU",
  font: ("calibri"),
  fontsize: 10pt,
  sectionnumbering: "1.1",
  toc: false,
  doc
  ) = {
    set page(
    paper: paper,
    margin: margin,
    numbering: "1",
  )
  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)
  set heading(numbering: sectionnumbering)
  
  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }

}

// format heading 1 differently from the rest.
#show heading.where(
  level: 1
): it => block(width: 100%)[
  #box(width: 100%, stroke: (bottom:1pt), outset: (bottom: 4pt))[
  #set text(weight: "light", size: 17pt)
  #counter(heading).display(it.numbering) #smallcaps(it.body)]
  #v(0.5em)
]

#let like_header(it) = {
  box(width: 100%, stroke: (bottom:1pt), outset: (bottom: -2pt))[
    #set text(weight: "light", size: 17pt)
    #smallcaps(it)
    #v(0.5em)
  ]
}

#let article(
  title: none,
  authors: none,
  date: none,
  abstract: none,
  cols: 1,
  margin: (x: 1.25in, y: 1.25in),
  paper: "us-letter",
  lang: "en",
  region: "US",
  font: (),
  fontsize: 11pt,
  sectionnumbering: none,
  toc: false,
  doc,
) = {
  

  if title != none {
    align(center)[#block(inset: 2em)[
      #text(weight: "bold", size: 1.5em)[#title]
    ]]
  }

  if authors != none {
    let count = authors.len()
    let ncols = calc.min(count, 3)
    grid(
      columns: (1fr,) * ncols,
      row-gutter: 1.5em,
      ..authors.map(author =>
          align(center)[
            #author.name \
            #author.affiliation \
            #author.email
          ]
      )
    )
  }

  if date != none {
    align(center)[#block(inset: 1em)[
      #date
    ]]
  }

  if abstract != none {
    block(inset: 2em)[
    #text(weight: "semibold")[Abstract] #h(1em) #abstract
    ]
  }

  if toc {
    block(above: 0em, below: 2em)[
    #outline(
      title: auto,
      depth: none
    );
    ]
  }

}
