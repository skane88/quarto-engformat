
// This is an example typst template (based on the default template that ships
// with Quarto). It defines a typst function named 'engformat' which provides
// various customization options. This function is called from the 
// 'typst-show.typ' file (which maps Pandoc metadata function arguments)
//
// If you are creating or packaging a custom typst template you will likely
// want to replace this file and 'typst-show.typ' entirely. You can find 
// documentation on creating typst templates and some examples here: 
//   - https://typst.app/docs/tutorial/making-a-template/
//   - https://github.com/typst/templates

#let logo(logo_path:none) = {
  if logo_path != none {[#image(logo_path)]} else {[*NO LOGO*]}
}

#let engformat(
  title: none,
  authors: none,
  date: none,
  cols: 1,
  margin: (inside: 2.5cm, outside: 1.5cm, top: 4.5cm, bottom: 2.5cm),
  paper: "a4",
  lang: "en",
  region: "AU",
  font: ("calibri"),
  fontsize: 10pt,
  sectionnumbering: "1.1",
  toc: false,
  logo_company: none,
  logo_client: none,
  doc
  ) = {
    set page(
    paper: paper,
    margin: margin,
    numbering: "1",
    footer: [
      #box(width:100%, stroke: (top: 1pt), outset:(top: 6pt))[
        #set align(center)
        #set text(size: 9pt)
        #counter(page).display("1 of 1", both:true)
      ]
    ],
    header: [
      #table(
        columns: 6*(1fr,),
        rows: (1.5cm, 0.5cm, 0.5cm, 0.5cm),
        table.cell(align: center)[#logo(logo_path:logo_company)],
        table.cell(colspan:4, align: center)[#text(size: 28pt)[*CALCULATION SHEET*]],
        table.cell(align: center)[#logo(logo_path:logo_client)],
        [],[],[],[],[],[],
        [],[],[],[],[],[],
        [],[],[],[],[],[],
      )
    ]
  )
  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)
  set heading(numbering: sectionnumbering)
  
  // format heading 1 differently from the rest.
  show heading.where(
    level: 1
  ): it => {
    block(width: 100%)[
      #box(width: 100%, stroke: (bottom:1pt), outset: (bottom: .5em))[
      #set text(weight: "light", size: 17pt)
      #counter(heading).display(it.numbering) #smallcaps(it.body)]
      #v(0.5em)
    ]
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }

}

#let like_header(it) = {
  v(0.5em)
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
